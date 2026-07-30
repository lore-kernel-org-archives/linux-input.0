Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11392372ECA;
	Thu, 30 Jul 2026 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443529; cv=none; b=nE5a2lMTh63OZcM6IrOf/Q/78Pgup2Q5Oq6VFaHaRlSV8NxMmZ8r3NCvtR0jqGglVLNbUiANDr1e1ukv9d+LyQuRyYE3rq/9ERPnYXlBnCvtbf/3zu3j8j/QyybrKmrGKXtc+rIVK6dpy58+dCgSQ9ePLBKZcAdlag2DihfP5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443529; c=relaxed/simple;
	bh=ltp9rpH75N4jzEu8KYmLVjYxA4yX/WK1khrIYuEAo0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jDZ4a/oJ5q2G+C9UqwZ8r9aisMtalfseq1OyxgSzzu+pirt582KXAldt2DS2Xd6D1pJRINR0k6wzru4MKajIgdr2iRrwRjL4/p6cj81klAwQZs+nI7YqVeIp9zP6R+Nwo/lFdakTXrLbSiA/K28GWpOJFvO7iWxJGbL7/NL87co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXwHl/+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXwHl/+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399FD1F000E9;
	Thu, 30 Jul 2026 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785443518;
	bh=OqQrlLzevJfKesxlgN2vLjLIVLSv6VJzAb67OIIJts4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oXwHl/+4DzTDwW7DUDbB26UzLAyTPC6V9z0ujmbXa15FLrmxEv6zdqPgtnTV+DFU7
	 zBbwjf9imexqru0saIrcf++vthzwka09083JNT+uDluOeJ4A+u4Krxz2a2LKJCEVtg
	 RjsVok3Xco36s2JdaJvH7CKbw45dTQlS7jlKxnD+EspmH2kX7tz9a2KQOuNANg4nkc
	 awMaKVc14Zg4LdsOqBHx9qQCraS6v22jRi3TLKEbVoQyZ59LzfNrRbkNKq56SZAdyA
	 XkGiEDc0G0dhchE8Oo+/LrI9eoB+3I6wAxXF0QwX6z3wtqGE75O9xE85eNf9EvE+Ot
	 xwmaT3ZAlw+kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] Input: zinitix - check all available fingers for
 every touch event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260731-zinitix-modes-v3-1-2c8de712997a@disroot.org>
References: <20260731-zinitix-modes-v3-0-2c8de712997a@disroot.org>
 <20260731-zinitix-modes-v3-1-2c8de712997a@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:31:57 +0000
Message-Id: <20260730203158.399FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unconditionally iterating all slots without a mask reinstates a kn=
own phantom fingers bug on certain devices.

Pre-existing issues:
- [High] The input device is registered and exposed to userspace before its=
 operational properties are fully parsed and initialized.
- [High] Failing to read icon events discards already successfully read tou=
ch events, bypassing synchronization.
- [High] Stack-allocated variables are used directly as data buffers for I2=
C transfers, violating DMA safety requirements.
--

--- Patch [1]: [PATCH v3 1/5] Input: zinitix - check all available fingers =
for every touch event ---
commit 324dca54b2be4e95e88ba6bec7c1bec867e0e687
Author: Kaustabh Chakraborty <kauschluss@disroot.org>
Input: zinitix - check all available fingers for every touch event

This patch changes the touch reporting to iterate unconditionally over all
slots rather than relying on the finger_mask field. It relies on the
SUB_BIT_EXIST bit in the finger status to filter valid touches.

Link: https://android.googlesource.com/kernel/bcm/+/23d376ef33aa4c500a5ea24=
a290f029d5f8e2de3/drivers/input/touchscreen/zinitix_touch.c#1942 [1]

> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscr=
een/zinitix.c
> index 0c36765bd79f8..3421b8ffb19b2 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c
> @@ -445,7 +445,6 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, vo=
id *bt541_handler)
>  	struct bt541_ts_data *bt541 =3D bt541_handler;
>  	struct i2c_client *client =3D bt541->client;
>  	struct touch_event touch_event;

[Severity: High]
This isn't a bug introduced by this patch, but touch_event is allocated on
the stack and then passed to zinitix_read_data(), which feeds it directly
to the I2C subsystem. Since this buffer might be used for DMA transfers on
certain I2C host controllers, can this cause memory corruption or a kernel
panic when CONFIG_VMAP_STACK is enabled?

Similarly, in zinitix_read_data():

zinitix_read_data() {
    __le16 reg_le =3D cpu_to_le16(reg);
    ...
    ret =3D i2c_master_send(client, (u8 *)&reg_le, sizeof(reg_le));
    ...
}

Are there similar DMA safety concerns when using the stack-allocated reg_le
buffer for I2C sending?

> -	unsigned long finger_mask;
>  	__le16 icon_events;
>  	int error;
>  	int i;
> @@ -470,8 +469,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, vo=
id *bt541_handler)
>  		zinitix_report_keys(bt541, le16_to_cpu(icon_events));
>  	}

[Severity: High]
This is a pre-existing issue, but I noticed something about the error handl=
ing
just above this block:

zinitix_ts_irq_handler() {
    ...
    if (le16_to_cpu(touch_event.status) & BIT_ICON_EVENT) {
        error =3D zinitix_read_data(bt541->client, bt541->icon_status_reg,
                                  &icon_events, sizeof(icon_events));
        if (error) {
            dev_err(&client->dev, "Failed to read icon events\n");
            goto out;
        }
        ...
    }
    ...
out:
    zinitix_write_cmd(bt541->client, ZINITIX_CLEAR_INT_STATUS_CMD);
    return IRQ_HANDLED;
}

If zinitix_read_data() for the icon events fails, the code jumps directly to
out. Will this discard the successfully read touch_event data and skip the
input_mt_sync_frame() and input_sync() calls, potentially leaving stuck tou=
ches
in the input core?

> =20
> -	finger_mask =3D touch_event.finger_mask;
> -	for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
> +	for (i =3D 0; i < MAX_SUPPORTED_FINGER_NUM; i++) {
>  		const struct point_coord *p =3D &touch_event.point_coord[i];
> =20
>  		/* Only process contacts that are actually reported */

[Severity: High]
The commit message mentions that phantom fingers will be ignored because
zinitix_report_finger() checks the SUB_BIT_EXIST bit. However, the
finger_mask check was originally introduced (in commit e941dc13fd37) because
some hardware erroneously sets SUB_BIT_EXIST for phantom fingers.=20

By removing the finger_mask iteration, is it possible this reinstates the
known phantom touches bug on affected hardware (like the BT404) where a
single physical touch causes multiple active slots?

[Severity: High]
This isn't a bug introduced by this patch, but looking at the device
initialization in zinitix_ts_probe():

zinitix_ts_probe() {
    ...
    error =3D zinitix_init_input_dev(bt541);
    if (error) {
        ...
    }

    error =3D device_property_read_u32(&client->dev, "zinitix,mode",
                                     &bt541->zinitix_mode);
    ...
}

Since zinitix_init_input_dev() calls input_register_device(), the input
device becomes immediately visible to userspace. If userspace opens the dev=
ice
instantly, zinitix_input_open() -> zinitix_start() will run before the
zinitix,mode property is read.

Could this cause the hardware to be configured with an incorrect mode
(0 instead of the requested or default 2)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-zinitix-mo=
des-v3-0-2c8de712997a@disroot.org?part=3D1
