//
//  ViewController.m
//  ARTestTool
//
//  Created by 陈文娟 on 2017/5/4.
//  Copyright © 2017年 陈文娟. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ARScanViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>
{
    UIImagePickerController *imagePicker;
    AppDelegate * appDelegate;
    UIAlertController *tipAlert;
}
@property (weak, nonatomic) IBOutlet UIImageView *selImg;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)takeCamera:(id)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    // 设置导航默认标题的颜色及字体大小
    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)savePhoto:(id)sender {
    UIImageWriteToSavedPhotosAlbum(appDelegate.currentImg, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [self presentAlert:@"保存图片失败了"];

    }
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

- (IBAction)takePhoto:(id)sender {
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = NO;
    //设置相册呈现的样式
    pickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
    
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    if(image)
    {
        
        appDelegate.currentImg = image;
        [self.selImg setImage:image];
        self.selImg.contentMode = UIViewContentModeScaleAspectFit
        ;
        [picker dismissViewControllerAnimated:YES completion:nil];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新建文件夹" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        UITextField *txtName = [alert textFieldAtIndex:0];
        txtName.placeholder = @"请输入名称";
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    if(buttonIndex == 1)
    {
        UITextField *txt = [alertView textFieldAtIndex:0];
        if(txt.text)
        {
            NSString *txtstr =  [txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if(txtstr && txtstr.length>0){
                appDelegate.imgName = txtstr;
            }
            
        }
        
    }
}
- (IBAction)ARScanAction:(id)sender {
    if (!appDelegate.imgName) {
        [self presentAlert:@"请先拍照取景"];
        return;
    }
    
    ARScanViewController *scanVC = [[ARScanViewController alloc] init];
    [self presentViewController:scanVC animated:YES completion:nil];
}

-(void) performDismiss:(NSTimer *)timer
{
    [tipAlert.view removeFromSuperview];

    [tipAlert dismissViewControllerAnimated:YES completion:nil];
    tipAlert = nil;
}

-(void)presentAlert:(NSString*)message
{
    tipAlert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:tipAlert animated:YES completion:nil];

    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(performDismiss:) userInfo:tipAlert repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
