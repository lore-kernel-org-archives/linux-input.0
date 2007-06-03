From: Jan Kratochvil <honza@jikos.cz>
Subject: [PATCH 2/4] xpad.c Check for data length and ignore packet if it is
 smaller
Date: Sun, 3 Jun 2007 16:01:36 +0200 (CEST)
Message-ID: <alpine.LRH.0.98.0706031556110.22353@twin.jikos.cz>
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

xpad360_process_packet will ignore packets smaller then 20 bytes. For example 
notification about headset connection is only 3 bytes long.

Signed-off-by: Jan Kratochvil <honza@jikos.cz>
---
  drivers/input/joystick/xpad.c |    5 +++++
  1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 56d5e3e..15f9877 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -268,12 +268,17 @@ static void xpad_process_packet(struct u
   *
   *	The used report descriptor was taken from:
   *		http://www.free60.org/wiki/Gamepad
+ *     Packet length for valid data is 20 bytes.
   */

  static void xpad360_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
  {
  	struct input_dev *dev = xpad->dev;

+	/* valid data */
+	if (data[1] < 20)
+		return;
+
  	/* digital pad */
  	if (xpad->dpad_mapping == MAP_DPAD_TO_AXES) {
  		input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x01) - !!((data[2] & 0x08) >> 3));
-- 
1.4.3.4
