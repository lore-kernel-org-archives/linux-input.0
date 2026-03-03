Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A94BCAB9
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554515; cv=none; b=SlwbLLgfJyCtnqFMmb9k0wJt2IcokXLp7I/wO+ixDpVVk7FQ19KMiMqz7S4RRM/eHD8yqlnkfCx2YQqtslB/zShq2f6q/A9XJHgxvlb4sIPCADar0/e70atzomdQlFpZratflkqr+FrM9UCGNJMJW5N/2uEmD+EkEq5BTM0qXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554515; c=relaxed/simple;
	bh=g6wJXKdgwjdhbbJCQpY0n2URjxDo2iSh9vaWqgVlYPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTNTR0G26M+3YelD/gXdRpyV0B8DfAnBS233g6Yk6UEXiqKofbS+yvY8CpdYplVCMjQT7yqrmHOV/5TF4Trq2F7LGXo+kicsPYkLX3pM6nzVhgUs84gGEX1XxfOV2gNvy6uotKVzMyuoL+zDZZ3eB9tlTnFupeZNUep7eNk6JKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vxSOQ-0000WO-Nm; Tue, 03 Mar 2026 17:14:42 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vxSOO-003Zk0-1K;
	Tue, 03 Mar 2026 17:14:41 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1vxSOP-0000000G7Sq-2dyJ;
	Tue, 03 Mar 2026 17:14:41 +0100
Date: Tue, 3 Mar 2026 17:14:41 +0100
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
Message-ID: <4x3dnedfzf3rqzsy3wjdoj6yaxmy6kop37xhxeao4vjer7ifdi@35ux42ztq3eb>
References: <20260111-v6-10-topic-touchscreen-axiom-v5-0-f94e0ae266cb@pengutronix.de>
 <20260111-v6-10-topic-touchscreen-axiom-v5-4-f94e0ae266cb@pengutronix.de>
 <qoelgb5k77a4c4jodn622a6wauotzkeygy5fj54cjjnobb5g6c@ysxkou6nhkop>
 <a7hajq5edw3w2pm5l3ytn65kmudjckvaj5relydayoua5i7oha@wsattyisot4s>
 <lgpdkwl7hxz7ok7qtujzdhf3c3iehwvm5d7myxfewr4kgrcq5k@3s4v4sjus7go>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lgpdkwl7hxz7ok7qtujzdhf3c3iehwvm5d7myxfewr4kgrcq5k@3s4v4sjus7go>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

Hi Andrew,

On 26-02-26, Andrew Thomas wrote:
> On Wed, Feb 25, 2026 at 09:50:11PM +0100, Marco Felsch wrote:

...

> > > > +static int axiom_u02_enter_bootloader(struct axiom_data *ts)
> > > > +{
> > > > +	struct axiom_u02_rev1_system_manager_msg msg = { };
> > > > +	struct device *dev = ts->dev;
> > > > +	unsigned int val;
> > > > +	int ret;
> > > > +
> > > > +	if (!axiom_driver_supports_usage(ts, AXIOM_U02))
> > > > +		return -EINVAL;
> > > > +
> > > > +	/*
> > > > +	 * Enter the bootloader mode requires 3 consecutive messages so we can't
> > > > +	 * check for the response.
> > > > +	 */
> > > > +	msg.command = cpu_to_le16(AXIOM_U02_REV1_CMD_ENTERBOOTLOADER);
> > > > +	msg.parameters[0] = cpu_to_le16(AXIOM_U02_REV1_PARAM0_ENTERBOOLOADER_KEY1);
> > > > +	ret = axiom_u02_send_msg(ts, &msg, false);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to send bootloader-key1: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > 
> > > A delay is required between commands. 10ms is fine.
> > 
> > Can I make use of the axiom_u02_wait_idle() logic which checks the
> > AXIOM_U02_REV1_RESP_SUCCESS? Arbitrary delays are always a source of
> > trouble.
> 
> Yes, I tested with axiom_u02_wait_idle() which is OK.

I tested it too, unfortunately I wasn't able to enter the bootlaoder
mode with:
  - axiom_u02_send_msg(.., .., true);

This aligns with the "Programmer's Guide":
| 
| 0x000B: ENTERBOOTLOADER
| 
| This command must be sent sequentially, in 3 phases, with no other usage
| accesses in between each phase...
| 

> I am slightly worried about too short a delay to axiom causing instability,
> however this works fine.
> It can unfortunately be an unstable device..

That could be one issue. I've added a delay of 10ms between each
enter-bootloader-cmd and tested the update. It turns out that the 10ms
delay makes the "enter bootloader" process more unstable. Without the
delay, I mostly enter the bootloader on the first attempt or at least
after three attempts. With the delay I needed 5+ attempts sometimes.

Therefore I would like to keep it as it is right now (no delay). Note:
The "Programmer's Guide" mentions no timing contraints as well. I added
a TODO comment to the driver.

...

> > > > +/* Custom regmap read/write handling is required due to the aXiom protocol */
> > > > +static int axiom_regmap_read(void *context, const void *reg_buf, size_t reg_size,
> > > > +			     void *val_buf, size_t val_size)
> > > > +{
> > > > +	struct device *dev = context;
> > > > +	struct i2c_client *i2c = to_i2c_client(dev);
> > > > +	struct axiom_data *ts = i2c_get_clientdata(i2c);
> > > > +	struct axiom_cmd_header hdr;
> > > > +	u16 xferlen, addr, baseaddr;
> > > > +	struct i2c_msg xfer[2];
> > > > +	int ret;
> > > > +
> > > > +	if (val_size > AXIOM_MAX_XFERLEN) {
> > > > +		dev_err(ts->dev, "Exceed max xferlen: %zu > %u\n",
> > > > +			val_size, AXIOM_MAX_XFERLEN);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	addr = *((u16 *)reg_buf);
> > > > +	hdr.target_address = cpu_to_le16(addr);
> > > > +	xferlen = FIELD_PREP(AXIOM_CMD_HDR_DIR_MASK, AXIOM_CMD_HDR_READ) |
> > > > +		  FIELD_PREP(AXIOM_CMD_HDR_LEN_MASK, val_size);
> > > > +	hdr.xferlen = cpu_to_le16(xferlen);
> > > > +
> > > > +	/* Verify that usage including the usage rev is supported */
> > > > +	baseaddr = addr & AXIOM_USAGE_BASEADDR_MASK;
> > > > +	if (!axiom_usage_supported(ts, baseaddr))
> > > > +		return -EINVAL;
> > > > +
> > > > +	xfer[0].addr = i2c->addr;
> > > > +	xfer[0].flags = 0;
> > > > +	xfer[0].len = sizeof(hdr);
> > > > +	xfer[0].buf = (u8 *)&hdr;
> > > > +
> > > > +	xfer[1].addr = i2c->addr;
> > > > +	xfer[1].flags = I2C_M_RD;
> > > > +	xfer[1].len = val_size;
> > > > +	xfer[1].buf = val_buf;
> > > > +
> > > > +	ret = i2c_transfer(i2c->adapter, xfer, 2);
> > > > +	if (ret == 2)
> > > > +		return 0;
> > > > +	else if (ret < 0)
> > > > +		return ret;
> > > > +	else
> > > > +		return -EIO;
> > > > +}
> > > 
> > > There needs to be atleast 40us holdoff between axiom bus transfers.
> > > I am not sure that has been considered here.
> > 
> > Is this written somewhere within the datasheet/programming-guide?
> 
> In aXiom Comms Protocol in v4.8.9 if you have access to the webportal
> it says to use 40us holdoff for report reading. Although this may apply
> to all transactions.

Okay this is new information :) TBH the paragraph is bit hard to read.
Furthermore in POLL-mode the IRQ-pin can't be sampled :/ As already
pointed out, I'm also not a fan of adding arbitrary delays. The driver
has already enough delays.

It's also not quite clear to me why the device keeps the IRQ line
asserted till the I2C-STOP was received? It's like your postman is
holding your door bell till you go to the door, open it, provide your
signature and close the door. In other words, this sounds like a
firmware bug.

For polling there should be a simple 'is data-avaiable?' -> yes: do
further processing; -> no: try again in N-poll-ms.

> Doing comms while axiom is changing the DMA causes issues (NAKs), for the
> driver I posted atleast, the holdoff was required otherwise I would receive
> 0-length reports frequently.

Yep in this is actually the case but the driver can handle 0-length
reports just fine. I will add this new information as code comment.
Also according "aXiom Comms Protocol v4.8.9":
|
| This will not result in a communications failure but the host will
| read an empty report, as the device will not have had time to prepare
| the next report.
|
it shouldn't be a problem.

> It looks to be fine currently, however if there is unstability for users
> we should consider adding this or something similar.

I would like to use the same mechanism for polling and IRQ mode to check
if the device POLL/IRQ is done or not. Since the driver can handle
0-length reports just fine, there should be no issue.

> > ...
> > 
> > > > +static enum fw_upload_err
> > > > +axiom_cfg_fw_prepare(struct fw_upload *fw_upload, const u8 *data, u32 size)
> > > > +{
> > 
> > ...
> > 
> > > > +	cur_runtime_crc = ts->crc[AXIOM_CRC_CUR].runtime;
> > > > +	fw_runtime_crc = ts->crc[AXIOM_CRC_NEW].runtime;
> > > > +	if (cur_runtime_crc != fw_runtime_crc) {
> > > > +		dev_err(dev, "TH2CFG and device runtime CRC doesn't match: %#x != %#x\n",
> > > > +			fw_runtime_crc, cur_runtime_crc);
> > > > +		ret = FW_UPLOAD_ERR_FW_INVALID;
> > > > +		goto out;
> > > > +	}
> > > 
> > > The firmware CRCs dont need to match for a config load, only the usage revision/length.
> > 
> > What difference does it make? The firmware CRC implicit includes the
> > usage revision and the length (register layout). So we can ensure that
> > the configuration was made for the correct register layout without
> > checking each register and revision.
> 
> Different firmware revisions/CRCs can have compatible usages.

Yes this could be possible, but...

> Aslong as the usage revisions match to u31 the usages will be compatible.

isn't a th2cfg binary a complete register value update or can a th2cfg
binary update only register parts?

> For us atleast we have different CRCs for small firmware changes, therefore
> if testing such firmware here we would always have to uncomment this section.

So it's rather a feature used by you guys during development?

> In the updated python I changed the check to the following:
> 
>     # Compare the firmware runtime CRC from the file with the CRC from the device.
>     # Only proceed if the CRCs match.
>     if not force:
>         if u33_from_file.fld_runtime_crc != ax.u33.fld_runtime_crc:
>             logging.error("Cannot load config file as it was saved from a different revision of firmware:")
>             logging.error("Firmware info from device      : 0x{0:08X}, {1}".format(ax.u33.fld_runtime_crc, ax.u31.get_device_info_short()))
>             logging.error("Firmware info from config file : 0x{0:08X}, {1}".format(u33_from_file.fld_runtime_crc, u31_from_file.get_device_info_short()))
>             return ERROR_CFG_FILE_NOT_COMPATIBLE
>     else:
>         if u33_from_file.fld_runtime_crc != ax.u33.fld_runtime_crc:
>             logging.warning("The config file was saved from a different revision of firmware therefore it may not be compatible:")
>             logging.warning("Firmware info from device      : 0x{0:08X}, {1}".format(ax.u33.fld_runtime_crc, ax.u31.get_device_info_short()))
>             logging.warning("Firmware info from config file : 0x{0:08X}, {1}".format(u33_from_file.fld_runtime_crc, u31_from_file.get_device_info_short()))
> 
>     # Now ensure the config is compatible with the device
>     valid_cfg = False
>     file_usage_table = u31_from_file.get_usage_table()
> 
>     for usage in usages.keys():
>         if usage not in ax.u31.get_usages():
>             logging.error(f"Usage u{usage:02x} unsupported on this device.")
>             break

I don't understand the logic here. Above you have a 'force' switch but
here you perform the checks anyway. So it's more like a 'light-force'?

Don't get me wrong I get your point but since this the mainline kernel
and the kernel needs to ensure that everything is correct I would like
to keep the simple firmware-crc check.

>         usage_entry = ax.u31.get_usage_entry(usage)
>         if usage_entry.start_page != file_usage_table[usage].start_page:
>             logging.error(f"Incompatible config address for u{usage:02x}:")
>             logging.error(f"  Device: 0x{usage_entry.start_page:02x}00  File: 0x{file_usage_table[usage].start_page:02x}00")
>             break
> 
>         if ax.get_usage_length(usage) != len(usages[usage][2]):
>             logging.error(f"Incompatible config length for u{usage:02x}:")
>             logging.error(f"  Device: {ax.get_usage_length(usage)}  File: {len(usages[usage][2])}")
>             break
>     else:
>         valid_cfg = True
> 
>     if not valid_cfg:
>         logging.error("Cannot load config as the usages are incompatible with the device.")
>         return ERROR_CFG_FILE_NOT_COMPATIBLE
> 
> Possibly we could add a force parameter to the sysfs like above?

Yes :) But this would be a 'force' aka no CRC check at all. I would see
this as addition which could be provided by you guys :)

> > ...
> > 
> > > > +static enum fw_upload_err
> > > > +axiom_cfg_fw_write(struct fw_upload *fw_upload, const u8 *data, u32 offset,
> > > > +		   u32 size, u32 *written)
> > > > +{
> > 
> > ....
> > 
> > > > +	/* Ensure that the chunks are written correctly */
> > > > +	ret = axiom_verify_volatile_mem(ts);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to verify written config, abort\n");
> > > > +		goto err_swreset;
> > > > +	}
> > > > +
> > > > +	ret = axiom_u02_save_config(ts);
> > > > +	if (ret)
> > > > +		goto err_swreset;
> > > > +
> > > > +	/*
> > > > +	 * TODO: Check if u02 start would be sufficient to load the new config
> > > > +	 * values
> > > > +	 */
> > > 
> > > It is not necessarily needed.
> > 
> > What do you mean by this? Do we need the axiom_u02_swreset() or can we
> > just start the system via u02 (without swreset)?
> 
> There is no need to do a reset after a config load you can just start the AE
> with CMD_START, but we can keep it as is since it does the same thing.

Okay, I will update the comment then.

> > > > +	ret = axiom_u02_swreset(ts);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Soft reset failed\n");
> > > > +		goto err_unlock;
> > > > +	}
> > 
> > ....
> > 
> > > > +static ssize_t fw_variant_show(struct device *dev,
> > > > +			       struct device_attribute *attr, char *buf)
> > > > +{
> > > > +	struct i2c_client *i2c = to_i2c_client(dev);
> > > > +	struct axiom_data *ts = i2c_get_clientdata(i2c);
> > > > +	const char *val;
> > > > +
> > > > +	switch (ts->fw_variant) {
> > > > +	case 0:
> > > > +		val = "3d";
> > > > +		break;
> > > > +	case 1:
> > > > +		val = "2d";
> > > > +		break;
> > > > +	case 3:
> > > > +		val = "force";
> > > > +		break;
> > > > +	default:
> > > > +		val = "unknown";
> > > > +		break;
> > > > +	}
> > > 
> > > The following are all the variants we currently support in order:
> > > FW_VARIANTS = ["3D", "2D", "FORCE", "0D", "XL"]
> > 
> > Means:
> > 
> > 0 == 3d
> > 1 == 2d
> > 3 == force
> > 4 == 0d
> > 5 == xl
> > 
> > ?
> > 
> > This is also something I can test on my site. Patches are welcome once
> > this is mainline of course :)
> 
> It is like so:
> #define DEVICE_BUILD_VARIANT_3D       (0U)
> #define DEVICE_BUILD_VARIANT_2D       (1U)
> #define DEVICE_BUILD_VARIANT_FORCE    (2U)
> #define DEVICE_BUILD_VARIANT_0D       (3U)
> #define DEVICE_BUILD_VARIANT_XL       (4U)

...

> I shall try to give a more prompt review once you have the new version up.

Thanks for your input, but keep in mind, that you guys could add your
additions ontop of our changes since our use-cases are fulfilled with
the current driver. However I've added the 0d, xl fw_variants and
updated the code comments.

Regards,
  Marco




> 
> Many Thanks,
> Andrew
> 
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
