Received: from box.trvn.ru (box.trvn.ru [45.141.101.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C9360EE1;
	Mon, 13 Jul 2026 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.141.101.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921979; cv=none; b=Lpx0OkfSfe7mThAH3td6nEzSBahreiPKRqnKDocTYJRGm6q4yhYStXRWnThQbJZbwuwW8hY0xRhbJ1FRH2mHiDoLITXWnuiJI9BEdqkYkMCiEmNZ9TX5f+HKra3qI1Tk+B8O+GsXJOW5rdfYSFJv2BWYDAoL8ROol4LZHuaOHGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921979; c=relaxed/simple;
	bh=lbL4FAbqkEaxJWIfg4gID+qDhnCvuvIhqc1F1Lh1GUk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mpnpZjRKCkl8VCJAoHjnDw7rDfri4/rKN1kLTFFVPP+iMZztzE0LF/6KwkNxyhHw2pVnR3483cxpj2EhTUQniTvMKYJurL9jWXD5yY905XCcsU+2jsb0Z5KalasW4nk8+r+Lh1UQV5sNuzDbfTHRc0zeMPnWgzEQ9I0liW6E08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=DxGUzeiF; arc=none smtp.client-ip=45.141.101.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="DxGUzeiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1783921662; bh=lbL4FAbqkEaxJWIfg4gID+qDhnCvuvIhqc1F1Lh1GUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DxGUzeiFlsISAOE8GgyM59P+383gBRnQOi9oU+W4C+xeJLMXUxAXT4+zYWjw2/Qo0
	 jzpo8XGk3vb5jInfr2I0upfB6wwlMkdcUaqvQcjzmEpXATyjsC48YbuWboT6Wfvp3O
	 VEAvDZWCAIfLlcQ9H0eimQ4U6FB8+jHrVwIbw66VYl/dt27ZG75+69lSxIeRZsu8Nu
	 97r8+B2nLd4NGL7ET4BdZYtghAT4W5/nOU9YQK4AvSgo5SW2syKtkbs0xx5FKCHHqx
	 Pijqp69nQSYzJjb7pcb1T3/vHP4K9LNGGR9yWNfqQ3GeEedie9Vv6tndS+Kc7ltlEm
	 XSah8dC4sgogw==
Received: from authenticated-user (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 824A56E81C;
	Mon, 13 Jul 2026 10:47:42 +0500 (+05)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 10:47:42 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Kavan Smith <kavansmith82@gmail.com>
Cc: dmitry.torokhov@gmail.com, michael.srba@seznam.cz,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: zinitix - support the 6-byte/count touch report
 used by bt532
In-Reply-To: <20260706180826.408989-1-kavansmith82@gmail.com>
References: <20260706180826.408989-1-kavansmith82@gmail.com>
Message-ID: <be60e6278a67cfed38c4e0874ec3431d@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kavan Smith писал(а) 06.07.2026 23:08:
> The driver assumes an 8-byte per-contact report stride with a per-finger
> bitmask in report byte[2]. bt532 firmware (Samsung Galaxy Tab A 8.0,
> msm8916-samsung-gt58) instead packs contacts at a 6-byte stride and reports
> a finger COUNT in byte[2]. Under the 8-byte/bitmask assumption fingers 1+
> are read misaligned, and a two-finger report (count 0x02) makes
> for_each_set_bit() visit only slot 1, collapsing multitouch to a single
> contact.
> 
> Add a per-compatible struct zinitix_chip_data that selects the report stride
> and how byte[2] is interpreted, and attach it to the bt532 compatible (the
> only in-tree user of it). All other compatibles keep the existing 8-byte,
> bitmask behaviour unchanged. Contacts are parsed at the chip's stride, and
> for count-style firmware every slot the chip marks with SUB_BIT_EXIST is
> reported.
> 

Hi!

I don't think this approach is correct here. Since the layout is most
likely fw defined, I don't think it should be attached to the chip
compatible but rather to each specific device - oem driver has a
dedicated fw update just for gt58 for example.

Notably, the driver already has facilities to define which touch mode a
device uses, just that only one mode was implemented so far.

Please refer to the OEM driver [1], perhaps you will be able to notice
something simpler there that'd make this firmware accept mode=2...

See few more minor comments below

Nikita

[1] https://github.com/msm8916-mainline/linux-downstream/blob/SM-T355Y/drivers/input/touchscreen/zinitix_bt532/zinitix_bt532_ts.c

> Signed-off-by: Kavan Smith <kavansmith82@gmail.com>
> ---
>  drivers/input/touchscreen/zinitix.c | 71 +++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c
> @@ -135,26 +135,47 @@
>  #define CHIP_ON_DELAY				15 // ms
>  #define FIRMWARE_ON_DELAY			40 // ms
>  
> +/*
> + * Two Zinitix touch-report layouts exist in the wild. The default is an 8-byte
> + * per-contact stride with a per-finger bitmask in report byte[2]. Some firmware
> + * (e.g. bt532 on the Samsung Galaxy Tab A 8.0) packs contacts at a 6-byte stride
> + * and reports a finger COUNT in byte[2] instead of a bitmask. Selected per
> + * compatible via the of_device_id .data below.
> + */
> +struct zinitix_chip_data {
> +	unsigned int coord_stride;	/* per-contact byte stride in the report */
> +	bool finger_count;		/* byte[2] is a finger count, not a bitmask */
> +};
> +
> +static const struct zinitix_chip_data zinitix_bt532_data = {
> +	.coord_stride = 6,
> +	.finger_count = true,
> +};
> +
>  struct point_coord {
>  	__le16	x;
>  	__le16	y;
>  	u8	width;
>  	u8	sub_status;
> -	// currently unused, but needed as padding:
> -	u8	minor_width;
> -	u8	angle;
> +	/*
> +	 * 8-byte-stride firmware appends two unused bytes here (minor_width,
> +	 * angle); the report is parsed at the chip's coord_stride, so on that
> +	 * firmware they are simply skipped rather than being part of this struct.
> +	 */
>  };
>  
>  struct touch_event {
>  	__le16	status;
>  	u8	finger_mask;
>  	u8	time_stamp;
> -	struct point_coord point_coord[MAX_SUPPORTED_FINGER_NUM];
> +	/* raw per-contact bytes, parsed at the chip's coord_stride (max 8) */
> +	u8	coords[MAX_SUPPORTED_FINGER_NUM * 8];
>  };
>  
>  struct bt541_ts_data {
>  	struct i2c_client *client;
>  	struct input_dev *input_dev;
> +	const struct zinitix_chip_data *chip;
>  	struct touchscreen_properties prop;
>  	struct regulator_bulk_data supplies[2];
>  	u32 zinitix_mode;
> @@ -444,6 +465,8 @@
>  {
>  	struct bt541_ts_data *bt541 = bt541_handler;
>  	struct i2c_client *client = bt541->client;
> +	unsigned int stride = bt541->chip ? bt541->chip->coord_stride : 8;
> +	bool finger_count = bt541->chip ? bt541->chip->finger_count : false;
>  	struct touch_event touch_event;
>  	unsigned long finger_mask;
>  	__le16 icon_events;
> @@ -452,8 +475,11 @@
>  
>  	memset(&touch_event, 0, sizeof(struct touch_event));
>  
> +	/* header (status, finger_mask, time_stamp) + one stride per contact */
>  	error = zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
> -				  &touch_event, sizeof(struct touch_event));
> +				  &touch_event,
> +				  offsetof(struct touch_event, coords) +
> +					  MAX_SUPPORTED_FINGER_NUM * stride);
>  	if (error) {
>  		dev_err(&client->dev, "Failed to read in touchpoint struct\n");
>  		goto out;
> @@ -470,13 +496,31 @@
>  		zinitix_report_keys(bt541, le16_to_cpu(icon_events));
>  	}
>  
> -	finger_mask = touch_event.finger_mask;
> -	for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
> -		const struct point_coord *p = &touch_event.point_coord[i];
> -
> -		/* Only process contacts that are actually reported */
> -		if (p->sub_status & SUB_BIT_EXIST)
> -			zinitix_report_finger(bt541, i, p);
> +	if (finger_count) {
> +		/*
> +		 * On this firmware byte[2] is a finger COUNT, not a bitmask: a

Which firmware?

> +		 * 2-finger report carries 0x02, so for_each_set_bit() would look
> +		 * only at slot 1 and silently drop slot 0. The chip marks every
> +		 * populated contact with SUB_BIT_EXIST, so iterate all slots and
> +		 * report the present ones.
> +		 */

Maybe worth checking how OEM driver works for different devices
that use zinitix chips.

> +		for (i = 0; i < MAX_SUPPORTED_FINGER_NUM; i++) {
> +			const struct point_coord *p =
> +				(const struct point_coord *)&touch_event.coords[i * stride];
> +
> +			if (p->sub_status & SUB_BIT_EXIST)
> +				zinitix_report_finger(bt541, i, p);
> +		}
> +	} else {
> +		/* default: byte[2] is a per-finger bitmask */
> +		finger_mask = touch_event.finger_mask;
> +		for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
> +			const struct point_coord *p =
> +				(const struct point_coord *)&touch_event.coords[i * stride];
> +
> +			if (p->sub_status & SUB_BIT_EXIST)
> +				zinitix_report_finger(bt541, i, p);
> +		}
>  	}
>  
>  	input_mt_sync_frame(bt541->input_dev);
> @@ -627,6 +671,7 @@
>  		return -ENOMEM;
>  
>  	bt541->client = client;
> +	bt541->chip = device_get_match_data(&client->dev);
>  	i2c_set_clientdata(client, bt541);
>  
>  	error = zinitix_init_regulators(bt541);
> @@ -741,7 +786,7 @@
>  	{ .compatible = "zinitix,bt431" },
>  	{ .compatible = "zinitix,bt432" },
>  	{ .compatible = "zinitix,bt531" },
> -	{ .compatible = "zinitix,bt532" },
> +	{ .compatible = "zinitix,bt532", .data = &zinitix_bt532_data },
>  	{ .compatible = "zinitix,bt538" },
>  	{ .compatible = "zinitix,bt541" },
>  	{ .compatible = "zinitix,bt548" },
