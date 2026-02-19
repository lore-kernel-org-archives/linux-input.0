Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF534AAF2
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771516044; cv=none; b=d22ax9ESRCfQGlrU+vftZTHUZh21bcBvLs35g6YsCvTbkVNF4ysY+8uCmlVnj0KEG2g2o3uBk3LkpE4944qANU7YGnM1pOHpcxKcqTbCJuxd6NK1o0H05oit1TuK5Z7Yt3sSK4Uw6KlXdjm1yNvaHPh9ahrbt9oTn97/TCTAWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771516044; c=relaxed/simple;
	bh=rHC0ddBkM6U8PAeFD+58KIluahMJYACy5ONx8fsBpuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYfKhKn/4ShZ4dHU2RIVXWaUR7VvvOGqzEo9jAX+Qt7Jz59tXLyb7xuMNILAuxgjO9t8VoXiDhElOsWUGNWsjn0pifkh46zyDUmveGSL4/1Sz1X8094r3yU6M52q/Ume1yTPtrvzED5XQYpmGjGdW/i3xT41H3l7GgWIeFVpuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xRgZXS2u; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xRgZXS2u"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43626796202so1047431f8f.3
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 07:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771516041; x=1772120841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C0AYfqaecN2k84Dz9pF1D4qKR1fg2anyghMrr8wFE4M=;
        b=xRgZXS2uXzOzbP2R1m3TSCoZwJyFFYPViFqZhTBBDNQp21oiR8kXktz0JqSWSGPIXy
         Gs+rQ5MAcBqPl6Oa+W5xCzr4ao9hv5Mltwb3XOrRtmxz/OSZ7QeQ9HTCwh+xB6t4YzzQ
         9qtCMBbYqRysvJfKs6JtATbC6NSgcH3QSic3TKaWJPHa6HmQ+ykCcBCOf3hh2p9Zx+nB
         vm2VJA87/G9JGKBLGsPnCLOUIuMMJ3orfU4VACtB391qhK5IsS0exAPBlYjUD8IO38Yl
         21RGb6MwhlEMXNJFh6Dinpzsyqpz4T5rfVd0kuyN5ftGSaVxtZ9yJbO1x7GbXBHwUsNw
         w7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771516041; x=1772120841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0AYfqaecN2k84Dz9pF1D4qKR1fg2anyghMrr8wFE4M=;
        b=mx7C/0Vf7OZEDH0WLWnD0QPHyBEI0+eKRbwhiofMXzocZn/+/aKYblfU6QPMf50h5K
         cyx6OdP4YJSdfBGeJqJ0swftIRLLmGWlakDpEadTTu3nY469DjxswNEy4557oh7BWuLT
         sgxNlOmfwjG1+8igN2oLggksooMbXPqsSivxgcAEb09mgx1uPSbiMCkoy+a/AG9m7Emo
         XZoBSO50EBwhNq/jX/V5Tyll4ES13WC+CjxkCfyfll99E3ueboSQQPrWybJ/aB+SvK3M
         psrUt+zt+0aHBg4luE0NjqZB3auPNWRor1v/iG0g/UxS5ldKib8HaHtPpe+K8D4gRf6+
         OtDg==
X-Forwarded-Encrypted: i=1; AJvYcCUhzpbuEHaRsremzdSkp9LN8ud2oBcqeGyD6WT8z+oyC8pmPbd0k48PXpBwYyygKwGWQbjISz9zPxaDyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkjfLJ0HE+8G1rGVZfl5xNiFqgRW3u3eUfJL8xjMop7KgcGhCB
	kN5WKn/04dxUR57zPEJSDh+0/9wI/H7ALkBUx/LZVm6yewxt7YCACPrGK5XekBueKQ==
X-Gm-Gg: AZuq6aK/XfPbSr2sxudcchdZfJZRpKoedyeExkSMK0w5j3g0aHJEi9OIbKio4tnlkg3
	0qq7WcU8JVwrQTr6LCgIqKXKxGSswjROFlnoOKd4WhJ9mUXU1KWExyg5anMZiyb1KQJESjM7D+T
	EZ+Vj+eyYtzVmb7Y6WKCAIXllOdWMQdctpAb2MjiAEj6H2x9GcuBlALBCMHMeUfe0vFcPoCZLZe
	ZMIHqTVks4NHAJQfWhnjoWRff4mwiA8VoJSR0chENVCwNwVzvImTgIJR/R3e8cNzVJuDNgjzMJh
	FzDSXtZ7apuh4ViKvk71qagX6ADZts8Qr8jCICXBMHqL3I01QCAbj633Q1hBhTye47fcZw5h/hn
	1tT79gxSjt5HpMXZSD9MIHRGCOFblWzKW/4nsjegwNuX8rNgoQ+jAfeH3hNvnqe9HAS1k4Msm3W
	PV2Nsd19zHhxBZgzE0KCU+DSPwBw2Lp4gXInRTwclovrP7SNQc+ovSfw==
X-Received: by 2002:a05:6000:1a8f:b0:430:fcda:452d with SMTP id ffacd0b85a97d-43958e0c0a8mr10213207f8f.22.1771516040891;
        Thu, 19 Feb 2026 07:47:20 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:846b:b058:f015:d4d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6ba57sm41007465f8f.15.2026.02.19.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 07:47:20 -0800 (PST)
Date: Thu, 19 Feb 2026 16:47:15 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: apple: avoid memory leak in apple_report_fixup()
Message-ID: <aZcwg4beUU-9DufG@google.com>
References: <20260217160125.1097578-1-gnoack@google.com>
 <20260217160125.1097578-2-gnoack@google.com>
 <aZSxeusondD26uN3@plouf>
 <aZTEnPEHcWEkoTJR@google.com>
 <aZYMcsHlWL5pDHdR@plouf>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZYMcsHlWL5pDHdR@plouf>

On Wed, Feb 18, 2026 at 08:04:52PM +0100, Benjamin Tissoires wrote:
> Ouch. Yeah, sorry. I wrote that code and it seemed I completely paged
> it out. Your code is actually correct (all three) but it would be nice
> to have a longer commit message explaining this above.
> 
> The main point of this alloc before calling fixup is because some
> drivers are using a static array as the new report descriptor. So we can
> not free it later on. Working on a known copy allows to handle the kfree
> correctly.
> 
> So yes, sorry, returning rdesc+1 in 1/3 and 2/3 is correct, and using a
> devm_kzalloc is too in 3/3.

Ah OK, thanks for the review!  I sent you an updated version where I
am trying to express it more clearly in the commit messages.

I also added a commit that documents the expected allocation
properties in hid.h where the .report_fixup() field is defined (feel
free to ignore this one, if it feels like it's too much).

Link to V2:
https://lore.kernel.org/all/20260219154338.786625-2-gnoack@google.com/

—Günther
