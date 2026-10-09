Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD539768D
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 03:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517379; cv=none; b=dQ19OhTJZbEFHRc5uW1cO5ugfjbr2t0MddSKk1WycICdLCwUc+AtWXIzG99TGEfuLzu28UntFErkTjNu6Ixb3DkgfBe/Os5a8VAn22vGQNc8RtB/A7h4OwfOfy7UHpYx5uL+Bm4ijZJguVB0MH5EuR0ZdZcmr2v71lgr1E0c9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517379; c=relaxed/simple;
	bh=cSelemOpzW0OekeRwY/VcK3OcTjycgijuR84rFCXApw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ljeuFocuWTsUepODxmkBmS/p18/Cv2hgy6jfqBHigPzeM5BM590zLzB7adRj2ecsZ/nMMq8bMfLZMfu5Zd3ZWgrP83VwjAmzmmFv9Xu8cvZWiUskgqmGGvbm1nuUv95P1mqz/2lLhL2tGduxVfXaVGhVEeqkuJJzBW3OhoiY2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi05FSto; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi05FSto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630411F000FF;
	Fri,  9 Oct 2026 03:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791517362;
	bh=RPTPJfLDNJ9t9QWl/AWWGsRnGpQTpPj0uyZGnKH7lQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pi05FStogD0UrHuDdyiPNRVY/CxhubsYbAkWqnkwxO346HdGAsTYsnboh1VmFTDRR
	 ABks/1hg0xhuQ3r+OWQoBKSlRGRPSuVJwzArBG91HqgmR9c077ghwfj03rnPY04wUR
	 fxwkaww6GGqWVsgCD9p1Vi2LEGVjZRIbZ+L8LbIfAa0gdkHTnJ2u5SgwdYHI/Hfnaz
	 GpmcMmbZxoogrpqmjZHbpnWc3uyblqfPls4qyq4fFZoOCLTjBFVBukkC1HSVhp6YLu
	 saDmUBndms/lyMe7UMFPw+BPsLlgsGZOS4SzJa3n35IptxwMFrNo1otzY6gYssq6z6
	 GedTWK4rIfM9w==
Message-ID: <sashiko-outbox-164785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: haptic: fix use-after-free of devm haptic data
 in hid_haptic_destroy()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261009032607.3233482-1-qwe.aldo@gmail.com>
References: <20261009032607.3233482-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:42:41 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] input: double free of haptic struct due to input_ff_destroy() auto=
-free
- [High] hid: double free of td->haptic on device removal
- [High] hid: memory leak and UAF of td->haptic on hid_hw_start error
- [Medium] hid: memory leak of td->haptic on hid_hw_start() failure
- [Medium] hid: memory leak of td->haptic on hid_hw_start() failure
--

commit ca7640e3726f1a30aa5c64767994c043a634455a
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: haptic: fix use-after-free of devm haptic data in hid_haptic_destroy()

This patch attempts to fix a use-after-free by replacing devm_kzalloc with
kzalloc for the haptic data so it outlives driver unbind. It introduces
manual teardown in the hid_haptic_destroy callback and updates the error
paths in mt_probe to free the unmanaged memory.

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index 8760eeb08b2cd..6c365dbf0b9cf 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
> @@ -406,6 +406,8 @@ static void hid_haptic_destroy(struct ff_device *ff)
>  	haptic->hid_usage_map =3D NULL;
> =20
>  	module_put(THIS_MODULE);
> +
> +	kfree(haptic);
>  }

[Severity: High]
Does this explicit kfree() cause a double free?

Looking at the input core's teardown path in input_ff_destroy(), the core
automatically frees ff->private immediately after calling the driver's
destroy callback:

drivers/input/ff-core.c:input_ff_destroy() {
        ...
        if (ff->destroy)
                ff->destroy(ff);
        kfree(ff->private);
        ...
}

Since hid_haptic_init() sets ff->private to the haptic struct, the newly
added kfree(haptic) here will free the pointer, and then the input core
will immediately free it again.

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 4e19a0c4d2381..f4d8d640d9577 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -2132,7 +2132,7 @@ static int mt_probe(struct hid_device *hdev, const =
struct hid_device_id *id)
>  		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
>  		return -ENOMEM;
>  	}
> -	td->haptic =3D devm_kzalloc(&hdev->dev, sizeof(*(td->haptic)), GFP_KERN=
EL);
> +	td->haptic =3D kzalloc(sizeof(*(td->haptic)), GFP_KERNEL);
>  	if (!td->haptic)
>  		return -ENOMEM;

[ ... ]

> @@ -2206,9 +2208,13 @@ static int mt_probe(struct hid_device *hdev, const=
 struct hid_device_id *id)
>  	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
> =20
>  	if (!td->is_haptic_touchpad)
> -		devm_kfree(&hdev->dev, td->haptic);
> +		kfree(td->haptic);
> =20
>  	return 0;
> +
> +err_free_haptic:
> +	kfree(td->haptic);
> +	return ret;
>  }

[Severity: High]
Does this leak the td->haptic structure when hid_hw_start() fails?

Since td->haptic is now allocated with kzalloc() instead of devm_kzalloc(),
it requires manual cleanup on all failure paths. However, the error path
for hid_hw_start() in mt_probe() returns directly without freeing it:

mt_probe() {
        ...
        ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
        if (ret)
                return ret;
        ...
}

If hid_hw_start() fails early (for example, during low-level transport
initialization before hidinput_connect() runs), the force-feedback
callback is never registered and the memory allocated for td->haptic is
permanently leaked.

Additionally, could this sequence lead to a use-after-free if
hidinput_connect() fails but another transport succeeds?

If hid_haptic_init() successfully installs the FF callback, but input
registration unwinds due to a failure, the input core frees td->haptic
via the hid_haptic_destroy() callback.

If another transport like hidraw subsequently succeeds, hid_hw_start()
will return 0 and mt_probe() completes successfully. The driver would
then be bound with td->haptic pointing to freed memory, leading to a
use-after-free when incoming HID reports are processed in
mt_process_slot() by calling hid_haptic_pressure_increase().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009032607.3233=
482-1-qwe.aldo@gmail.com?part=3D1
