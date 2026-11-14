Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660883;
	b=t5fSDEiCyCcb79SIJhF2QyRKvd0XE2Z/k19+vXKdPT7fjitejBqdOsLmEmITBZsKOIqN
	 Pkdqo1K4UdSo6B4iLjFVIKpfZEpFcfg8VcIWHL+wTDcfSIsw4U4EYeVXYisZmhknTIqRo
	 OgZbgjkmjQiISVg5U5AmX1LNygZoYKeAGt6jhtytp2pD6SSsTGaJLLrWd3khbFtfqCm8o
	 Oa0mBlkuMOrOYixQxxeC04GNlN5QYZo8PuGMWJeR3GW6Wc2tpr5jsZGe8X9gv895zVBLG
	 oVF7L2FSXnDq6DyWATsycmLbf56bklOgGqX8TXzEBF4gWgtI8E4TWDO3LuwyE5QuzOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660883;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hlz2RuBBGemT82l8KFHAbURWPsjr48ulFuL12dvP2LA=;
	b=PgJkvOPphvzUTRFi9J5Cp80MLuO3F/OpYIBoYgfpX0Fsn6WkASn6wbrEZr3qhjXAfUt+
	 IRIihHYWOGB9Jm9JabrxpYJN3ndSVnLzvg0Uf7fL/8o5jY8KL1zD7OfHbkBT7VC3WF09A
	 5HZHOtgzeNRYNWO96/rx5/kJ8pCSGNFnq1JMs8gqqXIMvFEGUVnIBFBLUCOxO1Y6q+jfi
	 T7qIwf/dLrTnd0vdYvo3GupbDnz2533Rcwz9x+MUqmXDKDuGr6LOuYVW423JtdWu6oqNt
	 7UabwRgujLRhItMB7FniLm3gdNGH71bzESImWiHiJGzk+AZYOP2b5/4HC/9X9j8652A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ZOnZM0Z9;
	arc=none smtp.remote-ip=79.135.106.101
Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F2606A32E
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 12:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 532F2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ZOnZM0Z9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794660880; x=1794920080;
	bh=hlz2RuBBGemT82l8KFHAbURWPsjr48ulFuL12dvP2LA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZOnZM0Z9jsyNi3yM3Rtj7f6PZVcvrE9tj8aWZgBCJvHdTBg3kA4NIb3jYcDoBAKIf
	 Dpl/rVv3A+nfdBOYz6jktIA2fhmPuAzScinh/6aUeAbI0vWYx9UtioyW6yg7YalIOC
	 EtCo5A5OfNDASo8naT2EY1MlsXVILQB/LsR1boZK37R7dKxn1zi6gKtsIL2dEmVecs
	 8CwUW9AaehrozbfOSRHbm7QOzVoML9NNp/fzQ/jeqQ5LG8gXaxdaCjvxdNhcMgwWIz
	 l37A/FFyGoIx7+dhLL8/YT4pDtmT/qI19W10bSfB3daK/4ZPK7Ijlwj46wNnIwSQoZ
	 LVPy2wAnDlePQ==
Date: Sat, 14 Nov 2026 12:54:35 +0000
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Hirthe <ohirthe@proton.me>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: microsoft: normalize Xbox Series X|S controller axes over Bluetooth
Message-ID: <QnGOyPhgTxtpKXubnPyRUIDE7QMVgOShRgM3MM8TaW6LT-wYGGvGg1Zj_tZXDfl1bdu5Yr3YPeQcTqUUNDV1Ge1V-1tL9gwvIX9Ac7nn-FM=@proton.me>
In-Reply-To: <20261114-hid-ms-xbox-ble-v1-1-0b114dc5dcf3@proton.me>
References: <20261114-hid-ms-xbox-ble-v1-1-0b114dc5dcf3@proton.me>
Feedback-ID: 177045190:user:proton
X-Pm-Message-ID: cfdaf9f06b46681fd572a5ec54b19029167635c2
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

Please drop this patch, I'm withdrawing it.

SDL's controller database already has a mapping for the current evdev layou=
t of this device (right stick on axes 2/3, triggers on axes 4/5), and the c=
ontroller works correctly with it. Changing the axis layout in the kernel w=
ould break that mapping for existing users.

Sorry for the noise.

Adolf Hirthe
