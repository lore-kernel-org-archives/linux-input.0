Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BC3B9D8F
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667554; cv=none; b=IzC4JZoqVCC0IrWY3YyEcN8bd5+xSoUV+k4R4Vzwup6MuU1TELwFzdEk7Xs/KMKhxuzHdfrNShpa6FqNvTgMfex4J312yu4y7kHFCmrc2TOS3P2A+ERgL2nK5lNAiykh3IDa+zhn/Rjs5DwDxdnceBFDpTq6qaoZGfXmiNpQU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667554; c=relaxed/simple;
	bh=qhbh9JrUDjvFvh4qX8SCpaVDvbkTMEfimmeFPmtkOjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8KDgar4OjQtpxc9KH1oo15XbsshkYlo4JxbyF0G4Xhn2slFVbUHcHrwvy532XpphDMTgMq53evg/YjBmlf38WJk1BTj35TDDsPxCQ8a8NlF4YHLtKm3sknp4F1O5z99GWG1blTe2Ok8beS5SAshMUfBbMwiizT1AmQPVyFXoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8wjkz2M; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8wjkz2M"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358ed696623so52752a91.0
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775667552; x=1776272352; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iNqmvT7YdCXAJg4FUIwYA7EHq158uKGOYNj5DRKvtwE=;
        b=C8wjkz2Mygmhu112xWRjgZTYR199Iyrm+scL3jroLtsEsH7fUoLYFeV35z4tPLEZrN
         aUrSA2Ocm5FiVCqn9vyqaN6kOv48tJESmc6SzOAFxRls7a2RzSn8UzLIvQOx5C+l0TP5
         Cv3A3su1LPduabNmGvpTUI3shJh7czSVfwUK/b8CVT63Jjtvjltg0MFdIlEFXsSBjQWB
         o3mG2bYezN3PHW3ibC+eF5gKLn96NYvwkttt1ISR71GOnj1WAZYkDDoT+iELiz0KRKB2
         P6bMdDNPLjb0l+HSopC5RS5rCPxt00exMDSaQaZOGnW+bkXgHXkA7Ri8XjapOrMboINu
         SRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775667552; x=1776272352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNqmvT7YdCXAJg4FUIwYA7EHq158uKGOYNj5DRKvtwE=;
        b=eXGUhFnfpRAHuRmkO7d6v46Ep0Fuyc/oPKdJt64/R3O2kiFe4B0pdgH4UQC8x9TSA4
         6kvCTOmhNTzMT8catpBBJPq0nWNa73Xgpk7vtC3CzT2SnJ2s1AUOtSbkcl2Xv+F1303w
         4Cn1Q7T3eCQJ9lDIz1ChLrJ+3gEnw0cZqgiVT8uI3nmACPS5BJ3JLmD8BwqDoskkVsSV
         XGwQLRr3ggawW2J1zl3kEZFgq0SDlb5/+nEBk8GqWQjPU8PXoTIKHR2ebO5q841eCaJG
         ZueEKkPYAksNLzzrGIxLRQ+vMl6fUtFvcEUlLcGQnnaVcg9Q/EzTCHer8qAiIwmLjfeL
         /1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbAvwiVw/joJjgfjowonTA1eN2rtjrtaZIT1dXr04y4ygZ9JVYxUsur5Y5KqjSMYSP+HBh3vGOQ4hmUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxIR/CJIhkmHreIrWsc+m3hllH9UkNOxMgmDy9UhBNUnMM7A9E
	J3ZvfscNKR+KBehQ7KYD+kQP1omPJC6FVguseQs+0mvhd5BgpjYQjBp0
X-Gm-Gg: AeBDieuehNp0UWI9pllSTfnKjYgsBOKoIMwMgd/jAdHu8/PaffO67DVNQVOagg4Zi1R
	FK0XMKh/Fq9Hbv0yqrOhfSOvsdqjFLcVsk0G89gDh1/UBvUcCWCWxZXSOFG6wIrbAS1n86URlBl
	fmofOFICEVSrru+GzSl9abiq6xKNbq2KQfgWRr7YrMkgiAnf42BkPh5aiEWdJeg6uYahKzToK55
	dbfV4TSKbrcfERcsFHdOT184WkiYB4pq4OuoNr22SYZsTH3Tt1RpthSpsZWZMsSTdNARfxeqMBy
	8NYZzqrHRa2WuCZTm4FfcjFJyP2oXvk3o5/YhvxaqePQ0D6yIKgIe8VXFpUGN62b21FIgBdMTUb
	YaQd4VdHCSfCo6br02s0rf6u3XQYiX870laOItzhb2ghZhtCkaOv6mpKSxSQfZcw4bgqatVD9AQ
	BkFDPpLsGUdqswgUdOLS41n0F3i0o2/DQzo2yHmfjUc0IO+iQYClaari/uxZgkt1sD
X-Received: by 2002:a05:7301:6097:b0:2b7:38cf:c2fd with SMTP id 5a478bee46e88-2d40e9cdf98mr157907eec.26.1775667552362;
        Wed, 08 Apr 2026 09:59:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f3cf:7538:b120:7924])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm22328464eec.0.2026.04.08.09.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:59:11 -0700 (PDT)
Date: Wed, 8 Apr 2026 09:59:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: input: adc-keys: allow
 linux,input-type property
Message-ID: <adaJOEZHHmvZM_cB@google.com>
References: <20251215-rock4d-audio-v2-0-82a61de39b4c@collabora.com>
 <20251215-rock4d-audio-v2-1-82a61de39b4c@collabora.com>
 <20251217-tough-ultra-junglefowl-f1a9ae@quoll>
 <6778765.lOV4Wx5bFT@workhorse>
 <20251217133440.GA724723-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251217133440.GA724723-robh@kernel.org>

On Wed, Dec 17, 2025 at 07:34:40AM -0600, Rob Herring wrote:
> On Wed, Dec 17, 2025 at 01:57:46PM +0100, Nicolas Frattaroli wrote:
> > On Wednesday, 17 December 2025 09:31:15 Central European Standard Time Krzysztof Kozlowski wrote:
> > > On Mon, Dec 15, 2025 at 01:29:29PM +0100, Nicolas Frattaroli wrote:
> > > > adc-keys, unlike gpio-keys, does not allow linux,input-type as a valid
> > > > property. This makes it impossible to model devices that have ADC inputs
> > > > that should generate switch events.
> > > 
> > > The solution is to use unevaluatedProps instead, which also allows
> > > dropping other properties.
> > > 
> > > Best regards,
> > > Krzysztof
> > > 
> > > 
> > 
> > Hi Krzysztof,
> > 
> > to understand the motivation behind this suggestion correctly:
> > are the "linux," vendor prefixed properties, especially with regards
> > to key codes, generally a bit of a thorn in the side of DT bindings
> > maintainers?
> 
> Not really. Most have existed for decades. New ones get extra scrutiny 
> and often end up dropping the linux prefix.
> 
> > I'd imagine so since they technically tie the DT to a specific OS
> > kernel (though of course, others are free to translate those key
> > codes). And the whole idea of configuring which code is emitted
> > from something is basically abusing DT for configuring software
> > rather than describing hardware.
> > 
> > I'm mainly interested because this is a thought that has been in
> > the back of my mind for a while now, and I'm curious if the DT
> > binding maintainers happen to have arrived at the same impassé,
> > where linux,input-type et al abuse the DT model for something we
> > would tell any other vendor not to abuse it for, but no better
> > solution exists right now to achieve the same thing.
> 
> Not sure what the BSDs do here. It's never come up that I remember. Best 
> I can tell is they just make it a userspace problem. So every possible 
> keyboard needs a keymap file. Though I'm not sure how that would work 
> with GPIO keys as you don't really have a scan code.

Is there an update for this binding or should I apply the current
version? I am OK with the driver changes...

Thanks.

-- 
Dmitry
