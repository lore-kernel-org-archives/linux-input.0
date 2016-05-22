From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Sun, 22 May 2016 17:32:59 +0800
Message-ID: <1463909579-316-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <20160513041852.GA8932@dtor-ws>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34940 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbcEVJdQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 May 2016 05:33:16 -0400
In-Reply-To: <20160513041852.GA8932@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org

Hi Dmitry:

+static int raydium_i2c_read_message(struct i2c_client *client,
+				    u32 addr, void *data, size_t len)
+{
+	__be32 be_addr;
+	size_t xfer_len;
+	int error;
+
+	while (len) {
+		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);
+
+		be_addr = cpu_to_be32(addr);
+
+		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
+					 &be_addr, sizeof(be_addr));
+		if (!error)
+			error = raydium_i2c_read(client, (be_addr >> 24) & 0xff,
+						 data, xfer_len);
+		if (error)
+			return error;
+
+		len -= xfer_len;
+		data += xfer_len;
+		addr += xfer_len;
+	}
+
+	return 0;
+}
I change access address method of touch MCU direct mode so that I can change raydium i2c driver as below.

static int raydium_i2c_read_message(struct i2c_client *client,
				    u32 addr, void *data, size_t len)
{
	__le32 le_addr;
	size_t xfer_len;
	u32 shift_addr;
	int error;

	while (len) {
		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);

		le_addr = cpu_to_le32(addr);

		shift_addr = le_addr >> 8;/*send the first 3rd byte addr.*/
		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
					 &shift_addr, sizeof(le_addr));
		if (!error)/*read from last byte addr.*/
			error = raydium_i2c_read(client, le_addr & 0xff,
						 data, xfer_len);
		if (error)
			return error;

		len -= xfer_len;
		data += xfer_len;
		addr += xfer_len;
	}

	return 0;
}
Is this okay? If okay, I will use this form update one new patch.

>> static int raydium_i2c_fw_write_page(struct i2c_client *client,
>> 				     u16 page_idx, const void *data, size_t len)
>> {
>> 	u8 buf[RM_BL_WRT_LEN];
>> 	u8 pkg_idx = 1;
>> 	size_t xfer_len;
>> 	int error;
>> 
>> 	while (len) {
>> 		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
>> 		buf[BL_HEADER] = RM_CMD_BOOT_PAGE_WRT;
>> 		/*FIXME,Touch MCU need zero index as start page*/
>> 		buf[BL_PAGE_STR] = page_idx ? 0xff : 0;
>> 		buf[BL_PKG_IDX] = pkg_idx++;
>> 
>> 		memcpy(&buf[BL_DATA_STR], data, xfer_len);
>> 
>> 		if (len < RM_BL_WRT_PKG_SIZE) {
>> 			buf[BL_PKG_IDX] = 4;

>Why 4???
4 is trigger index for write flash. Our page write size is 128 bytes, but in order to meet maximum I2C bus read/write byte limite and need fill full all pages of 128 bytes. So that I split 128 bytes to "4" section, and start burning flash if touch MCU get index "4". 
