Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757059B676
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890439; cv=none; b=Ne/nGFU0xxo5nJTmVLST5wbZUKZ/l5SpJKqiDBo0Oa9LysTAnxb5rDjZ7Igb2wWQoN7iNzx7yP9qJinNUtD0U0gc6xHEVon8yG/RdZBHl39js8qxp4HsJMHUGwSC4mXA5N383KeweOvb9A5KbMhLwpYiQvuaRt8gDXHl63RrpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890439; c=relaxed/simple;
	bh=fG26GWpS/fgJrFqPeH2y991rhDqt4aBGaYKpJH1czXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/05ABBNHlrudgG7zI1iSO4HxSBA/JMzoMwLnStYQf+VBNATORDdU1zGrCQiZjWOhnHeyIB4eMqaNtcDGv8gqcmAQimuZi0EqkZa1YZqtwxCxXJhgZPc3aqbNZPASnjweHAw6WxU9ONRftiW8fciusmm3WIc23UJfK9xQWIFCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpPyRHFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpPyRHFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C2D1F00A3A;
	Tue,  8 Sep 2026 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890432;
	bh=7DA3SvhNL2k307RhUy9DFpQ2rLFCC90sSeRdBLuza6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpPyRHFIDna403Oa45Nxwkb04xO9oBb6uwh4yiZ+856aCAr+t9R1SMEjo7h32OrZU
	 wEtubBtdMgIxamcF2y5OaqPe/Mu14p2X8OtpILLWVwvEojgUVAZ1089uBfZojkF9XG
	 83ApUQ4zwjNsozdMDe8IEpmHzgmnTLe3B6Tppho2CBD5t/clLmt4MljBwHkMedrVEm
	 MJv6EC3f+mA0hKY6RaGblxTC33hbYUU98dHlwVOWTlaNMCHZ0UYJWzhdYjjRjfEOLd
	 Aq3XIbxFiMf6dh5WjzXJCBgB0Xh+//JUNfKSeVZGfNZea1DTV52Qp9gPasxu3/cBZY
	 KaC7FiXtpNzoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/13] HID: asus: reinitialize the device after
 exiting a sleep state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908174433.74260-3-denis.benato@linux.dev>
References: <20260908174433.74260-1-denis.benato@linux.dev>
 <20260908174433.74260-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 18:00:31 +0000
Message-Id: <20260908180032.34C2D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect teardown order in remove and probe error paths.
--

commit d02eb8a767770eafa0296c08186b26c229986e03
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: reinitialize the device after exiting a sleep state
   =20
The ROG ally needs to have the EC string sent back after resuming from
s2idle since the USB device can be turned completely off by the firmware
when mcu_powersave firmware-attribute is set to 1.
   =20
This may also be true for other laptops and certain features might stop
working after the device exit from sleep.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index bd46aba6622a1..2125680c7effc 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1493,16 +1518,8 @@ static int asus_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  		return ret;
>  	}
> =20
> -	if (!drvdata->tp) {
> -		for (int r =3D 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
> -			if (asus_has_report_id(hdev, asus_report_id_init[r])) {
> -				ret =3D asus_kbd_init(hdev, asus_report_id_init[r]);
> -				if (ret < 0)
> -					hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
> -						 asus_report_id_init[r], ret);
> -			}
> -		}
> -	}
> +	if (!drvdata->tp)
> +		asus_initialize_reports(hdev);
> =20
>  	/* Laptops keyboard backlight is always at 0x5a */
>  	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&

[Severity: High]
This isn't a bug introduced by this patch, but I noticed an incorrect
teardown order in the error path of asus_probe() and in asus_remove():

drivers/hid/hid-asus.c:asus_remove() {
    ...
	asus_worker_stop(drvdata->worker);
	hid_hw_stop(hdev);
}

Does this violate the HID core lifecycle rules? It appears the custom worker
is cancelled before the hardware device is stopped.

The subsystem guidelines mandate calling hid_hw_stop() before cancelling
workers to prevent new work from being queued by userspace or the hardware
after teardown has begun.

While there might be a custom worker flag to discard new work items during
teardown, does relying on custom synchronization rather than the correct co=
re
teardown ordering risk a use-after-free during driver unbind or probe failu=
re?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908174433.7426=
0-1-denis.benato@linux.dev?part=3D2
