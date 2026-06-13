Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01F283FE6
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365401; cv=none; b=gZEn+ttHQMazhrjc4LUMbB6n+rAsaxiM7UxV+9UWpwVtfSd+axRwXkX4BW/FGcXsu+CjYe7XJBlUXyUzo7IK7TEn1Pf2AJAtXF/EvkaG7MZFEQPLTV6ZRf+EVgHsSrnVZKAPj/xFeWdBqOe3FoZI+/N8FmYVtjRdWMDrALIDCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365401; c=relaxed/simple;
	bh=ucz8lvVBUxjBq/HAiebA6Dk1ysskboisOj1yMixp8kc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pGy3kj/WGA5AtaeoIx50DAlcL1SCNmrOfxSD6Cu5bI4i+4yOASGwrkWdD6xE5pxeAC/NzrBQFxPPdD5yr8cuDliW02WcS90pTmNSgbDwUkVzDXMFdfQUyx76ZYVs9J9jDK05lCfS4ZImF03/uiu5o/lsaWBtJiEFUwpJbofeSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiRfDBo8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiRfDBo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78951F000E9;
	Sat, 13 Jun 2026 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781365400;
	bh=biQVX0P5W6hCRBb//AK7Rue5BRaKm2i9zj6/zarenpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jiRfDBo8T9nSpkac2rsC86i6UrsN+psDkyKLLeSCFevJ633JrH2vy5lhBe0Pdcq5/
	 uedyYjdOdT/qEK2mxgt0oO+TTICKJ02cDyVLzJrFWrbeWbXCr6+D9HZqHCEy68e3fh
	 f2xcJe/JuJkpmhxv/a6g+ipOiuLGUtQzxvsOW56eAMTT69Xtm9US1UEqPDsir6CcjD
	 gl439KX9+U+LeYw17ZKiA3jgo1bFJHmnboIY37dKl5kAPo+wewrEFUltIR1G7b6OLJ
	 +ukESbYtf7slyBEUmUoMUyCjW/fk58m/7BbBys8CpsDyDN6tbov7zvoLJlNx+wAS2/
	 JQdR8CG4pDBnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] HID: asus: avoid sleeping calls in atomic
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260613153029.2559774-6-denis.benato@linux.dev>
References: <20260613153029.2559774-6-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 15:43:19 +0000
Message-Id: <20260613154319.D78951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unbounded wmi_size assignment causes a stack buffer overflow and o=
ut-of-bounds read in asus_wmi_work().
- [High] Asynchronous invocation of hid_report_raw_event without acquiring =
driver_input_lock causes a data race.
- [High] Missing cancel_work_sync in asus_probe error paths leaves wmi_work=
 pending, causing a Use-After-Free.
- [Medium] Passing report_size as bufsize to hid_report_raw_event silently =
drops valid short reports.
--

commit 59c560d9da130f0e811e0abb99b0edf58eef0925
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: avoid sleeping calls in atomic context

Avoid possibly calling asus_wmi_send_event(): a method that can sleep in
asus_raw_event() that is called in atomic context.

This commit changes when methods are called, not method parameters:
the driver behaves as before.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index e3a03f7cf77d0..a3437789b2341 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -361,6 +369,32 @@ static int asus_wmi_send_event(struct asus_drvdata *=
drvdata, u8 code)
>  	return 0;
>  }
> =20
> +static void asus_wmi_work(struct work_struct *work)
> +{
> +	struct asus_drvdata *drvdata =3D container_of(work, struct asus_drvdata=
, wmi_work);
> +	u8 report_data[FEATURE_KBD_REPORT_SIZE];
> +	int report_size;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&drvdata->wmi_lock, flags);
> +	memcpy(report_data, drvdata->wmi_data, drvdata->wmi_size);

[Severity: High]
Can this memcpy cause a stack buffer overflow?

In asus_raw_event(), drvdata->wmi_size is assigned the untrusted raw event
size without being clipped to the maximum buffer size. When the asynchronous
worker processes this, it uses that unclipped size as the length for memcpy
into the fixed 64-byte report_data stack array.

A malicious or malfunctioning USB device sending a report larger than
64 bytes could overflow the stack here.

> +	report_size =3D drvdata->wmi_size;
> +	spin_unlock_irqrestore(&drvdata->wmi_lock, flags);
> +
> +	ret =3D asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
> +	if (ret) {
> +		if (ret !=3D -ENODEV)
> +			hid_warn(drvdata->hdev, "Failed to notify asus-wmi: %d\n", ret);
> +
> +		/* Fallback: pass the raw event to the HID core */
> +		hid_report_raw_event(drvdata->hdev, HID_INPUT_REPORT,
> +				     report_data, report_size,
> +				     report_size, 1);

[Severity: High]
Is it safe to call hid_report_raw_event() asynchronously without acquiring
hdev->driver_input_lock?

The HID core expects callers of hid_report_raw_event() to hold this lock
to ensure exclusive access when modifying shared state within the HID report
structure. If a concurrent hardware interrupt triggers __hid_input_report(),
it could successfully acquire the lock and mutate the HID report state at t=
he
same time, potentially leading to data corruption or crashes.

[Severity: Medium]
Does passing report_size as the bufsize parameter prevent the HID core from
safely handling short reports?

The HID core requires bufsize to be at least the expected size of the report
so it can safely zero-pad short reports. Because bufsize is constrained here
to the actual payload size, the safety check inside hid_report_raw_event()
might fail, causing valid short reports to be permanently dropped with an
EINVAL error.

> +	}
> +}
> +#endif
> +

[ ... ]

> @@ -422,19 +459,18 @@ static int asus_raw_event(struct hid_device *hdev,
>  			 * pass to userspace so it can implement its own fan control.
>  			 */
>  			if (data[1] =3D=3D ASUS_FAN_CTRL_KEY_CODE) {
> -				int ret =3D asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
> -
> -				if (ret =3D=3D 0) {
> -					/* Successfully handled by asus-wmi, block event */
> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
> +				spin_lock_irqsave(&drvdata->wmi_lock, flags);
> +				memcpy(drvdata->wmi_data, data, min_t(int, size, sizeof(drvdata->wmi=
_data)));
> +				drvdata->wmi_size =3D size;

[Severity: High]
Should drvdata->wmi_size be capped to the size of the buffer?

While the memcpy directly above safely clips the copy using min_t(),
drvdata->wmi_size is assigned the unclipped size, leading to the stack buff=
er
overflow when it is consumed in asus_wmi_work().

> +				spin_unlock_irqrestore(&drvdata->wmi_lock, flags);
> +
> +				if (!drvdata->wmi_work_disabled) {
> +					schedule_work(&drvdata->wmi_work);
> +					/* Successfully handled asynchronously, block event */
>  					return -1;
>  				}

[ ... ]

> @@ -1344,6 +1380,10 @@ static int asus_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  		hdev->quirks |=3D HID_QUIRK_NO_INIT_REPORTS;
> =20
>  	drvdata->hdev =3D hdev;
> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
> +	INIT_WORK(&drvdata->wmi_work, asus_wmi_work);
> +	spin_lock_init(&drvdata->wmi_lock);
> +#endif

[Severity: High]
Could wmi_work trigger a use-after-free if probe fails during later stages?

In asus_probe(), after wmi_work is initialized, hid_hw_start() is called wh=
ich
enables hardware interrupts. At this point, incoming events can queue wmi_w=
ork.

If a subsequent initialization step fails (for example, asus_xgm_init()),
the function jumps to the err_stop_hw label:

err_stop_hw:
    hid_hw_stop(hdev);
    return ret;

This returns an error without calling cancel_work_sync(&drvdata->wmi_work).
The workqueue subsystem guidelines state that once a work struct is queued,
shutdown methods must prevent leaking it. The drvdata memory will be freed
by devres, and any pending wmi_work will execute on freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613153029.2559=
774-1-denis.benato@linux.dev?part=3D5
