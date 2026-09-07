Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF36470444;
	Mon,  7 Sep 2026 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779084; cv=none; b=Cb0fgIisJ4R6BuU/pk9gQN7mT9ZdIH4QyUG426YzwZwr7jQXgpSqefRtUAmbFLfLhbH37knetC2wzMGm3DfTjvjj9O10cfUmE+sAqQZxSJYPdthEbzeqU6fpJLq5Lnh2jK5tMM3sNBQ6Fn0jFvfnZjKHlZMJ9DBU2kEOxsflGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779084; c=relaxed/simple;
	bh=0hCVn0f4EBDaDcQ/BTyw91QenIAjFpnFb9Glpz2YRtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cxFhJXzfYolEXihIhIE0vvpQ10PIW05HJSNhjIPTrVRU2gfueZJwBxTI5K6HxAPqtU4bozfP3+Igh5U0SXge7OpRnvZ+aX/BmVLplPxJpMMZrPioNGfPquOz9hpy4Evg+VtkECGFnqCgwVb2cxDvCAIY/ad/zmptm5D2SSkX4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m02rmuK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m02rmuK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEBE1F00A3E;
	Mon,  7 Sep 2026 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788779082;
	bh=hBLMR0Lv02o8iJdW3skpsP3HsYSEPCwE4aMrRL6027Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m02rmuK55DJpHdmYLxyuSqXC5Bu781FAjD4XH52Mjfz45vzTAsdDtARYlsHEDGrgm
	 yheh2JXC8SAbwN2thqdJNrc4KGd3szd7cLimfp+iVCkYo2QONQ2EUaLqyku1aTuSlQ
	 zG9m7zaBw9sPbztOkI0XRsBS1TSvd6a/iUUxcfpHT2YA5wEWUBgxcnARow4HByJJzL
	 sp2jAaU3pEKjbn6aduqQvgEhXUtz0PE4qv5XsAPRzVM9uIi8O3tG/quWa8nxLfgKXt
	 rXidH6H3xYBPlv2OWte2QrcFm2MkCj669dD27UQetm/ng8yunsB7TxVcF+opY3N3hT
	 x6uAk6pIIwkPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] Input: stmfts - support FTS5
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260907-stmfts5-v7-3-4a53381cd038@ixit.cz>
References: <20260907-stmfts5-v7-0-4a53381cd038@ixit.cz>
 <20260907-stmfts5-v7-3-4a53381cd038@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:04:41 +0000
Message-Id: <20260907110442.6BEBE1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The FTS5 driver silently drops all stylus and palm tool-type eve=
nts because the ABS_MT_TOOL_TYPE capability is never configured on the inpu=
t device.
- [Medium] Prematurely exiting the event parsing loop on non-terminal event=
s can cause dropped touch events and partial frames.

Pre-existing issues:
- [High] sysfs attribute returns uninitialized kernel memory due to incorre=
ct error check.
--

commit aa502b398bf6eeb31cabf6ce200968e3d20a68a7
Author: David Heidelberg <david@ixit.cz>
Subject: Input: stmfts - support FTS5

This commit introduces support for the FTS5 protocol in the stmfts
touchscreen driver. It adds FTS5-specific functions for device configuratio=
n,
input setup (including initial stylus handling), and event parsing.

This is a pre-existing issue, but while reviewing I noticed a potential
memory leak in the sysfs read handler stmfts_sysfs_read_status() that
was not introduced by this patch:

drivers/input/touchscreen/stmfts.c:stmfts_sysfs_read_status() {
    ...
    err =3D i2c_smbus_read_i2c_block_data(sdata->client, STMFTS_READ_STATUS,
                                        sizeof(status), status);
    if (err)
        return err;

    return sysfs_emit(buf, "%#02x\n", status[0]);
}

[Severity: High]
Does this error check leak uninitialized memory? The function
i2c_smbus_read_i2c_block_data() returns the positive number of bytes read
on success. By treating any non-zero return value as an error, a successful
read will immediately return this positive byte count to the sysfs core,
bypassing sysfs_emit() and potentially leaking up to 4 bytes of uninitializ=
ed
kernel memory to userspace.

> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscre=
en/stmfts.c
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c
[ ... ]
> +static void stmfts5_report_contact_event(struct stmfts_data *sdata,
> +					 const u8 event[])
> +{
[ ... ]
> +	switch (touch_type) {
> +	case STMFTS_TOUCH_TYPE_STYLUS:
> +		if (sdata->stylus_enabled) {
> +			tool =3D MT_TOOL_PEN;
> +			break;
> +		}
> +		fallthrough; /* Report as finger if stylus not enabled */
[ ... ]
> +	input_mt_slot(sdata->input, touch_id);
> +	input_mt_report_slot_state(sdata->input, tool, true);
[ ... ]
> +static void stmfts5_parse_events(struct stmfts_data *sdata)
> +{
> +	for (int i =3D 0; i < STMFTS_STACK_DEPTH; i++) {
> +		u8 *event =3D &sdata->data[i * STMFTS_EVENT_SIZE];
[ ... ]
> +		switch (event[0] & STMFTS5_MASK_EVENT_ID) {
> +		case STMFTS5_EV_STATUS_UPDATE:
> +		case STMFTS5_EV_USER_REPORT:
> +		case STMFTS5_EV_DEBUG:
> +			goto sync;

[Severity: Medium]
Could this premature loop exit cause subsequent touch events in the same
buffer to be dropped?

If STMFTS5_EV_STATUS_UPDATE, STMFTS5_EV_USER_REPORT, or STMFTS5_EV_DEBUG=20
occurs alongside standard touch events in a single read buffer, the=20
goto sync; statement will break out of the event parsing loop entirely.=20
Would using continue be more appropriate here to skip the non-touch event=20
and continue processing the rest of the buffer?

> +
> +		case STMFTS5_EV_MULTI_TOUCH_ENTER:
> +		case STMFTS5_EV_MULTI_TOUCH_MOTION:
> +			stmfts5_report_contact_event(sdata, event);
> +			break;
[ ... ]
> +static int stmfts5_setup_input(struct stmfts_data *sdata)
> +{
[ ... ]
> +	input_set_abs_params(sdata->input, ABS_MT_DISTANCE, 0, 255, 0, 0);
> +
> +	/* Enable stylus support if requested */
> +	sdata->stylus_enabled =3D device_property_read_bool(dev, "stylus-enable=
d");
> +
> +	return input_mt_init_slots(sdata->input, STMFTS_MAX_FINGERS,
> +				   INPUT_MT_DIRECT);
> +}

[Severity: Medium]
Does this driver need to configure the ABS_MT_TOOL_TYPE capability for
stylus and palm events to be processed?

In stmfts5_report_contact_event() above, the tool type is reported to the
input core. However, because input_set_abs_params() or input_set_capability=
()
is not called for ABS_MT_TOOL_TYPE here in stmfts5_setup_input(), the input=
=20
subsystem will silently drop these tool type events, degrading the hardware=
=20
functionality to basic finger touches.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-stmfts5-v7=
-0-4a53381cd038@ixit.cz?part=3D3
