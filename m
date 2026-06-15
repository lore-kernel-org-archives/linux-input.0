Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68913F6C27
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529163; cv=none; b=B3h3KPTnxuT9mJi9OZL83qLN825gcKCpK6uB8o+ZZ/8hvO0vqTKhhdkzEMa9+XHP28slvdfn0UzvvRNgC7kCryaprXQTZTWWh7QEt4EzNslg+Wgfb2OpFFedisfvTd4stoW/dSnhwC/pMHVDAbb0cujjY7F5TcRyuz4tMjTSyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529163; c=relaxed/simple;
	bh=BVIOwXkhFQR0xm5/NzJjgT94UE8Jz080Q4JtMKq2KcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gz1X3Tuq0RTE/UNzxTz1y9tD+rkSHhkTs/4jL1xm8kkST5bnxqbQK0fNExtPVlyWL1txaYX2loisryZJkcAXhH6yubUkq6CGdM8WZEUqvG+sE+MhW6+cmkCsJwa6HefehspwUFKVfD8z61toRiHKrVFoV2CifATj30dXBxA3rT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTpgmuEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTpgmuEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208F71F000E9;
	Mon, 15 Jun 2026 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781529162;
	bh=TvXSGSRug5P5jfS02tOylaxuzxnDsng+r5e/j7v+vK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTpgmuEwI2Dor7AO6TFaC1zLv0bJjri/Ea89ImOPzK9rawy96+VKzEusvLgis++rE
	 HVD1cDXuX0kL3J2GAdunLsgMOv5qT05+/1HC1LEOk1KXbOtfP0ALRokZnTaz+MmaiH
	 59DgpR9KlD8huupG0gzQD8cqaLF6a6GCyMEl3/CmjERFZ+TfDFsWcBtvYgzO6b4s4d
	 bPFVlMAIFJImIeTezWwzg93eZyU5MvR7Xf7zznoFB+zCrROq3TSsfx9KGj7vbZj3lD
	 QASr9SozGgumJQIUzxg5a34bSS5tDaIZhR8fB+3UdeVgWjO+ZySoIaBJjWBnWEF8hH
	 nut0eKPOJ1UIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hidpp: fix potential UAF in hidpp_connect_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Kosina" <jikos@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <qq420675-14n0-p23s-10oo-1n8113s2nq22@xreary.bet>
References: <qq420675-14n0-p23s-10oo-1n8113s2nq22@xreary.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 13:12:41 +0000
Message-Id: <20260615131242.208F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dangling pointer Use-After-Free when `input_register_device()`=
 fails during synchronous probe via `hid_connect()`.
- [High] Time-of-Check to Time-of-Use (TOCTOU) race condition leading to a =
Use-After-Free.
--

commit 958cf4bb8a3ce7336c278ac4fb346b928f5fe9b9
Author: Jiri Kosina <jikos@kernel.org>

HID: hidpp: fix potential UAF in hidpp_connect_event()
   =20
If input_register_device() fails, we call input_free_device(), but keep
stale pointer to the old device in hidpp->input, which could potentially
lead to UAF. Fix that by resetting it to NULL before returning from
hidpp_connect_event().

Reported-by: zdi-disclosures@trendmicro.com
Signed-off-by: Jiri Kosina <jkosina@suse.com>

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index ccbf28869a968..d8e86b6ccf375 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4295,6 +4295,7 @@ static void hidpp_connect_event(struct work_struct =
*work)
> =20
>  	ret =3D input_register_device(input);
>  	if (ret) {
> +		hidpp->input =3D NULL;

[Severity: High]
This is a pre-existing issue, but does this clear the shared state too late=
 to
prevent a race condition?

Since hidpp_connect_event() runs asynchronously in a workqueue, hardware
events can be processed concurrently in interrupt context. The allocated
device pointer is published to the global hidpp->input state via
hidpp_populate_input() before the registration attempt.

A concurrent raw event could read hidpp->input and pass the safety check:

drivers/hid/hid-logitech-hidpp.c:wtp_raw_event() {
	if (!wd || !hidpp->input)
		return 1;
}

If input_register_device() then fails, the error path clears hidpp->input
and frees the memory locklessly.

Could the concurrent raw event handler, already past the safety check,
access the freed memory and cause a use-after-free?

>  		input_free_device(input);
>  		return;

[Severity: Critical]
This is also a pre-existing issue, but does a similar dangling pointer rema=
in
if registration fails during synchronous probe?

While this patch addresses a dangling pointer in hidpp_connect_event(), a
similar situation appears to exist in the hid core connection path. For
non-delayed devices, hidinput_connect() calls hidpp_input_configured(),
which caches hidinput->input into hidpp->input:

drivers/hid/hid-logitech-hidpp.c:hidpp_input_configured() {
	hidpp_populate_input(hidpp, input);
}

Immediately after, hidinput_connect() calls input_register_device(). If
registration fails, the error path frees the device:

drivers/hid/hid-input.c:hidinput_connect() {
		if (input_register_device(hidinput->input))
			goto out_unwind;
}

Because hid_connect() ignores the hidinput_connect() failure when the
driver has a raw_event handler, probe succeeds and the device remains activ=
e.

Would incoming hardware events then trigger hidpp_raw_event(), successfully
pass the check against hidpp->input, and dereference the freed pointer?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/qq420675-14n0-p23s-=
10oo-1n8113s2nq22@xreary.bet?part=3D1
