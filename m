From: Daniele Forsi <dforsi@gmail.com>
Subject: [RFC PATCH 1/2] USB: input: yealink.c: use KEY_NUMERIC_* for numeric keys, star and pound
Date: Mon, 22 Dec 2014 15:41:08 +0100
Message-ID: <1419259269-23820-2-git-send-email-dforsi@gmail.com>
References: <1419259269-23820-1-git-send-email-dforsi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419259269-23820-1-git-send-email-dforsi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henk Vergonet <Henk.Vergonet@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: usbb2k-api-dev@nongnu.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniele Forsi <dforsi@gmail.com>
List-Id: linux-input@vger.kernel.org

=46ix the "pound" key that being mapped to Shift+3 was returning '=C2=A3=
' instead
of '#' when using an Italian keyboard mapping and use the same values a=
s
the cm109.c driver (which was based on this yealink.c driver) also for =
'0'
to '9' and for '*'.

Signed-off-by: Daniele Forsi <dforsi@gmail.com>
---
 drivers/input/misc/yealink.c | 39 +++++++++++++++---------------------=
---
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.=
c
index 79c964c..e9403da 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -212,27 +212,24 @@ static int map_p1k_to_key(int scancode)
 	case 0x03: return KEY_ENTER;	/*   pickup	*/
 	case 0x14: return KEY_BACKSPACE; /*  C		*/
 	case 0x13: return KEY_ESC;	/*   hangup	*/
-	case 0x00: return KEY_1;	/*   1		*/
-	case 0x01: return KEY_2;	/*   2 		*/
-	case 0x02: return KEY_3;	/*   3		*/
-	case 0x10: return KEY_4;	/*   4		*/
-	case 0x11: return KEY_5;	/*   5		*/
-	case 0x12: return KEY_6;	/*   6		*/
-	case 0x20: return KEY_7;	/*   7		*/
-	case 0x21: return KEY_8;	/*   8		*/
-	case 0x22: return KEY_9;	/*   9		*/
-	case 0x30: return KEY_KPASTERISK; /* *		*/
-	case 0x31: return KEY_0;	/*   0		*/
-	case 0x32: return KEY_LEFTSHIFT |
-			  KEY_3 << 8;	/*   #		*/
+	case 0x00: return KEY_NUMERIC_1;	/*   1		*/
+	case 0x01: return KEY_NUMERIC_2;	/*   2		*/
+	case 0x02: return KEY_NUMERIC_3;	/*   3		*/
+	case 0x10: return KEY_NUMERIC_4;	/*   4		*/
+	case 0x11: return KEY_NUMERIC_5;	/*   5		*/
+	case 0x12: return KEY_NUMERIC_6;	/*   6		*/
+	case 0x20: return KEY_NUMERIC_7;	/*   7		*/
+	case 0x21: return KEY_NUMERIC_8;	/*   8		*/
+	case 0x22: return KEY_NUMERIC_9;	/*   9		*/
+	case 0x30: return KEY_NUMERIC_STAR;	/*   *		*/
+	case 0x31: return KEY_NUMERIC_0;	/*   0		*/
+	case 0x32: return KEY_NUMERIC_POUND;	/*   #		*/
 	}
 	return -EINVAL;
 }
=20
 /* Completes a request by converting the data into events for the
  * input subsystem.
- *
- * The key parameter can be cascaded: key2 << 8 | key1
  */
 static void report_key(struct yealink_dev *yld, int key)
 {
@@ -240,17 +237,13 @@ static void report_key(struct yealink_dev *yld, i=
nt key)
=20
 	if (yld->key_code >=3D 0) {
 		/* old key up */
-		input_report_key(idev, yld->key_code & 0xff, 0);
-		if (yld->key_code >> 8)
-			input_report_key(idev, yld->key_code >> 8, 0);
+		input_report_key(idev, yld->key_code, 0);
 	}
=20
 	yld->key_code =3D key;
 	if (key >=3D 0) {
 		/* new valid key */
-		input_report_key(idev, key & 0xff, 1);
-		if (key >> 8)
-			input_report_key(idev, key >> 8, 1);
+		input_report_key(idev, key, 1);
 	}
 	input_sync(idev);
 }
@@ -966,9 +959,7 @@ static int usb_probe(struct usb_interface *intf, co=
nst struct usb_device_id *id)
 	for (i =3D 0; i < 256; i++) {
 		int k =3D map_p1k_to_key(i);
 		if (k >=3D 0) {
-			set_bit(k & 0xff, input_dev->keybit);
-			if (k >> 8)
-				set_bit(k >> 8, input_dev->keybit);
+			set_bit(k, input_dev->keybit);
 		}
 	}
=20
--=20
2.1.3
