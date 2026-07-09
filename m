Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB6392C34
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568163; cv=none; b=giVp3wE2TpjRxTW0FMAK8XKvD+V3kE8lttib6fFpIykvo0pfJwkmpRphq4DtcTYzZWC4qSqCHFNvKS9/h5F/f4c87c3wrE10npJZqq1y78JW6aPK9lrvq1QJAxS6WqXdEQkUl8EwMiYOrTsxptQ15ztHQonFfwPbyXf3l3pLw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568163; c=relaxed/simple;
	bh=qphZClAOsfl6feTQba+j5nqqCg3AKiORofhg+qKpK4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tDNpnUlXEcPtXsbgodUubJdMRhPOxh+pPbYtkpuZuG7iAsnfMUnDLAoHkHBDEEZZ+JKVdDRlmJEL5+N6PIgRNUqH3C6RJBLoFs9k+uxGLeE9BbduOMLnP6cSSKyY3NWS4s07DAXW/AAJYKTuBOKkr8krA6MNde6ULBc8PDqKQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALgrCDto; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALgrCDto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50B81F000E9;
	Thu,  9 Jul 2026 03:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783568162;
	bh=AYPsXajiZzqWkomHWu1n5Fx43Q/ykn2Icg03qDWDIkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ALgrCDtoMUgbchMiAqHMnN8fhffG9mUA6bUKbxy6YOJYjcsQLcKZhH0CwErK4uqqN
	 gbD3qA/qESgsSijbk6m9IQOMFMzPqBWOiS6X4z84gHJ5o9GkMUxKW4J5uq8M5XR/8/
	 yymRfGEdWZ38r2fuBhp+G+mYHfZVxQ6mhBORki9YK78xDnrotzfvPOP7iyiDopY9+8
	 sCTtgdOf3zYDqHo+GUg2dHQF3JMxdCN3rjaMXMzNbARTA61P7K3x2QG1HRmoUSAiYe
	 Fr7d3Ym5ZfwwcKKFGRpsfnnTTF09cq2YMewfWIlyQgsLcRo90gsNYW7Co5nNfA+PF1
	 7jZSZpj7YdA3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] HID: steelseries: Fix ARCTIS_1_X device
 mislabeling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260709032316.1908460-2-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
 <20260709032316.1908460-2-68172138+srimanachanta@users.noreply.github.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 03:36:01 +0000
Message-Id: <20260709033601.B50B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The probe function leaks hardware state and input devices if `hid_=
hw_open()` fails, leading to Use-After-Free.
- [High] Failure to register the power supply leaves an ERR_PTR and an unin=
itialized delayed_work, causing kernel panics on incoming events or device =
removal.
--

--- Patch [1]: [PATCH v6 1/9] HID: steelseries: Fix ARCTIS_1_X device misla=
beling ---
commit c38516edb3d8e3340b9141595b245b3a3b7f06a6
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Fix ARCTIS_1_X device mislabeling

The SteelSeries Arctis 1 Wireless for Xbox (0x12b6) was labelled as the
plain Arctis 1 Wireless. Rename USB_DEVICE_ID_STEELSERIES_ARCTIS_1 to
USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X, along with the matching quirk flag
and device table entry. The device ID value is unchanged.

> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> index f98435631aa18..fd38ee3ea6fcb 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c

[ ... ]

> @@ -638,7 +638,7 @@ static int steelseries_headset_raw_event(struct hid_d=
evice *hdev,
>  	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_SRWS1)
>  		return 0;
> =20
> -	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_ARCTIS_1) {
> +	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) {
>  		hid_dbg(sd->hdev,
>  			"Parsing raw event for Arctis 1 headset (%*ph)\n", size, read_buf);

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in how
headset events are handled if battery registration fails.

Looking at steelseries_probe(), if the battery registration fails it logs an
error but returns success:

drivers/hid/hid-steelseries.c:steelseries_probe() {
    ...
    if (steelseries_headset_battery_register(sd) < 0)
        hid_err(sd->hdev,
            "Failed to register battery for headset\n");

    return ret;
}

This leaves sd->battery containing an error pointer, and skips initializing
the battery_work structure. When an event is received later, the headset raw
event handler proceeds to use these uninitialized members:

drivers/hid/hid-steelseries.c:steelseries_headset_raw_event() {
    ...
    power_supply_changed(sd->battery);
    ...
    schedule_delayed_work(&sd->battery_work,
            msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
}

Could this cause a panic from dereferencing the error pointer in
power_supply_changed(), and trigger an oops when schedule_delayed_work()
runs on the uninitialized work structure?

[Severity: High]
This is another pre-existing issue, but does steelseries_probe() properly
clean up resources if hardware open fails?

drivers/hid/hid-steelseries.c:steelseries_probe() {
    ...
    ret =3D hid_hw_open(hdev);
    if (ret)
        return ret;
    ...
}

If hid_hw_open() fails, the function returns directly. Would this bypass
calling hid_hw_stop() to unregister the devices allocated by the earlier
call to hid_hw_start()?=20

Could this leak the input devices and cause a use-after-free when the
parent device is subsequently removed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709032316.1908=
460-1-68172138+srimanachanta@users.noreply.github.com?part=3D1
