From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] drivers/input/: #if 0 unused functions
Date: Mon, 31 Mar 2008 02:28:09 +0300
Message-ID: <20080330232809.GU28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:54331 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755364AbYC3X2W (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Mar 2008 19:28:22 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This patch #if 0's the following unused functions:
- gameport/gameport.c:gameport_reconnect()
- gameport/gameport.c:gameport_rescan()
- serio/libps2.c:ps2_execute_scheduled_command()
- serio/libps2.c:ps2_schedule_command()

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/input/gameport/gameport.c |    5 ++++-
 drivers/input/serio/libps2.c      |    4 ++++
 include/linux/gameport.h          |    1 -
 include/linux/libps2.h            |    1 -
 4 files changed, 8 insertions(+), 3 deletions(-)

0df226574e0cd37388380469589f9348e334a7a3 diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index c5600ac..a6f2552 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -36,7 +36,6 @@ EXPORT_SYMBOL(__gameport_register_driver);
 EXPORT_SYMBOL(gameport_unregister_driver);
 EXPORT_SYMBOL(gameport_open);
 EXPORT_SYMBOL(gameport_close);
-EXPORT_SYMBOL(gameport_rescan);
 EXPORT_SYMBOL(gameport_set_phys);
 EXPORT_SYMBOL(gameport_start_polling);
 EXPORT_SYMBOL(gameport_stop_polling);
@@ -651,6 +650,8 @@ static void gameport_disconnect_port(struct gameport *gameport)
 	device_release_driver(&gameport->dev);
 }
 
+#if 0
+
 void gameport_rescan(struct gameport *gameport)
 {
 	gameport_queue_event(gameport, NULL, GAMEPORT_RESCAN);
@@ -661,6 +662,8 @@ void gameport_reconnect(struct gameport *gameport)
 	gameport_queue_event(gameport, NULL, GAMEPORT_RECONNECT);
 }
 
+#endif  /*  0  */
+
 /*
  * Submits register request to kgameportd for subsequent execution.
  * Note that port registration is always asynchronous.
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index b819239..5a8347c 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -245,6 +245,8 @@ int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
 }
 EXPORT_SYMBOL(ps2_command);
 
+#if 0
+
 /*
  * ps2_execute_scheduled_command() sends a command, previously scheduled by
  * ps2_schedule_command(), to a PS/2 device (keyboard, mouse, etc.)
@@ -288,6 +290,8 @@ int ps2_schedule_command(struct ps2dev *ps2dev, unsigned char *param, int comman
 }
 EXPORT_SYMBOL(ps2_schedule_command);
 
+#endif  /*  0  */
+
 /*
  * ps2_init() initializes ps2dev structure
  */
diff --git a/include/linux/gameport.h b/include/linux/gameport.h
index afad952..f64e29c 100644
--- a/include/linux/gameport.h
+++ b/include/linux/gameport.h
@@ -68,7 +68,6 @@ struct gameport_driver {
 
 int gameport_open(struct gameport *gameport, struct gameport_driver *drv, int mode);
 void gameport_close(struct gameport *gameport);
-void gameport_rescan(struct gameport *gameport);
 
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
 
diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index f6f301e..afc4133 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -43,7 +43,6 @@ void ps2_init(struct ps2dev *ps2dev, struct serio *serio);
 int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout);
 void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout);
 int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
-int ps2_schedule_command(struct ps2dev *ps2dev, unsigned char *param, int command);
 int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data);
 int ps2_handle_response(struct ps2dev *ps2dev, unsigned char data);
 void ps2_cmd_aborted(struct ps2dev *ps2dev);

