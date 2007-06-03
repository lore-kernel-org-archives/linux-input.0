From: Jan Kratochvil <honza@jikos.cz>
Subject: [PATCH 4/4] xpad.c - fixed report for dpad and inverted Y and RY
 axes
Date: Sun, 3 Jun 2007 16:14:32 +0200 (CEST)
Message-ID: <alpine.LRH.0.98.0706031610380.22353@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Brian Magnuson <bdmagnuson@gmail.com>
List-Id: linux-input@vger.kernel.org

Fixed input report handling for xbox 360 controller.
Y/RY up is now positive and down negative.
DPAD report fixed.

Reported-by: Brian Magnuson <bdmagnuson@gmail.com>
Signed-off-by: Jan Kratochvil <honza@jikos.cz>
---
  drivers/input/joystick/xpad.c |   16 ++++++++--------
  1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 1651950..f3f2ade 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -283,14 +283,14 @@ static void xpad360_process_packet(struc

  	/* digital pad */
  	if (xpad->dpad_mapping == MAP_DPAD_TO_AXES) {
-		input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x01) - !!((data[2] & 0x08) >> 3));
-		input_report_abs(dev, ABS_HAT0Y, !!((data[2] & 0x02) >> 1) - !!((data[2] & 0x04) >> 2));
+		input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x01) - !!((data[2] & 0x02) >> 1));
+		input_report_abs(dev, ABS_HAT0Y, !!((data[2] & 0x08) >> 3) - !!((data[2] & 0x04) >> 2));
  	} else if ( xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS ) {
  		/* dpad as buttons (right, left, down, up) */
-		input_report_key(dev, BTN_RIGHT, (data[2] & 0x01));
-		input_report_key(dev, BTN_LEFT, (data[2] & 0x08) >> 3);
-		input_report_key(dev, BTN_0, (data[2] & 0x02) >> 1);
-		input_report_key(dev, BTN_1, (data[2] & 0x04) >> 2);
+		input_report_key(dev, BTN_0, (data[2] & 0x01));
+		input_report_key(dev, BTN_1, (data[2] & 0x02) >> 1);
+		input_report_key(dev, BTN_LEFT, (data[2] & 0x04) >> 2);
+		input_report_key(dev, BTN_RIGHT, (data[2] & 0x08) >> 3);
  	}

  	/* start/back buttons */
@@ -312,10 +312,10 @@ static void xpad360_process_packet(struc

  	/* left stick */
  	input_report_abs(dev, ABS_X, (__s16) (((__s16)data[7] << 8) | (__s16)data[6]));
-	input_report_abs(dev, ABS_Y, ~(__s16) (((__s16)data[9] << 8) | (__s16)data[8]));
+	input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[9] << 8) | (__s16)data[8]));

  	/* right stick */
-	input_report_abs(dev, ABS_RY, ~(__s16) (((__s16)data[13] << 8) | (__s16)data[12]));
+	input_report_abs(dev, ABS_RY, (__s16) (((__s16)data[13] << 8) | (__s16)data[12]));
  	input_report_abs(dev, ABS_RX, (__s16) (((__s16)data[11] << 8) | (__s16)data[10]));

  	/* triggers left/right */
-- 
1.4.3.4
