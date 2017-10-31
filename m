From: Anthony Kim <anthony.kim@hideep.com>
Subject: [PATCH v2 resend 0/1] Input: add support HiDeep touchscreen.
Date: Tue, 31 Oct 2017 19:17:56 +0900
Message-ID: <1509445077-19246-1-git-send-email-anthony.kim@hideep.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dennis.hong@hideep.com, Anthony Kim <anthony.kim@hideep.com>
List-Id: linux-input@vger.kernel.org

Hi,

I remake patch to base on dmitry's modified code.
Please refer as follow.
http://www.spinics.net/lists/linux-input/msg53724.html

That code is working well almost, but needed to some modified.

- v2
  - Our fw binary data is little endian, but our IC protocol
    for fw update use big endian. So it need to convert to big endian data
    and I added about it.
  - Chagned PGM pattern value to big endian.
  - Changed to process for product code to using switch case.

Please review this.
Thank you.

P.S. I added to changes about dmitry's code.

diff --git a/drivers/input/touchscreen/hideep.c b/drivers/input/touchscreen/hideep.c
index 8831464..1df0a43 100644
--- a/drivers/input/touchscreen/hideep.c
+++ b/drivers/input/touchscreen/hideep.c
@@ -347,7 +347,7 @@ static int hideep_enter_pgm(struct hideep_ts *ts)
		if (error) {
			dev_err(&ts->client->dev,
				"hideep_pgm_get_pattern failed: %d\n", error);
-		} else if (pattern != 0xDF9DAF39) {
+		} else if (pattern != 0x39AF9DDF) {
			dev_err(&ts->client->dev, "%s: bad pattern: %#08x\n",
				__func__, pattern);
		} else {
@@ -408,7 +408,7 @@ static int hideep_check_status(struct hideep_ts *ts)
 }
 
 static int hideep_program_page(struct hideep_ts *ts, u32 addr,
-			       const __be32 *ucode, size_t xfer_count)
+			       __be32 *ucode, size_t xfer_count)
 {
	u32 val;
	int error;
@@ -457,13 +457,15 @@ static int hideep_program_page(struct hideep_ts *ts, u32 addr,
 }
 
 static int hideep_program_nvm(struct hideep_ts *ts,
-			      const __be32 *ucode, size_t ucode_len)
+			      const u32 *ucode, size_t ucode_len)
 {
	struct pgm_packet *packet_r = (void *)ts->xfer_buf;
	__be32 *current_ucode = packet_r->payload;
+	__be32 write_ucode[HIDEEP_NVM_PAGE_SIZE];
	size_t xfer_len;
	size_t xfer_count;
	u32 addr = 0;
+	int i;
	int error;
 
	hideep_nvm_unlock(ts);
@@ -481,10 +483,14 @@ static int hideep_program_nvm(struct hideep_ts *ts,
			return error;
		}
 
+		/* Need to because binary data is little endian */
+		for (i = 0; i < xfer_len; i++)
+			write_ucode[i] = cpu_to_be32(ucode[i]);
+
		/* See if the page needs updating */
-		if (memcmp(ucode, current_ucode, xfer_len)) {
+		if (memcmp(write_ucode, current_ucode, xfer_len)) {
			error = hideep_program_page(ts, addr,
-						    ucode, xfer_count);
+						    write_ucode, xfer_count);
			if (error) {
				dev_err(&ts->client->dev,
					"%s: iwrite failure @%#08x: %d\n",
@@ -504,10 +510,11 @@ static int hideep_program_nvm(struct hideep_ts *ts,
 }
 
 static int hideep_verify_nvm(struct hideep_ts *ts,
-			     const __be32 *ucode, size_t ucode_len)
+			     const u32 *ucode, size_t ucode_len)
 {
	struct pgm_packet *packet_r = (void *)ts->xfer_buf;
	__be32 *current_ucode = packet_r->payload;
+	__be32 verify_ucode[HIDEEP_NVM_PAGE_SIZE];
	size_t xfer_len;
	size_t xfer_count;
	u32 addr = 0;
@@ -527,8 +534,12 @@ static int hideep_verify_nvm(struct hideep_ts *ts,
			return error;
		}
 
-		if (memcmp(ucode, current_ucode, xfer_len)) {
-			const u8 *ucode_bytes = (const u8 *)ucode;
+		/* Need to because binary data is little endian */
+		for (i = 0; i < xfer_len; i++)
+			verify_ucode[i] = cpu_to_be32(ucode[i]);
+
+		if (memcmp(verify_ucode, current_ucode, xfer_len)) {
+			const u8 *ucode_bytes = (const u8 *)verify_ucode;
			const u8 *current_bytes = (const u8 *)current_ucode;
 
			for (i = 0; i < xfer_len; i++)
@@ -575,20 +586,21 @@ static int hideep_load_dwz(struct hideep_ts *ts)
	}
 
	product_code = be16_to_cpu(ts->dwz_info.product_code);
-	if (product_code & 0x60) {
-		/* Lime fw size */
-		dev_dbg(&ts->client->dev, "used lime IC");
-		ts->fw_size = 1024 * 64;
-		ts->nvm_mask = 0x0030027B;
-	} else if (product_code & 0x40) {
-		// XXX FIXME: this is weird, 0x60 ask covers 0x40, this
-		// condition will never trigger.
-		/* Crimson IC */
+
+	switch (product_code & 0xF0) {
+	case 0x40:
		dev_dbg(&ts->client->dev, "used crimson IC");
		ts->fw_size = 1024 * 48;
		ts->nvm_mask = 0x00310000;
-	} else {
-		dev_dbg(&ts->client->dev, "product code is wrong!!!");
+		break;
+	case 0x60:
+		dev_dbg(&ts->client->dev, "used lime IC");
+		ts->fw_size = 1024 * 64;
+		ts->nvm_mask = 0x0030027B;
+		break;
+	default:
+		dev_err(&ts->client->dev, "product code is wrong: %#04x",
+			product_code);
		return -EINVAL;
	}
 
@@ -599,7 +611,7 @@ static int hideep_load_dwz(struct hideep_ts *ts)
 }
 
 static int hideep_flash_firmware(struct hideep_ts *ts,
-				 const __be32 *ucode, size_t ucode_len)
+				 const u32 *ucode, size_t ucode_len)
 {
	int retry_cnt = 3;
	int error;
@@ -617,7 +629,7 @@ static int hideep_flash_firmware(struct hideep_ts *ts,
 }
 
 static int hideep_update_firmware(struct hideep_ts *ts,
-				  const __be32 *ucode, size_t ucode_len)
+				  const u32 *ucode, size_t ucode_len)
 {
	int error, error2;
 
@@ -897,7 +909,7 @@ static ssize_t hideep_update_fw(struct device *dev,
	mutex_lock(&ts->dev_mutex);
	disable_irq(client->irq);
 
-	error = hideep_update_firmware(ts, (const __be32 *)fw_entry->data,
+	error = hideep_update_firmware(ts, (const u32 *)fw_entry->data,
				       fw_entry->size);
 
	enable_irq(client->irq);

Anthony Kim (1):
  Input: add support for HiDeep touchscreen

 .../bindings/input/touchscreen/hideep.txt          |   42 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/input/touchscreen/Kconfig                  |   11 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/hideep.c                 | 1131 ++++++++++++++++++++
 5 files changed, 1186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
 create mode 100644 drivers/input/touchscreen/hideep.c

-- 
2.7.4
