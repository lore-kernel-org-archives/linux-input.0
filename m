Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7298211A14
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785395; cv=none; b=N3NLXVOefPN6UIYgOqt2RpIl4cCaJd7nMb6pvFHlaEuvdV/COV+I7rSi1JU+gvlpQ/LLreEojmTXA26jZIab+r2+s5ajyZ2GZDvgre3OCNkIunX5C5/QhSbmGJVDN2UdIixdAPvCJf7Ob5zorfosoxM1sLnWX/zJhAB0yRRba7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785395; c=relaxed/simple;
	bh=218/CQqbjl3eiBZujlQXnJ9jd1SC2Z64IyODX+EIXrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U5Dls+lzJG8DsgSgBzstW5K4cXWRaaRvCgoDKvmcz7VIzZgNaCjxY9kHpN2Ps4sr2jaEzW1oC6I2M0+ts0NCFwcmTU0QCxYHIT96jTtC09XNCxp6irB1hlmGcvq5lYG3tl5FnJMGY55YqNC+BGHN49/Zn9GdltMwFWW110dHrmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCN7+JmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCN7+JmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE651F000E9;
	Mon,  3 Aug 2026 19:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785393;
	bh=2qp8K2gMgCCd6zSSwLdqI+ZbFaFtOdlOGPsyOhIFN3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eCN7+JmCYiSyWKJ1fT1qj3Rd+cI6fcZ6NQz/l2Wt8XE9FS/Zcu/KDIyxrsPqlYpUy
	 vLMu+jBG6ubUfQQFVj8CKDqQAYK7PHRV8u+cCD1+aDYK0+41yAbgYLzFde3NYGLBfN
	 3RG8HHnBfyQMPh7LfbR1xAynxAAoPYSaqb80MTeiAJlYzssg891x3psnjzbjs83mNT
	 Z71ctOxPV1yen0bZhfZJemJkDZ/fa/jgBhKTxEArJQSamZ3EDcY74nfE3njFEcFxXo
	 uSy9QorIxHWmGg+q/m5Rqye65QFoWKFrCkjmQ4jMEjLf9ld3PHQnrCZDpI661vU1Z1
	 u3cBDOOLatC7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/8] HID: steelseries: Manage battery lifetime with
 refcounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260803191553.66368-7-srimanachanta@gmail.com>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
 <20260803191553.66368-7-srimanachanta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 19:29:53 +0000
Message-Id: <20260803192953.8DE651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Concurrent execution of `steelseries_arctis_raw_event()` and expli=
cit battery unregistration in `steelseries_arctis_remove()` introduces a Us=
e-After-Free and NULL pointer dereference.
- [Medium] The power supply name string is allocated with `devm_kasprintf` =
but is embedded inside a manually reference-counted object `sd`, leading to=
 a lifecycle mismatch.
--

--- Patch [6]: [PATCH v7 6/8] HID: steelseries: Manage battery lifetime wit=
h refcounting ---
commit fd37e70cee8d0953a9d3de05f0149d2fc76d513a
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Manage battery lifetime with refcounting

This commit changes the steelseries_device structure to use a kref for
lifetime management instead of devm. It explicitly registers and
unregisters the battery power supply and nullifies the battery pointer
during removal.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> index b54f20f081a26..e534aa44e70a0 100644
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c

[ ... ]

> @@ -277,9 +288,10 @@ static int steelseries_battery_register(struct steel=
series_device *sd)
>  	sd->battery_desc.num_properties =3D ARRAY_SIZE(steelseries_battery_prop=
s);
>  	sd->battery_desc.get_property =3D steelseries_battery_get_property;
>  	sd->battery_desc.use_for_apm =3D 0;
> -	n =3D atomic_inc_return(&battery_no) - 1;
>  	sd->battery_desc.name =3D devm_kasprintf(&sd->hdev->dev, GFP_KERNEL,
> -						"steelseries_headset_battery_%ld", n);
> +					       "steelseries_headset_battery_%s",
> +					       sd->hdev->uniq[0] ? sd->hdev->uniq :
> +					       dev_name(&sd->hdev->dev));

[Severity: Medium]
Since the steelseries_device struct sd is now refcounted and can outlive
the device, will using devm_kasprintf() for sd->battery_desc.name leave a
dangling pointer inside sd when the device unbinds and devres frees the
string?

[ ... ]

> @@ -387,13 +405,20 @@ static void steelseries_arctis_remove(struct hid_de=
vice *hdev)
>  	if (interface_num =3D=3D sd->info->sync_interface) {
>  		spin_lock_irqsave(&sd->lock, flags);
>  		sd->removed =3D true;
> +		battery =3D sd->battery;
> +		sd->battery =3D NULL;
>  		spin_unlock_irqrestore(&sd->lock, flags);
> =20
>  		cancel_delayed_work_sync(&sd->status_work);
> +
> +		if (battery)
> +			power_supply_unregister(battery);
>  	}
> =20
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);

[Severity: High]
Can an incoming HID event trigger steelseries_arctis_raw_event() concurrent=
ly
with this teardown, leading to a NULL pointer dereference or use-after-free?

Since hid_hw_stop() hasn't been called yet, hardware events can still fire.
If steelseries_arctis_raw_event() locklessly checks sd->battery and then
calls power_supply_changed(sd->battery), could remove() nullify and free the
battery in between the check and the use?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803191553.6636=
8-1-srimanachanta@gmail.com?part=3D6
