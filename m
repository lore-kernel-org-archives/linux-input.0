From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] synaptics: T540p: make the min/max identical to other LEN0034 models
Date: Fri, 16 May 2014 20:46:47 +0200
Message-ID: <1400266009-5436-2-git-send-email-hdegoede@redhat.com>
References: <1400266009-5436-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1400266009-5436-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

The T540p has a touchpad with pnp-id LEN0034, all the models with this pnp-id
have the same min/max values, except the T540p where the values are slightly
off. Fix them to be identical.

This is a preparation patch for simplifying the quirk table.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index d4c05b1..898e8bb 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1603,7 +1603,7 @@ static const struct dmi_system_id min_max_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T540"),
 		},
-		.driver_data = (int []){1024, 5056, 2058, 4832},
+		.driver_data = (int []){1024, 5112, 2024, 4832},
 	},
 	{
 		/* Lenovo ThinkPad L540 */
-- 
1.9.0
