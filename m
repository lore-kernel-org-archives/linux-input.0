From: Anthony Kim <Anthony.Kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH resend 1/1] Input: add support for HiDeep touchscreen
Date: Thu, 26 Oct 2017 23:48:00 +0000
Message-ID: <93AED97F53D7B941873C33A3FA309288557125@mbox02.hideep.com>
References: <1508119806-8074-1-git-send-email-anthony.kim@hideep.com>
 <1508119806-8074-2-git-send-email-anthony.kim@hideep.com>
 <20171026230808.zabyzonnahzczuip@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171026230808.zabyzonnahzczuip@dtor-ws>
Content-Language: ko-KR
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Dmitry Torokhov' <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "'linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dennis Hong <Dennis.Hong-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thank you very much for your kindness. 
I will apply and test your patch. Also if need to modify, I will send patch file again.

P.S. Added loop my team mate.

Thank you.
Anthony.

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] 
Sent: Friday, October 27, 2017 8:08 AM
To: Anthony Kim <Anthony.Kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH resend 1/1] Input: add support for HiDeep touchscreen

Hi Anthony,

On Mon, Oct 16, 2017 at 11:10:06AM +0900, Anthony Kim wrote:
> The HiDeep touchscreen device is a capacitive multi-touch controller
> mainly for multi-touch supported devices use. It use I2C interface for
> communication to IC and provide axis X, Y, Z locations for ten finger
> touch through input event interface to userspace.
> 
> It support the Crimson and the Lime two type IC. They are different
> the number of channel supported and FW size. But the working protocol
> is same.

I was looking at the patch and I have a few concerns. The device seems
to speak big-endian when being programmed, so I think it would make
sense to have dwz_info and the firmware as bin-endian data as well, to
avoid unnecessary conversions.

...

> +static int hideep_pgm_r_mem(struct hideep_ts *ts, u32 addr,
> +	struct pgm_packet *packet, u32 len)
> +{
> +	int ret;
> +	int i;
> +	u8 *buff;
> +	struct i2c_msg msg[2];
> +
> +	if ((len % sizeof(u32)) != 0)
> +		return -EINVAL;
> +
> +	buff = kmalloc(len, GFP_KERNEL);
> +
> +	if (!buff)
> +		return -ENOMEM;
> +
> +	put_unaligned_be32((0x00 | (len / sizeof(u32) - 1)),
> +		&packet->header.w[0]);
> +	put_unaligned_be32(addr, &packet->header.w[1]);
> +
> +	msg[0].addr = ts->client->addr;
> +	msg[0].flags = 0;
> +	msg[0].len = 5;
> +	msg[0].buf = &packet->header.b[3];
> +
> +	msg[1].addr = ts->client->addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].len = len;
> +	msg[1].buf = buff;
> +
> +	ret = i2c_transfer(ts->client->adapter, msg, 2);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < len / sizeof(u32); i++)
> +		packet->payload[i] = get_unaligned_be32(&buff[i * sizeof(u32)]);
> +
> +	return ret;
> +}

You are leaking memory here (buff is not freed).

...

> +
> +static int hideep_pgm_r_reg(struct hideep_ts *ts, u32 addr,
> +	u32 *val)
> +{
> +	int ret;
> +	struct pgm_packet packet;
> +
> +	put_unaligned_be32(0x00, &packet.header.w[0]);
> +	put_unaligned_be32(addr, &packet.header.w[1]);

This is going to be done again in hideep_pgm_r_mem(). BTW, the elements
are perfectly aligned here.

...

> +
> +static int hideep_load_dwz(struct hideep_ts *ts)
> +{
> +	int ret = 0;
> +	struct pgm_packet packet_r;
> +
> +	ret = hideep_enter_pgm(ts);
> +
> +	if (ret)
> +		return ret;
> +
> +	mdelay(50);
> +
> +	hideep_pgm_r_mem(ts, HIDEEP_DWZ_INFO, &packet_r,
> +		sizeof(struct dwz_info));
> +
> +	memcpy(&ts->dwz_info, packet_r.payload,
> +		sizeof(struct dwz_info));
> +
> +	SW_RESET_IN_PGM(10);
> +
> +	if (get_unaligned_le16(&ts->dwz_info.product_code) & 0x60) {
> +		/* Lime fw size */
> +		dev_dbg(&ts->client->dev, "used lime IC");
> +		ts->fw_size = 1024 * 64;
> +		ts->nvm_mask = 0x0030027B;
> +	} else if (get_unaligned_le16(&ts->dwz_info.product_code) & 0x40) {

Bits in 0x40 are subset of 0x60 so this branch will never fire. Did you
mean to write something like

	switch (product_code & SOME_MASK) {
	case 0x60:
		// handle lime
		break;

	case 040:
		// handle crimson
		break;

	default:
		// bad product
	}

...

> +
> +static int hideep_pwr_on(struct hideep_ts *ts)
> +{
> +	int ret = 0;
> +	u8 cmd = 0x01;
> +
> +	if (ts->vcc_vdd) {

You will never get a NULL regulator here.

...

> +
> +static int hideep_parse_event(struct hideep_ts *ts, u8 *data)
> +{
> +	int touch_count;
> +
> +	ts->tch_count = data[0];
> +	ts->key_count = data[1] & 0x0f;
> +	ts->lpm_count = data[1] & 0xf0;
> +
> +	/* get touch event count */
> +	dev_dbg(&ts->client->dev, "mt = %d, key = %d, lpm = %02x",
> +		ts->tch_count, ts->key_count, ts->lpm_count);
> +
> +	/* get touch event information */
> +	if (ts->tch_count < HIDEEP_MT_MAX)
> +		memcpy(ts->touch_event, &data[HIDEEP_TOUCH_EVENT_INDEX],
> +			HIDEEP_MT_MAX * sizeof(struct hideep_event));

Why do we need all this copying of the data?

...

> +
> +	ret = devm_add_action_or_reset(&ts->client->dev, hideep_pwr_off, ts);
> +	if (ret) {
> +		hideep_pwr_off(ts);

devm_add_action_or_reset() calls the "action" on failure, there is no
need to call hideep_pwr_off() again here.

> +	}
> +
> +	mdelay(30);
> +
> +	/* read info */
> +	ret = hideep_load_dwz(ts);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "fail to load dwz, ret = 0x%x", ret);
> +		return ret;
> +	}
> +
> +	/* init input device */
> +	ts->input_dev = devm_input_allocate_device(&client->dev);
> +	if (!ts->input_dev) {
> +		dev_err(&client->dev, "can't allocate memory for input_dev");
> +		return -ENOMEM;
> +	}
> +
> +	touchscreen_parse_properties(ts->input_dev, true, &ts->prop);

You need to tell touchscreen_parse_properties what axes to expect before
calling it.

I tried addressing all the comments above (and some more), below is the
incremental patch that should apply on top of the patch I am replying
to. I am also attaching full source of hideep.c in case you have trouble
applying this patch. Please give it a try and let me know if it still
works. If there are any additional changes needed, please do it in top
of this patch and when it is time to merge I'll squash it all together.

Thanks!

-- 
Dmitry


Input: hideep - misc changes

From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/touchscreen/hideep.c | 1391 +++++++++++++++++-------------------
 1 file changed, 667 insertions(+), 724 deletions(-)

diff --git a/drivers/input/touchscreen/hideep.c b/drivers/input/touchscreen/hideep.c
index 186cc309a3a7..88314643a1ba 100644
--- a/drivers/input/touchscreen/hideep.c
+++ b/drivers/input/touchscreen/hideep.c
@@ -23,72 +23,73 @@
 #include <linux/regulator/consumer.h>
 #include <asm/unaligned.h>
 
-#define HIDEEP_TS_NAME				"HiDeep Touchscreen"
-#define HIDEEP_I2C_NAME				"hideep_ts"
+#define HIDEEP_TS_NAME			"HiDeep Touchscreen"
+#define HIDEEP_I2C_NAME			"hideep_ts"
+
+#define HIDEEP_MT_MAX			10
+#define HIDEEP_KEY_MAX			3
 
-#define HIDEEP_MT_MAX				10
-#define HIDEEP_KEY_MAX				3
 /* count(2) + touch data(100) + key data(6) */
-#define HIDEEP_MAX_EVENT			108
-#define HIDEEP_TOUCH_EVENT_INDEX		2
-#define HIDEEP_KEY_EVENT_INDEX			102
+#define HIDEEP_MAX_EVENT		108UL
+
+#define HIDEEP_TOUCH_EVENT_INDEX	2
+#define HIDEEP_KEY_EVENT_INDEX		102
 
 /* Touch & key event */
-#define HIDEEP_EVENT_ADDR			0x240
+#define HIDEEP_EVENT_ADDR		0x240
 
 /* command list */
-#define HIDEEP_RESET_CMD			0x9800
+#define HIDEEP_RESET_CMD		0x9800
 
 /* event bit */
-#define HIDEEP_MT_RELEASED			BIT(4)
-#define HIDEEP_KEY_PRESSED			BIT(7)
-#define HIDEEP_KEY_FIRST_PRESSED		BIT(8)
-#define HIDEEP_KEY_PRESSED_MASK \
-	(HIDEEP_KEY_PRESSED | HIDEEP_KEY_FIRST_PRESSED)
+#define HIDEEP_MT_RELEASED		BIT(4)
+#define HIDEEP_KEY_PRESSED		BIT(7)
+#define HIDEEP_KEY_FIRST_PRESSED	BIT(8)
+#define HIDEEP_KEY_PRESSED_MASK		(HIDEEP_KEY_PRESSED | \
+					 HIDEEP_KEY_FIRST_PRESSED)
+
+#define HIDEEP_KEY_IDX_MASK		0x0f
 
 /* For NVM */
-#define HIDEEP_YRAM_BASE			0x40000000
-#define HIDEEP_PERIPHERAL_BASE			0x50000000
-#define HIDEEP_ESI_BASE \
-	(HIDEEP_PERIPHERAL_BASE + 0x00000000)
-#define HIDEEP_FLASH_BASE \
-	(HIDEEP_PERIPHERAL_BASE + 0x01000000)
-#define HIDEEP_SYSCON_BASE \
-	(HIDEEP_PERIPHERAL_BASE + 0x02000000)
-
-#define HIDEEP_SYSCON_MOD_CON			(HIDEEP_SYSCON_BASE + 0x0000)
-#define HIDEEP_SYSCON_SPC_CON			(HIDEEP_SYSCON_BASE + 0x0004)
-#define HIDEEP_SYSCON_CLK_CON			(HIDEEP_SYSCON_BASE + 0x0008)
-#define HIDEEP_SYSCON_CLK_ENA			(HIDEEP_SYSCON_BASE + 0x000C)
-#define HIDEEP_SYSCON_RST_CON			(HIDEEP_SYSCON_BASE + 0x0010)
-#define HIDEEP_SYSCON_WDT_CON			(HIDEEP_SYSCON_BASE + 0x0014)
-#define HIDEEP_SYSCON_WDT_CNT			(HIDEEP_SYSCON_BASE + 0x0018)
-#define HIDEEP_SYSCON_PWR_CON			(HIDEEP_SYSCON_BASE + 0x0020)
-#define HIDEEP_SYSCON_PGM_ID			(HIDEEP_SYSCON_BASE + 0x00F4)
-
-#define HIDEEP_FLASH_CON			(HIDEEP_FLASH_BASE + 0x0000)
-#define HIDEEP_FLASH_STA			(HIDEEP_FLASH_BASE + 0x0004)
-#define HIDEEP_FLASH_CFG			(HIDEEP_FLASH_BASE + 0x0008)
-#define HIDEEP_FLASH_TIM			(HIDEEP_FLASH_BASE + 0x000C)
-#define HIDEEP_FLASH_CACHE_CFG			(HIDEEP_FLASH_BASE + 0x0010)
-#define HIDEEP_FLASH_PIO_SIG			(HIDEEP_FLASH_BASE + 0x400000)
-
-#define HIDEEP_ESI_TX_INVALID			(HIDEEP_ESI_BASE + 0x0008)
-
-#define HIDEEP_PERASE				0x00040000
-#define HIDEEP_WRONLY				0x00100000
-
-#define HIDEEP_NVM_MASK_OFS			0x0000000C
-#define HIDEEP_NVM_DEFAULT_PAGE			0
-#define HIDEEP_NVM_SFR_WPAGE			1
-#define HIDEEP_NVM_SFR_RPAGE			2
-
-#define HIDEEP_PIO_SIG				0x00400000
-#define HIDEEP_PROT_MODE			0x03400000
-
-#define HIDEEP_NVM_PAGE_SIZE			128
-
-#define HIDEEP_DWZ_INFO				0x000002C0
+#define HIDEEP_YRAM_BASE		0x40000000
+#define HIDEEP_PERIPHERAL_BASE		0x50000000
+#define HIDEEP_ESI_BASE			(HIDEEP_PERIPHERAL_BASE + 0x00000000)
+#define HIDEEP_FLASH_BASE		(HIDEEP_PERIPHERAL_BASE + 0x01000000)
+#define HIDEEP_SYSCON_BASE		(HIDEEP_PERIPHERAL_BASE + 0x02000000)
+
+#define HIDEEP_SYSCON_MOD_CON		(HIDEEP_SYSCON_BASE + 0x0000)
+#define HIDEEP_SYSCON_SPC_CON		(HIDEEP_SYSCON_BASE + 0x0004)
+#define HIDEEP_SYSCON_CLK_CON		(HIDEEP_SYSCON_BASE + 0x0008)
+#define HIDEEP_SYSCON_CLK_ENA		(HIDEEP_SYSCON_BASE + 0x000C)
+#define HIDEEP_SYSCON_RST_CON		(HIDEEP_SYSCON_BASE + 0x0010)
+#define HIDEEP_SYSCON_WDT_CON		(HIDEEP_SYSCON_BASE + 0x0014)
+#define HIDEEP_SYSCON_WDT_CNT		(HIDEEP_SYSCON_BASE + 0x0018)
+#define HIDEEP_SYSCON_PWR_CON		(HIDEEP_SYSCON_BASE + 0x0020)
+#define HIDEEP_SYSCON_PGM_ID		(HIDEEP_SYSCON_BASE + 0x00F4)
+
+#define HIDEEP_FLASH_CON		(HIDEEP_FLASH_BASE + 0x0000)
+#define HIDEEP_FLASH_STA		(HIDEEP_FLASH_BASE + 0x0004)
+#define HIDEEP_FLASH_CFG		(HIDEEP_FLASH_BASE + 0x0008)
+#define HIDEEP_FLASH_TIM		(HIDEEP_FLASH_BASE + 0x000C)
+#define HIDEEP_FLASH_CACHE_CFG		(HIDEEP_FLASH_BASE + 0x0010)
+#define HIDEEP_FLASH_PIO_SIG		(HIDEEP_FLASH_BASE + 0x400000)
+
+#define HIDEEP_ESI_TX_INVALID		(HIDEEP_ESI_BASE + 0x0008)
+
+#define HIDEEP_PERASE			0x00040000
+#define HIDEEP_WRONLY			0x00100000
+
+#define HIDEEP_NVM_MASK_OFS		0x0000000C
+#define HIDEEP_NVM_DEFAULT_PAGE		0
+#define HIDEEP_NVM_SFR_WPAGE		1
+#define HIDEEP_NVM_SFR_RPAGE		2
+
+#define HIDEEP_PIO_SIG			0x00400000
+#define HIDEEP_PROT_MODE		0x03400000
+
+#define HIDEEP_NVM_PAGE_SIZE		128UL
+
+#define HIDEEP_DWZ_INFO			0x000002C0
 
 struct hideep_event {
 	__le16 x;
@@ -98,38 +99,51 @@ struct hideep_event {
 	u8 flag;
 	u8 type;
 	u8 index;
-} __packed;
+};
 
 struct dwz_info {
-	__le32	code_start;
+	__be32 code_start;
 	u8 code_crc[12];
 
-	__le32 c_code_start;
-	__le16 c_code_len;
-	__le16 gen_ver;
+	__be32 c_code_start;
+	__be16 gen_ver;
+	__be16 c_code_len;
+
+	__be32 vr_start;
+	__be16 rsv0;
+	__be16 vr_len;
 
-	__le32 vr_start;
-	__le16 vr_len;
-	__le16 rsv0;
+	__be32 ft_start;
+	__be16 vr_version;
+	__be16 ft_len;
 
-	__le32 ft_start;
-	__le16 ft_len;
-	__le16 vr_version;
+	__be16 core_ver;
+	__be16 boot_ver;
 
-	__le16 boot_ver;
-	__le16 core_ver;
-	__le16 custom_ver;
-	__le16 release_ver;
+	__be16 release_ver;
+	__be16 custom_ver;
 
+	u8 model_name[6];
 	u8 factory_id;
 	u8 panel_type;
-	u8 model_name[6];
-	__le16 product_code;
-	__le16 extra_option;
 
-	__le16 product_id;
-	__le16 vendor_id;
-} __packed;
+	__be16 extra_option;
+	__be16 product_code;
+
+	__be16 vendor_id;
+	__be16 product_id;
+};
+
+struct pgm_packet {
+	struct {
+		u8 unused[3];
+		u8 len;
+		__be32 addr;
+	} header;
+	__be32 payload[HIDEEP_NVM_PAGE_SIZE / sizeof(__be32)];
+};
+
+#define HIDEEP_XFER_BUF_SIZE	sizeof(struct pgm_packet)
 
 struct hideep_ts {
 	struct i2c_client *client;
@@ -146,151 +160,141 @@ struct hideep_ts {
 	struct mutex dev_mutex;
 
 	u32 tch_count;
-	u32 key_count;
 	u32 lpm_count;
 
-	u8 touch_event[HIDEEP_MT_MAX * 10];
-	u8 key_event[HIDEEP_KEY_MAX * 2];
+	/*
+	 * Data buffer to read packet from the device (contacts and key
+	 * states). We align it on double-word boundary to keep word-sized
+	 * fields in contact data and double-word-sized fields in program
+	 * packet aligned.
+	 */
+	u8 xfer_buf[HIDEEP_XFER_BUF_SIZE] __aligned(4);
 
 	int key_num;
-	int key_codes[HIDEEP_KEY_MAX];
+	u32 key_codes[HIDEEP_KEY_MAX];
 
 	struct dwz_info dwz_info;
 
-	int fw_size;
-	int nvm_mask;
-};
-
-struct pgm_packet {
-	union {
-		u8 b[8];
-		u32 w[2];
-	} header;
-
-	u32 payload[HIDEEP_NVM_PAGE_SIZE / sizeof(u32)];
+	unsigned int fw_size;
+	u32 nvm_mask;
 };
 
 static int hideep_pgm_w_mem(struct hideep_ts *ts, u32 addr,
-	struct pgm_packet *packet, u32 len)
+			    const __be32 *data, size_t count)
 {
+	struct pgm_packet *packet = (void *)ts->xfer_buf;
+	size_t len = count * sizeof(*data);
+	struct i2c_msg msg = {
+		.addr	= ts->client->addr,
+		.len	= len + sizeof(packet->header.len) +
+				sizeof(packet->header.addr),
+		.buf	= &packet->header.len,
+	};
 	int ret;
-	int i;
-	struct i2c_msg msg;
 
-	if ((len % sizeof(u32)) != 0)
+	if (len > HIDEEP_NVM_PAGE_SIZE)
 		return -EINVAL;
 
-	put_unaligned_be32((0x80 | (len / sizeof(u32) - 1)),
-		&packet->header.w[0]);
-	put_unaligned_be32(addr, &packet->header.w[1]);
-
-	for (i = 0; i < len / sizeof(u32); i++)
-		put_unaligned_be32(packet->payload[i], &packet->payload[i]);
-
-	msg.addr = ts->client->addr;
-	msg.flags = 0;
-	msg.len = len + 5;
-	msg.buf = &packet->header.b[3];
+	packet->header.len = 0x80 | (count - 1);
+	packet->header.addr = cpu_to_be32(addr);
+	memcpy(packet->payload, data, len);
 
 	ret = i2c_transfer(ts->client->adapter, &msg, 1);
+	if (ret != 1)
+		return ret < 0 ? ret : -EIO;
 
-	return ret;
+	return 0;
 }
 
 static int hideep_pgm_r_mem(struct hideep_ts *ts, u32 addr,
-	struct pgm_packet *packet, u32 len)
+			    __be32 *data, size_t count)
 {
+	struct pgm_packet *packet = (void *)ts->xfer_buf;
+	size_t len = count * sizeof(*data);
+	struct i2c_msg msg[] = {
+		{
+			.addr	= ts->client->addr,
+			.len	= sizeof(packet->header.len) +
+					sizeof(packet->header.addr),
+			.buf	= &packet->header.len,
+		},
+		{
+			.addr	= ts->client->addr,
+			.flags	= I2C_M_RD,
+			.len	= len,
+			.buf	= (u8 *)data,
+		},
+	};
 	int ret;
-	int i;
-	u8 *buff;
-	struct i2c_msg msg[2];
 
-	if ((len % sizeof(u32)) != 0)
+	if (len > HIDEEP_NVM_PAGE_SIZE)
 		return -EINVAL;
 
-	buff = kmalloc(len, GFP_KERNEL);
-
-	if (!buff)
-		return -ENOMEM;
+	packet->header.len = count - 1;
+	packet->header.addr = cpu_to_be32(addr);
 
-	put_unaligned_be32((0x00 | (len / sizeof(u32) - 1)),
-		&packet->header.w[0]);
-	put_unaligned_be32(addr, &packet->header.w[1]);
+	ret = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg))
+		return ret < 0 ? ret : -EIO;
 
-	msg[0].addr = ts->client->addr;
-	msg[0].flags = 0;
-	msg[0].len = 5;
-	msg[0].buf = &packet->header.b[3];
-
-	msg[1].addr = ts->client->addr;
-	msg[1].flags = I2C_M_RD;
-	msg[1].len = len;
-	msg[1].buf = buff;
-
-	ret = i2c_transfer(ts->client->adapter, msg, 2);
-
-	if (ret < 0)
-		return ret;
-
-	for (i = 0; i < len / sizeof(u32); i++)
-		packet->payload[i] = get_unaligned_be32(&buff[i * sizeof(u32)]);
-
-	return ret;
+	return 0;
 }
 
-static int hideep_pgm_r_reg(struct hideep_ts *ts, u32 addr,
-	u32 *val)
+static int hideep_pgm_r_reg(struct hideep_ts *ts, u32 addr, u32 *val)
 {
-	int ret;
-	struct pgm_packet packet;
-
-	put_unaligned_be32(0x00, &packet.header.w[0]);
-	put_unaligned_be32(addr, &packet.header.w[1]);
+	__be32 data;
+	int error;
 
-	ret = hideep_pgm_r_mem(ts, addr, &packet, sizeof(u32));
-
-	if (ret < 0)
-		return ret;
-
-	*val = packet.payload[0];
+	error = hideep_pgm_r_mem(ts, addr, &data, 1);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"read of register %#08x failed: %d\n",
+			addr, error);
+		return error;
+	}
 
-	return ret;
+	*val = be32_to_cpu(data);
+	return 0;
 }
 
-static int hideep_pgm_w_reg(struct hideep_ts *ts, u32 addr,
-	u32 data)
+static int hideep_pgm_w_reg(struct hideep_ts *ts, u32 addr, u32 val)
 {
-	int ret;
-	struct pgm_packet packet;
-
-	put_unaligned_be32(0x80, &packet.header.w[0]);
-	put_unaligned_be32(addr, &packet.header.w[1]);
-	packet.payload[0] = data;
+	__be32 data = cpu_to_be32(val);
+	int error;
 
-	ret = hideep_pgm_w_mem(ts, addr, &packet, sizeof(u32));
+	error = hideep_pgm_w_mem(ts, addr, &data, 1);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"write to register %#08x (%#08x) failed: %d\n",
+			addr, val, error);
+		return error;
+	}
 
-	return ret;
+	return 0;
 }
 
-#define SW_RESET_IN_PGM(CLK) \
-{ \
-	hideep_pgm_w_reg(ts, HIDEEP_SYSCON_WDT_CNT, CLK); \
-	hideep_pgm_w_reg(ts, HIDEEP_SYSCON_WDT_CON, 0x03); \
-	hideep_pgm_w_reg(ts, HIDEEP_SYSCON_WDT_CON, 0x01); \
+#define SW_RESET_IN_PGM(clk)					\
+{								\
+	hideep_pgm_w_reg(ts, HIDEEP_SYSCON_WDT_CNT, (clk));	\
+	hideep_pgm_w_reg(ts, HIDEEP_SYSCON_WDT_CON, 0x03);	\
+	hideep_pgm_w_reg(ts, HIDEEP_SYSCON_WDT_CON, 0x01);	\
 }
 
-#define SET_FLASH_PIO(CE) \
-	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CON, 0x01 | (CE << 1))
-#define SET_PIO_SIG(X, Y) \
-	hideep_pgm_w_reg(ts, HIDEEP_FLASH_PIO_SIG + X, Y)
-#define SET_FLASH_HWCONTROL() \
+#define SET_FLASH_PIO(ce)					\
+	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CON,			\
+			 0x01 | ((ce) << 1))
+
+#define SET_PIO_SIG(x, y)					\
+	hideep_pgm_w_reg(ts, HIDEEP_FLASH_PIO_SIG + (x), (y))
+
+#define SET_FLASH_HWCONTROL()					\
 	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CON, 0x00)
 
-#define NVM_W_SFR(x, y) \
-{ \
-	SET_FLASH_PIO(1); \
-	SET_PIO_SIG(x, y); \
-	SET_FLASH_PIO(0); \
+#define NVM_W_SFR(x, y)						\
+{								\
+	SET_FLASH_PIO(1);					\
+	SET_PIO_SIG(x, y);					\
+	SET_FLASH_PIO(0);					\
 }
 
 static void hideep_pgm_set(struct hideep_ts *ts)
@@ -304,160 +308,147 @@ static void hideep_pgm_set(struct hideep_ts *ts)
 	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CACHE_CFG, 0x00);
 }
 
-static int hideep_pgm_get_pattern(struct hideep_ts *ts)
+static int hideep_pgm_get_pattern(struct hideep_ts *ts, u32 *pattern)
 {
-	int ret;
-	u32 status;
 	u16 p1 = 0xAF39;
 	u16 p2 = 0xDF9D;
+	int error;
 
-	ret = regmap_bulk_write(ts->reg, p1, (void *)&p2, 1);
-
-	if (ret < 0) {
-		dev_err(&ts->client->dev, "%d, %08X", __LINE__, ret);
-		return ret;
+	error = regmap_bulk_write(ts->reg, p1, &p2, 1);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"%s: regmap_bulk_write() failed with %d\n",
+			__func__, error);
+		return error;
 	}
 
-	mdelay(1);
+	usleep_range(1000, 1100);
 
 	/* flush invalid Tx load register */
-	ret = hideep_pgm_w_reg(ts, HIDEEP_ESI_TX_INVALID, 0x01);
-
-	if (ret < 0)
-		return ret;
+	error = hideep_pgm_w_reg(ts, HIDEEP_ESI_TX_INVALID, 0x01);
+	if (error)
+		return error;
 
-	ret = hideep_pgm_r_reg(ts, HIDEEP_SYSCON_PGM_ID, &status);
+	error = hideep_pgm_r_reg(ts, HIDEEP_SYSCON_PGM_ID, pattern);
+	if (error)
+		return error;
 
-	if (ret < 0)
-		return ret;
-
-	return status;
+	return 0;
 }
 
 static int hideep_enter_pgm(struct hideep_ts *ts)
 {
 	int retry_count = 10;
-	int val;
-	u32 pgm_pattern = 0xDF9DAF39;
+	u32 pattern;
+	int error;
 
 	while (retry_count--) {
-		val = hideep_pgm_get_pattern(ts);
-
-		if (pgm_pattern != get_unaligned_be32(&val)) {
-			dev_err(&ts->client->dev, "enter_pgm : error(%08x):",
-				get_unaligned_be32(&val));
+		error = hideep_pgm_get_pattern(ts, &pattern);
+		if (error) {
+			dev_err(&ts->client->dev,
+				"hideep_pgm_get_pattern failed: %d\n", error);
+		} else if (pattern != 0xDF9DAF39) {
+			dev_err(&ts->client->dev, "%s: bad pattern: %#08x\n",
+				__func__, pattern);
 		} else {
 			dev_dbg(&ts->client->dev, "found magic code");
-			break;
-		}
-	}
 
-	if (retry_count < 0) {
-		dev_err(&ts->client->dev, "couldn't enter pgm mode!!!");
-		SW_RESET_IN_PGM(1000);
-		return -EBADMSG;
-	}
+			hideep_pgm_set(ts);
+			usleep_range(1000, 1100);
 
-	hideep_pgm_set(ts);
-	mdelay(1);
+			return 0;
+		}
+	}
 
-	return 0;
+	dev_err(&ts->client->dev, "failed to  enter pgm mode\n");
+	SW_RESET_IN_PGM(1000);
+	return -EIO;
 }
 
 static void hideep_nvm_unlock(struct hideep_ts *ts)
 {
-	u32 unmask_code = 0;
-
-	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CFG,
-		HIDEEP_NVM_SFR_RPAGE);
+	u32 unmask_code;
 
+	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CFG, HIDEEP_NVM_SFR_RPAGE);
 	hideep_pgm_r_reg(ts, 0x0000000C, &unmask_code);
-
-	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CFG,
-		HIDEEP_NVM_DEFAULT_PAGE);
+	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CFG, HIDEEP_NVM_DEFAULT_PAGE);
 
 	/* make it unprotected code */
-	unmask_code &= (~HIDEEP_PROT_MODE);
+	unmask_code &= ~HIDEEP_PROT_MODE;
 
 	/* compare unmask code */
 	if (unmask_code != ts->nvm_mask)
-		dev_dbg(&ts->client->dev, "read mask code different 0x%x",
-			unmask_code);
+		dev_warn(&ts->client->dev,
+			 "read mask code different %#08x vs %#08x",
+			 unmask_code, ts->nvm_mask);
 
-	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CFG,
-		HIDEEP_NVM_SFR_WPAGE);
+	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CFG, HIDEEP_NVM_SFR_WPAGE);
 	SET_FLASH_PIO(0);
 
 	NVM_W_SFR(HIDEEP_NVM_MASK_OFS, ts->nvm_mask);
 	SET_FLASH_HWCONTROL();
-	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CFG,
-		HIDEEP_NVM_DEFAULT_PAGE);
+	hideep_pgm_w_reg(ts, HIDEEP_FLASH_CFG, HIDEEP_NVM_DEFAULT_PAGE);
 }
 
 static int hideep_check_status(struct hideep_ts *ts)
 {
-	int ret, status;
 	int time_out = 100;
+	int status;
+	int error;
 
 	while (time_out--) {
-		mdelay(1);
-		ret = hideep_pgm_r_reg(ts, HIDEEP_FLASH_STA,
-			&status);
-
-		if (ret < 0)
-			continue;
+		error = hideep_pgm_r_reg(ts, HIDEEP_FLASH_STA, &status);
+		if (!error && status)
+			return 0;
 
-		if (status)
-			return status;
+		usleep_range(1000, 1100);
 	}
 
-	return time_out;
+	return -ETIMEDOUT;
 }
 
-static int hideep_program_page(struct hideep_ts *ts,
-	u32 addr, struct pgm_packet *packet_w)
+static int hideep_program_page(struct hideep_ts *ts, u32 addr,
+			       const __be32 *ucode, size_t xfer_count)
 {
-	int ret;
-
+	u32 val;
+	int error;
 
-	ret = hideep_check_status(ts);
-
-	if (ret < 0)
+	error = hideep_check_status(ts);
+	if (error)
 		return -EBUSY;
 
-	addr = addr & ~(HIDEEP_NVM_PAGE_SIZE - 1);
+	addr &= ~(HIDEEP_NVM_PAGE_SIZE - 1);
 
 	SET_FLASH_PIO(0);
 	SET_FLASH_PIO(1);
 
 	/* erase page */
-	SET_PIO_SIG((HIDEEP_PERASE | addr), 0xFFFFFFFF);
+	SET_PIO_SIG(HIDEEP_PERASE | addr, 0xFFFFFFFF);
 
 	SET_FLASH_PIO(0);
 
-	ret = hideep_check_status(ts);
-
-	if (ret < 0)
+	error = hideep_check_status(ts);
+	if (error)
 		return -EBUSY;
 
 	/* write page */
 	SET_FLASH_PIO(1);
 
-	SET_PIO_SIG((HIDEEP_WRONLY | addr),
-		get_unaligned_be32(&packet_w->payload[0]));
+	val = be32_to_cpu(ucode[0]);
+	SET_PIO_SIG(HIDEEP_WRONLY | addr, val);
 
-	hideep_pgm_w_mem(ts, (HIDEEP_FLASH_PIO_SIG | HIDEEP_WRONLY),
-		packet_w, HIDEEP_NVM_PAGE_SIZE);
+	hideep_pgm_w_mem(ts, HIDEEP_FLASH_PIO_SIG | HIDEEP_WRONLY,
+			 ucode, xfer_count);
 
-	SET_PIO_SIG(124, get_unaligned_be32(&packet_w->payload[31]));
+	val = be32_to_cpu(ucode[xfer_count - 1]);
+	SET_PIO_SIG(124, val);
 
 	SET_FLASH_PIO(0);
 
-	mdelay(1);
+	usleep_range(1000, 1100);
 
-	ret = hideep_check_status(ts);
-
-	if (ret < 0)
+	error = hideep_check_status(ts);
+	if (error)
 		return -EBUSY;
 
 	SET_FLASH_HWCONTROL();
@@ -465,174 +456,133 @@ static int hideep_program_page(struct hideep_ts *ts,
 	return 0;
 }
 
-static void hideep_program_nvm(struct hideep_ts *ts, const u8 *ucode,
-	int len)
+static int hideep_program_nvm(struct hideep_ts *ts,
+			      const __be32 *ucode, size_t ucode_len)
 {
-	struct pgm_packet packet_w;
-	struct pgm_packet packet_r;
-	int i;
-	int ret;
-	int addr = 0;
-	int len_r = len;
-	int len_w = HIDEEP_NVM_PAGE_SIZE;
-	u32 pages = DIV_ROUND_UP(len, HIDEEP_NVM_PAGE_SIZE);
-
+	struct pgm_packet *packet_r = (void *)ts->xfer_buf;
+	__be32 *current_ucode = packet_r->payload;
+	size_t xfer_len;
+	size_t xfer_count;
+	u32 addr = 0;
+	int error;
 
 	hideep_nvm_unlock(ts);
 
-	dev_dbg(&ts->client->dev, "pages : %d", pages);
-
-	for (i = 0; i < pages; i++) {
-		if (len_r < HIDEEP_NVM_PAGE_SIZE)
-			len_w = len_r;
+	while (ucode_len > 0) {
+		xfer_len = min(ucode_len, HIDEEP_NVM_PAGE_SIZE);
+		xfer_count = xfer_len / sizeof(*ucode);
 
-		/* compare */
-		hideep_pgm_r_mem(ts, 0x00000000 + addr, &packet_r,
-			HIDEEP_NVM_PAGE_SIZE);
-		ret = memcmp(&ucode[addr], packet_r.payload, len_w);
-
-		if (ret) {
-			/* write page */
-			memcpy(packet_w.payload, &ucode[addr], len_w);
-			ret = hideep_program_page(ts, addr, &packet_w);
-			if (ret)
-				dev_err(&ts->client->dev,
-					"%s : error(%08x):",
-					__func__, addr);
-			mdelay(1);
+		error = hideep_pgm_r_mem(ts, 0x00000000 + addr,
+					 current_ucode, xfer_count);
+		if (error) {
+			dev_err(&ts->client->dev,
+				"%s: failed to read page at offset %#08x: %d\n",
+				__func__, addr, error);
+			return error;
 		}
 
-		addr += HIDEEP_NVM_PAGE_SIZE;
-		len_r -= HIDEEP_NVM_PAGE_SIZE;
-		if (len_r < 0)
-			break;
-	}
-}
-
-static int hideep_verify_nvm(struct hideep_ts *ts, const u8 *ucode,
-	int len)
-{
-	struct pgm_packet packet_r;
-	int i, j;
-	int ret;
-	int addr = 0;
-	int len_r = len;
-	int len_v = HIDEEP_NVM_PAGE_SIZE;
-	u32 pages = DIV_ROUND_UP(len, HIDEEP_NVM_PAGE_SIZE);
-
-	for (i = 0; i < pages; i++) {
-		if (len_r < HIDEEP_NVM_PAGE_SIZE)
-			len_v = len_r;
-
-		hideep_pgm_r_mem(ts, 0x00000000 + addr, &packet_r,
-			HIDEEP_NVM_PAGE_SIZE);
-
-		ret = memcmp(&ucode[addr], packet_r.payload, len_v);
-
-		if (ret) {
-			u8 *read = (u8 *)packet_r.payload;
-
-			for (j = 0; j < HIDEEP_NVM_PAGE_SIZE; j++) {
-				if (ucode[addr + j] != read[j])
-					dev_err(&ts->client->dev,
-						"verify : error([%d] %02x : %02x)",
-						addr + j, ucode[addr + j],
-						read[j]);
+		/* See if the page needs updating */
+		if (memcmp(ucode, current_ucode, xfer_len)) {
+			error = hideep_program_page(ts, addr,
+						    ucode, xfer_count);
+			if (error) {
+				dev_err(&ts->client->dev,
+					"%s: iwrite failure @%#08x: %d\n",
+					__func__, addr, error);
+				return error;
 			}
-			return ret;
+
+			usleep_range(1000, 1100);
 		}
 
-		addr += HIDEEP_NVM_PAGE_SIZE;
-		len_r -= HIDEEP_NVM_PAGE_SIZE;
-		if (len_r < 0)
-			break;
+		ucode += xfer_count;
+		addr += xfer_len;
+		ucode_len -= xfer_len;
 	}
 
 	return 0;
 }
 
-static int hideep_update_firmware(struct hideep_ts *ts, const char *fn)
+static int hideep_verify_nvm(struct hideep_ts *ts,
+			     const __be32 *ucode, size_t ucode_len)
 {
-	int ret;
-	int retry, retry_cnt = 3;
-	const struct firmware *fw_entry;
-
-	dev_dbg(&ts->client->dev, "enter");
-	ret = request_firmware(&fw_entry, fn, &ts->client->dev);
+	struct pgm_packet *packet_r = (void *)ts->xfer_buf;
+	__be32 *current_ucode = packet_r->payload;
+	size_t xfer_len;
+	size_t xfer_count;
+	u32 addr = 0;
+	int i;
+	int error;
 
-	if (ret != 0) {
-		dev_err(&ts->client->dev, "request_firmware : fail(%d)", ret);
-		return ret;
-	}
+	while (ucode_len > 0) {
+		xfer_len = min(ucode_len, HIDEEP_NVM_PAGE_SIZE);
+		xfer_count = xfer_len / sizeof(*ucode);
 
-	if (fw_entry->size > ts->fw_size) {
-		dev_err(&ts->client->dev,
-			"file size(%zu) is big more than fw memory size(%d)",
-			fw_entry->size, ts->fw_size);
-		release_firmware(fw_entry);
-		return -EFBIG;
-	}
-
-	/* chip specific code for flash fuse */
-	mutex_lock(&ts->dev_mutex);
+		error = hideep_pgm_r_mem(ts, 0x00000000 + addr,
+					 current_ucode, xfer_count);
+		if (error) {
+			dev_err(&ts->client->dev,
+				"%s: failed to read page at offset %#08x: %d\n",
+				__func__, addr, error);
+			return error;
+		}
 
-	/* enter program mode */
-	ret = hideep_enter_pgm(ts);
+		if (memcmp(ucode, current_ucode, xfer_len)) {
+			const u8 *ucode_bytes = (const u8 *)ucode;
+			const u8 *current_bytes = (const u8 *)current_ucode;
 
-	if (ret)
-		return ret;
+			for (i = 0; i < xfer_len; i++)
+				if (ucode_bytes[i] != current_bytes[i])
+					dev_err(&ts->client->dev,
+						"%s: mismatch @%#08x: (%#02x vs %#02x)\n",
+						__func__, addr + i,
+						ucode_bytes[i],
+						current_bytes[i]);
 
-	/* comparing & programming each page, if the memory of specified
-	 * page is exactly same, no need to update.
-	 */
-	for (retry = 0; retry < retry_cnt; retry++) {
-		hideep_program_nvm(ts, fw_entry->data, fw_entry->size);
+			return -EIO;
+		}
 
-		ret = hideep_verify_nvm(ts, fw_entry->data, fw_entry->size);
-		if (!ret)
-			break;
+		ucode += xfer_count;
+		addr += xfer_len;
+		ucode_len -= xfer_len;
 	}
 
-	if (retry < retry_cnt)
-		dev_dbg(&ts->client->dev, "update success!!!");
-	else
-		dev_err(&ts->client->dev, "update failed!!!");
-
-	SW_RESET_IN_PGM(1000);
-
-	mutex_unlock(&ts->dev_mutex);
-
-	release_firmware(fw_entry);
-
-	return ret;
+	return 0;
 }
 
 static int hideep_load_dwz(struct hideep_ts *ts)
 {
-	int ret = 0;
-	struct pgm_packet packet_r;
-
-	ret = hideep_enter_pgm(ts);
-
-	if (ret)
-		return ret;
+	u16 product_code;
+	int error;
 
-	mdelay(50);
+	error = hideep_enter_pgm(ts);
+	if (error)
+		return error;
 
-	hideep_pgm_r_mem(ts, HIDEEP_DWZ_INFO, &packet_r,
-		sizeof(struct dwz_info));
+	msleep(50);
 
-	memcpy(&ts->dwz_info, packet_r.payload,
-		sizeof(struct dwz_info));
+	error = hideep_pgm_r_mem(ts, HIDEEP_DWZ_INFO,
+				 (void *)&ts->dwz_info,
+				 sizeof(ts->dwz_info) / sizeof(__be32));
 
 	SW_RESET_IN_PGM(10);
+	msleep(50);
 
-	if (get_unaligned_le16(&ts->dwz_info.product_code) & 0x60) {
+	if (error) {
+		dev_err(&ts->client->dev,
+			"failed to fetch DWZ data: %d\n", error);
+		return error;
+	}
+
+	product_code = be16_to_cpu(ts->dwz_info.product_code);
+	if (product_code & 0x60) {
 		/* Lime fw size */
 		dev_dbg(&ts->client->dev, "used lime IC");
 		ts->fw_size = 1024 * 64;
 		ts->nvm_mask = 0x0030027B;
-	} else if (get_unaligned_le16(&ts->dwz_info.product_code) & 0x40) {
+	} else if (product_code & 0x40) {
+		// XXX FIXME: this is weird, 0x60 ask covers 0x40, this
+		// condition will never trigger.
 		/* Crimson IC */
 		dev_dbg(&ts->client->dev, "used crimson IC");
 		ts->fw_size = 1024 * 48;
@@ -642,300 +592,350 @@ static int hideep_load_dwz(struct hideep_ts *ts)
 		return -EINVAL;
 	}
 
-	dev_dbg(&ts->client->dev, "firmware release version : %04x",
-		get_unaligned_le16(&ts->dwz_info.release_ver));
-
-	mdelay(50);
+	dev_dbg(&ts->client->dev, "firmware release version: %#04x",
+		be16_to_cpu(ts->dwz_info.release_ver));
 
 	return 0;
 }
 
-static int hideep_pwr_on(struct hideep_ts *ts)
+static int hideep_flash_firmware(struct hideep_ts *ts,
+				 const __be32 *ucode, size_t ucode_len)
 {
-	int ret = 0;
-	u8 cmd = 0x01;
-
-	if (ts->vcc_vdd) {
-		ret = regulator_enable(ts->vcc_vdd);
-		if (ret)
-			dev_err(&ts->client->dev,
-				"Regulator vdd enable failed ret=%d", ret);
-		usleep_range(999, 1000);
+	int retry_cnt = 3;
+	int error;
+
+	while (retry_cnt--) {
+		error = hideep_program_nvm(ts, ucode, ucode_len);
+		if (!error) {
+			error = hideep_verify_nvm(ts, ucode, ucode_len);
+			if (!error)
+				return 0;
+		}
 	}
 
-	if (ts->vcc_vid) {
-		ret = regulator_enable(ts->vcc_vid);
-		if (ret)
-			dev_err(&ts->client->dev,
-				"Regulator vcc_vid enable failed ret=%d", ret);
-		usleep_range(2999, 3000);
-	}
+	return error;
+}
+
+static int hideep_update_firmware(struct hideep_ts *ts,
+				  const __be32 *ucode, size_t ucode_len)
+{
+	int error, error2;
 
-	mdelay(30);
+	dev_dbg(&ts->client->dev, "starting firmware update");
 
-	if (ts->reset_gpio)
-		gpiod_set_raw_value(ts->reset_gpio, 1);
+	/* enter program mode */
+	error = hideep_enter_pgm(ts);
+	if (error)
+		return error;
+
+	error = hideep_flash_firmware(ts, ucode, ucode_len);
+	if (error)
+		dev_err(&ts->client->dev,
+			"firmware update failed: %d\n", error);
 	else
-		regmap_write(ts->reg, HIDEEP_RESET_CMD, cmd);
+		dev_dbg(&ts->client->dev, "firmware updated successfully\n");
+
+	SW_RESET_IN_PGM(1000);
 
-	mdelay(50);
+	error2 = hideep_load_dwz(ts);
+	if (error2)
+		dev_err(&ts->client->dev,
+			"failed to load dwz after firmware update: %d\n",
+			error2);
 
-	return ret;
+	return error ?: error2;
 }
 
-static void hideep_pwr_off(void *data)
+static int hideep_power_on(struct hideep_ts *ts)
 {
-	struct hideep_ts *ts = data;
+	int error = 0;
 
-	if (ts->reset_gpio)
-		gpiod_set_value(ts->reset_gpio, 0);
+	error = regulator_enable(ts->vcc_vdd);
+	if (error)
+		dev_err(&ts->client->dev,
+			"failed to enable 'vdd' regulator: %d", error);
 
-	if (ts->vcc_vid)
-		regulator_disable(ts->vcc_vid);
+	usleep_range(999, 1000);
 
-	if (ts->vcc_vdd)
-		regulator_disable(ts->vcc_vdd);
-}
+	error = regulator_enable(ts->vcc_vid);
+	if (error)
+		dev_err(&ts->client->dev,
+			"failed to enable 'vcc_vid' regulator: %d",
+			error);
 
-#define __GET_MT_TOOL_TYPE(X) ((X == 0x01) ? MT_TOOL_FINGER : MT_TOOL_PEN)
+	msleep(30);
 
-static void push_mt(struct hideep_ts *ts)
-{
-	int id;
-	int i;
-	int btn_up = 0;
-	int evt = 0;
-	int offset = sizeof(struct hideep_event);
-	struct hideep_event *event;
-
-	/* load multi-touch event to input system */
-	for (i = 0; i < ts->tch_count; i++) {
-		event = (struct hideep_event *)&ts->touch_event[i * offset];
-		id = event->index & 0x0F;
-		btn_up = event->flag & HIDEEP_MT_RELEASED;
-
-		dev_dbg(&ts->client->dev,
-			"type = %d, id = %d, i = %d, x = %d, y = %d, z = %d",
-			event->type, event->index, i,
-			get_unaligned_le16(&event->x),
-			get_unaligned_le16(&event->y),
-			get_unaligned_le16(&event->z));
-
-		input_mt_slot(ts->input_dev, id);
-		input_mt_report_slot_state(ts->input_dev,
-			__GET_MT_TOOL_TYPE(event->type),
-			(btn_up == 0));
-
-		if (btn_up == 0) {
-			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
-				get_unaligned_le16(&event->x));
-			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
-				get_unaligned_le16(&event->y));
-			input_report_abs(ts->input_dev, ABS_MT_PRESSURE,
-				get_unaligned_le16(&event->z));
-			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
-				event->w);
-			evt++;
-		}
+	if (ts->reset_gpio) {
+		gpiod_set_value_cansleep(ts->reset_gpio, 0);
+	} else {
+		error = regmap_write(ts->reg, HIDEEP_RESET_CMD, 0x01);
+		if (error)
+			dev_err(&ts->client->dev,
+				"failed to send 'reset' command: %d\n", error);
 	}
 
-	input_mt_sync_frame(ts->input_dev);
+	msleep(50);
+
+	return error;
 }
 
-static void push_ky(struct hideep_ts *ts)
+static void hideep_power_off(void *data)
 {
-	int i;
-	int status;
-	int code;
+	struct hideep_ts *ts = data;
 
-	for (i = 0; i < ts->key_count; i++) {
-		code = ts->key_event[i * 2] & 0x0F;
-		status = ts->key_event[i * 2] & 0xF0;
+	if (ts->reset_gpio)
+		gpiod_set_value(ts->reset_gpio, 1);
 
-		input_report_key(ts->input_dev, ts->key_codes[code],
-			status & HIDEEP_KEY_PRESSED_MASK);
-	}
+	regulator_disable(ts->vcc_vid);
+	regulator_disable(ts->vcc_vdd);
 }
 
-static void hideep_put_event(struct hideep_ts *ts)
-{
-	/* mangling touch information */
-	if (ts->tch_count > 0)
-		push_mt(ts);
-
-	if (ts->key_count > 0)
-		push_ky(ts);
+#define __GET_MT_TOOL_TYPE(type) ((type) == 0x01 ? MT_TOOL_FINGER : MT_TOOL_PEN)
 
-	input_sync(ts->input_dev);
+static void hideep_report_slot(struct input_dev *input,
+			       const struct hideep_event *event)
+{
+	input_mt_slot(input, event->index & 0x0f);
+	input_mt_report_slot_state(input,
+				   __GET_MT_TOOL_TYPE(event->type),
+				   !(event->flag & HIDEEP_MT_RELEASED));
+	if (!(event->flag & HIDEEP_MT_RELEASED)) {
+		input_report_abs(input, ABS_MT_POSITION_X,
+				 le16_to_cpup(&event->x));
+		input_report_abs(input, ABS_MT_POSITION_Y,
+				 le16_to_cpup(&event->y));
+		input_report_abs(input, ABS_MT_PRESSURE,
+				 le16_to_cpup(&event->z));
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR, event->w);
+	}
 }
 
-static int hideep_parse_event(struct hideep_ts *ts, u8 *data)
+static void hideep_parse_and_report(struct hideep_ts *ts)
 {
-	int touch_count;
-
-	ts->tch_count = data[0];
-	ts->key_count = data[1] & 0x0f;
-	ts->lpm_count = data[1] & 0xf0;
+	const struct hideep_event *events =
+			(void *)&ts->xfer_buf[HIDEEP_TOUCH_EVENT_INDEX];
+	const u8 *keys = &ts->xfer_buf[HIDEEP_KEY_EVENT_INDEX];
+	int touch_count = ts->xfer_buf[0];
+	int key_count = ts->xfer_buf[1] & 0x0f;
+	int lpm_count = ts->xfer_buf[1] & 0xf0;
+	int i;
 
 	/* get touch event count */
 	dev_dbg(&ts->client->dev, "mt = %d, key = %d, lpm = %02x",
-		ts->tch_count, ts->key_count, ts->lpm_count);
+		touch_count, key_count, lpm_count);
 
-	/* get touch event information */
-	if (ts->tch_count < HIDEEP_MT_MAX)
-		memcpy(ts->touch_event, &data[HIDEEP_TOUCH_EVENT_INDEX],
-			HIDEEP_MT_MAX * sizeof(struct hideep_event));
-	else
-		ts->tch_count = 0;
+	touch_count = min(touch_count, HIDEEP_MT_MAX);
+	for (i = 0; i < touch_count; i++)
+		hideep_report_slot(ts->input_dev, events + i);
 
-	if (ts->key_count < HIDEEP_KEY_MAX)
-		memcpy(ts->key_event, &data[HIDEEP_KEY_EVENT_INDEX],
-			HIDEEP_KEY_MAX * 2);
-	else
-		ts->key_count = 0;
+	key_count = min(key_count, HIDEEP_KEY_MAX);
+	for (i = 0; i < key_count; i++) {
+		u8 key_data = keys[i * 2];
 
-	touch_count = ts->tch_count + ts->key_count;
+		input_report_key(ts->input_dev,
+				 ts->key_codes[key_data & HIDEEP_KEY_IDX_MASK],
+				 key_data & HIDEEP_KEY_PRESSED_MASK);
+	}
 
-	return touch_count;
+	input_mt_sync_frame(ts->input_dev);
+	input_sync(ts->input_dev);
 }
 
-static irqreturn_t hideep_irq_task(int irq, void *handle)
+static irqreturn_t hideep_irq(int irq, void *handle)
 {
-	u8 buff[HIDEEP_MAX_EVENT];
-	int ret;
-
 	struct hideep_ts *ts = handle;
+	int error;
 
-	ret = regmap_bulk_read(ts->reg, HIDEEP_EVENT_ADDR,
-		buff, HIDEEP_MAX_EVENT / 2);
+	BUILD_BUG_ON(HIDEEP_MAX_EVENT > HIDEEP_XFER_BUF_SIZE);
 
-	if (ret < 0)
-		return IRQ_HANDLED;
-
-	ret = hideep_parse_event(ts, buff);
+	error = regmap_bulk_read(ts->reg, HIDEEP_EVENT_ADDR,
+				 ts->xfer_buf, HIDEEP_MAX_EVENT / 2);
+	if (error) {
+		dev_err(&ts->client->dev, "failed to read events: %d\n", error);
+		goto out;
+	}
 
-	if (ret > 0)
-		hideep_put_event(ts);
+	hideep_parse_and_report(ts);
 
+out:
 	return IRQ_HANDLED;
 }
 
-static void hideep_get_axis_info(struct hideep_ts *ts)
+static int hideep_get_axis_info(struct hideep_ts *ts)
 {
-	int ret;
-	u8 val[4];
+	__le16 val[2];
+	int error;
 
-	if (ts->prop.max_x == 0 || ts->prop.max_y == 0) {
-		ret = regmap_bulk_read(ts->reg, 0x28, val, 2);
+	error = regmap_bulk_read(ts->reg, 0x28, val, ARRAY_SIZE(val));
+	if (error)
+		return error;
 
-		if (ret < 0) {
-			ts->prop.max_x = -1;
-			ts->prop.max_y = -1;
-		} else {
-			ts->prop.max_x =
-				get_unaligned_le16(&val[0]);
-			ts->prop.max_y =
-				get_unaligned_le16(&val[2]);
-		}
-	}
+	ts->prop.max_x = le16_to_cpup(val);
+	ts->prop.max_y = le16_to_cpup(val + 1);
 
-	dev_dbg(&ts->client->dev, "X : %d, Y : %d",
+	dev_dbg(&ts->client->dev, "X: %d, Y: %d",
 		ts->prop.max_x, ts->prop.max_y);
+
+	return 0;
 }
 
-static int hideep_capability(struct hideep_ts *ts)
+static int hideep_init_input(struct hideep_ts *ts)
 {
-	int ret, i;
-
-	hideep_get_axis_info(ts);
+	struct device *dev = &ts->client->dev;
+	int i;
+	int error;
 
-	if (ts->prop.max_x < 0 || ts->prop.max_y < 0)
-		return -EINVAL;
+	ts->input_dev = devm_input_allocate_device(dev);
+	if (!ts->input_dev) {
+		dev_err(dev, "failed to allocate input device\n");
+		return -ENOMEM;
+	}
 
 	ts->input_dev->name = HIDEEP_TS_NAME;
 	ts->input_dev->id.bustype = BUS_I2C;
+	input_set_drvdata(ts->input_dev, ts);
+
+	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_X);
+	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_Y);
+	input_set_abs_params(ts->input_dev, ABS_MT_PRESSURE, 0, 65535, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_TOOL_TYPE,
+			     0, MT_TOOL_MAX, 0, 0);
+	touchscreen_parse_properties(ts->input_dev, true, &ts->prop);
 
-	if (ts->key_num) {
-		ts->input_dev->keycode = ts->key_codes;
-		ts->input_dev->keycodesize = sizeof(ts->key_codes[0]);
-		ts->input_dev->keycodemax = ts->key_num;
-		for (i = 0; i < ts->key_num; i++)
-			input_set_capability(ts->input_dev, EV_KEY,
-				ts->key_codes[i]);
+	if (ts->prop.max_x == 0 || ts->prop.max_y == 0) {
+		error = hideep_get_axis_info(ts);
+		if (error)
+			return error;
 	}
 
-	input_set_abs_params(ts->input_dev,
-		ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
-	input_set_abs_params(ts->input_dev,
-		ABS_MT_POSITION_X, 0, ts->prop.max_x, 0, 0);
-	input_set_abs_params(ts->input_dev,
-		ABS_MT_POSITION_Y, 0, ts->prop.max_y, 0, 0);
-	input_set_abs_params(ts->input_dev,
-		ABS_MT_PRESSURE, 0, 65535, 0, 0);
-	input_set_abs_params(ts->input_dev,
-		ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
-
-	ret = input_mt_init_slots(ts->input_dev,
-		HIDEEP_MT_MAX, INPUT_MT_DIRECT);
-
-	return ret;
+	error = input_mt_init_slots(ts->input_dev, HIDEEP_MT_MAX,
+				    INPUT_MT_DIRECT);
+	if (error)
+		return error;
+
+	ts->key_num = device_property_read_u32_array(dev, "linux,keycodes",
+						     NULL, 0);
+	if (ts->key_num > HIDEEP_KEY_MAX) {
+		dev_err(dev, "too many keys defined: %d\n",
+			ts->key_num);
+		return -EINVAL;
+	}
+
+	if (ts->key_num <= 0) {
+		dev_dbg(dev,
+			"missing or malformed 'linux,keycodes' property\n");
+	} else {
+		error = device_property_read_u32_array(dev, "linux,keycodes",
+						       ts->key_codes,
+						       ts->key_num);
+		if (error) {
+			dev_dbg(dev, "failed to read keymap: %d", error);
+			return error;
+		}
+
+		if (ts->key_num) {
+			ts->input_dev->keycode = ts->key_codes;
+			ts->input_dev->keycodesize = sizeof(ts->key_codes[0]);
+			ts->input_dev->keycodemax = ts->key_num;
+
+			for (i = 0; i < ts->key_num; i++)
+				input_set_capability(ts->input_dev, EV_KEY,
+					ts->key_codes[i]);
+		}
+	}
+
+	error = input_register_device(ts->input_dev);
+	if (error) {
+		dev_err(dev, "failed to register input device: %d", error);
+		return error;
+	}
+
+	return 0;
 }
 
 static ssize_t hideep_update_fw(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
-	struct hideep_ts *ts = dev_get_drvdata(dev);
-	int mode, ret;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hideep_ts *ts = i2c_get_clientdata(client);
+	const struct firmware *fw_entry;
 	char *fw_name;
+	int mode;
+	int error;
 
-	ret = kstrtoint(buf, 8, &mode);
-	if (ret)
-		return ret;
-
-	disable_irq(ts->client->irq);
+	error = kstrtoint(buf, 0, &mode);
+	if (error)
+		return error;
 
 	fw_name = kasprintf(GFP_KERNEL, "hideep_ts_%04x.bin",
-		get_unaligned_le16(&ts->dwz_info.product_id));
-	ret = hideep_update_firmware(ts, fw_name);
+			    be16_to_cpu(ts->dwz_info.product_id));
+	if (!fw_name)
+		return -ENOMEM;
 
-	if (ret != 0)
-		dev_err(dev, "The firmware update failed(%d)", ret);
+	error = request_firmware(&fw_entry, fw_name, dev);
+	if (error) {
+		dev_err(dev, "failed to request firmware %s: %d",
+			fw_name, error);
+		goto out_free_fw_name;
+	}
 
-	kfree(fw_name);
+	if (fw_entry->size % sizeof(__be32)) {
+		dev_err(dev, "invalid firmware size %zu\n", fw_entry->size);
+		error = -EINVAL;
+		goto out_release_fw;
+	}
 
-	ret = hideep_load_dwz(ts);
+	if (fw_entry->size > ts->fw_size) {
+		dev_err(dev, "fw size (%zu) is too big (memory size %d)\n",
+			fw_entry->size, ts->fw_size);
+		error = -EFBIG;
+		goto out_release_fw;
+	}
 
-	if (ret < 0)
-		dev_err(&ts->client->dev, "fail to load dwz, ret = 0x%x", ret);
+	mutex_lock(&ts->dev_mutex);
+	disable_irq(client->irq);
 
-	enable_irq(ts->client->irq);
+	error = hideep_update_firmware(ts, (const __be32 *)fw_entry->data,
+				       fw_entry->size);
+
+	enable_irq(client->irq);
+	mutex_unlock(&ts->dev_mutex);
+
+out_release_fw:
+	release_firmware(fw_entry);
+out_free_fw_name:
+	kfree(fw_name);
 
-	return count;
+	return error ?: count;
 }
 
 static ssize_t hideep_fw_version_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
+				      struct device_attribute *attr, char *buf)
 {
-	int len = 0;
-	struct hideep_ts *ts = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hideep_ts *ts = i2c_get_clientdata(client);
+	ssize_t len;
 
 	mutex_lock(&ts->dev_mutex);
-	len = scnprintf(buf, PAGE_SIZE,
-		"%04x\n", get_unaligned_le16(&ts->dwz_info.release_ver));
+	len = scnprintf(buf, PAGE_SIZE, "%04x\n",
+			be16_to_cpu(ts->dwz_info.release_ver));
 	mutex_unlock(&ts->dev_mutex);
 
 	return len;
 }
 
 static ssize_t hideep_product_id_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
+				      struct device_attribute *attr, char *buf)
 {
-	int len = 0;
-	struct hideep_ts *ts = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hideep_ts *ts = i2c_get_clientdata(client);
+	ssize_t len;
 
 	mutex_lock(&ts->dev_mutex);
-	len = scnprintf(buf, PAGE_SIZE,
-		"%04x\n", get_unaligned_le16(&ts->dwz_info.product_id));
+	len = scnprintf(buf, PAGE_SIZE, "%04x\n",
+			be16_to_cpu(ts->dwz_info.product_id));
 	mutex_unlock(&ts->dev_mutex);
 
 	return len;
@@ -952,71 +952,41 @@ static struct attribute *hideep_ts_sysfs_entries[] = {
 	NULL,
 };
 
-static struct attribute_group hideep_ts_attr_group = {
+static const struct attribute_group hideep_ts_attr_group = {
 	.attrs = hideep_ts_sysfs_entries,
 };
 
-static int __maybe_unused hideep_resume(struct device *dev)
-{
-	struct hideep_ts *ts = dev_get_drvdata(dev);
-	int ret;
-
-	ret = hideep_pwr_on(ts);
-	if (ret < 0)
-		dev_err(&ts->client->dev, "power on failed");
-	else
-		enable_irq(ts->client->irq);
-
-	return ret;
-}
-
 static int __maybe_unused hideep_suspend(struct device *dev)
 {
-	struct hideep_ts *ts = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hideep_ts *ts = i2c_get_clientdata(client);
 
-	disable_irq(ts->client->irq);
-	hideep_pwr_off(ts);
+	disable_irq(client->irq);
+	hideep_power_off(ts);
 
 	return 0;
 }
 
-static int  hideep_parse_dts(struct device *dev, struct hideep_ts *ts)
+static int __maybe_unused hideep_resume(struct device *dev)
 {
-	int ret;
-
-	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-							GPIOD_OUT_HIGH);
-	if (IS_ERR(ts->reset_gpio))
-		return PTR_ERR(ts->reset_gpio);
-
-	ts->vcc_vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(ts->vcc_vdd))
-		return PTR_ERR(ts->vcc_vdd);
-
-	ts->vcc_vid = devm_regulator_get(dev, "vid");
-	if (IS_ERR(ts->vcc_vid))
-		return PTR_ERR(ts->vcc_vid);
-
-	ts->key_num = device_property_read_u32_array(dev, "linux,keycodes",
-						NULL, 0);
-
-	if (ts->key_num > HIDEEP_KEY_MAX) {
-		dev_err(dev, "too many support key defined(%d)!!!",
-			ts->key_num);
-		return -EINVAL;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hideep_ts *ts = i2c_get_clientdata(client);
+	int error;
+
+	error = hideep_power_on(ts);
+	if (error) {
+		dev_err(&client->dev, "power on failed");
+		return error;
 	}
 
-	ret = device_property_read_u32_array(dev, "linux,keycodes",
-				ts->key_codes, ts->key_num);
-	if (ret) {
-		dev_dbg(dev, "don't support touch key");
-		ts->key_num = 0;
-	}
+	enable_irq(client->irq);
 
 	return 0;
 }
 
-const struct regmap_config hideep_regmap_config = {
+static SIMPLE_DEV_PM_OPS(hideep_pm_ops, hideep_suspend, hideep_resume);
+
+static const struct regmap_config hideep_regmap_config = {
 	.reg_bits = 16,
 	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
 	.val_bits = 16,
@@ -1025,127 +995,100 @@ const struct regmap_config hideep_regmap_config = {
 };
 
 static int hideep_probe(struct i2c_client *client,
-	const struct i2c_device_id *id)
+			const struct i2c_device_id *id)
 {
-	int ret;
-	struct regmap *regmap;
 	struct hideep_ts *ts;
+	int error;
 
 	/* check i2c bus */
-	if (!i2c_check_functionality(client->adapter,
-		I2C_FUNC_I2C)) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(&client->dev, "check i2c device error");
 		return -ENODEV;
 	}
 
-	regmap = devm_regmap_init_i2c(client, &hideep_regmap_config);
-
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "don't init regmap");
-		return PTR_ERR(regmap);
+	if (client->irq <= 0) {
+		dev_err(&client->dev, "missing irq: %d\n", client->irq);
+		return -EINVAL;
 	}
 
-	/* init hideep_ts */
-	ts = devm_kzalloc(&client->dev,
-		sizeof(*ts), GFP_KERNEL);
+	ts = devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
 
-	ret = hideep_parse_dts(&client->dev, ts);
-
-	if (ret)
-		return ret;
-
 	ts->client = client;
-	ts->reg = regmap;
-
 	i2c_set_clientdata(client, ts);
-
 	mutex_init(&ts->dev_mutex);
 
-	/* power on */
-	ret = hideep_pwr_on(ts);
-	if (ret) {
-		dev_err(&ts->client->dev, "power on failed");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&ts->client->dev, hideep_pwr_off, ts);
-	if (ret) {
-		hideep_pwr_off(ts);
-		return ret;
+	ts->reg = devm_regmap_init_i2c(client, &hideep_regmap_config);
+	if (IS_ERR(ts->reg)) {
+		error = PTR_ERR(ts->reg);
+		dev_err(&client->dev,
+			"failed to initialize regmap: %d\n", error);
+		return error;
 	}
 
-	mdelay(30);
-
-	/* read info */
-	ret = hideep_load_dwz(ts);
-	if (ret < 0) {
-		dev_err(&client->dev, "fail to load dwz, ret = 0x%x", ret);
-		return ret;
-	}
-
-	/* init input device */
-	ts->input_dev = devm_input_allocate_device(&client->dev);
-	if (!ts->input_dev) {
-		dev_err(&client->dev, "can't allocate memory for input_dev");
-		return -ENOMEM;
-	}
+	ts->vcc_vdd = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(ts->vcc_vdd))
+		return PTR_ERR(ts->vcc_vdd);
 
-	touchscreen_parse_properties(ts->input_dev, true, &ts->prop);
+	ts->vcc_vid = devm_regulator_get(&client->dev, "vid");
+	if (IS_ERR(ts->vcc_vid))
+		return PTR_ERR(ts->vcc_vid);
 
-	ret = hideep_capability(ts);
-	if (ret) {
-		dev_err(&client->dev, "can't init input properties");
-		return ret;
-	}
+	ts->reset_gpio = devm_gpiod_get_optional(&client->dev,
+						 "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ts->reset_gpio))
+		return PTR_ERR(ts->reset_gpio);
 
-	ret = input_register_device(ts->input_dev);
-	if (ret) {
-		dev_err(&client->dev, "can't register input_dev");
-		return ret;
+	error = hideep_power_on(ts);
+	if (error) {
+		dev_err(&client->dev, "power on failed: %d\n", error);
+		return error;
 	}
 
-	input_set_drvdata(ts->input_dev, ts);
+	error = devm_add_action_or_reset(&client->dev, hideep_power_off, ts);
+	if (error)
+		return error;
 
-	dev_info(&ts->client->dev, "ts irq: %d", ts->client->irq);
-	if (client->irq <= 0) {
-		dev_err(&client->dev, "can't be assigned irq");
-		return -EINVAL;
+	error = hideep_load_dwz(ts);
+	if (error) {
+		dev_err(&client->dev, "failed to load dwz: %d", error);
+		return error;
 	}
 
-	ret = devm_request_threaded_irq(&client->dev, ts->client->irq,
-		NULL, hideep_irq_task, IRQF_ONESHOT,
-		ts->client->name, ts);
-
-	if (ret < 0) {
-		dev_err(&client->dev, "fail to get irq, ret = 0x%08x",
-			ret);
-		return ret;
+	error = hideep_init_input(ts);
+	if (error)
+		return error;
+
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, hideep_irq, IRQF_ONESHOT,
+					  client->name, ts);
+	if (error) {
+		dev_err(&client->dev, "failed to request irq %d: %d\n",
+			client->irq, error);
+		return error;
 	}
 
-	ret = devm_device_add_group(&client->dev, &hideep_ts_attr_group);
-
-	if (ret) {
-		dev_err(&client->dev, "fail init sys, ret = 0x%x", ret);
-		return ret;
+	error = devm_device_add_group(&client->dev, &hideep_ts_attr_group);
+	if (error) {
+		dev_err(&client->dev,
+			"failed to add sysfs attributes: %d\n", error);
+		return error;
 	}
 
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(hideep_pm_ops, hideep_suspend, hideep_resume);
-
-static const struct i2c_device_id hideep_dev_idtable[] = {
+static const struct i2c_device_id hideep_i2c_id[] = {
 	{ HIDEEP_I2C_NAME, 0 },
-	{}
+	{ }
 };
-MODULE_DEVICE_TABLE(i2c, hideep_dev_idtable);
+MODULE_DEVICE_TABLE(i2c, hideep_i2c_id);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id hideep_acpi_id[] = {
 	{ "HIDP0001", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, hideep_acpi_id);
 #endif
@@ -1153,20 +1096,20 @@ MODULE_DEVICE_TABLE(acpi, hideep_acpi_id);
 #ifdef CONFIG_OF
 static const struct of_device_id hideep_match_table[] = {
 	{ .compatible = "hideep,hideep-ts" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hideep_match_table);
 #endif
 
 static struct i2c_driver hideep_driver = {
-	.probe = hideep_probe,
-	.id_table = hideep_dev_idtable,
 	.driver = {
-		.name = HIDEEP_I2C_NAME,
-		.of_match_table = of_match_ptr(hideep_match_table),
-		.acpi_match_table = ACPI_PTR(hideep_acpi_id),
-		.pm = &hideep_pm_ops,
+		.name			= HIDEEP_I2C_NAME,
+		.of_match_table		= of_match_ptr(hideep_match_table),
+		.acpi_match_table	= ACPI_PTR(hideep_acpi_id),
+		.pm			= &hideep_pm_ops,
 	},
+	.id_table	= hideep_i2c_id,
+	.probe		= hideep_probe,
 };
 
 module_i2c_driver(hideep_driver);
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
