From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 7/7] Input: synaptics - Remove X1 Carbon 3rd gen from the topbuttonpad list
Date: Fri,  6 Feb 2015 15:04:35 -0500
Message-ID: <1423253075-23469-8-git-send-email-benjamin.tissoires@redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Lenovo decided to switch back to physical buttons for the trackstick
on their latest series. The PNPId list was provided before they reverted
back to physical buttons, so it contains the new models too.
We can know from the touchpad capabilities that the touchpad has physical
buttons, so removing the ids from the list is not mandatory. It is still
nicer to remove the wrong ids, so start by removing the X1 Carbon 3rd gen,
with the PNPId of LEN0048.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

v2:
- no changes

 drivers/input/mouse/synaptics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index dfe8235..7267738 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -186,7 +186,6 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN0045",
 	"LEN0046",
 	"LEN0047",
-	"LEN0048",
 	"LEN0049",
 	"LEN2000",
 	"LEN2001", /* Edge E431 */
-- 
2.1.0
