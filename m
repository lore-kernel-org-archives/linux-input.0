Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431855;
	b=eZjprb822Jhw0wBMLjwV2gPhRRbJ0RpJgh/g+9h4GYEeylWxa6pDSE5SqqNtqla59hYp
	 msFLiriaroc58If5jZ+9jv2jZ57jKhTzoZrT/GGBAVpdGpamldE2sHqI5KxLBVsfloueN
	 5nctrEp8jtRbQIr5L8MmUe3fOLj1of0jWsYI2ahtZ5uPxjnIH1p5kX0KuaLSnGMANnUsM
	 Bi9mjEY8GwmFpvnU0Bu5ThBdB4lNBF9r21t+738zM66AFWyHpRTz+LVj8WpFcx0STi8GT
	 ah4dZnSpeDnXevkEtnSaJPoSIiNXAwuLkOmeT+09zxCoD7WpyySkiYqD9d/Js8JPIVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:User-Agent:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+x4XGLGWws4qU2+ljM6zYDkaB+j4Wc1XJmCnn2agD6k=;
	b=UZFaUCWf5eK4ZfEmQOz+USc2LlSLMe/VElds3WtVuGcb72yYGkS5bNRXSgw8Sn7hhU9r
	 1JpjMOuAe8iYjrRuMfjxCRi0R2KqMUUeAlijow5ElQTtOan93DJ3HkB6Yfg2Y/kvqXzAb
	 1v/7kZ9cPSTmvylEKwZDCYPIkiSYC7wNSPeJ6mRR8OSnNfcfxp13PSc/x61iQhNH7/GQp
	 6S4a8YCdrLpWXbQ1GNrT53/hgdXTEsaPrbV/auWICRS+lmpOCBR3VNHajevYd4IzXaubF
	 MDmVIHvbYcLVlWjazpGY0CxT0Vo4+6YSi0LiLCXmgqmo0mZ0km1ibNzkFv1iXwZlwDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k50pQO6C;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17469606A31C
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 17:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17469606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k50pQO6C
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48df8fe8513so1990669f8f.0
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792431853; x=1793036653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+x4XGLGWws4qU2+ljM6zYDkaB+j4Wc1XJmCnn2agD6k=;
        b=k50pQO6C3VQJlDHtudMEUjP1iQeDb2MHzHHGQvB6HftSFBxChNUrwQ9ZglBVU03m5i
         anWmQ9AM7bdmE+N81F10W3n9qNkVum01EAf8FmEOeDIdWDf6MX6YlLK3VIeI7nt1ySfv
         vKudKIvxUGTtsYhDfewEIiEqUhBkuWepOmF7WVKPpxl+LkVWDD/+e5HhMFSDDZtKxK92
         EwPlrpkgsON8l3H4hdP0+MaV4dCrX5J1ESPmheVJ0QVAtuEd3E4MWGTYHRCjJn2RG6bh
         sJqPFO9XsLpNQOJTvf1w0ieUlHFHwaHfCH0BPDIfjk+dG5Ew1X2Ls+e5riZ/pANk84Rh
         mB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792431853; x=1793036653;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+x4XGLGWws4qU2+ljM6zYDkaB+j4Wc1XJmCnn2agD6k=;
        b=T08+5qexyQobhCcvEG5PIQtkCQ1ixytiQ2dp9enMRgvQeB3rDESgNdcZ6PaLpWBpRQ
         cPrAJnLpnmXX3on2oFJaFKAFqsrCD2/BAj90bUbQ361weofDSXt8Cjl7B+nzK9pgr6Kn
         AVfRXkA5aQyAleLdltubCqyoj/MaJsrhL/R31CN5Dsb0XRKR7nriB8wqqeOtYNf+60KN
         rvfKi1x5OmhBaH9eHqzft7F39IWNRUKQuxy8HiJzcsVksZ8vwFXoZzCohkspu6g0sgRR
         FcP71vEe3XqYjYwzNFLkF0ivqa0nK9rqFhiDAOKnwTuCzrhrCXaGf0s4uuADUDZKzwUt
         Cc9A==
X-Forwarded-Encrypted: i=1; AKwUvByvkmmVOKfX6EbNHfOD50IAhHuE8fRwuYz2B95R3bRqmnw8VrrOc5G3CxAqgjFf0GU+r0+zAxAwWGhUkg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKak5pHkOFvyUY9Q6QIN0pcpn8T+l6z6Ha3o4Tla9afKy0kgzKX
	1PYDEsia6rJ+mnI7o4P5MIwtbWbMGefMFxWwyAv3uSauy5SRXr9wwzFR
X-Gm-Gg: AYBFou31SJA7gKfzsdhV4Qf5SLN81TP65qnVptaFgGlO/c8V8vluav6jVxmVb5jiwJd
	UlJYYW05xh3it+vjs560/wlz2kXj1ROzyNUJsOOqplyrVm3zv5D11h87iI/0ENVPWKxOTRY5bZ4
	YdElpG3dx2psVlz99ihrE0FFGB1403X915DHEcsgCzPNXP8VSntMUsLBaYhI8OwCV+k/nVoZqFd
	e242qIw1qSusQiBDQlbGNnDIW1mvspX1UDflw1Fmy2vkc75a0lDAWgAJtJ0HOI9mfAE3l3QXP2N
	Sl2VuA0/xkhE7iGd/o5EOoBb1ZWAtVeWZVYoaSR3Dw1auX50VnhnD2l/vRl9e3MaTOCvT1DAfh4
	2ZkQ5WOSpI/1/IF9lCIIjtK3hQyjLbxwa0wyErfqEgYTKGZaQIfIThpCXcjqxRUr0q0P+Rb2oAL
	zhnF9s24p794v6FOmqKfVGSVTlLXlrkrp0jVnfkQbO1ELzCdyaFSIgb83HIlv7y1yM4Xq3JkAd
X-Received: by 2002:a05:6000:430a:b0:48e:43a:1d84 with SMTP id ffacd0b85a97d-48e07bbca55mr17668410f8f.23.1792431853127;
        Mon, 19 Oct 2026 10:44:13 -0700 (PDT)
Received: from localhost ([81.6.39.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dd2a2sm413280f8f.7.2026.10.19.10.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:44:12 -0700 (PDT)
Date: Mon, 19 Oct 2026 19:44:12 +0200
To: Jiri Kosina <jikos@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Vicki Pfau <vi@endrift.com>,
 oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: introduce dependency in USB_HID
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <202610171559.gZ0QBMFv-lkp@intel.com>
 <3HN3VLNWTGRM8.2HVANQO7V2MPM@homearch.localdomain>
 <8q2ss5so-r679-247p-o8q3-pror0844p3nr@xreary.bet>
 <224MMXDV49Y20.3OGRUP8M1CBFH@homearch.localdomain>
 <999rr212-sp54-sr2n-6pp7-rq9o69463677@xreary.bet>
 <2qs9085o-r962-r57s-16r0-4rp34o81726q@xreary.bet>
In-Reply-To: <2qs9085o-r962-r57s-16r0-4rp34o81726q@xreary.bet>
Message-Id: <2SHWV2E59YE9P.3GRUK9VZ1YHPZ@homearch.localdomain>
User-Agent: mblaze/1.4-3-ga04b747 (2026-07-03)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jiri Kosina <jikos@kernel.org> wrote:
> From: Jiri Kosina <jkosina@suse.com>
>=20
> hid-nintendo does depend on USB_HID. Reflect that in Kconfig.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610171559.gZ0QBMFv-lkp@i=
ntel.com/
> Signed-off-by: Jiri Kosina <jkosina@suse.com>
> ---
>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

LGTM!

Thanks for the fix.


Cheers,
Silvan

>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index f06263ddfbfe..f88ec97f3976 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -867,6 +867,7 @@ config HID_NINTENDO
>  	tristate "Nintendo Joy-Con, NSO, and Pro Controller support"
>  	depends on NEW_LEDS
>  	depends on LEDS_CLASS
> +	depends on USB_HID
>  	select POWER_SUPPLY
>  	help
>  	Adds support for the Nintendo Switch Joy-Cons, NSO, Pro Controller, as


