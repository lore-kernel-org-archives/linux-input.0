Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218617;
	b=JM049Tro+8xPz39bYBTXp/ViuL9L74jMGDuPMhSQdZ7x6qwW44JblJ4MOeaz5t0EtEiB
	 X0oqBmNcoAjyg/sh8hImIcfYzgB946Sy2cbVim3m0sGqiEWrTSASBKDCEVfkzg8K/ToE/
	 baGHpZ+9xemos8MXP7eRPzZfsNVkl0PzrDSJEeGw6hzgsRmOMXZFHUf+Pgh7NkSpnJFpd
	 6mhQihzD06dHMKXFoWa0Iqftf14oweCiRvQV/QYTzDtx2ra7kwMkc+MuEtf4ugZ+1mXcM
	 JHegEQL3wTFiczQaPhGQz9ljj3doJSp3AwtNejmntil6DdZJvn1nisKe9MDzMrY6O7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218617;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=NcBU2cPzzA69TnFKl3QcEWwS4YrVCELU3Z1b9WHRzow=;
	b=sF15FL2WfvptdlFEFthG39Qq3TRZbf1pZW0LW2agsBGLV0R8B06nl+UrPek8wE+FoDHK
	 otreqpcCEkEBPEb3Csbia9D0Yba5ZdE53zVJHK6JMjLua4rqc3AV5tK4NoZM7rh3uAsVI
	 jPrUY7ePe1w9zii2KR/w7ss5pB7vuS1wQv4TiBo7W/VDe9NJEtZ3Z9tkNa9Sz2HSP1QeB
	 0xJEz0sXWCCZhV3xj6IkNGopGO8b2Q6fI1iwCdqDSX+1SiwOZHALqgGnnHeuh1l7PyQSJ
	 9vKXherSGKSUdQqlrdmRhj+l8sb3hOu1w9EDEbqVfuNgizDJF2mxhkGXjdK3ggrjWow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b="U/3+jibd";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yOsGBGru;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB9606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 10:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CFB9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=U/3+jibd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yOsGBGru
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B2787A017E
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 05:03:36 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 09 Nov 2026 05:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794218612;
	 x=1794305012; bh=NcBU2cPzzA69TnFKl3QcEWwS4YrVCELU3Z1b9WHRzow=; b=
	U/3+jibdQ7w09n8aWRpqomoBEXOLgzf9E7RSvnbej+BpSS9jXiTaCxC+rp4EwjB7
	2+ljXNHVwGmMepBnmucfLh2UcA9Aq/L1wfsP8mIdDKksvQpcrrT+IXiubOQMgv9x
	w+2iC45jBQhDgymh+T8nMfy5aXmwg1WR37pHlCKT16zP9gxXli4VxYsZ3PN2vd6P
	Pqi5zZ5f/Zdn0TlpGKwamFQ/ByApdgBYgHZsoQ/ofIFVgnVJTrnBrLTdkgjkHnLr
	MQZEkCNE0qOirkqX0LboZ2tMgC/Ziwru9M+3ZOGucgXb8DOFhtO4LBpvJTYpamcb
	AH4O+0RP+E2sQmxqUmb6OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794218612; x=
	1794305012; bh=NcBU2cPzzA69TnFKl3QcEWwS4YrVCELU3Z1b9WHRzow=; b=y
	OsGBGrutSkhSdaQ/ocJkFKrEmFkUOXl4S6P103BxwZ8zsstGhHPRtEGO1GwbGes2
	OMBAe2FwcaSmQX/O+XBwhT5oZsW5EjG0DVy8v7BrPquJR5uuMzuCURi4IqjmKgcB
	8QwGeAvxBoVWRohYXXQIOgT/neg2AEOjhLYdjaHegPAJh5epFZnXmJA13yBKLDLC
	3Wy7B1Lq61GuDRbowUgCuKojMjGHqfUQ9vWGpfhRkYyunycUOz/Ja6riBqhaZvqu
	JqKWKulhxoaLaYKfl+IVynUB8mnLBEAAQ5mfi3EiZEcym+oENqd/b8uGUkmagRS+
	V1oHmYgDPPGGuyXHcMIaw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794218612; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:ex1n7J3JflgAJfcXmVb+qKwsauVidxfGmey4y5lgXyTqkUY
	0dJ7MmCcxUJ799Pa2ZjVLaWWX8H6BV004eNnMGsRwrLNpyN3cPC3UivJZaDV0umr
	rOMbkmiFJrWYCcnqWSsUcEg2TP7g/0qGY9Yfjh5rdLfzdSUEVu+94z0DUoNxTV1T
	/WlEmsgLLDNUadec8GtUqtb9cnlXXSJajacwM+X+Gpa3hqeDJpqrfgMlhsP7COn4
	F3PouandY8AunM3KP4PtkV413Z5rXEoBD+6NFqKfqMiFTt1ako+rX4EfNosF+Poz
	zWkWzlxs2dhkw/GTj43+IQYX+2Fa1LkbmeFteDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/T8MQmjz4GgBV8DREY1eJ8DpVLZE+wGw4tn3GSaZ7xU=:57Zn1j/vg5m77olubO1nUZ0hRd4/i5D+ObqZzW2/XIE=;
X-ME-Sender: <xms:cJrxapzgnQqPss_-TwQrMYbyKTgsEz6hZ8621LCMpyVrbfZOmn0T5A>
    <xme:cJrxakGeY5By--w60vNj9Wo3ydd-t3hOoDrHtZWN4O-bffoJ5y6tHcPiVc2GH-khh
    lCZcW_xIZtljhaCardEgnKbIlLCQnsjqlIkHbMcqXD4PmBV7bNjqKvk>
X-ME-Proxy-Cause: dmFkZTGvWADeWR/cH2ixjH2ih6Shn7KR8b6kzpUoRzcAgWCVZfdu5PxFSNYgCdsaBx4kaN
    voP7dIVHKYz17En2UcFyHAph/oJuKXxytAVdfU4I8x/F6lTuiqhMeySiQmO4KuXRXZdF6X
    y65RrVvohm3rtrGxnryzfbyb7+PrWXNZd02w2yJ86QnvVtkrRu39DaIiTVZ8O+fsx6Eo/h
    mstnA7zFXRRLBJ8EtbIYWMy9ALVMztR49hHA5kQnxdSuWOMsBY518tECWvKFP3uwKMP1Uk
    qtKLvNyebuxzJRINHjt8OdRLXuZ6RoC3ijSQwIWccFJO1SAcPpM7R75j/bwnWgXjFAgGD+
    eacF6WdYw8srTH0TxqnS2/AASgz6v10E01ZNPe5Xx1N8h2aI0IP0NBkU9h6SK584V66C68
    roKXba+DE/MtDgsKiZzrgtfn4U59rzi0fNgPq9A7EDMDmQppcX9YARd3KjraRKt1JRB7N+
    wwzz6jL4Q6M9cMtrCd2vzH7SBS3If4zTS0PhBuW5MM8TImzSKHxODJQcQP/Y1Rn7UVCaLj
    I9andH2RXfMutRY5nLTVhI1DhFEDJh0NXF3We+h9z2M50zcS9z3hrN5SfYjWIQ1PW1OhNN
    mpgaCrPxfvKPkGpNaMoBvMqq9X+FVG3sdBWDd9Afo24nCrLJFuzYjiRqviHA
X-ME-Proxy: <xmx:cprxavUQ6OAb7GkkSH7a-EuKBsPopbhUTIUUyKARXJsHCKiouD2UPQ>
    <xmx:cprxajcpzFDVsQ3QyEqRyk9yspa1t22fXjOnuZIaIRsZ-s6vv9AOQQ>
    <xmx:cprxaoYRdFRSwPwsIcuDgfJLZzqrc6VdZel4tKDFR8lVb0I33GFTEQ>
    <xmx:cprxavNE41VAk_zq_paGGP-cPuBKMIjA7aYU82M5vnVU8ofljaMy-w>
    <xmx:dJrxasDgAn3QgTRQ4zX-prmDKdcIj5kwR7Dvp1_aSxo4tlIjF-S4Dy04>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5D2B732A0099; Mon,  9 Nov 2026 05:03:28 -0500 (EST)
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
X-ThreadId: AW8OeY5oRCck
Date: Mon, 09 Nov 2026 11:00:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>
Cc: "Daniel Mack" <daniel@zonque.org>, "Russell King" <linux@armlinux.org.uk>,
 "Sasha Levin" <sashal@kernel.org>, linux-input@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <8560bc0d-5687-4b77-ab07-3d6dda465537@app.fastmail.com>
In-Reply-To: <20261109080944.3802916-1-dmitry.torokhov@gmail.com>
References: <20261109080944.3802916-1-dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: apm-power - remove driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 9, 2026, at 09:09, Dmitry Torokhov wrote:
> The apm-power input handler solely listens for EV_PWR KEY_SUSPEND
> events to queue APM_USER_SUSPEND via legacy APM emulation. The only
> in-tree platforms generating those events are legacy Sharp Zaurus ARM
> machines (spitz/borzoi/akita and collie), none of which were converted
> to Device Tree. Both mach-pxa board files and mach-sa1100 were marked
> deprecated in v7.3 by commit cc7852314abd ("ARM: PXA: mark remaining
> board files as deprecated") and commit 7d92e50ceacd ("ARM: mark
> mach-sa1100 as deprecated"), and are queued for removal in v7.5. None
> of the remaining ARM platforms or other APM_EMULATION targets
> (MIPS_ALCHEMY, PMAC_APM_EMU, and SH_HP6XX) emit EV_PWR input events or
> enable CONFIG_INPUT_APMPOWER, and arch/arm/configs/pxa_defconfig
> already dropped CONFIG_PXA_SHARPSL at the same time, leaving its
> CONFIG_INPUT_APMPOWER=m entry inert.
>
> Normalizing dashes and underscores in scripts/modules-check.sh for v7.5
> exposes a module name collision (apm_power) between
> drivers/input/apm-power.ko and drivers/power/supply/apm_power.ko.
> Remove this obsolete input bridge to resolve the collision rather than
> renaming a module whose last target platforms are going away in the
> same cycle.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I missed this one and thought it was still needed, but your
explanation makes sense.

I think we can follow the same logic for drivers/power/supply/apm_power.c
and remove that once my board removal lands: the only actual battery
that is ever registered with battery_desc.use_for_apm=1 is for the
OLPC XO1.5, and that one does not have CONFIG_APM_EMULATION, so that
can probably all go away.

Maybe we can then fold drivers/char/apm-emulation.c back into
arch/sh/boards/mach-hp6xx/hp6xx_apm.c and drivers/macintosh/apm_emu.c
as separate copies. This started out in the mac driver to be
compatible with x86 and was later unified across architectures,
but is entirely obsolete now except for the few 20+ year old
machines that were converted to it in the past.

       Arnd
