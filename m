From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 8/7] Input: synaptics - Remove X250 from the topbuttonpad list
Date: Thu, 12 Feb 2015 12:09:13 -0500
Message-ID: <1423760953-30365-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Lenovo X250 has a PnpID of LEN0046, but it does not have
the top software button requirement.

For the record, Lenovo T450s and W541 have a PnpID of
LEN200f and LEN004a, so they are not on the top software
button list.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi Dmitry,

we got our hands on 3 new Lenovo laptops, and only one appears in the
top buttonpad list. Again no need to CC stable this one I think.

Cheers,
Benjamin

 drivers/input/mouse/synaptics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7267738..fa3d683 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -184,7 +184,6 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN0041",
 	"LEN0042", /* Yoga */
 	"LEN0045",
-	"LEN0046",
 	"LEN0047",
 	"LEN0049",
 	"LEN2000",
-- 
2.1.0
