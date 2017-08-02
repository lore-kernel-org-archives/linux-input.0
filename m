From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elantech - support new touchpad IC and extend elan's touchapd command Origianl ic-body field is not sufficient for upcoming IC, Elan ps/2 driver extend the fomation to support future IC. Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Date: Wed,  2 Aug 2017 19:11:41 +0800
Message-ID: <1501672301-3443-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw
List-Id: linux-input@vger.kernel.org

---
 drivers/input/mouse/elantech.c | 28 ++++++++++++++++++++++++----
 drivers/input/mouse/elantech.h |  3 +++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 65c9de3..14ab5ba 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1398,6 +1398,10 @@ static bool elantech_is_signature_valid(const unsigned char *param)
 	    param[2] < 40)
 		return true;
 
+	/* hw_version 0x0F does not need to check rate alose*/
+	if ((param[0] & 0x0f) == 0x0f)
+		return true;
+
 	for (i = 0; i < ARRAY_SIZE(rates); i++)
 		if (param[2] == rates[i])
 			return false;
@@ -1576,7 +1580,7 @@ static const struct dmi_system_id no_hw_res_dmi_table[] = {
 /*
  * determine hardware version and set some properties according to it.
  */
-static int elantech_set_properties(struct elantech_data *etd)
+static int elantech_set_properties(struct elantech_data *etd, struct psmouse *psmouse)
 {
 	/* This represents the version of IC body. */
 	int ver = (etd->fw_version & 0x0f0000) >> 16;
@@ -1593,14 +1597,14 @@ static int elantech_set_properties(struct elantech_data *etd)
 		case 5:
 			etd->hw_version = 3;
 			break;
-		case 6 ... 14:
+		case 6 ... 15:
 			etd->hw_version = 4;
 			break;
 		default:
 			return -1;
 		}
 	}
-
+	
 	/* decide which send_cmd we're gonna use early */
 	etd->send_cmd = etd->hw_version >= 3 ? elantech_send_cmd :
 					       synaptics_send_cmd;
@@ -1634,6 +1638,22 @@ static int elantech_set_properties(struct elantech_data *etd)
 	/* Enable real hardware resolution on hw_version 3 ? */
 	etd->set_hw_resolution = !dmi_check_system(no_hw_res_dmi_table);
 
+	/*if ver == 15 and info_pattern == 0x01, it is ELAN new pattern
+	 *which support a command for extend IC_body/FW_Version reading
+	 */
+	etd->info_pattern = etd->fw_version & 0xFF;
+	if (ver == 0x0F && etd->info_pattern == 0x01) {
+		if (etd->send_cmd(psmouse, ETP_ICBODY_QUERY, etd->icbody)) {
+			psmouse_err(psmouse, "failed to query icbody data\n");
+			return -1;
+		}
+		psmouse_info(psmouse,
+				"Elan ICBODY query result %02x, %02x, %02x\n",
+				etd->icbody[0], etd->icbody[1], etd->icbody[2]);
+		etd->fw_version	&= 0xFFFF00;
+		etd->fw_version |= etd->icbody[2];
+	}
+
 	return 0;
 }
 
@@ -1667,7 +1687,7 @@ int elantech_init(struct psmouse *psmouse)
 	}
 	etd->fw_version = (param[0] << 16) | (param[1] << 8) | param[2];
 
-	if (elantech_set_properties(etd)) {
+	if (elantech_set_properties(etd, psmouse)) {
 		psmouse_err(psmouse, "unknown hardware version, aborting...\n");
 		goto init_fail;
 	}
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index e1cbf40..708ad85 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -21,6 +21,7 @@
 #define ETP_CAPABILITIES_QUERY		0x02
 #define ETP_SAMPLE_QUERY		0x03
 #define ETP_RESOLUTION_QUERY		0x04
+#define ETP_ICBODY_QUERY		0x05
 
 /*
  * Command values for register reading or writing
@@ -130,6 +131,7 @@ struct elantech_data {
 	unsigned char debug;
 	unsigned char capabilities[3];
 	unsigned char samples[3];
+	unsigned char icbody[3];
 	bool paritycheck;
 	bool jumpy_cursor;
 	bool reports_pressure;
@@ -140,6 +142,7 @@ struct elantech_data {
 	unsigned int single_finger_reports;
 	unsigned int y_max;
 	unsigned int width;
+	unsigned int info_pattern;
 	struct finger_pos mt[ETP_MAX_FINGERS];
 	unsigned char parity[256];
 	int (*send_cmd)(struct psmouse *psmouse, unsigned char c, unsigned char *param);
-- 
2.7.4
