From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: [PATCH 1/4] hda: Rename fixup thinkpad_acpi to fixup_thinkpad
Date: Mon, 12 Sep 2016 12:44:50 +0200
Message-ID: <5cb009b2-11a0-fb19-e751-965a874903b0@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de, lukas@wunner.de, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, david.henningsson@canonical.com, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com, jikos@kernel.org
List-Id: linux-input@vger.kernel.org

This is some preparatory work to not only support led control in
thinkpad_helper over thinkpad_acpi.

A further patch will introduce led control over hid-lenovo.
This will make it possible to use the thinkpad_helper not only with
lenovo devices via acpi but also with hid-lenovo driver
if there is a hid-lenovo compatible device found.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
---
 sound/pci/hda/patch_conexant.c  | 14 +++++++-------
 sound/pci/hda/patch_realtek.c   | 24 ++++++++++++------------
 sound/pci/hda/thinkpad_helper.c |  4 ++--
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 56fefbd..d54ffd9 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -254,7 +254,7 @@ enum {
 	CXT_FIXUP_HEADPHONE_MIC,
 	CXT_FIXUP_GPIO1,
 	CXT_FIXUP_ASPIRE_DMIC,
-	CXT_FIXUP_THINKPAD_ACPI,
+	CXT_FIXUP_THINKPAD,
 	CXT_FIXUP_OLPC_XO,
 	CXT_FIXUP_CAP_MIX_AMP,
 	CXT_FIXUP_TOSHIBA_P105,
@@ -263,7 +263,7 @@ enum {
 	CXT_FIXUP_MUTE_LED_EAPD,
 };
 
-/* for hda_fixup_thinkpad_acpi() */
+/* for hda_fixup_thinkpad() */
 #include "thinkpad_helper.c"
 
 static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
@@ -670,7 +670,7 @@ static void cxt_fixup_cap_mix_amp_5047(struct hda_codec *codec,
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_lenovo_tp410,
 		.chained = true,
-		.chain_id = CXT_FIXUP_THINKPAD_ACPI,
+		.chain_id = CXT_FIXUP_THINKPAD,
 	},
 	[CXT_PINCFG_LEMOTE_A1004] = {
 		.type = HDA_FIXUP_PINS,
@@ -727,9 +727,9 @@ static void cxt_fixup_cap_mix_amp_5047(struct hda_codec *codec,
 		.chained = true,
 		.chain_id = CXT_FIXUP_GPIO1,
 	},
-	[CXT_FIXUP_THINKPAD_ACPI] = {
+	[CXT_FIXUP_THINKPAD] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = hda_fixup_thinkpad_acpi,
+		.v.func = hda_fixup_thinkpad,
 	},
 	[CXT_FIXUP_OLPC_XO] = {
 		.type = HDA_FIXUP_FUNC,
@@ -828,7 +828,7 @@ static void cxt_fixup_cap_mix_amp_5047(struct hda_codec *codec,
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
-	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
+	SND_PCI_QUIRK_VENDOR(0x17aa,  "Thinkpad", CXT_FIXUP_THINKPAD),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
 	{}
@@ -839,7 +839,7 @@ static void cxt_fixup_cap_mix_amp_5047(struct hda_codec *codec,
 	{ .id = CXT_FIXUP_GPIO1, .name = "gpio1" },
 	{ .id = CXT_FIXUP_HEADPHONE_MIC_PIN, .name = "headphone-mic-pin" },
 	{ .id = CXT_PINCFG_LENOVO_TP410, .name = "tp410" },
-	{ .id = CXT_FIXUP_THINKPAD_ACPI, .name = "thinkpad" },
+	{ .id = CXT_FIXUP_THINKPAD, .name = "thinkpad" },
 	{ .id = CXT_PINCFG_LEMOTE_A1004, .name = "lemote-a1004" },
 	{ .id = CXT_PINCFG_LEMOTE_A1205, .name = "lemote-a1205" },
 	{ .id = CXT_FIXUP_OLPC_XO, .name = "olpc-xo" },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1fe8750..6d78d76 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4754,7 +4754,7 @@ static void alc280_fixup_hp_9480m(struct hda_codec *codec,
 	}
 }
 
-/* for hda_fixup_thinkpad_acpi() */
+/* for hda_fixup_thinkpad() */
 #include "thinkpad_helper.c"
 
 /* for dell wmi mic mute led */
@@ -4819,8 +4819,8 @@ enum {
 	ALC290_FIXUP_MONO_SPEAKERS_HSJACK,
 	ALC290_FIXUP_SUBWOOFER,
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
-	ALC269_FIXUP_THINKPAD_ACPI,
-	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
+	ALC269_FIXUP_THINKPAD,
+	ALC269_FIXUP_DMIC_THINKPAD,
 	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 	ALC255_FIXUP_HEADSET_MODE,
@@ -5052,7 +5052,7 @@ enum {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
 		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+		.chain_id = ALC269_FIXUP_THINKPAD,
 	},
 	[ALC269_FIXUP_DELL1_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
@@ -5175,7 +5175,7 @@ enum {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_limit_int_mic_boost,
 		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+		.chain_id = ALC269_FIXUP_THINKPAD,
 	},
 	[ALC269VB_FIXUP_ASUS_ZENBOOK] = {
 		.type = HDA_FIXUP_FUNC,
@@ -5261,17 +5261,17 @@ enum {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
 	},
-	[ALC269_FIXUP_THINKPAD_ACPI] = {
+	[ALC269_FIXUP_THINKPAD] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = hda_fixup_thinkpad_acpi,
+		.v.func = hda_fixup_thinkpad,
 		.chained = true,
 		.chain_id = ALC269_FIXUP_SKU_IGNORE,
 	},
-	[ALC269_FIXUP_DMIC_THINKPAD_ACPI] = {
+	[ALC269_FIXUP_DMIC_THINKPAD] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic,
 		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+		.chain_id = ALC269_FIXUP_THINKPAD,
 	},
 	[ALC255_FIXUP_DELL1_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
@@ -5471,7 +5471,7 @@ enum {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_disable_aamix,
 		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
+		.chain_id = ALC269_FIXUP_THINKPAD
 	},
 	[ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY] = {
 		.type = HDA_FIXUP_FUNC,
@@ -5691,7 +5691,7 @@ enum {
 	SND_PCI_QUIRK(0x17aa, 0x2233, "Thinkpad", ALC292_FIXUP_TPT460),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
-	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "IdeaPad Y410P", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
@@ -5766,7 +5766,7 @@ enum {
 	SND_PCI_QUIRK_VENDOR(0x1025, "Acer Aspire", ALC271_FIXUP_DMIC),
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK_VENDOR(0x104d, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
-	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", ALC269_FIXUP_THINKPAD_ACPI),
+	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", ALC269_FIXUP_THINKPAD),
 	{}
 };
 
diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
index f0955fd..62741a7 100644
--- a/sound/pci/hda/thinkpad_helper.c
+++ b/sound/pci/hda/thinkpad_helper.c
@@ -38,7 +38,7 @@ static void update_tpacpi_micmute_led(struct hda_codec *codec,
 	}
 }
 
-static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
+static void hda_fixup_thinkpad(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -81,7 +81,7 @@ static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
 
 #else /* CONFIG_THINKPAD_ACPI */
 
-static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
+static void hda_fixup_thinkpad(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
 {
 }
-- 
1.9.1
