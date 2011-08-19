From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: imx_keypad: Provide PM support
Date: Fri, 19 Aug 2011 12:56:04 -0300
Message-ID: <1313769364-27249-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36561 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab1HSP4N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 11:56:13 -0400
Received: by ywf7 with SMTP id 7so2283271ywf.19
        for <linux-input@vger.kernel.org>; Fri, 19 Aug 2011 08:56:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: kernel@pengutronix.de, dmitry.torokhov@gmail.com, Fabio Estevam <festevam@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>

Provide PM support to imx_keypad and allow the keypad to be used as a wakeup source.

Tested on a mx27_3ds, which wakes up via keypad press.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---

If I put disable_irq_wake(keypad->irq) inside imx_keypad_resume
like other keyboard drivers do I get the following:

mx27# echo mem > /sys/power/state                                               
PM: Syncing filesystems ... done.                                               
Freezing user space processes ... (elapsed 0.01 seconds) done.                  
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.             
Suspending console(s) (use no_console_suspend to debug)                         
PM: suspend of devices complete after 0.692 msecs                               
PM: late suspend of devices complete after 0.418 msecs                          
PM: early resume of devices complete after 0.179 msecs                          
------------[ cut here ]------------                                            
WARNING: at kernel/irq/manage.c:510 irq_set_irq_wake+0xdc/0xec()                
Unbalanced IRQ 21 wake disable                                                  
Modules linked in:                                                              
[<c00197bc>] (unwind_backtrace+0x0/0xf4) from [<c002ba50>] (warn_slowpath_common
+0x4c/0x64)                                                                     
[<c002ba50>] (warn_slowpath_common+0x4c/0x64) from [<c002bafc>] (warn_slowpath_f
mt+0x30/0x40)                                                                   
[<c002bafc>] (warn_slowpath_fmt+0x30/0x40) from [<c0069db0>] (irq_set_irq_wake+0
xdc/0xec)                                                                       
[<c0069db0>] (irq_set_irq_wake+0xdc/0xec) from [<c022b7b0>] (imx_keypad_resume+0
x30/0x38)                                                                       
[<c022b7b0>] (imx_keypad_resume+0x30/0x38) from [<c01ec224>] (platform_pm_resume
+0x2c/0x4c)                                                                     
[<c01ec224>] (platform_pm_resume+0x2c/0x4c) from [<c01ef568>] (pm_op+0xa0/0xc0) 
[<c01ef568>] (pm_op+0xa0/0xc0) from [<c01ef9ac>] (device_resume+0x5c/0x100)     
[<c01ef9ac>] (device_resume+0x5c/0x100) from [<c01efbc8>] (dpm_resume+0x134/0x19
0)                                                                              
[<c01efbc8>] (dpm_resume+0x134/0x190) from [<c01efc30>] (dpm_resume_end+0xc/0x18
)                                                                               
[<c01efc30>] (dpm_resume_end+0xc/0x18) from [<c0068860>] (suspend_devices_and_en
ter+0x160/0x338)                                                                
[<c0068860>] (suspend_devices_and_enter+0x160/0x338) from [<c0068b24>] (enter_st
ate+0xec/0x128)                                                                 
[<c0068b24>] (enter_state+0xec/0x128) from [<c0067ee4>] (state_store+0xd0/0x124)
[<c0067ee4>] (state_store+0xd0/0x124) from [<c0192d58>] (kobj_attr_store+0x18/0x
1c)                                                                             
[<c0192d58>] (kobj_attr_store+0x18/0x1c) from [<c01167ec>] (sysfs_write_file+0xf
8/0x17c)                                                                        
[<c01167ec>] (sysfs_write_file+0xf8/0x17c) from [<c00c395c>] (vfs_write+0xb0/0x1
34)                                                                             
[<c00c395c>] (vfs_write+0xb0/0x134) from [<c00c3ab0>] (sys_write+0x40/0x70)     
[<c00c3ab0>] (sys_write+0x40/0x70) from [<c0013ea0>] (ret_fast_syscall+0x0/0x2c)
---[ end trace 5656d76309d84fa1 ]---                                            
PM: resume of devices complete after 1.960 msecs                                
Restarting tasks ... done. 

 drivers/input/keyboard/imx_keypad.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index d92c15c..4acb480 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -408,6 +408,28 @@ open_err:
 	return -EIO;
 }
 
+#ifdef CONFIG_PM
+static int imx_keypad_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_keypad *keypad = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(keypad->irq);
+
+	return 0;
+}
+
+static int imx_keypad_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops imx_keypad_pm_ops = {
+	.suspend	= imx_keypad_suspend,
+	.resume		= imx_keypad_resume,
+};
+#endif
 static int __devinit imx_keypad_probe(struct platform_device *pdev)
 {
 	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
@@ -571,6 +593,9 @@ static struct platform_driver imx_keypad_driver = {
 	.driver		= {
 		.name	= "imx-keypad",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &imx_keypad_pm_ops,
+#endif
 	},
 	.probe		= imx_keypad_probe,
 	.remove		= __devexit_p(imx_keypad_remove),
-- 
1.6.0.4

