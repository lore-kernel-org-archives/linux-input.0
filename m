From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Sat, 14 May 2016 01:08:30 +0800
Message-ID: <1463159310-17630-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <20160513041852.GA8932@dtor-ws>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160513041852.GA8932@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry:
This patch you submitted had some problems. I still debug in progress. Should I comment the issues in this patch or create a new patch if I finish the issues?

 >static int raydium_i2c_fastboot(struct i2c_client *client)
 > {
 >-	static const u8 boot_cmd[] = { 0x50, 0x00, 0x06, 0x20 };
 >-	u8 buf[HEADER_SIZE];
 >+	u8 buf[4]; // XXX FIXME why size 4 and not 1?
Correct.Raydium direct access mode is word alignment, so that 4 bytes reading is correct but only lower bytes show the message I need.

 >static int raydium_i2c_check_fw_status(struct raydium_data *ts)
 >{
 >	struct i2c_client *client = ts->client;
 >-	static const u8 bl_area[] = {0x62, 0x6f, 0x6f, 0x74};
 >-	static const u8 main_area[] = {0x66, 0x69, 0x72, 0x6d};
 >-	u8 buf[HEADER_SIZE];
 >+	static const u8 bl_area[] = { 0x62, 0x6f, 0x6f, 0x74 };
 >+	static const u8 main_area[] = { 0x66, 0x69, 0x72, 0x6d };
 >+	u8 buf[4];
 > 	int error;
 > 
 >-	error = raydium_i2c_read(client, CMD_BOOT_READ, HEADER_SIZE,
 >-		(void *)buf);
 >+	error = raydium_i2c_read(client, RM_CMD_BOOT_READ, buf, sizeof(buf));
 > 	if (!error) {
 >+		// XXX FIXME: why do we compare only 1st bytes? Do we even
 >+		// need 4-byte constants?
One bytes comparison is fine. I'll change as below:

static int raydium_i2c_check_fw_status(struct raydium_data *ts)
{
	struct i2c_client *client = ts->client;
	static const u8 bl_ack = 0x62;
	static const u8 main_ack = 0x66;
	u8 buf[4];
	int error;

	error = raydium_i2c_read(client, RM_CMD_BOOT_READ, buf, sizeof(buf));
	if (!error) {
		// XXX FIXME: why do we compare only 1st bytes? Do we even
		// need 4-byte constants?
		if (buf[0] == bl_ack)
			ts->boot_mode = RAYDIUM_TS_BLDR;
		else if (buf[0] == main_ack)
			ts->boot_mode = RAYDIUM_TS_MAIN;
		return 0;

>+	while (len) {
>+		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
> 
>-		memcpy(&buf[DATA_STR], page + DATA_STR +
>-			u8_idx*RAYDIUM_TRANS_BUFSIZE,
>-			RAYDIUM_TRANS_BUFSIZE);
>+		buf[BL_HEADER] = 0x0b;
>+		// XXX FIXME: is this correct? Do we really want all pages
>+		// after 1st to have 0xff? Should it be a counter?
>+		// Why do we need both pages and packages within pages?
>+		buf[BL_PAGE_STR] = page_idx ? 0 : 0xff;
This is correct. Touch MCU need this index as start page.
>+		buf[BL_PKG_IDX] = pkg_idx;
This should be:
		buf[BL_PKG_IDX] = pkg_idx++;
>+		memcpy(&buf[BL_DATA_STR], data, xfer_len);
