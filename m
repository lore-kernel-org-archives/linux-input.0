From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH] input: Silence 'unused variable' warning in iforce joystick driver
Date: Fri, 31 Aug 2007 00:13:12 +0200
Message-ID: <200708310013.12347.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>, dtor@mail.ru, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, Jesper Juhl <jesper.juhl@gmail.com>
List-Id: linux-input@vger.kernel.org

In the iforce driver we currently get this warning

 drivers/input/joystick/iforce/iforce-packets.c: In function 'iforce_get_id_packet':
 drivers/input/joystick/iforce/iforce-packets.c:249: warning: unused variable 'status'

if CONFIG_JOYSTICK_IFORCE_USB is not defined.

The warning is easy to avoid by simply moving the variable inside 
the only case in the switch that actually use it.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 3154ccd..48d4a86 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -246,13 +246,12 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 
 int iforce_get_id_packet(struct iforce *iforce, char *packet)
 {
-	int status;
-
 	switch (iforce->bus) {
 
 	case IFORCE_USB:
-
 #ifdef CONFIG_JOYSTICK_IFORCE_USB
+		int status;
+
 		iforce->cr.bRequest = packet[0];
 		iforce->ctrl->dev = iforce->usbdev;
 
