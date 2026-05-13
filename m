Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E20357D06
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677937; cv=none; b=qLSkt4CgEkzfXB8QvXZB62nlY7yEdE00j0W1nu6wfylRwHKl76WFXyacD2sKbs+ZgePqoKTLlDKi6nJHM5MhvYfzfTSJd5lJK9nyPhXceQmMUJ3E3w2oIvMmMcodDeITKSefLE7iAd25agnEXVyAW9DyJd3UhIv5C/U96wG9p9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677937; c=relaxed/simple;
	bh=/sUJg3hUwxTRul2ZsZ4mlG/usggKGB6ir2gWE2H3i38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMtdfbyMJ47KCgsV94riUxeLKyIEc+tH3KXYUNnzxOn5suS4wZVYmguhsb2+Fg7qfpk/eB2hGLB6kaFkN6ypXjcCSCVfKpfNeXfwghr06MaJFtjyWbnGYA9iWjyTQGxh7fQJ7utSvWQqyrCzMkjLS2v5q5oPJ3nJJiLBq4lBeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=h.judt@gmx.at header.b=KX0ye3xx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=h.judt@gmx.at header.b="KX0ye3xx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1778677933; x=1779282733; i=h.judt@gmx.at;
	bh=QcwM1XsDSlCWF7diJSDbK4mTRiEf9afJ9wtQ16W/884=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KX0ye3xxiTC/ncgqeTEPTX11/i+MidfJsVfrPc+sRD3Ya1Rhb8ncBFXZxPxLAjqi
	 ZKtgnF6Gbrx9FMPMcvljKiNSkMp0RddjXgjaDaYsrxpADzPla14Bn03Pj739Ils8Z
	 YWXhrHaTCYRI1vj1wGvMHQIP7gjvRsTKkl/SPiwaAP9eJb6MOnj1/gDcpb5zw3Fbk
	 RpjGjbs20aRLUVREz2euK1DPK/xSAVodhnPr49G4puNkoOOiz5eW0NjbHfIl8Dd3T
	 xOhqGLtxeZg235csczmw32mXaLcX4XwwQwCVYm1OAoMM1AjfyH9yLvQnIYQdAnC2t
	 CU9NnbOmywQu2P+Kfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1x33i91jaq-00jfOw; Wed, 13
 May 2026 15:12:13 +0200
Message-ID: <de7383af-fd59-4519-b18c-4cd29980db7b@gmx.at>
Date: Wed, 13 May 2026 15:12:13 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2] HID: Add force feedback support for Speedlink
 Cougar Vibration Flightstick
Content-Language: de-AT
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
References: <b3bfa73b-0547-45f9-b6ae-f28815e6c632@gmx.at>
 <20260508225130.C6D33C2BCB0@smtp.kernel.org> <af5tJlRJr_GFTjVH@google.com>
From: Harald Judt <h.judt@gmx.at>
Autocrypt: addr=h.judt@gmx.at; keydata=
 xjMEWz9DYxYJKwYBBAHaRw8BAQdAKS36MI1JSuMxtk7tkZ2/NK1C9te1XJ8bBlB9qF4blEbN
 G0hhcmFsZCBKdWR0IDxoLmp1ZHRAZ214LmF0PsKWBBMWCAA+AhsDBQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAFiEE4HNt2P9AnPIGZRHUT/+rIbhYCr0FAmStFG8FCRLT0owACgkQT/+rIbhY
 Cr1dYwEAsT/9SLGebsLz4TIuYaDY7c4ou+i7Stae6FIb62NXw7UBAPopYK3pJuyjhvK8qb3N
 FQeZyDrHeJLvOWEoj5OYsLIIzjgEWz9DYxIKKwYBBAGXVQEFAQEHQA7/uzYBE88LdCm19AaX
 q46nMKkhxM5CZ2YAa1uC5l97AwEIB8J+BBgWCAAmAhsMFiEE4HNt2P9AnPIGZRHUT/+rIbhY
 Cr0FAmStFMkFCRLT0uYACgkQT/+rIbhYCr12kAD9HnfrVNMxwa8LWtpKCiv4+zk1ujthlZZm
 G75GoPWofXEBAMQ8kqpJDk2/DH4qT0ZneIT5SnQPt5ZtAFtpX6XOa0oB
In-Reply-To: <af5tJlRJr_GFTjVH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MF7SauFlIJ0nuPUTNQGh2sSXA4BimzBqA0L5bhmZlywub2EBg0/
 /etM77YfISC+tukcLEUPaIbR/Z3S7bUFixPaR216yVAYHqnc1m/Yv1/4E8vxHKhh17dw8y9
 uAGJnwFB/LUy8qtBiKe2BHVW6Uo6lceF1pLqJxmzAPXt1CDiCcpvLNeGJoT+0FKJ0xh8f3O
 SsXC66voIMejaWwfGHzHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3u19W4tdtpQ=;Q3EFMfdrzT9k8+Gg59grjL00L7O
 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
 uD/YNt0oGdXPhmUtpHCRUie6yEJh65fQrbYM=

Hi,

Am 09.05.26 um 01:14 schrieb Dmitry Torokhov:

[ ... ]

>>> +	strong =3D (strong / 0xff) * 0x1f / 0xff;
>>> +	weak =3D (weak / 0xff) * 0x1f / 0xff;
>>> +
>>> +	/* ... and to support the notions of strong vs weak rumble effects,
>>> +	 * increase the magnitude for the strong rumble effect if it is belo=
w the
>>> +	 * half of the maximum value, as the strong motor has the same stren=
gth as
>>> +	 * the weak one. Likewise, decrease the magnitude for the weak effec=
t.
>>> +	 */
>>> +	if (strong < 0x10 && !weak)         /* fftest effect 4 strong rumble=
 */
>>> +		strong *=3D 2;
>>> +	else if (!strong && weak >=3D 0x10)   /* fftest effect 5 weak rumble=
 */
>>> +		weak /=3D 2;
>>
>> Will this cause issues with non-monotonic force feedback behavior and
>> unintended truncation?

I thought about this too. I have not experienced any negative behavior wit=
h
this solution, the stick seems to work fine with it. But honestly, there
are not many tests available. fftest and SuperTuxKart have been the only
applications I found supporting force feedback, it worked fine there,
but the stick is also a bit limited in capabilities, it does not really
support "force feedback", only some degrees of rumble.

Since I wrote this patch some time passed and I have gained a bit more
experience with force feedback in general and implementing support for it.

>> Since the math uses integer division, any input value below 255 for str=
ong
>> or weak will evaluate to zero during the first division by 0xff.

I am aware of this but IIRC this does not have any practical impact for
this stick. It seems to correspond to the values I got from the SET_REPORT=
s
in Windows and the vibrating behaviour.

>> Additionally, could the conditional scaling cause abrupt changes in rum=
ble
>> strength? For instance, if a game requests a strong magnitude that scal=
es
>> down to 15, it gets doubled to 30 because of the strong < 0x10 check.
>> However, a slightly stronger requested magnitude that scales to 16 will
>> remain 16, meaning an increase in requested strength results in a drop =
in
>> physical rumble.

True. I have tested this only with fftest and observed the behaviour in
SuperTuxKart, where it worked fine, as it uses both strong and weak
attributes. Existing implementations for other devices in the kernel
source I found sometimes use a "left" motor and a "right" motor,
other times a "strong" motor and a "weak" motor. But the games do a
variation of strong vs weak. So I finally decided to somehow get it
to work with the game I could test it with. I will do more checks
with other parameters/gain and try to improve this or think about
another, better solution. I might probably need to write some
ff tests myself for this, but why not...
>> [ ... ]
>>
>>> +static int gembird_joy_probe(struct hid_device *hdev, const struct hi=
d_device_id *id)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret =3D hid_parse(hdev);
>>> +	if (ret) {
>>> +		hid_err(hdev, "parse failed\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
>>> +	if (ret) {
>>> +		hid_err(hdev, "hw start failed\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	gembird_joy_init(hdev);
>>> +
>>> +	return 0;
>>> +}
>>
>> What happens if gembird_joy_init fails?
>>
>> If input_ff_create_memless returns an error, gembird_joy_init
>> propagates it, but the return value is ignored here and probe succeeds.
>>
>> Because set_bit(FF_RUMBLE, dev->ffbit) was already called, the device
>> remains registered and advertises rumble support. If userspace then iss=
ues
>> an EVIOCSFF ioctl, the kernel will allow it, which could lead to a pani=
c
>> when it tries to dereference the missing force feedback structures.
>=20
> Need to have error handling.

I have looked at some other implementations, and if I have not missed
anything, then they do it similarly (hid-gaff.c, hid-sjoy.c, hid-emsff.c,
hid-megaworld.c). I will take a closer look again and try to fix it.

> Thanks.
Thank you for your suggestions and spending your time on this review.
I will try to improve it and send a new patch when ready.

Regards,
Harald

=2D-=20
`Experience is the best teacher.'

PGP Key ID: 4FFFAB21B8580ABD
Fingerprint: E073 6DD8 FF40 9CF2 0665 11D4 4FFF AB21 B858 0ABD
