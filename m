Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490802;
	b=3QirqYO8Wi6PkQ0zea36FnZSTSvvTMjFaEnstGpExDUOYMLZwJYBzUYJFXKvF5UJG0ml
	 SZ4GJWuyjF5v9FRa46M4ZKnWLzqHIYpJZNEFy43VeZC2h2PesUp2kTWlaHGAj+fvyt8Fc
	 NN1l7YV3JHFylOaCeDUREeFIVgAziINlw51Iexqh8w/GPaJf41v8jmuFbs3RmoK4nug13
	 dvXLQOtV3sSWnTD7iQ7ooh97X8FUSWzoWnfZDFeQ6EvS8WEzvYiKAEh0t/ShP61BytTEw
	 2+UB9XeHRPh0QjaZ6rMSyiR1zegif7YdGhzNbrqxI9dq+zmvoQrVOPxmLoZdZERkYHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490802;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OMGGbX/6RdQgtMo4UbXRulNe/sg7v97MS8L9SvLkr4A=;
	b=bx8KyEWRkA0nn64TEYAtcSEaslz0kVb18r3oJPx65ULQ8zmpfQj0nalbBJgebgNg9kHN
	 2CCX+HTY4CdFpO//Qx4GvUY8io/ZBWw7T6QRpj3lr0o7+ptNgFAkAzB2KFy0KBeQMp2GO
	 4thConQfwI20+si/t1Av9eoFf3XxibPBlFbAXYjt85Q7WT80gYcYcMw/JVttL6e1awmF6
	 xI//dVRz/AdiVi2ynC8X/RFtR+h9QRpE/Zk5659mT04c+9aT0Ai4ajZeAsVoW+9JA/Bgf
	 ExfzpzWVpYJzSqp4DqJzIZ+d5KAIZriQUTlB4m57EydrNs+y720ZYpkFdLU3rgKWc+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hj7YCnUC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374A606A31B;
	Tue, 20 Oct 2026 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hj7YCnUC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4921F000C4;
	Tue, 20 Oct 2026 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490802;
	bh=OMGGbX/6RdQgtMo4UbXRulNe/sg7v97MS8L9SvLkr4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hj7YCnUCbJdAVZIh9hzQbBkn0snKoT8Gu/1cSuobqZyfpd61bxgIuxDoEyXed50r7
	 c52oizrY7425Dx9Qfbs/3CIZZicfC3D1schunDoqZKKkLnoNUcWtNRqU9YnjUWNs2d
	 y5E4Dw17Y6P5z6Qh01QHPZ90dDqGf1/Krvuj7w6AmvBjx37JIU+O2oneta1hYIOh85
	 Uloack8LJlITmCbsMNpW9H4ufzrQ+KEBB3byTFyZJG0uHa7LaW9l+OYcaYW6u3biOb
	 xgD0MoGVuRXAM5WrzUvmwvNzz6igmgFBcwD/YVi4KHJlNr2yyjuvGWaJf0XX4tC6wx
	 5lYgedYXNe0Xg==
Message-ID: <sashiko-outbox-178793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] HID: generic: add LampArray support via
 hid-lamparray helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Erhardt" <aer@tuxedocomputers.com>
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261020-hid-lamparray-v7-2-47418b667b47@tuxedocomputers.com>
References: <20261020-hid-lamparray-v7-0-47418b667b47@tuxedocomputers.com>
 <20261020-hid-lamparray-v7-2-47418b667b47@tuxedocomputers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:06:41 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] HID: generic: drvdata clobber and uninitialized read in hid_ge=
neric_remove()
- [High] HID: generic: double hid_hw_start() in hid_generic_probe() corrupt=
s reports
--

commit 977659b4786943b7473279419965b0035b45922c
Author: Aaron Erhardt <aer@tuxedocomputers.com>

HID: generic: add LampArray support via hid-lamparray helper

This commit checks for LampArray support in hid_generic_probe() after
hid_parse() and registers a lamparray instance when present. On failure, it
stops the hardware and falls back to starting the device without LampArray,
and unregisters the lamparray instance in hid_generic_remove().

Link: https://lore.kernel.org/all/20260728115918.125349-2-aer@tuxedocompute=
rs.com

[ ... ]

> diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
> index c2de916747dec..fde772c5014bb 100644
> --- a/drivers/hid/hid-generic.c
> +++ b/drivers/hid/hid-generic.c

[ ... ]

> @@ -67,6 +69,34 @@ static int hid_generic_probe(struct hid_device *hdev,
>  	if (ret)
>  		return ret;
> =20
> +	/*
> +	 * Optional: attach LampArray support if present.
> +	 * Never fail probe on LampArray errors; keep device functional.
> +	 */
> +	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && lamparray_is_supported_device(h=
dev)) {
> +		/*
> +		 * Use HID_CONNECT_DRIVER to make sure requests are
> +		 * processed in hid_report_raw_event. Without this,
> +		 * hid-core will skip parsing for devices that are only
> +		 * claimed by hidraw, thus making it impossible to query
> +		 * the required information.
> +		 * See 7704ac937345 for more information about this flag
> +		 * and why it is necessary.
> +		 */
> +		ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT | HID_CONNECT_DRIVER);
> +		if (ret)
> +			return ret;
> +
> +		la =3D lamparray_register(hdev, NULL);
> +		if (IS_ERR(la)) {
> +			hid_hw_stop(hdev);
> +			hid_warn(hdev, "LampArray init failed: %ld\n", PTR_ERR(la));
> +		} else {
> +			hid_set_drvdata(hdev, la);
> +			return 0;
> +		}
> +	}
> +
>  	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>  }

[Severity: High]
Does calling hid_hw_start() a second time on the fallback path when
lamparray_register() fails leak report->field_entries and duplicate entries
in report->field_entry_list?

The first hid_hw_start() calls hid_connect() -> hid_process_ordering() ->
hid_report_process_ordering() for every HID_INPUT_REPORT:

drivers/hid/hid-core.c:hid_report_process_ordering() {
	...
	/* allocate the memory to process the fields */
	entries =3D kzalloc_objs(*entries, count);
	if (!entries)
		return;

	report->field_entries =3D entries;
	...
}

And appends each entry to report->field_entry_list (which was initialized
once during hid_parse() -> hid_register_report()).

When lamparray_register() fails, hid_generic_probe() calls hid_hw_stop() ->
hid_disconnect(), which does not free report->field_entries or reinitialize
report->field_entry_list because those are only cleaned up in
hid_close_report() -> hid_free_report():

drivers/hid/hid-core.c:hid_free_report() {
	unsigned n;

	kfree(report->field_entries);

	for (n =3D 0; n < report->maxfield; n++)
		kvfree(report->field[n]);
	kfree(report);
}

When hid_generic_probe() falls through to the second hid_hw_start() on the
same parsed reports, hid_report_process_ordering() allocates a new entries
array, overwrites report->field_entries without freeing the previous array,
and links a second set of entries into report->field_entry_list alongside
the still-linked entries from the first leaked array.

Wouldn't this permanently leak the first report->field_entries allocation a=
nd
cause hid_process_report() to process every input field twice per report?

> @@ -78,6 +108,16 @@ static int hid_generic_reset_resume(struct hid_device=
 *hdev)
>  	return 0;
>  }
> =20
> +static void hid_generic_remove(struct hid_device *hdev)
> +{
> +	struct lamparray *la =3D hid_get_drvdata(hdev);
> +
> +	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
> +		lamparray_unregister(la);
> +
> +	hid_hw_stop(hdev);
> +}

[Severity: Critical]
Can using hid_set_drvdata() and hid_get_drvdata() here collide with low-lev=
el
HID transport drivers that store their own private data in
hdev->dev.driver_data?

For example, drivers/hid/hid-hyperv.c sets drvdata before registering the H=
ID
device:

drivers/hid/hid-hyperv.c:mousevsc_probe() {
	...
	hid_set_drvdata(hid_dev, device);

	ret =3D hid_add_device(hid_dev);
	...
}

And drivers/platform/x86/tuxedo/nb04/wmi_ab.c sets drvdata inside its start
callback during hid_hw_start():

drivers/platform/x86/tuxedo/nb04/wmi_ab.c:tux_ll_start() {
	...
	dev_set_drvdata(&hdev->dev, driver_data);

	return ret;
}

Because hid_generic_probe() only calls hid_set_drvdata(hdev, la) when
lamparray_register() succeeds and leaves hdev->dev.driver_data untouched on
all other paths, if a device on such a transport does not support LampArray
or fails lamparray_register(), won't hid_generic_remove() retrieve the
transport driver's pointer via hid_get_drvdata(hdev) and pass it to
lamparray_unregister(la), corrupting memory and calling kfree() on the
transport driver's structure?

Conversely, if lamparray_register() succeeds on tuxedo_nb04_wmi, won't
hid_set_drvdata(hdev, la) overwrite the struct tux_hdev_driver_data_t point=
er
stored by tux_ll_start(), causing subsequent tux_ll_raw_request() calls to
dereference struct lamparray as struct tux_hdev_driver_data_t?

[ ... ]

>
>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-hid-lampar=
ray-v7-0-47418b667b47@tuxedocomputers.com?part=3D2
