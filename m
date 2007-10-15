From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] Map MS Presenter 8000 bottom-side buttons
Date: Mon, 15 Oct 2007 19:35:21 +0200
Message-ID: <4713A4D9.4060909@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

The MS Presenter 8000 bluetooth mouse is a "dual-use" device: If you press a button on the top, you can turn it around and find special keys on the other side, useful for presentations. This patch maps those three bottom-keys that are not already detected to the intended functions. The magic bottom on the top is mapped to F5 when we switch from mouse to presenter mode in order to activate the presentation mode in the related software (e.g. OpenOffice).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

---
 drivers/hid/hid-input.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

Index: linux-2.6.23.1/drivers/hid/hid-input.c
===================================================================
--- linux-2.6.23.1.orig/drivers/hid/hid-input.c
+++ linux-2.6.23.1/drivers/hid/hid-input.c
@@ -737,9 +737,19 @@ static void hidinput_configure_usage(str
 					case 0xff0b: map_key_clear(BTN_B);		break;
 					default:    goto ignore;
 				}
-			} else {
+			} else if (device->vendor == 0x045e && device->product == 0x0713) {
+				set_bit(EV_REP, input->evbit);
+				switch(usage->hid & HID_USAGE) {
+					/* Make MS Presenter 8000 bottom-side keys useful,
+					 * e.g. under OOffice */
+					case 0xfd08: map_key_clear(KEY_RIGHT);		break;
+					case 0xfd09: map_key_clear(KEY_LEFT);		break;
+					case 0xfd0b: map_key_clear(KEY_PAUSE);		break;
+					case 0xfd0f: map_key_clear(KEY_F5);		break;
+					default:    goto ignore;
+				}
+			} else
 				goto ignore;
-			}
 			break;
 
 		case HID_UP_CUSTOM: /* Reported on Logitech and Powerbook USB keyboards */
