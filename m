From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] HID: wacom: bitwise vs logical ORs
Date: Wed, 9 Dec 2015 13:22:05 +0300
Message-ID: <20151209102205.GB3173@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Smatch complains that these should probably be bitwise ORs instead of
logical.  It doesn't matter for "prox" but it makes a difference for
"strip1" and "strip2".

Fixes: c7f0522a1ad1 ('HID: wacom: Slim down wacom_intuos_pad processing')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 7cf0417..af330aa 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -545,12 +545,12 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 			          ((data[6] & 0x0F) << 4)  |
 			          (data[5] & 0x0F);
 		}
-		strip1 = (data[1] << 8) || data[2];
-		strip2 = (data[3] << 8) || data[4];
+		strip1 = (data[1] << 8) | data[2];
+		strip2 = (data[3] << 8) | data[4];
 	}
 
-	prox = (buttons & ~(~0 << nbuttons)) || (keys & ~(~0 << nkeys)) ||
-	       (ring1 & 0x80) || (ring2 & 0x80) || strip1 || strip2;
+	prox = (buttons & ~(~0 << nbuttons)) | (keys & ~(~0 << nkeys)) |
+	       (ring1 & 0x80) | (ring2 & 0x80) | strip1 | strip2;
 
 	wacom_report_numbered_buttons(input, nbuttons, buttons);
 
