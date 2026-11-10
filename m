Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327195;
	b=wjrOLbJVy5N1czC0Iza7ivANMb0n59kufpVzQ/7jH3dlC+T6qk4yszIAQO8/vpB0kWR8
	 z4DQcibsc+iPUQWEooF2AhO7UwoFo1JKR05GieducaPEiNJttpOvOWRh1nQDuMBzEewKH
	 bipNlqL1zAUvZF2j8Sg8QegNvnNpiz5Qfqaa0ETODbsyeLq+M9mrTp5ju2Ps75uUyQLX9
	 iZc9yF5Tty/RAsuOzJQmgGbY9rA0s9bo+FrFFgjDnwslXx7qmLAjokbrORdHzWDc+/OXV
	 iDxFIa7k3ShAUd9NWqtq+hylqe8nt0RCxNp5wa0kX1fjDy3TDl6CwCjlTrnlIpuiOqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327195;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=4stWdQp7BpJLS0676322fsmeG4ymFjAT9IbMRkPmpp0=;
	b=qXPymC1Or74svGQ5KbXL/l5CvE4G85fhHOqufLs2dHdHrsTVyuWmC2zGG8pAY7UPbJts
	 5c3qon3ot31Rn+G9fCzcAWiLPQNYUy09HSkshVBlF7rgj4OYJg7wX0dNxknOkWrMYhF1k
	 ByFkaoVFHmWbp3TRG6lhHZXeqM0vguOtzrOLocNhYhpqzVn7E69EMSl7X56bQLKklFTRp
	 rxYYoduEATBz4icAtst+XP3sNZaXR8MPdZ7K98M18SpC8+hTBWDbXb3LL4yZ5Ut7jR81J
	 sPDiVWJzwwMnvp7XtDub/F1CDvZw1UGFb6SofQw+HD3aXvaKwAqOO3jysajAEZBA9Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=asQC+qHD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pjDZKFBW;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB87606A337
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 16:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB87606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=asQC+qHD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pjDZKFBW
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id A08B213813D7
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 11:13:14 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 10 Nov 2026 11:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794327177;
	 x=1794334377; bh=4stWdQp7BpJLS0676322fsmeG4ymFjAT9IbMRkPmpp0=; b=
	asQC+qHDAv/I83EYngLJ0bkBe+uuEnPcLg0jrc2OX9kVtaPYAd/md3quox9jqmy4
	S/jELTpXjA2k1IxJWtdK3HZW4IriVAHis0xufJR256BBPAzbfZ5QsGw2eqYq1k/I
	S4qzaUtb3Ob4GAV2mxThnKp0r/zG0TfcXAK+eUmyQOHhHqtyGONG7gkgzRBQG2d0
	/gzJT11LHsGNvLKSZnn9JL3iytYjrT3V7KZt2FZsHfjjQeZHywjaesrjJhD0e7vN
	Y6/iN3Jg7w8xS8OVdYMBSUZOfxDnVhVfPJGqKe/oSxsAZXPn7y2e4GOOItdMLZ2R
	LLVckhHoSzC+MGE1iJu5eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794327177; x=
	1794334377; bh=4stWdQp7BpJLS0676322fsmeG4ymFjAT9IbMRkPmpp0=; b=p
	jDZKFBWlX484yfO06iZThedU7MnSaqyMkXKHKaXomC5/xVavgZU65SsCjokZJWML
	GjeTj8Lq4+LWeI1CWzzxuQj2m4isbVa0ssa9g7eZhXilCypVINe5kxTBiobUF6uZ
	Gtle0jaTmJtlAyGlrtNmbTTDPt9uAjbADo1dgbyzsDA47ykOoKjYt1o87LKBSqHb
	mP2YIbspjWDiF2EJOgZRHTKT7VhzsY0TtBEN2nWcPAnRSw5Q7HRlPmorpTONvfpP
	auvP37j94bGeH1y2GQ4LwX12DjFEZi+3xGQave3kINRA2PBRPI5FXxcFzbhhhvXR
	Tsc8Y3Jb1FgwsS6Y0dcjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794327177; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:f28Pz8cLCSx7Wwe2+27r/4ZU5f7purqnxMx+yjoyRekrejy
	oaGcbzlLj3YZSc66aZn1x9zZQNNZkX5aSIDglRZ1tWorFP+W0AiJfxcfBSKOlCp8
	AM/x9kbWFgSB0LZQgqDQ80leIlIt5Dn+0j2SqHamDtsv6Bqvj9ty4KU1JmzC0J1U
	dgZ6vV4Xg77MiVXcQbDAKmy+WxH1wKips4r14voEOXMg8TLsiV0Q7IQ3J3uBIxog
	0PysyS0Pj0jULgXZcAWv0+Azk9P7fTBc3wEGNtdUDzIqaGNHXZmZ9/FtzvPn284K
	a0s3mYVXcijwUOW4+JtjMkmSo4jr7qRqlK1W9Ng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NY+qH6VFe1gb9eaYka4u3Pju9dQg6z2rB5jHAxzea+M=:YUoKa4y1cAE3r8AhMFawDzVW7orX9AEZ4cmB97mmTGA=;
X-ME-Sender: <xms:gELzat-KhdG49YOXD28knxP-wmxhvouurLuqg65ijoK_1PztTiM67w>
    <xme:gELzashOw3MORHNRaj5VZYoHPjgRatChT2__Hps4-a7QS4ExIju8qL8_9B3SiDtB2
    sGKQug7JFF_lfIFqrxv09JzfzrzZWKrRlvdLjWPWqavJafwb6XI9q0tBA>
X-ME-Proxy-Cause: dmFkZTEwJqmeu88i0D1P4NSr1o0RdeyL0ncQrpwlZpsRiyH4mGhKK76jqiY9/AURvmAyKQ
    Xh2LjT8fovpOgpIQnvH5QYWZs5UCg8lDhPsbwXo4GfEZeWp/aOvfLOYPWjqnmAFI1BwG/q
    XyZG43p0HoLIgnysLFo6MzsLlgysOWgB08DJdha5yxDuEjeXR7MU6VvvNb4tgDJLpz9WaL
    DOmlUn0Mje4CQssJm+pxYVCWPCE7uxZNBjliBSIc14Pa1+Q+euFKNdLxxVitjY9vJ+1g1T
    +rig9iVkFuoti3t+qEcHMM2vh4+G+ag1IzrG3We9+FcQnC6cOfB1bItA6vAPi6A+u1KULf
    wxoJ36bIqa+kM9OWApvgKo4MId3H8RRe0FCkMwp8Cj2i2hPzQqFijO+zALFklT7XBp4yQ4
    D0Bsmvzif3sMMCJY2OSk1bwCPIIRPEFuJI4Mi/vpw7sfUa+jfrhN159tiieQQE7aztSV43
    DlSawBFw+hJYm5oAPkD2NlBoL/gRh3vgmwf+Y/GbihlHM/o3EcsWCertLTOcD6iStWXR7G
    LAS2aVSdVtxoGSiZj2/kYUSfLhEBFCn05KpxcrFYCW/FmzT2YT72YPVx3p0wR8sMiJ3lAW
    x+8+3z8XttowLJjfinG9ew4R0xJsilSkEkmhmN5AqofFDl0uTCDo7P0ixMQQ
X-ME-Proxy: <xmx:hkLzak2BPEyGi10FxxkrY3byRVHSjq_0wLclV2jUuSmkyRE3xcj4fw>
    <xmx:hkLzakkySXPgYGwh_r1Ql-VHDAdYXcQ3p0tjVOV29OCOWQo8MbFMmw>
    <xmx:hkLzavloJp1yUj6WriMMnPneQ8pVgU9Ew-sH84r-kdZ-OdXPheHDYw>
    <xmx:hkLzarPnZB-B1EOixQtLefzjQeDp3wnHNrTbJ3SPpTKyjOvpO-EsFA>
    <xmx:iULzajThipr-UxTyuQQEJ7jWDCsE73KlfzXTf41eZRpd8Rpi4a2MNCT2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id AC32432A0097; Tue, 10 Nov 2026 11:12:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AK-jVwBtQCQR
Date: Tue, 10 Nov 2026 17:12:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>
Cc: "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Daniel Thompson" <danielt@kernel.org>,
 "Helge Deller" <deller@gmx.de>, devicetree@vger.kernel.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, "Jingoo Han" <jingoohan1@gmail.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Linus Walleij" <linusw@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fbdev@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-watchdog@vger.kernel.org,
 "Guenter Roeck" <linux@roeck-us.net>, linuxppc-dev@lists.ozlabs.org,
 llvm@lists.linux.dev, "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 mfd@lists.linux.dev, "Michael Hennerich" <michael.hennerich@analog.com>,
 patches@opensource.cirrus.com, "Pavel Machek" <pavel@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Support Opensource" <support.opensource@diasemi.com>
Message-Id: <991009b6-e62b-46bd-9a0b-43c3b7a6d10a@app.fastmail.com>
In-Reply-To: <avM5EnC9yujUZcCO@nsa>
References: 
 <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
 <20260912232047.19c4cb10@jic23-hlaptop> <avM5EnC9yujUZcCO@nsa>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026, at 16:39, Nuno S=C3=A1 wrote:
> On Sat, Sep 12, 2026 at 11:20:47PM +0100, Jonathan Cameron wrote:
>> On Thu, 10 Sep 2026 20:14:15 +0200 "Arnd Bergmann" <arnd@arndb.de> wr=
ote:

>> > drivers/iio/adc/ad7793.c
>> Maybe. Analog devices ack needed.
>>=20
>> Production part but this one indeed fails to probe.  Analog
>> folk, do you want to fix this one up?
>
> Given it's production we should fix. Looking at platdata seems to nice=
ly
> fir in DT. Issue is that I don't have HW with me to test. So I'll maybe
> just remove platdata and assume some defaults.

Sounds good. I already dropped my removal patch for this one.

>> > drivers/iio/frequency/ad9523.c
>> Maybe. Analog Devices ack needed.
>>=20
>
> Hmm we definitely use this one and we have OF support out of tree with
> likely some DT abuse of what can be in DT or not. Not sure if I have
> some HW around but we'll need to fix it.
>
> In general for ADI parts, I think we can drop the ones that are not
> recommended for new designs. All the others I tempted to say we should
> keep. Naturally we need to fix all the drivers that do not compile
> without platdata. And for the ones with defaults we can also just remo=
ve
> platdata and use the plain defaults.

Ok, I'll leave it alone as well now.

I currently still have patches to remove adp8860/8870 (backlight), ad7877
(touchscreen), ad714x (touch) and adxl34x (input, not the iio one), which
are currently unusable with DT but are all listed as in production.

I assume you want to fix all of these and keep them in the kernel,
but possibly still remove the adxl34x and only keep the IIO driver for
that part?

I also have patches to remove platform_data probing from ad5761, adf4350,
ad5791, ad5421 and ad5504, these all have DT support.

See=20
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/=
?h=3Dboard-remove-7.4
for the updated series. I hope to slowly get through that. Let
me know if you want me to skip any more of those patches.

Thanks,

    Arnd
