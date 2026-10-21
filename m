Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572192;
	b=LSlodc8pk1qBCUdACS6+bo+WAQ81Et8Pevmm9KZqriUVbiTcW+Alv5TpBqgdDz3jQxyR
	 +DaLABRo6ngq+JsrNjgLDFiLz3m6vfCzA9GdZaGIOOt6m6EoxEh1T032hQG2Qg3JaynVM
	 fVbJjXIT3qGtr+otWIbjkP/PfxylLEiLZ06OPNPXVX0EOyNESwbNGatXLOAqDBRXqMeGw
	 tEyXrKeKmKXYxXrf1itP9G0zPg2YDwZyWaWVuA177LodU/CW5GZHWehTwxXyioJV6i4lb
	 T0+u/vD7OsUPw5FOQBxO1XQc4eLxLIYafiMKIzFUXBS5qz5hU0N5hyaalyyvOMifbEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572192;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=6EKlD4dVlbT2HdJAsRzduQ9O4hNi1tgQ8/s9a4JRDLU=;
	b=EmmTGPfI6PCssZoize4LK9NfIOhb04/rB9aalubFJpDy/2lhrlxkMRMt4xjJDEVmwUS6
	 ouYPOFeuaILpIa03z3ca/uxvv+CUOmV56FtiZCuy2NSM249B7pQFOP5b18m94/Lk/GRk4
	 r1qXsb141/7K3EQyFMPryzdjVoGL6BvYbkaVThQcXu8N76p0mPcuAb5N/fspmLds0xrhN
	 eTtAC3LwsHrfJ5+JVOxN16EmvQpD/p0dfk3Ex1aqH8W+1oyxeZDhKR20b27ddAF0eETGo
	 q+CVmcHa8X7EePELHmZ/29VgghFn8xiwyhtZoQFGngKUJbU5hnBKZzRUJdDV1aqSXWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=uaW3Mys2;
	arc=none smtp.remote-ip=109.224.244.26
Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F3606A319
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 08:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 724F3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=uaW3Mys2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1792572189; x=1792831389;
	bh=6EKlD4dVlbT2HdJAsRzduQ9O4hNi1tgQ8/s9a4JRDLU=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uaW3Mys2ekEOjDIt7OXjEtsptMwuw7HYDMp1w0pNIMcdyqa9bp+OnPSe8uzPjfS+O
	 qZspwyJb/VSprB+hcwYM/RbaXpSBZNzfpQwKct0Mq4OOAp4LD1XXxgRfRSmrE92L81
	 yj52Jd6ciwhzWi+JK14/PHcPYHRmjuMqFbyQ4NnbO2NrFSACKJT1nV0uv2rn1zzG4U
	 I1ePZemlNHowRL852vzDHeyy96pxsj29ZiZLuzFc94WcGpE5IOz30FZ45oSSm2M91v
	 s7VOFo9DRvCKTMMmPY7aQLANZ54ticyIIPT65DF7dtxaBQr1MduA4xuuoQllYQv5Cj
	 nZkWFWeTSdvWA==
Date: Wed, 21 Oct 2026 08:43:07 +0000
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From: TheDragonWhoAte <TheDragonWhoAte@protonmail.com>
Subject: Re: [PATCH] HID: add quirk for IBM SK-8845 keyboard
Message-ID: <TlsUnHwjer5DDeomtgCOzbToB5cb5PFhPbTxfUKPd24ka02o9jnA10pyalLiHPiSMMdwnW5URHnIglbM8rKBcASgaVYdw90z2GOsIlHXxLA=@protonmail.com>
In-Reply-To: <UL8kz0PEs3tCPPUaukHYg_M3ZVCyfNOrGj8zm1XeTIlX4EQ6Euw3kEa2NHqkqpfY4IiEiCz4ktDRoI-e1AKq-yvSUarSAL3_Af0pbWs-U8o=@protonmail.com>
References: <UL8kz0PEs3tCPPUaukHYg_M3ZVCyfNOrGj8zm1XeTIlX4EQ6Euw3kEa2NHqkqpfY4IiEiCz4ktDRoI-e1AKq-yvSUarSAL3_Af0pbWs-U8o=@protonmail.com>
Feedback-ID: 82532079:user:proton
X-Pm-Message-ID: 540a09fbb9550ce29e387e4f422950379aa73585
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello, I've sent this patch months ago and I notice it still hasn't gotten =
any comments nor been merged to my knowledge.

Thanks.

Signed-off-by: Muhammed Ali <TheDragonWhoAte@protonmail.com>



Sent with Proton Mail secure email.

On Wednesday, June 10th, 2026 at 7:09 AM, TheDragonWhoAte <TheDragonWhoAte@=
protonmail.com> wrote:

> HID: add quirk for IBM SK-8845 keyboard
>=20
> The TrackPoint on the IBM SK-8845 (Synaptics 06cb:0009) sends corrupted
> input events when bound to the synaptics_usb driver. Moving the stick
> generates random BTN_LEFT/BTN_RIGHT/BTN_MIDDLE events instead of
> REL_X/REL_Y movement.
>=20
> Force the device to bind to hid-generic instead by setting
> HID_QUIRK_IGNORE_SPECIAL_DRIVER.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221624
>=20
> Note: This quirk disables two-finger scrolling on the touchpad. That's a =
trade-off, but without it the TrackPoint is completely unusable. The real f=
ix would be to make synaptics_usb handle this device properly, so both the =
touchpad gestures and the TrackPoint work. That's beyond this patch.
>=20
> Signed-off-by: TheDragonWhoAte <TheDragonWhoAte@protonmail.com>
