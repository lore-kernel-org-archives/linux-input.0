Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550930E83F;
	Sun, 11 Oct 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791743219; cv=none; b=UT++Ia2y+6XU959JljSlpZu/fm/oXF/+UAt78c8l/bCvnRX/1WpUi0t1pjW8cH0zTAIeVGdW7L2IbO1bHcxaG3Moxe//WIUL/R2phAwWizewCs9t8uoQA2GU5Kkj4vvZAWeMeJEgzEBgZY8E7YtO9Q3t6W5TDNeKS12mfA71SbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791743219; c=relaxed/simple;
	bh=oSJ/ZslUiF9shLW6hEhQxk0zRYFM18ZAqTuRIY6xu54=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ECuk6taAxA+RwjykN1joeAaogTK558M0RGTDSalCmixNOdzoAO1z+yxqyz9jGDFaJZoVJW52raZBgC39LtxRTgLa/PStEGouaekzC1ocapS7FwubGr/nqIXBtpGstQnXVPxAbCS1raRzrZCg5s/yKZdqtpbefQK2aY+IdQWOgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY2X4Nq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY2X4Nq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B1B1F0089B;
	Sun, 11 Oct 2026 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791743218;
	bh=rxGwIY2IEdGUVvkCUR0SvEwzfMVuxTJiVFN4fAwbAl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bY2X4Nq5HFLVF1EeDDo5Cuko1DFRKFf1G+jhZItVDgYr2dwuUUhAXaR/aoBQ+9qP9
	 A+vxIPKpzhK5RvErRRPwJdioSDTdoXshy3u8T8Z1oDmAgOo1Olqhhl0iuri7QUElXr
	 nGSJePqKQ6ko03TKzNXNXooFuwWLSXf4p3/Mv08oht7R2+F40F+tW1pcufHGyzvfS1
	 6fwZJPhl73e5ViYqlbGUd0LAwQz2/a1bL5x2VQGG2rDK2kkW0hfjjuZng7rTrY7xdq
	 qE5A4qOwFkdC9cW3w/Ic7nU6cUz2/N1mandjFikV/mZlYGU2tE/rxs4GjeriKwKpl/
	 LoLcfQgGchTfg==
Message-ID: <sashiko-outbox-167377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] HID: Add Himax HX83102J SPI touchscreen driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20261011181633.1778969-3-michal@nozomi.space>
References: <20261011181633.1778969-1-michal@nozomi.space>
 <20261011181633.1778969-3-michal@nozomi.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 18:26:57 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] hid: himax_hid_raw_request() returns requested length instead of a=
ctual bytes written, leaking uninitialized memory
- [High] hid: hardware swallows commands after himax_pin_reset() due to mis=
sing dummy bus read
- [Low] hid: himax_hid_add() fails to initialize mandatory hid_device field=
s (phys, uniq, country)
--

commit 09f1c425ef5c3359e150cf5f66b3a172b5847898
Author: Micha=C5=82 Kope=C4=87 <michal@nozomi.space>

HID: Add Himax HX83102J SPI touchscreen driver

This commit adds a new driver for the Himax HX83102J touch and display driv=
er
integrated (TDDI) controller, connecting over SPI and sending HID reports.
The driver supports loading firmware for flashless variants and coordinates
power management with the display panel.

Link: https://lore.kernel.org/all/TY0PR06MB56110754EB9D827BE3304A259E0F2@TY=
0PR06MB5611.apcprd06.prod.outlook.com/ [1]
Link: https://chromium-review.googlesource.com/c/chromiumos/third_party/ker=
nel/+/5326106 [2]

> diff --git a/drivers/hid/hid-himax-spi.c b/drivers/hid/hid-himax-spi.c
> new file mode 100644
> index 0000000000000..98ee51658b362
> --- /dev/null
> +++ b/drivers/hid/hid-himax-spi.c

[ ... ]

> +static int himax_sense_off(struct himax_ts_data *ts)
> +{
> +	unsigned int tries =3D 5;
> +	u32 val;
> +	int ret;
> +
> +	while (tries--) {
> +		ret =3D himax_enter_safe_mode(ts);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D himax_read32(ts, HIMAX_REG_FW_STATUS, &val);
> +		if (ret)
> +			return ret;
> +
> +		if (FIELD_GET(HIMAX_FW_STATE, val) =3D=3D HIMAX_FW_STATE_SAFE_MODE) {
> +			/* The touch MCU can't be used before the TCON is reset */
> +			ret =3D himax_write32(ts, HX83102J_REG_TCON_RST, 0);
> +			if (ret)
> +				return ret;
> +
> +			fsleep(1000);
> +			return 0;
> +		}
> +
> +		fsleep(5000);
> +		himax_pin_reset(ts);
> +	}
> +
> +	return -EIO;
> +}

[Severity: High]
Does this error recovery loop inadvertently swallow the safe mode command?

The documentation in himax_interface_on() states that the hardware swallows
the first SPI transaction after a pin reset. Here, himax_pin_reset(ts)
is called and the loop immediately restarts with himax_enter_safe_mode(ts).
Without a dummy read to wake the bus, the safe mode command itself might be
swallowed, which could prevent the IC from ever entering safe mode and
create an infinite failure loop.

> +static int himax_sense_on(struct himax_ts_data *ts)
> +{
> +	int ret;
> +
> +	ret =3D himax_interface_on(ts);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D himax_write32(ts, HIMAX_REG_CTRL_FW, HIMAX_FW_RE_INIT);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(10000);
> +	himax_pin_reset(ts);
> +
> +	ret =3D himax_enable_hw_crc(ts);

[Severity: High]
Could the hardware swallow the first AHB configuration write here?

Similarly to the loop in himax_sense_off(), a hardware reset from
himax_pin_reset(ts) is immediately followed by a write function
(himax_enable_hw_crc). This means the first AHB configuration write
(HIMAX_BUS_AHB_CONTI inside himax_ahb_set_burst) might be swallowed
by the sleeping bus, potentially corrupting the AHB transaction state.

[ ... ]

> +static int himax_hid_raw_request(struct hid_device *hid, unsigned char r=
eportnum,
> +				 u8 *buf, size_t len, unsigned char rtype, int reqtype)
> +{
> +	struct himax_ts_data *ts =3D hid->driver_data;
> +
> +	/* The only feature report the driver serves is the maximum contact cou=
nt */
> +	if (reqtype !=3D HID_REQ_GET_REPORT || reportnum !=3D HIMAX_REPORT_ID_C=
ONTACT_MAX ||
> +	    len < 2)
> +		return -EINVAL;
> +
> +	buf[0] =3D reportnum;
> +	buf[1] =3D ts->max_points;
> +
> +	return len;

[Severity: High]
Does this code leak uninitialized kernel heap memory to userspace?

The driver handles HID_REQ_GET_REPORT requests by populating exactly 2 byte=
s.
However, it unconditionally returns len (the size of the buffer requested
by the caller) rather than 2.=20

When userspace issues an ioctl (like HIDIOCGFEATURE) with a length larger
than 2, the hidraw core allocates a buffer of size len using kmalloc(), whi=
ch
does not zero memory. Because the driver returns len, hidraw copies the full
buffer back to userspace, leaking the remaining uninitialized bytes.

[ ... ]

> +static int himax_hid_add(struct himax_ts_data *ts)
> +{
> +	const struct himax_hid_desc *desc =3D ts->hid_desc;
> +	struct hid_device *hid;
> +	int ret;
> +
> +	if (!ts->event_buf) {
> +		ret =3D himax_read_ic_info(ts);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D himax_alloc_report_bufs(ts);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	hid =3D hid_allocate_device();
> +	if (IS_ERR(hid))
> +		return PTR_ERR(hid);
> +
> +	hid->driver_data =3D ts;
> +	hid->ll_driver =3D &himax_hid_ll_driver;
> +	hid->bus =3D BUS_SPI;
> +	hid->dev.parent =3D ts->dev;
> +	hid->version =3D le16_to_cpu(desc->bcd_version);
> +	hid->vendor =3D le16_to_cpu(desc->vendor_id);
> +	hid->product =3D le16_to_cpu(desc->product_id);
> +	snprintf(hid->name, sizeof(hid->name), "hid-hxtp %04X:%04X",
> +		 hid->vendor, hid->product);
> +
> +	ret =3D hid_add_device(hid);

[Severity: Low]
Are there missing initializations for mandatory hid_device fields here?

According to the HID Subsystem Guide, before registration, the transport
driver must fully initialize the hid_device fields, including phys, uniq,
and country. While hid_allocate_device() zeroes the structure, explicitly
setting these fields is a documented subsystem requirement for all
transport drivers before calling hid_add_device().

[ ... ]

> +static irqreturn_t himax_irq(int irq, void *data)
> +{
> +	struct himax_ts_data *ts =3D data;
> +	size_t len =3D ts->max_input_len - HIMAX_REPORT_HDR_SIZE;
> +	size_t pos =3D HIMAX_REPORT_HDR_SIZE;
> +	int ret;
> +
> +	ret =3D himax_read_events(ts);
> +	if (ret) {
> +		dev_warn_ratelimited(ts->dev, "failed to read events: %d\n", ret);
> +		himax_pin_reset(ts);
> +		himax_reload_to_active(ts);
> +		return IRQ_HANDLED;
> +	}

[Severity: High]
Is a dummy bus read also needed here during error recovery?

The error recovery path calls himax_pin_reset(ts) and directly writes to
HIMAX_REG_RELOAD_TO_ACTIVE. Just like the reset cases in himax_sense_off()
and himax_sense_on(), this command might be swallowed by the sleeping bus,
leaving the hardware in an inconsistent state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011181633.1778=
969-1-michal@nozomi.space?part=3D2
