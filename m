From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] Map MS Presenter 8000 bottom-side buttons
Date: Tue, 16 Oct 2007 19:12:27 +0200
Message-ID: <4714F0FB.4090403@siemens.com>
References: <4713A4D9.4060909@siemens.com> <Pine.LNX.4.64.0710161214440.12935@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0710161214440.12935@jikos.suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Mon, 15 Oct 2007, Jan Kiszka wrote:
> 
>> +			} else if (device->vendor == 0x045e && device->product == 0x0713) {
>> +				set_bit(EV_REP, input->evbit);
>> +				switch(usage->hid & HID_USAGE) {
>> +					/* Make MS Presenter 8000 bottom-side keys useful,
>> +					 * e.g. under OOffice */
>> +					case 0xfd08: map_key_clear(KEY_RIGHT);		break;
>> +					case 0xfd09: map_key_clear(KEY_LEFT);		break;
>> +					case 0xfd0b: map_key_clear(KEY_PAUSE);		break;
>> +					case 0xfd0f: map_key_clear(KEY_F5);		break;
>> +					default:    goto ignore;
>> +				}
>> +			} else
> 
> Hi Jan,
> 
> could you please take a short look at current Linus' git tree - there are 
> some more devices using MSVENDOR page, and we have introduced macros to 
> match them. It would be great if you could redo the patch to fit into this 
> picture and send it to me again.

OK. Do you mean something like this? Sorry, in a hurry, not even
compile-tested...

--snip--

The MS Presenter 8000 bluetooth mouse is a "dual-use" device: If you
press a button on the top, you can turn it around and find special keys
on the other side, useful for presentations. This patch maps those three
bottom-keys that are not already detected to the intended functions. The
magic bottom on the top is mapped to F5 when we switch from mouse to
presenter mode in order to activate the presentation mode in the related
software (e.g. OpenOffice).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

---
 drivers/hid/hid-input.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/hid/hid-input.c
===================================================================
--- linux-2.6.orig/drivers/hid/hid-input.c
+++ linux-2.6/drivers/hid/hid-input.c
@@ -89,6 +89,7 @@ static const struct {
 /* hardware needing special handling due to colliding MSVENDOR page usages */
 #define IS_CHICONY_TACTICAL_PAD(x) (x->vendor == 0x04f2 && device->product == 0x0418)
 #define IS_MS_KB(x) (x->vendor == 0x045e && (x->product == 0x00db || x->product == 0x00f9))
+#define IS_MS_PRESENTER_8000(x) (x->vendor == 0x045e && x->product == 0x0713)
 
 #ifdef CONFIG_USB_HIDINPUT_POWERBOOK
 
@@ -780,9 +781,20 @@ static void hidinput_configure_usage(str
 						set_bit(KEY_F18, input->keybit);
 					default:	goto ignore;
 				}
-			} else {
+
+			/* Microsoft Wireless Notebook Presenter Mouse 8000 */
+			} else if (IS_MS_PRESENTER_8000(device)) {
+				set_bit(EV_REP, input->evbit);
+				switch(usage->hid & HID_USAGE) {
+					/* Useful mappings of bottom-side keys for presentations */
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
