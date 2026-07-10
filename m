Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A628277C88
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649696; cv=none; b=kqttYpWGb+EK5e9VL/lrNs/lhAkpmUljntP+/XBDAN0tlw/WG2epNYCXan80mnhksrn4EHJOAhlpMWgNrqeR4wOJLXpdz0c1DRWKASaNTth2hI/yP+ceuBw7BwwiE8EMQaNCXRUHTR+T5hj85GO8c0Jg0QcUWzxBisKisW79jHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649696; c=relaxed/simple;
	bh=FybvJTksdGs0ZKAGDrmSvmHS3cDcIFkFS/RASRNdEh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QYuDBv9/y2mTpiQf8vDq/QoNUV8Wq9cEQzKLec1a8UP/BnDNO8UrZMhRCkS4Fy4fkLzMDttt6LhaKdrPmgPduqHNG8mlzF70aR7TkNqZbFaYMntG/uTVVwh8V8PHZPi+UyoMhiArDM53RDZQHNm0QIT2BLxPtxBm9AqST9LqmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0NEsaYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0NEsaYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6A81F000E9;
	Fri, 10 Jul 2026 02:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783649694;
	bh=9lfNYBu22JinIsEDe8DOKGFqnBmNpNG3X8nhZKbnXoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H0NEsaYJpBIoRCekMl8NU3D5dIbTkGkk4vdbIuB4f/pdCigvtliOJ8M0+uEJRSjK1
	 IcS/LzIm66BBPrxmB1XFNgvv0CIOtlCoN6XcIO/JuL0pcbcjxaDapdd0PB1Yv8NQC2
	 q1raRNJ3TYbWDCv5LtTGViLf+n46/h7qbNNO1PxKpGRBayMfm1t3b5skU35M4xPwU/
	 t/ybeS06GAMAt3GmDn2oPs8Ltg7mIfKb/zMaKPz+OIKHak/yv9W8Ul/7KQJYtStOoF
	 CAuG5XNCc8JvqQlBQzjHNo5Fn2F7HDbgFM/k5C3zv8gexznV2FsC6J/qnd5661LTx2
	 VLMuWWSGpp3kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] HID: steam: Refactor and clean up report
 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710020048.2337655-3-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
 <20260710020048.2337655-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:14:54 +0000
Message-Id: <20260710021454.9C6A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Redundant pointer cast discards 'const' qualifier.

Pre-existing issues:
- [High] The teardown sequence in `steam_remove()` cancels workqueues befor=
e stopping hardware and input devices, creating a race condition that allow=
s works to be re-queued, leading to a use-after-free.
- [High] Probe error paths skip unregistering the device, leaking resources=
 and corrupting the global `steam_devices` list.
--

--- Patch [2]: [PATCH v3 02/10] HID: steam: Refactor and clean up report pa=
rsing ---
commit 09cdda46064db010796f95410b8370beccf669e3
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Refactor and clean up report parsing

This commit refactors the parsing of buttons and axes into a unified
array-based mapping approach rather than parsing each out individually.
It introduces mapping arrays and helper functions to simplify the event
handling code.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index a854d6360a0e3..1b0367c98eac1 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -1355,13 +1356,45 @@ static void steam_do_connect_event(struct steam_d=
evice *steam, bool connected)
>   * Clamp the values to 32767..-32767 so that the range is
>   * symmetrical and can be negated safely.
>   */
> -static inline s16 steam_le16(u8 *data)
> +static inline s16 steam_le16(const u8 *data)
>  {
> -	s16 x =3D (s16) le16_to_cpup((__le16 *)data);
> +	s16 x =3D (s16) get_unaligned_le16((__le16 *)data);

[Severity: Low]
Since the data parameter is now const, and get_unaligned_le16() natively
accepts a const void pointer, does the explicit cast to (__le16 *)
unnecessarily discard the const qualifier and risk a -Wcast-qual warning?

[ ... ]

[Severity: High]
This is a pre-existing issue, but looking at the teardown sequence in
steam_remove(), background tasks are canceled before unregistering the
device and stopping the hardware:

drivers/hid/hid-steam.c:steam_remove() {
        ...
        cancel_work_sync(&steam->rumble_work);
        cancel_delayed_work_sync(&steam->mode_switch);
        cancel_delayed_work_sync(&steam->coalesce_rumble_work);
        hid_hw_stop(hdev);
}

Is it possible for a use-after-free to occur if an incoming hardware event
triggers steam_do_connect_event() and dynamically re-queues the work items
during this race window?

[Severity: High]
This is also a pre-existing issue, but looking at the error paths in
steam_probe(), could we be leaking resources and corrupting the global
steam_devices list?

If steam_register() adds the device to the list but subsequently fails
(for example, during steam_input_register()), it returns an error while
leaving the struct attached:

drivers/hid/hid-steam.c:steam_probe() {
        ...
        ret =3D steam_register(steam);
        if (ret) {
                hid_err(hdev,
                        "%s:steam_register failed with error %d\n",
                        __func__, ret);
                goto err_hw_stop;
        }
        ...
}

The err_hw_stop label completely bypasses err_steam_unregister, leaving a
freed pointer in the steam_devices list which could cause a kernel crash
when iterating the list later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710020048.2337=
655-1-vi@endrift.com?part=3D2
