From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] synaptics: Change min/max quirk table to pnp-id matching
Date: Fri, 16 May 2014 20:46:49 +0200
Message-ID: <1400266009-5436-4-git-send-email-hdegoede@redhat.com>
References: <1400266009-5436-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1400266009-5436-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

Most of the affected models share pnp-ids for the touchpad. So switching
to pnp-ids give us 2 advantages:
1) It shrinks the quirk list
2) It will lower the new quirk addition frequency, ie the recently added W540
   quirk would not have been necessary since it uses the same LEN0034 pnp ids
   as other models already added before it

As an added bonus it actually puts the quirk on the actual psmouse, rather then
on the machine, which is technically more correct.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/synaptics.c | 149 ++++++++++------------------------------
 1 file changed, 36 insertions(+), 113 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 395ec9c..c5ec703 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -117,6 +117,31 @@ void synaptics_reset(struct psmouse *psmouse)
 }
 
 #ifdef CONFIG_MOUSE_PS2_SYNAPTICS
+struct min_max_quirk {
+	const char * const *pnp_ids;
+	int x_min, x_max, y_min, y_max;
+};
+
+static const struct min_max_quirk min_max_pnpid_table[] = {
+	{
+		(const char * const []){"LEN0033", NULL},
+		1024, 5052, 2258, 4832
+	},
+	{
+		(const char * const []){"LEN0035", "LEN0042", NULL},
+		1232, 5710, 1156, 4696
+	},
+	{
+		(const char * const []){"LEN0034", "LEN0036", "LEN2004", NULL},
+		1024, 5112, 2024, 4832
+	},
+	{
+		(const char * const []){"LEN2001", NULL},
+		1024, 5022, 2508, 4832
+	},
+	{ }
+};
+
 /* This list has been kindly provided by Synaptics. */
 static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN0017",
@@ -129,7 +154,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN002D",
 	"LEN002E",
 	"LEN0033", /* Helix */
-	"LEN0034", /* T431s, T540, X1 Carbon 2nd */
+	"LEN0034", /* T431s, L440, L540, T540, W540, X1 Carbon 2nd */
 	"LEN0035", /* X240 */
 	"LEN0036", /* T440 */
 	"LEN0037",
@@ -142,7 +167,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN0048",
 	"LEN0049",
 	"LEN2000",
-	"LEN2001",
+	"LEN2001", /* Edge E431 */
 	"LEN2002",
 	"LEN2003",
 	"LEN2004", /* L440 */
@@ -316,20 +341,20 @@ static int synaptics_identify(struct psmouse *psmouse)
  * Resolution is left zero if touchpad does not support the query
  */
 
-static const int *quirk_min_max;
-
 static int synaptics_resolution(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 	unsigned char resp[3];
+	int i;
 
-	if (quirk_min_max) {
-		priv->x_min = quirk_min_max[0];
-		priv->x_max = quirk_min_max[1];
-		priv->y_min = quirk_min_max[2];
-		priv->y_max = quirk_min_max[3];
-		return 0;
-	}
+	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++)
+		if (matches_pnp_id(psmouse, min_max_pnpid_table[i].pnp_ids)) {
+			priv->x_min = min_max_pnpid_table[i].x_min;
+			priv->x_max = min_max_pnpid_table[i].x_max;
+			priv->y_min = min_max_pnpid_table[i].y_min;
+			priv->y_max = min_max_pnpid_table[i].y_max;
+			return 0;
+		}
 
 	if (SYN_ID_MAJOR(priv->identity) < 4)
 		return 0;
@@ -1550,112 +1575,10 @@ static const struct dmi_system_id olpc_dmi_table[] __initconst = {
 	{ }
 };
 
-static const struct dmi_system_id min_max_dmi_table[] __initconst = {
-#if defined(CONFIG_DMI)
-	{
-		/* Lenovo ThinkPad Helix */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Helix"),
-		},
-		.driver_data = (int []){1024, 5052, 2258, 4832},
-	},
-	{
-		/* Lenovo ThinkPad X240 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X240"),
-		},
-		.driver_data = (int []){1232, 5710, 1156, 4696},
-	},
-	{
-		/* Lenovo ThinkPad Edge E431 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Edge E431"),
-		},
-		.driver_data = (int []){1024, 5022, 2508, 4832},
-	},
-	{
-		/* Lenovo ThinkPad T431s */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T431"),
-		},
-		.driver_data = (int []){1024, 5112, 2024, 4832},
-	},
-	{
-		/* Lenovo ThinkPad T440s */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T440"),
-		},
-		.driver_data = (int []){1024, 5112, 2024, 4832},
-	},
-	{
-		/* Lenovo ThinkPad L440 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L440"),
-		},
-		.driver_data = (int []){1024, 5112, 2024, 4832},
-	},
-	{
-		/* Lenovo ThinkPad T540p */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T540"),
-		},
-		.driver_data = (int []){1024, 5112, 2024, 4832},
-	},
-	{
-		/* Lenovo ThinkPad L540 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L540"),
-		},
-		.driver_data = (int []){1024, 5112, 2024, 4832},
-	},
-	{
-		/* Lenovo ThinkPad W540 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W540"),
-		},
-		.driver_data = (int []){1024, 5112, 2024, 4832},
-	},
-	{
-		/* Lenovo Yoga S1 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
-					"ThinkPad S1 Yoga"),
-		},
-		.driver_data = (int []){1232, 5710, 1156, 4696},
-	},
-	{
-		/* Lenovo ThinkPad X1 Carbon Haswell (3rd generation) */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION,
-					"ThinkPad X1 Carbon 2nd"),
-		},
-		.driver_data = (int []){1024, 5112, 2024, 4832},
-	},
-#endif
-	{ }
-};
-
 void __init synaptics_module_init(void)
 {
-	const struct dmi_system_id *min_max_dmi;
-
 	impaired_toshiba_kbc = dmi_check_system(toshiba_dmi_table);
 	broken_olpc_ec = dmi_check_system(olpc_dmi_table);
-
-	min_max_dmi = dmi_first_match(min_max_dmi_table);
-	if (min_max_dmi)
-		quirk_min_max = min_max_dmi->driver_data;
 }
 
 static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
-- 
1.9.0
