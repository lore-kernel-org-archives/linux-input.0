From: Marjan Fojkar <marjan@pajkc.eu>
Subject: [PATCH] AT32AP700X PS/2 controller (PSIF): remove msleep call from
 atomic context
Date: Sun, 13 Dec 2009 14:25:25 +0100
Message-ID: <4B24EB45.2020708@pajkc.eu>
Reply-To: marjan@pajkc.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from md2.t-2.net ([84.255.209.81]:8353 "HELO md2.t-2.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751099AbZLMNbm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2009 08:31:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: kernel@avr32linux.org, hans-christian.egtvedt@atmel.com

From: Marjan Fojkar <marjan@pajkc.eu>

The patch removes msleep call from atomic context. To achieve that, the driver
PSIF leaves atomic context before the call in order to enable interrupts to be
performed safely. When the call is done, the driver jumps back to atomic context.

The boot logs caused by the call from atomic context inside the driver.
atkbd.c: keyboard reset failed on at32psif/serio1                              
BUG: scheduling while atomic: kseriod/69/0x00000002                            
Modules linked in:                                                             
Call trace:                                                                    
 [<90019128>] __schedule_bug+0x40/0x4c                                         
 [<9019afa6>] __sched_text_start+0x5e/0x220                                    
 [<9019b5a8>] schedule_timeout+0x5c/0x84                                       
 [<90022d84>] process_timeout+0x0/0x8                                          
 [<9019b5e0>] schedule_timeout_uninterruptible+0x10/0x14                       
 [<90023280>] msleep+0x10/0x1c                                                 
 [<90108688>] psif_write+0x20/0x6c                                             
 [<90108868>] ps2_sendbyte+0x44/0xd8                                           
 [<90029d8c>] autoremove_wake_function+0x0/0x1c                                
 [<90108a52>] ps2_command+0xaa/0x2a8                                           
 [<90013e8a>] clk_enable+0x16/0x38                                             
 [<9001d194>] printk+0xc/0x10                                                  
 [<9010b872>] atkbd_probe+0x3a/0xac                                            
 [<9010bb46>] atkbd_connect+0xca/0x188                                         
 [<901077a4>] serio_connect_driver+0x18/0x24                                   
 [<901077bc>] serio_driver_probe+0xc/0x10                                      
 [<900f7f02>] driver_probe_device+0x82/0xf0                                    
 [<900f7f9c>] __driver_attach+0x2c/0x44                                        
 [<900f7946>] bus_for_each_dev+0x2a/0x48                                       
 [<900f7f70>] __driver_attach+0x0/0x44                                         
 [<900f7df0>] driver_attach+0x10/0x14                                          
 [<90108024>] serio_thread+0x180/0x2e4                                         
 [<90029d8c>] autoremove_wake_function+0x0/0x1c                                
 [<90029b3e>] kthread+0x2a/0x44                                                
 [<90107ea4>] serio_thread+0x0/0x2e4                                           
 [<9001ed3c>] do_exit+0x0/0x52e                                                
 [<90029b14>] kthread+0x0/0x44                                                 
 [<9001ed3c>] do_exit+0x0/0x52e

Signed-off-by: Marjan Fojkar <marjan@pajkc.eu>

---

diff -up linux-2.6.32/drivers/input/serio/at32psif.c{.orig,}
--- linux-2.6.32/drivers/input/serio/at32psif.c.orig	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32/drivers/input/serio/at32psif.c	2009-12-13 13:08:39.000000000 +0100
@@ -135,9 +135,12 @@ static int psif_write(struct serio *io, 
 	int retval = 0;
 
 	spin_lock_irqsave(&psif->lock, flags);
-
-	while (!(psif_readl(psif, SR) & PSIF_BIT(TXEMPTY)) && timeout--)
-		msleep(10);
+	while (!(psif_readl(psif, SR) & PSIF_BIT(TXEMPTY)) && timeout) {
+		spin_unlock_irqrestore(&psif->lock, flags);
+		while (!(psif_readl(psif, SR) & PSIF_BIT(TXEMPTY)) && timeout--)
+			msleep(10);
+		spin_lock_irqsave(&psif->lock, flags);
+	}
 
 	if (timeout >= 0) {
 		psif_writel(psif, THR, val);
