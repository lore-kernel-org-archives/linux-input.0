From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/4] Input - synaptics: fix middle button on Lenovo 2015 products
Date: Wed, 28 Jan 2015 15:10:04 -0500
Message-ID: <1422475807-15033-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1422475807-15033-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422475807-15033-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On the X1 Carbon 3rd gen (with a 2015 broadwell cpu), the physical middle
button of the trackstick (attached to the touchpad serio device, of course)
seems to get lost.

Actually, the touchpads reports 3 extra buttons, which falls in the switch
below to the '2' case. Let's handle the case of odd numbers also, so that
the middle button finds its way back.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/synaptics.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f89de89..0d12664 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -689,7 +689,7 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
 
 		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
 		    ((buf[0] ^ buf[3]) & 0x02)) {
-			switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
+			switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
 			default:
 				/*
 				 * if nExtBtn is greater than 8 it should be
@@ -698,15 +698,19 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
 				break;
 			case 8:
 				hw->ext_buttons |= ((buf[5] & 0x08)) ? 0x80 : 0;
+			case 7:
 				hw->ext_buttons |= ((buf[4] & 0x08)) ? 0x40 : 0;
 			case 6:
 				hw->ext_buttons |= ((buf[5] & 0x04)) ? 0x20 : 0;
+			case 5:
 				hw->ext_buttons |= ((buf[4] & 0x04)) ? 0x10 : 0;
 			case 4:
 				hw->ext_buttons |= ((buf[5] & 0x02)) ? 0x08 : 0;
+			case 3:
 				hw->ext_buttons |= ((buf[4] & 0x02)) ? 0x04 : 0;
 			case 2:
 				hw->ext_buttons |= ((buf[5] & 0x01)) ? 0x02 : 0;
+			case 1:
 				hw->ext_buttons |= ((buf[4] & 0x01)) ? 0x01 : 0;
 			}
 		}
-- 
2.1.0
