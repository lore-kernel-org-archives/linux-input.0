From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: [RFC PATCH] Input: atmel_mxt_ts: Make config CRC calculation match
 that done by the firmware for mxt224S.
Date: Mon, 09 Feb 2015 19:33:44 +0100
Message-ID: <20150209183344.26257.66562.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ip83.parkeon.com ([213.152.31.83]:47864 "EHLO mta2.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933111AbbBITMO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Feb 2015 14:12:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org

Although the protocol guide says the CRC is calculated from T7 onwards on
the 224s it appears necessary to calculate from T71 (the previous object).

The mismatch is not critical from a functional perspective but causes an
incorrect warning "Config CRC error, calculated=... file=..."
to be emitted every time the configuration is uploaded.

My 224s has this memory map:

Family: 130 Variant: 36 Firmware V2.0.AA Objects: 23
Matrix size: X24Y14
Information Block CRC: 0x68822D

Type Start Size Instances ReportIds Name
-----------------------------------------------------------------

T37   148   130     1        0-0    DEBUG_DIAGNOSTIC_T37
T44   278     1     1        0-0    SPT_MESSAGECOUNT_T44
T5    279     9     1        0-0    GEN_MESSAGEPROCESSOR_T5
T6    288     6     1        1-1    GEN_COMMANDPROCESSOR_T6
T38   294     8     1        0-0    SPT_USERDATA_T38
T71   302   112     1        0-0    SPT_DYNAMICCONFIGURATIONCONTAINER_T71
T7    414     4     1        0-0    GEN_POWERCONFIG_T7


On a 224e it works without this patch but the 224e does not have a T71 object.

So, if the T71 object exists start calculating the CRC from there, otherwise from T7.
As I only have access to the mxt224e and mxt224s chips I don't know if this is
the right way for all chips, hence RFC status.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 29f9b9d..c773548 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -79,6 +79,7 @@
 #define MXT_SPT_DIGITIZER_T43		43
 #define MXT_SPT_MESSAGECOUNT_T44	44
 #define MXT_SPT_CTECONFIG_T46		46
+#define MXT_SPT_DYNAMICCONFIGURATIONCONTAINER_T71	71
 
 /* MXT_GEN_MESSAGE_T5 object */
 #define MXT_RPTID_NOMSG		0xff
@@ -264,6 +265,7 @@ struct mxt_data {
 	u8 T6_reportid;
 	u16 T6_address;
 	u16 T7_address;
+	u16 T71_address;
 	u8 T9_reportid_min;
 	u8 T9_reportid_max;
 	u8 T19_reportid;
@@ -1238,6 +1240,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 	u32 info_crc, config_crc, calculated_crc;
 	u8 *config_mem;
 	size_t config_mem_size;
+	u16 crc_start_address;
+	const char *crc_start_obj;
 
 	mxt_update_crc(data, MXT_COMMAND_REPORTALL, 1);
 
@@ -1326,15 +1330,24 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *cfg)
 		goto release_mem;
 
 	/* Calculate crc of the received configs (not the raw config file) */
-	if (data->T7_address < cfg_start_ofs) {
-		dev_err(dev, "Bad T7 address, T7addr = %x, config offset %x\n",
-			data->T7_address, cfg_start_ofs);
+	if (data->T71_address) {
+		/* At least the mxt224S calculates from T71 */
+		crc_start_address = data->T71_address;
+		crc_start_obj = "T71";
+	} else {
+		/* Protocol guide says from T7.. */
+		crc_start_address = data->T7_address;
+		crc_start_obj = "T7";
+	}
+	if (crc_start_address < cfg_start_ofs) {
+		dev_err(dev, "Bad %s address, addr = %x, config offset %x\n",
+			crc_start_obj, crc_start_address, cfg_start_ofs);
 		ret = 0;
 		goto release_mem;
 	}
 
 	calculated_crc = mxt_calculate_crc(config_mem,
-					   data->T7_address - cfg_start_ofs,
+					   crc_start_address - cfg_start_ofs,
 					   config_mem_size);
 
 	if (config_crc > 0 && config_crc != calculated_crc)
@@ -1404,6 +1417,7 @@ static void mxt_free_object_table(struct mxt_data *data)
 	data->T5_msg_size = 0;
 	data->T6_reportid = 0;
 	data->T7_address = 0;
+	data->T71_address = 0;
 	data->T9_reportid_min = 0;
 	data->T9_reportid_max = 0;
 	data->T19_reportid = 0;
@@ -1488,6 +1502,9 @@ static int mxt_get_object_table(struct mxt_data *data)
 		case MXT_GEN_POWER_T7:
 			data->T7_address = object->start_address;
 			break;
+		case MXT_SPT_DYNAMICCONFIGURATIONCONTAINER_T71:
+			data->T71_address = object->start_address;
+			break;
 		case MXT_TOUCH_MULTI_T9:
 			data->T9_reportid_min = min_id;
 			data->T9_reportid_max = max_id;

