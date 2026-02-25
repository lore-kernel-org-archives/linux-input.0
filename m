Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9669299920
	for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052648; cv=none; b=qQU2XBEr34NMdvsxTcovavBpu2K5XqMQmxddjRjmfPRVgy9umZtVielLUPscvjMdcjRsfren0SeV3sW5QJT1nOvbi5r2TKAtczjFeLx1h3DUoobSqI3HrKfMw0rMtelRUGu0EXThsI42lwHDH2NWbHl2r828Z1OyW8aMZLA4h00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052648; c=relaxed/simple;
	bh=7IYFCCYJsP59Gs4RouG45k1r6Z/NE0xFUWhUyzIqipg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sbijafg51ALKrwDfMsnJGjMIJvEQ0tfS00V5uT6edftFupZcfXgt05aEMXTPPoVAApXMrM4By+dFbWcVHPmUQuhF7TTvLfyw167MFofeAgoAm1XwQ80wR39BcPyl73rN9SHyKVyxjGtbtcIaJZ2gqzm8lVvD71PiDch2XGeiSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vvLpk-0001aX-PK; Wed, 25 Feb 2026 21:50:12 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vvLpi-002cT3-13;
	Wed, 25 Feb 2026 21:50:11 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1vvLpj-000000050YN-2Kay;
	Wed, 25 Feb 2026 21:50:11 +0100
Date: Wed, 25 Feb 2026 21:50:11 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Andrew Thomas <andrew.thomas@touchnetix.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Marco Felsch <kernel@pengutronix.de>, 
	Henrik Rydberg <rydberg@bitmath.org>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Message-ID: <a7hajq5edw3w2pm5l3ytn65kmudjckvaj5relydayoua5i7oha@wsattyisot4s>
References: <20260111-v6-10-topic-touchscreen-axiom-v5-0-f94e0ae266cb@pengutronix.de>
 <20260111-v6-10-topic-touchscreen-axiom-v5-4-f94e0ae266cb@pengutronix.de>
 <qoelgb5k77a4c4jodn622a6wauotzkeygy5fj54cjjnobb5g6c@ysxkou6nhkop>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qoelgb5k77a4c4jodn622a6wauotzkeygy5fj54cjjnobb5g6c@ysxkou6nhkop>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

Hi Andrew,

thanks for the your reply, please see below.

On 26-02-25, Andrew Thomas wrote:
> On Sun, Jan 11, 2026 at 04:05:47PM +0100, Marco Felsch wrote:

...

> > +struct axiom_u33_rev3 {
> > +	__le32 runtime_crc;
> > +	__le32 runtime_nvm_crc;
> > +	__le32 bootloader_crc;
> > +	__le32 nvltlusageconfig_crc;
> > +	__le32 vltusageconfig_crc;
> > +	__le32 u22_sequencedata_crc;
> > +	__le32 u43_hotspots_crc;
> > +	__le32 u77_dod_data_crc;
> > +	__le32 u93_profiles_crc;
> > +	__le32 u94_deltascalemap_crc;
> > +	__le32 runtimehash_crc;
> > +};
> > +
> 
> I think revision handling should be kept in unpacking where possible.
> Currently there are 10 revisions of u33, so adding support for many
> revisions and usages would add alot of code.

This isn't very complex nor very large code. Each u33 rev will add
44-byte of code, so in the end there will be 440-byte. I've also seen
that some revisions reduce the size because some fields aren't required.
E.g. u93_crc is at offset-5.

Furthermore describing the complete layout of u33 allows us using it to
query the u33 in one i2c-bulk-transfer.

> > +#define AXIOM_U34				0x34
> > +#define   AXIOM_U34_REV1_OVERFLOW_MASK		BIT(7)
> > +#define   AXIOM_U34_REV1_REPORTLENGTH_MASK	GENMASK(6, 0)
> > +#define   AXIOM_U34_REV1_PREAMBLE_BYTES		2
> > +#define   AXIOM_U34_REV1_POSTAMBLE_BYTES	4

...

> > +enum axiom_runmode {
> > +	AXIOM_DISCOVERY_MODE,
> > +	AXIOM_TCP_MODE,
> > +	AXIOM_TCP_CFG_UPDATE_MODE,
> > +	AXIOM_BLP_PRE_MODE,
> > +	AXIOM_BLP_MODE,
> > +};
> 
> There are only two actual axiom states, bootloader and runtime (TCP).
> This is more of a driver state rather than an axiom state.
> Could you label it as such?

Yes I know and the AXIOM_BLP_PRE_MODE will be dropped with the next
version, which I'm going to send this week!. Not sure why this would be
required.

> > +struct axiom_data {
> > +	struct input_dev *input;
> > +	struct device *dev;
> > +
> > +	struct gpio_desc *reset_gpio;
> > +	struct regulator_bulk_data supplies[2];
> > +	unsigned int num_supplies;
> > +
> > +	struct regmap *regmap;
> > +	struct touchscreen_properties prop;
> > +	bool irq_setup_done;
> > +	u32 poll_interval;
> > +
> > +	struct drm_panel_follower panel_follower;
> > +	bool is_panel_follower;
> > +
> > +	enum axiom_runmode mode;
> > +	/*
> > +	 * Two completion types to support firmware updates
> > +	 * in irq and poll mode.
> > +	 */
> > +	struct axiom_completion {
> > +		struct completion completion;
> > +		bool poll_done;
> > +	} nvm_write, boot_complete;
> > +
> > +	/* Lock to protect both firmware interfaces */
> > +	struct mutex fwupdate_lock;
> > +	struct axiom_firmware {
> > +		/* Lock to protect cancel */
> > +		struct mutex lock;
> > +		bool cancel;
> > +		struct fw_upload *fwl;
> > +	} fw[AXIOM_FW_NUM];
> > +
> > +	unsigned int fw_major;
> > +	unsigned int fw_minor;
> > +	unsigned int fw_rc;
> > +	unsigned int fw_status;
> > +	unsigned int fw_variant;
> > +	u16 device_id;
> > +	u16 jedec_id;
> > +	u8 silicon_rev;
> > +
> > +	/* CRCs we need to check during a config update */
> > +	struct axiom_crc {
> > +		u32 runtime;
> > +		u32 vltusageconfig;
> > +		u32 nvltlusageconfig;
> > +		u32 u22_sequencedata;
> > +		u32 u43_hotspots;
> > +		u32 u77_dod_data;
> > +		u32 u93_profiles;
> > +		u32 u94_deltascalemap;
> > +	} crc[AXIOM_CRC_NUM];
> 
> I think this structure should hold all possible u33 CRCs and then
> invalid ones can be ignored for the given u33 revision.

Why should be the bootloader CRC interessting? The bootloader can't be
updated/flashed, at least not according my documentation. Therefore I
didn't listed the bootloader CRC here.

> > +	bool cds_enabled;
> > +	unsigned long enabled_slots;
> > +	unsigned int num_slots;
> > +
> > +	unsigned int max_report_byte_len;
> > +	struct axiom_usage_table_entry {
> > +		bool populated;
> > +		unsigned int baseaddr;
> > +		unsigned int size_bytes;
> > +		const struct axiom_usage_info *info;
> > +	} usage_table[AXIOM_MAX_USAGES];
> > +};

....

> > +static int axiom_u02_swreset(struct axiom_data *ts)
> > +{
> > +	struct axiom_u02_rev1_system_manager_msg msg = { };
> > +	int ret;
> > +
> > +	if (!axiom_driver_supports_usage(ts, AXIOM_U02))
> > +		return -EINVAL;
> > +
> > +	msg.command = cpu_to_le16(AXIOM_U02_REV1_CMD_SOFTRESET);
> > +	ret = axiom_u02_send_msg(ts, &msg, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Downstream http://axcfg.py waits for 1sec without checking U01 hello. Tests
> > +	 * showed that waiting for the hello message isn't enough therefore we
> > +	 * need both to make it robuster.
> > +	 */
> > +	ret = axiom_wait_for_completion_timeout(ts, &ts->boot_complete,
> > +					msecs_to_jiffies(1 * MSEC_PER_SEC));
> 
> Boot can take up to 2s with all selftests enabled.

Thanks for this information :) I will add it.

> > +	if (!ret)
> > +		dev_err(ts->dev, "Error swreset timedout\n");
> > +
> > +	fsleep(USEC_PER_SEC);
> > +
> > +	return ret ? 0 : -ETIMEDOUT;
> > +}

...

> > +static int axiom_u02_enter_bootloader(struct axiom_data *ts)
> > +{
> > +	struct axiom_u02_rev1_system_manager_msg msg = { };
> > +	struct device *dev = ts->dev;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	if (!axiom_driver_supports_usage(ts, AXIOM_U02))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Enter the bootloader mode requires 3 consecutive messages so we can't
> > +	 * check for the response.
> > +	 */
> > +	msg.command = cpu_to_le16(AXIOM_U02_REV1_CMD_ENTERBOOTLOADER);
> > +	msg.parameters[0] = cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY1);
> > +	ret = axiom_u02_send_msg(ts, &msg, false);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to send bootloader-key1: %d\n", ret);
> > +		return ret;
> > +	}
> 
> A delay is required between commands. 10ms is fine.

Can I make use of the axiom_u02_wait_idle() logic which checks the
AXIOM_U02_REV1_RESP_SUCCESS? Arbitrary delays are always a source of
trouble.

> > +	msg.parameters[0] = cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY2);
> > +	ret = axiom_u02_send_msg(ts, &msg, false);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to send bootloader-key2: %d\n", ret);
> > +		return ret;
> > +	}
> 
> And here.
> 
> > +
> > +	msg.parameters[0] = cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY3);
> > +	ret = axiom_u02_send_msg(ts, &msg, false);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to send bootloader-key3: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Sleep before the first read to give the device time */
> > +	fsleep(250 * USEC_PER_MSEC);
> > +
> > +	/* Wait till the device reports it is in bootloader mode */
> > +	return regmap_read_poll_timeout(ts->regmap,
> > +			AXIOM_U31_REV1_DEVICE_ID_HIGH_REG, val,
> > +			FIELD_GET(AXIOM_U31_REV1_MODE_MASK, val) ==
> > +			AXIOM_U31_REV1_MODE_BLP, 250 * USEC_PER_MSEC,
> > +			USEC_PER_SEC);
> > +}
> 
> Just to note if we cannot enter bootloader with u02 due to a corrupted firmware,
> you can enter bootloader if the nRESET line is toggled 5 times without comms.

This could be added later on by $dev (maybe you :)) since I can't test
this. Our system has the reset line not connected :/

...

> > +static int axiom_u33_read(struct axiom_data *ts, struct axiom_crc *crc)
> > +{
> > +	struct device *dev = ts->dev;
> > +	unsigned int reg;
> > +	int ret;
> > +
> > +	if (!axiom_driver_supports_usage(ts, AXIOM_U33))
> > +		return -EINVAL;
> > +
> > +	if (axiom_usage_rev(ts, AXIOM_U33) == 2) {
> > +		struct axiom_u33_rev2 val;
> > +
> > +		reg = axiom_usage_baseaddr(ts, AXIOM_U33);
> > +		ret = regmap_raw_read(ts->regmap, reg, &val, sizeof(val));
> 
> Could we read into a raw buffer to save having to define a little endian
> version of the CRCs?

I don't see the benefit.

...

> > +/* Custom regmap read/write handling is required due to the aXiom protocol */
> > +static int axiom_regmap_read(void *context, const void *reg_buf, size_t reg_size,
> > +			     void *val_buf, size_t val_size)
> > +{
> > +	struct device *dev = context;
> > +	struct i2c_client *i2c = to_i2c_client(dev);
> > +	struct axiom_data *ts = i2c_get_clientdata(i2c);
> > +	struct axiom_cmd_header hdr;
> > +	u16 xferlen, addr, baseaddr;
> > +	struct i2c_msg xfer[2];
> > +	int ret;
> > +
> > +	if (val_size > AXIOM_MAX_XFERLEN) {
> > +		dev_err(ts->dev, "Exceed max xferlen: %zu > %u\n",
> > +			val_size, AXIOM_MAX_XFERLEN);
> > +		return -EINVAL;
> > +	}
> > +
> > +	addr = *((u16 *)reg_buf);
> > +	hdr.target_address = cpu_to_le16(addr);
> > +	xferlen = FIELD_PREP(AXIOM_CMD_HDR_DIR_MASK, AXIOM_CMD_HDR_READ) |
> > +		  FIELD_PREP(AXIOM_CMD_HDR_LEN_MASK, val_size);
> > +	hdr.xferlen = cpu_to_le16(xferlen);
> > +
> > +	/* Verify that usage including the usage rev is supported */
> > +	baseaddr = addr & AXIOM_USAGE_BASEADDR_MASK;
> > +	if (!axiom_usage_supported(ts, baseaddr))
> > +		return -EINVAL;
> > +
> > +	xfer[0].addr = i2c->addr;
> > +	xfer[0].flags = 0;
> > +	xfer[0].len = sizeof(hdr);
> > +	xfer[0].buf = (u8 *)&hdr;
> > +
> > +	xfer[1].addr = i2c->addr;
> > +	xfer[1].flags = I2C_M_RD;
> > +	xfer[1].len = val_size;
> > +	xfer[1].buf = val_buf;
> > +
> > +	ret = i2c_transfer(i2c->adapter, xfer, 2);
> > +	if (ret == 2)
> > +		return 0;
> > +	else if (ret < 0)
> > +		return ret;
> > +	else
> > +		return -EIO;
> > +}
> 
> There needs to be atleast 40us holdoff between axiom bus transfers.
> I am not sure that has been considered here.

Is this written somewhere within the datasheet/programming-guide?

...

> > +static enum fw_upload_err
> > +axiom_cfg_fw_prepare(struct fw_upload *fw_upload, const u8 *data, u32 size)
> > +{

...

> > +	cur_runtime_crc = ts->crc[AXIOM_CRC_CUR].runtime;
> > +	fw_runtime_crc = ts->crc[AXIOM_CRC_NEW].runtime;
> > +	if (cur_runtime_crc != fw_runtime_crc) {
> > +		dev_err(dev, "TH2CFG and device runtime CRC doesn't match: %#x != %#x\n",
> > +			fw_runtime_crc, cur_runtime_crc);
> > +		ret = FW_UPLOAD_ERR_FW_INVALID;
> > +		goto out;
> > +	}
> 
> The firmware CRCs dont need to match for a config load, only the usage revision/length.

What difference does it make? The firmware CRC implicit includes the
usage revision and the length (register layout). So we can ensure that
the configuration was made for the correct register layout without
checking each register and revision.

...

> > +static enum fw_upload_err
> > +axiom_cfg_fw_write(struct fw_upload *fw_upload, const u8 *data, u32 offset,
> > +		   u32 size, u32 *written)
> > +{

....

> > +	/* Ensure that the chunks are written correctly */
> > +	ret = axiom_verify_volatile_mem(ts);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to verify written config, abort\n");
> > +		goto err_swreset;
> > +	}
> > +
> > +	ret = axiom_u02_save_config(ts);
> > +	if (ret)
> > +		goto err_swreset;
> > +
> > +	/*
> > +	 * TODO: Check if u02 start would be sufficient to load the new config
> > +	 * values
> > +	 */
> 
> It is not necessarily needed.

What do you mean by this? Do we need the axiom_u02_swreset() or can we
just start the system via u02 (without swreset)?

> 
> > +	ret = axiom_u02_swreset(ts);
> > +	if (ret) {
> > +		dev_err(dev, "Soft reset failed\n");
> > +		goto err_unlock;
> > +	}

....

> > +static ssize_t fw_variant_show(struct device *dev,
> > +			       struct device_attribute *attr, char *buf)
> > +{
> > +	struct i2c_client *i2c = to_i2c_client(dev);
> > +	struct axiom_data *ts = i2c_get_clientdata(i2c);
> > +	const char *val;
> > +
> > +	switch (ts->fw_variant) {
> > +	case 0:
> > +		val = "3d";
> > +		break;
> > +	case 1:
> > +		val = "2d";
> > +		break;
> > +	case 3:
> > +		val = "force";
> > +		break;
> > +	default:
> > +		val = "unknown";
> > +		break;
> > +	}
> 
> The following are all the variants we currently support in order:
> FW_VARIANTS = ["3D", "2D", "FORCE", "0D", "XL"]

Means:

0 == 3d
1 == 2d
3 == force
4 == 0d
5 == xl

?

This is also something I can test on my site. Patches are welcome once
this is mainline of course :)

Regards,
  Marco

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
