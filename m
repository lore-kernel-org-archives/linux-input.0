From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elantech - Support new touchpad IC and extend elan's touchpad command
Date: Mon, 28 Aug 2017 11:19:25 +0800
Message-ID: <1503890365-3438-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ulrik.debie-os@e2big.org
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw
List-Id: linux-input@vger.kernel.org

Origianl ic-body field is not sufficient for upcoming IC,
Elan ps/2 driver extend the formation to support future IC.
If the IC ver is 0xf, the setting of etd->hw_version still keep 4
And add a new command to indicate a real IC body

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elantech.c | 21 ++++++++++++++++++++-
 drivers/input/mouse/elantech.h |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 65c9de3..fd8eaed 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1398,6 +1398,10 @@ static bool elantech_is_signature_valid(const unsigned char *param)
 	    param[2] < 40)
 		return true;
 
+	/* hw_version 0x0F does not need to check rate */
+	if ((param[0] & 0x0f) == 0x0f)
+		return true;
+
 	for (i = 0; i < ARRAY_SIZE(rates); i++)
 		if (param[2] == rates[i])
 			return false;
@@ -1593,7 +1597,7 @@ static int elantech_set_properties(struct elantech_data *etd)
 		case 5:
 			etd->hw_version = 3;
 			break;
-		case 6 ... 14:
+		case 6 ... 15:
 			etd->hw_version = 4;
 			break;
 		default:
@@ -1647,6 +1651,7 @@ int elantech_init(struct psmouse *psmouse)
 	int error = -EINVAL;
 	unsigned char param[3];
 	struct input_dev *tp_dev;
+	int ver;
 
 	psmouse->private = etd = kzalloc(sizeof(struct elantech_data), GFP_KERNEL);
 	if (!etd)
@@ -1695,6 +1700,20 @@ int elantech_init(struct psmouse *psmouse)
 			     etd->samples[0], etd->samples[1], etd->samples[2]);
 	}
 
+	/*if ver == 0xf, it is ELAN new pattern
+	 *which support a command for extend IC_body reading
+	 */
+	ver = (etd->fw_version & 0x0f0000) >> 16;
+	if (ver == 0x0F) {
+		if (etd->send_cmd(psmouse, ETP_ICBODY_QUERY, etd->icbody)) {
+			psmouse_err(psmouse, "failed to query icbody data\n");
+			goto init_fail;
+		}
+		psmouse_info(psmouse,
+				"Elan ICBODY query result %02x, %02x, %02x\n",
+				etd->icbody[0], etd->icbody[1], etd->icbody[2]);
+	}
+
 	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
 		/*
 		 * This module has a bug which makes absolute mode
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index e1cbf40..10675ae 100644
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
-- 
2.7.4
