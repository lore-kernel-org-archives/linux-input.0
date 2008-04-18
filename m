From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [2.6 patch] drivers/input/: #if 0 unused functions
Date: Fri, 18 Apr 2008 11:58:35 -0400
Message-ID: <20080418115615.ZZRA012@mailhub.coreip.homeip.net>
References: <20080330232809.GU28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:45569 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbYDRP6m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Apr 2008 11:58:42 -0400
Received: by wr-out-0506.google.com with SMTP id c48so398872wra.1
        for <linux-input@vger.kernel.org>; Fri, 18 Apr 2008 08:58:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080330232809.GU28445@cs181133002.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-input@vger.kernel.org

Hi Adrian,

On Mon, Mar 31, 2008 at 02:28:09AM +0300, Adrian Bunk wrote:
> This patch #if 0's the following unused functions:
> - gameport/gameport.c:gameport_reconnect()
> - gameport/gameport.c:gameport_rescan()
> - serio/libps2.c:ps2_execute_scheduled_command()
> - serio/libps2.c:ps2_schedule_command()
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 

Thank you for the patch but I'd rather completely remove these
functions, like in these 2 patches below.

-- 
Dmitry

Input: gameport - remove rescan/reconnect facilities

They have never been used and are unlikely to be used in the future
so remove them altogether.

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/gameport/gameport.c |   22 ----------------------
 include/linux/gameport.h          |    1 -
 2 files changed, 23 deletions(-)

Index: linux/drivers/input/gameport/gameport.c
===================================================================
--- linux.orig/drivers/input/gameport/gameport.c
+++ linux/drivers/input/gameport/gameport.c
@@ -36,7 +36,6 @@ EXPORT_SYMBOL(__gameport_register_driver
 EXPORT_SYMBOL(gameport_unregister_driver);
 EXPORT_SYMBOL(gameport_open);
 EXPORT_SYMBOL(gameport_close);
-EXPORT_SYMBOL(gameport_rescan);
 EXPORT_SYMBOL(gameport_set_phys);
 EXPORT_SYMBOL(gameport_start_polling);
 EXPORT_SYMBOL(gameport_stop_polling);
@@ -230,8 +229,6 @@ static void gameport_find_driver(struct 
  */
 
 enum gameport_event_type {
-	GAMEPORT_RESCAN,
-	GAMEPORT_RECONNECT,
 	GAMEPORT_REGISTER_PORT,
 	GAMEPORT_REGISTER_DRIVER,
 };
@@ -365,15 +362,6 @@ static void gameport_handle_event(void)
 				gameport_add_port(event->object);
 				break;
 
-			case GAMEPORT_RECONNECT:
-				gameport_reconnect_port(event->object);
-				break;
-
-			case GAMEPORT_RESCAN:
-				gameport_disconnect_port(event->object);
-				gameport_find_driver(event->object);
-				break;
-
 			case GAMEPORT_REGISTER_DRIVER:
 				gameport_add_driver(event->object);
 				break;
@@ -651,16 +639,6 @@ static void gameport_disconnect_port(str
 	device_release_driver(&gameport->dev);
 }
 
-void gameport_rescan(struct gameport *gameport)
-{
-	gameport_queue_event(gameport, NULL, GAMEPORT_RESCAN);
-}
-
-void gameport_reconnect(struct gameport *gameport)
-{
-	gameport_queue_event(gameport, NULL, GAMEPORT_RECONNECT);
-}
-
 /*
  * Submits register request to kgameportd for subsequent execution.
  * Note that port registration is always asynchronous.
Index: linux/include/linux/gameport.h
===================================================================
--- linux.orig/include/linux/gameport.h
+++ linux/include/linux/gameport.h
@@ -68,7 +68,6 @@ struct gameport_driver {
 
 int gameport_open(struct gameport *gameport, struct gameport_driver *drv, int mode);
 void gameport_close(struct gameport *gameport);
-void gameport_rescan(struct gameport *gameport);
 
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
 
Input: libps2 - remove delayed command execution

Delayed command execution is not used by anyone so let's remove it.

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/serio/libps2.c |   52 -------------------------------------------
 include/linux/libps2.h       |    1 
 2 files changed, 53 deletions(-)

Index: linux/drivers/input/serio/libps2.c
===================================================================
--- linux.orig/drivers/input/serio/libps2.c
+++ linux/drivers/input/serio/libps2.c
@@ -26,15 +26,6 @@ MODULE_AUTHOR("Dmitry Torokhov <dtor@mai
 MODULE_DESCRIPTION("PS/2 driver library");
 MODULE_LICENSE("GPL");
 
-/* Work structure to schedule execution of a command */
-struct ps2work {
-	struct work_struct work;
-	struct ps2dev *ps2dev;
-	int command;
-	unsigned char param[0];
-};
-
-
 /*
  * ps2_sendbyte() sends a byte to the device and waits for acknowledge.
  * It doesn't handle retransmission, though it could - because if there
@@ -246,49 +237,6 @@ int ps2_command(struct ps2dev *ps2dev, u
 EXPORT_SYMBOL(ps2_command);
 
 /*
- * ps2_execute_scheduled_command() sends a command, previously scheduled by
- * ps2_schedule_command(), to a PS/2 device (keyboard, mouse, etc.)
- */
-
-static void ps2_execute_scheduled_command(struct work_struct *work)
-{
-	struct ps2work *ps2work = container_of(work, struct ps2work, work);
-
-	ps2_command(ps2work->ps2dev, ps2work->param, ps2work->command);
-	kfree(ps2work);
-}
-
-/*
- * ps2_schedule_command() allows to schedule delayed execution of a PS/2
- * command and can be used to issue a command from an interrupt or softirq
- * context.
- */
-
-int ps2_schedule_command(struct ps2dev *ps2dev, unsigned char *param, int command)
-{
-	struct ps2work *ps2work;
-	int send = (command >> 12) & 0xf;
-	int receive = (command >> 8) & 0xf;
-
-	if (!(ps2work = kmalloc(sizeof(struct ps2work) + max(send, receive), GFP_ATOMIC)))
-		return -1;
-
-	memset(ps2work, 0, sizeof(struct ps2work));
-	ps2work->ps2dev = ps2dev;
-	ps2work->command = command;
-	memcpy(ps2work->param, param, send);
-	INIT_WORK(&ps2work->work, ps2_execute_scheduled_command);
-
-	if (!schedule_work(&ps2work->work)) {
-		kfree(ps2work);
-		return -1;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(ps2_schedule_command);
-
-/*
  * ps2_init() initializes ps2dev structure
  */
 
Index: linux/include/linux/libps2.h
===================================================================
--- linux.orig/include/linux/libps2.h
+++ linux/include/linux/libps2.h
@@ -43,7 +43,6 @@ void ps2_init(struct ps2dev *ps2dev, str
 int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout);
 void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout);
 int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
-int ps2_schedule_command(struct ps2dev *ps2dev, unsigned char *param, int command);
 int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data);
 int ps2_handle_response(struct ps2dev *ps2dev, unsigned char data);
 void ps2_cmd_aborted(struct ps2dev *ps2dev);
