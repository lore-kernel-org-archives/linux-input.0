Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794419152;
	b=X3J02wj6V6l5NUkwGqZB8+He8sfip6BesM01qKWOv/GsN7YEStm0J9JKVaa5u7kH43M/
	 Ll8vHrSYxR4ICxMlaZwOdR8/MBEs9vOipolk/Ts2GT00SkhdeM6DljklU2VYJFTmFyeAz
	 hjsKwGapVyFCACcIC7U83C5GPml8uQcC8wFcgmvc1ueaGKUwGhfkgEUymuBP+kizcMXN4
	 gm5NKRxWbmzEU3oUHeECVLioTMef4A+G5gEiYEL6LSQ8QHJS30juY/glLSA858H+Ad4b6
	 tJhWxLjazIWwXNfa2P0Q1ejhh4E5fASrAOiUaKt64sCwrV1NQmvKkvHdVuEW2b0AWBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419152;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=cnQjMemomrtAUFZ2+Y/r5Fl4C3K3H/4XXCCh9+3ZdjE=;
	b=Gm9hw3XA5C/2Mope8rwpdKzSq5scw+FdviLD+7nMK1UMxGHF/hZqz6sqr/g+O/k7h2hL
	 pdZ1YauUxpCMjRkX8AUf2g2xNoo7J4a7FiYaFA0QAfo07nTC57btVtE5PvFNiMC4v5eVg
	 Nx3urQLKB3rS5ot1iHH6/sQcp2zN0hKl5/u8Uqt98kUIx+wGVoII0LkxQk1BoPrcEqsTF
	 1ClAHHYkfl1QDn82/6k0nvyUldsC7Me3bjtt7fJfMy0D88UUWjHs98X3Hgiu+Ye887u9C
	 UB+OLN/LTxol6WG0w8Juc0/0dWRwfvbwHIJzZl4cdrfsxoNJDgtMnO1/wSjEw2vJAGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=K2thFDH2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0C606A331;
	Wed, 11 Nov 2026 17:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B0C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=K2thFDH2
ARC-Seal: i=1; a=rsa-sha256; t=1794419140; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nmzuq+YuOTr/XnjX22MWYdS9WkWjipjQLSIOejurtWLKiiyf/YGBifxfe3Qh/oh0fmwXBwkCwj5cxaeO+Qat/4CpajVhefFzdRHP3nc9K4OhuRbI4fD7zVFwxzL388T2NNMAKcj0RN847YASQ0glMkz9u7lVVyQjhRTeTWpBYv0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794419140; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cnQjMemomrtAUFZ2+Y/r5Fl4C3K3H/4XXCCh9+3ZdjE=; 
	b=IvgvpvP4Fp9AHY4ykcGqAMGx1drI+Knd/ierTnMVE0x+VQDZ5G88rCaiDcrkrtWVPbuC2GWQ905bE+KaCB8uNqIooHugg/fU1ZNooZAvONCob9IzzyJNIpc469ZAAHeu/M5blbNg7KwkY94Ju1S1ZoDf3pIixRlpmY59ZbkuyUc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=K2thFDH27b7B/YJYBmnGsiaXxkHr8p1Bb5gmyzM7yimg6qiChr25HSe8lScIBZWQIA3X9YRuqBcGi/1pq1eZElm702ExxoTAv4/Cloa11K6VPYDI2AaHq4+dCuPrAVANWbgU8P1oZ9+lq+5zBRShRONf6BCAT9p78bsQvjFlQa6Nuro5TkPeJgrpNYV5rzEJS40Cg3ENz0Gs1NY6xWW+HPgO536ltUBgr4mUv2vAGmNUlGIu39N+3p98+7i1wby2+ieD7jI5xkCbz7jPkXrxPixusXZRyklLlW3W1gCTl6sG7dDuHB/vRVpctI08t7rE0x1tVRVLerJE4SzQ3fH8hQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=cnQjMemomrtAUFZ2+Y/r5Fl4C3K3H/4XXCCh9+3ZdjE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794419138890504.7205507541514;
	Wed, 11 Nov 2026 09:45:38 -0800 (PST)
Message-ID: <474a0088ab286efb0e363ad27398020dd6b15499.camel@rong.moe>
Subject: Re: [PATCH RFC 0/2] Keyboard lighting for the Lenovo Legion Pro 7
 Gen 10
From: Rong Zhang <i@rong.moe>
To: Ciro Pedrini <ciro.pedrini@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark"	
 <derekjohn.clark@gmail.com>, Ike Panhc <ikepanhc@gmail.com>, Hans de Goede	
 <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, Werner Sembach <wse@tuxedocomputers.com>,
 Aaron Erhardt	 <aer@tuxedocomputers.com>,
 platform-driver-x86@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
In-Reply-To: <CAPKD0Hdt7WNC5n47Bpug=DMsJ8m63UnGprm+-cLaUh3tb=4vCg@mail.gmail.com>
References: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
	 <71ecff766a91670d509b1286efd995b71efc21f4.camel@rong.moe>
	 <CAPKD0HduW_atYsz47Nv-9A_88K1B33xENUnZgQAKcH4VHqV9PA@mail.gmail.com>
	 <db41708e7676697fda99573a31d7747dee112403.camel@rong.moe>
	 <CAPKD0Hdt7WNC5n47Bpug=DMsJ8m63UnGprm+-cLaUh3tb=4vCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:39:56 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

Hi Ciro,

On Wed, 2026-11-11 at 14:27 -0300, Ciro Pedrini wrote:
> Hey Rong,
>=20
> On Wed, 2026-11-11 at 20:10 +0800, Rong Zhang wrote:
> > What if (four permutations):
> >=20
> > - c197 sends 07 AA 02 00 00/01 00
> > - c193 sends autonomous_mode=3Don/off
> >=20
> > And what if the sequence is reversed (another four permutations)?
>=20
> I tried all eight. Before each one the LEDs were back to the
> controller's effect (AA 01, autonomous on). "host" below means
> autonomous off plus all lamps set to green.
>=20
>   c197 first:   AA 00, host  -> green
>                 AA 00, auto  -> controller's effect
>                 AA 01, host  -> controller's effect
>                 AA 01, auto  -> controller's effect
>=20
>   c193 first:   host, AA 00  -> green
>                 auto, AA 00  -> controller's effect
>                 host, AA 01  -> controller's effect
>                 auto, AA 01  -> controller's effect
>=20
> So the order doesn't matter. The LampArray only shows with AA 00 and
> autonomous off. c193 keeps the colours it gets while AA is 01, and they
> show up as soon as AA 00 is sent, without sending them again. AA 01
> takes the LEDs back even when c193 is not in autonomous mode.

Thanks for the experiments.

AFAICS, we should be able to integrate both as a unified autonomous mode
trigger. Yay!

Thanks,
Rong

>=20
> > My implementation connects the LampArray application to hid-input, so a=
ny
> > HID driver with hid_hw_start(HID_CONNECT_DEFAULT) or
> > hid_hw_start(HID_CONNECT_HIDINPUT | ...) will initialize the LampArray
> > application. Therefore, I suppose the only thing we need is a simple gl=
ue
> > driver[1] for c193.
>=20
> [...]
>=20
> > Does that make sense to you?
>=20
> Yes, it makes sense to me.
>=20
> > I will CC you when I submit it. For now let's focus on the driver for
> > c197 first.
>=20
> Thanks, I'll test it here when it's out.
>=20
> Ciro
