Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2543C9438
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 04:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583995; cv=none; b=Cm5ik++PvMetydsEwp5fATeXtNc3IYaqwA/VgsttzHKjnfA3B5/1q23Xas+TJ6PR9Oh+pa85Y+5g9Ai9q1EdEECpaJ2q2DulU57TaWjFhQ4dvbtqi8pdOZrbVKcaUO8syQDIS4yoUb/xcj9HV/kBrXtv1VLqwu6RWiTjFCorrds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583995; c=relaxed/simple;
	bh=oo4tfyy8/lTcDz9sLBYLwqwvpecf+BueTrMqZlBkdJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzfrFadUOOnaOkrNgbq7KxvZ/oY1Pjd4vMNlrvWJzSXjwDpfC3rPA//jZ5ZGrlbYmjHm149xb970uNsVlbDNmnoBcDKVdzWu3PaFjnrwHKvc406SaeMAx2//qS16LZr6iMNiARFsh1wlJOTUc4Uc1fXI843NTx9d8Qq2qhDClUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxVDiETX; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxVDiETX"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3075ce9c05aso10415126eec.1
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 21:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781583993; x=1782188793; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bY4/S5kAo7rT958o4WJs5aY2AIH3N1nSwFvgkKoR7DU=;
        b=IxVDiETXMu9w5l/RPm4LuK+2KnGgZJ4HOIUnfo+bHinIg1ulcPcR687NvE/6dW/bpW
         OUj9Zha+X20RjcukD7hNlxX1Mx4L73AaoG/42u1t24jnj4I/Osg5U58zAsqd48u0g3S7
         ZhKNWf7hVdxeLjAzciO+KqM/h7phqeedB3yslKahoB4OIco23FB56/ox1h9BW4GSiQPz
         iAWYZLtvTkfcIBn0QiH3UaMXnVhddQ07NHNGrxdfoAz3PouEPmNBqG6EplQeJWbZJskm
         E0Z4+758FRO22vnty66xXhAY3oq3jFe4AUvEmkPH2ifCNR2+hjz8OnTtFw6KWskZRyW4
         vgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781583993; x=1782188793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY4/S5kAo7rT958o4WJs5aY2AIH3N1nSwFvgkKoR7DU=;
        b=GtU0DBSlGXmEfbw6aom0Rrn3ZRCc9OuwWCGTNievY9vU48b6W3uyJo3VLogI2ytmap
         2zsT3jwQxHScjkuB+U+afj/RI4lEeOOwsEfRorojGo7rS2O+XaYnOXMRvOTIWnLFMGG0
         ds6FIjW4dhsNujBFGFUxAx5AAuIcno7Ceju/5s2fO+8IW0AtPsHcc5K3GHoachw0VWA4
         OzHr8I13MkaYJGXZ+Mx42Mh3v+k4GIQNdzhs6jnRST8ukDJiY16PbxhLw8uvucHyKouf
         vbEYonDWxG0nQSjkuhXi2gNguRLits3ZMeR+N9tj4SRpMXdiaOd43AdbTv9efsVmACbd
         /H5w==
X-Forwarded-Encrypted: i=1; AFNElJ9rtTGqlTmde10SQK+fwpGtoaL86lqsOepPaFAFL64yB2P9l9iLiSkfo85oQxXF/o9z6aK68qZgpe55IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YweoJN2NS/Aa6HMcmH2phaYdGBP3IxAHy9KZN/oLGJLX2kRzWZB
	NMQIHWukV6sOMbP1pDuM7ipMYM2Dt9sHUpedQFIhjL5kWPTtNoGnGU3lONH3zg==
X-Gm-Gg: Acq92OFDe7TzJKy57++A9ifdRo0vu6Rq1s+ouXZoJp8wMwhI7XPJpBGB9aHOxl4Gk1P
	/kHqTuMJzMOhVUWlHbJ9yssDuephqzQ0mKyVUYttGJvK/tz/lo5Tbpjur3BfmLx1g/t4jG8hg9Z
	assKg84nYr6uNNnrimBIExoXZHUqV/0nVAFzoUeQ0E0n2i5iuTLZq0P6sOpLsNgxNApvzMg5lIZ
	CSNCkoZBC7hlfp9guHh771AneNcQ5DLI3H86Xcf7LYFElCmOri3jSq/e54XXNzk4QDpRX/Hfe75
	f19Wdq8fCWJKznbInbKGUFT1XWAKg1b1tWWGK0d5Y3dDoupv+8lbiY3VZbJEXETXp3vf08wMiZT
	LehrEI8vTxl1a5X0/vGOpoBpTulpIzXy8Xaz4+JeWoq0W3eyDxMalmKj9fL5j0Z7i4PMhOWpyJl
	83bOxxckx8WOMcW4cVcW39/fsmDLF9Jvy2HYEJh2n2syz2dllEswgbNXJZTgaNkRyR
X-Received: by 2002:a05:7300:3b28:b0:304:e72a:d4d1 with SMTP id 5a478bee46e88-30ba5f4b95emr1163025eec.30.1781583993222;
        Mon, 15 Jun 2026 21:26:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8f8b2sm17660379eec.27.2026.06.15.21.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:26:32 -0700 (PDT)
Date: Mon, 15 Jun 2026 21:26:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Ion Agorria <ion@agorria.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
Message-ID: <ajDPtOyr8GJYaVYQ@google.com>
References: <20260528053203.9339-1-clamor95@gmail.com>
 <20260528053203.9339-5-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528053203.9339-5-clamor95@gmail.com>

Hi Svyatoslav,

On Thu, May 28, 2026 at 08:32:00AM +0300, Svyatoslav Ryhel wrote:
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Add support for multimedia top button row of ASUS Transformer's Mobile
> Dock keyboard. Driver is made that function keys (F1-F12) are used by
> default which suits average Linux use better and with pressing
> ScreenLock + AltGr function keys layout is switched to multimedia keys.
> Since this only modifies codes sent by asus-ec-keys it doesn't affect
> normal keyboards at all.

I think using input handler to intercept ScreenLock + AltGr is quite
awkward. I think this also passes the original key events (unless you
make it a filter not a regular handler).

I do not see benefit for reacting to AltGr+ScreenLock on other keyboards
to activate the special mode on this one. So given the fact that you
already mange the data stream when you split it into "serio" ports,
maybe just intercept this key combo right there and create the input
device and signal input events right there?

Thanks.

-- 
Dmitry
