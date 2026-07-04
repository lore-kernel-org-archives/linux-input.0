Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B33AA1A8
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783209010; cv=none; b=lolqZIQz9nhMJLZYm/EHysMt1MIvfJ9eA725jp6HaRObfHL2RDD0lAMJUh3XHs4TBaavGHryTLVfQKtr1uasP621Hlva2S8hjoOrCjEP/RLCmSmhe9jgi5pbtS1270PN1kn4hZ9zfUtbEQ3Zzze6WjJ0YSca033oqPn1p/B21Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783209010; c=relaxed/simple;
	bh=0agSobPV58P4EQ+dbxZAqINLXT9TxvK2g3s1XfBiieY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri7xMd37XzHemPuDkPDLJCOarN1iYbf4sZNsTvOpZWdfWKu3jElF9prDPh0xNlp2hrOcf7k6ekW7AqHXyWC/cfP9UZQsK0lKmdIz78vu9SZadzAGMLPtS3/apEHyYxCEnFNk/KDb56WiWRU3F9O4trKU5IeiKZItMaHUam3NTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilEyo2hu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilEyo2hu"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8894387780so880067a12.2
        for <linux-input@vger.kernel.org>; Sat, 04 Jul 2026 16:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783209008; x=1783813808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+HKV+KUUf1l6O94dRnCB7pZKpb3iSjpWDcx87J9hXKo=;
        b=ilEyo2huQPEeMNgEN5epkNYXQta6ImRxdcaRE0XxHVDc3TFLNJk6YVAIQjpOdTsVdu
         5zT7WMFyha3CqsMCfMXz2vWfYvSQ/ZxTL7ATL88/kkqKmOxGJ/DoKhpj2kMP2pCGhnv6
         7Gv2ageP64hE+5/Ei0Mj+VE+DSmb7LzrOmOnvepQz2TDymQVt1XQCSvp58QMLl7p7hHa
         s/kyJ2xTUc/E8zt/Y4BVMJ0NBblD5IgZeq0w9SqJ3t3BXEwanOz4D3d6+jGJvrVNpAt9
         KxDVMsUzF3Qoau24sogdT46BOYXzsnc6iQPihbPZn/YfFO3QVuVUwBxrNvf9FpAYLYEB
         GvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783209008; x=1783813808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HKV+KUUf1l6O94dRnCB7pZKpb3iSjpWDcx87J9hXKo=;
        b=N+K+dGeMGnWk8kT6n3UZ6THIN5dujWH2aMrj27eyshDmvOeYeX02Qqa1BrW05CNF75
         hIRqOQc11ZMpXxYYyYyvjnBbXuvSIhMUoNEmT53UqvMdLOz37EThloil+gIw8lVS002T
         WqMsflAXnghoev2PrEu09wMQaYhJSO8Zcqkn09D3zY5/VyLJ9Rn5HUYHZ0PIzDxDYvDd
         tzUbO/56WvweVlqnASh2fhKu4m2ygp6pDaqzXAo8NKqwlQSoLWfzL815IBckUwNgr3ZK
         tgPwKdOJP/K/HeXwwe+Sd1CFaXY6U8XQdlztCgxr9k6or8TkBdo5Cb6zqZfQTQP3py5e
         0e8A==
X-Forwarded-Encrypted: i=1; AFNElJ/7+Wq9sbxtmadAgejpya0DiWdFd/dRgF+CHIPiLQPhmDiwakYzwunUATGYd7K2D2H9CbfRwHEm0QZvdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxigmtIYqaSiN3s4KI9x9ts7YYXDvR/Kgj+y6vjs3y5Aao4xQYk
	Vdr6YTca4aEL62T6YgccieW5nXB/SEBI+rnZIxOxDAF5/eU/0ob1AT7r
X-Gm-Gg: AfdE7ckEko0LNm+tXm1Q3yT1YaWB+xlvyfFh7KjPRFWjJnuiLIXAjfgyHHSk5qBw4jJ
	2rfbGiLdWPBiepXyhz67ichLJXU6i6o6fBTDvmnv9/hYrA9veZxHMEdNawAB3ERz3H1tZf/Tfd3
	xDWYq07ohvC5/R0OqzMHHSMKEYOQiG+aQ6zPGaNcg+weqZ1WKRo4iVrAFNupvwtPmIdtH6a6Eoi
	62cH5wQ+TaSvAlBFDwaX+GF77Atc8rLtvpk9SAC8AkcMB3JouAcNKnbW2vgVQ/avLN42LaR/VEN
	tUGJV3w4JVvixbo4LrCWiypaJd+0FgoibtDWMFsLIqGAsW8+uq2yuutdkhbuKiPbAL0kcOX1eGW
	EKXgHiRsEgvzWglZk525ms2XfBJivgLa+8CrlK9TtSvlHQFn1IF9aSK+ygJy01HN5VDRRBjLneu
	DpOyiDUwK8I9s1jjMiBVgm1ACgDAkP7wcvahl0Z7H5gDVYAs1EBktBgQ==
X-Received: by 2002:a05:6a20:2445:b0:3bf:9a30:3a12 with SMTP id adf61e73a8af0-3c03e54ae21mr4963679637.50.1783209008197;
        Sat, 04 Jul 2026 16:50:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3f90:534a:314e:e11d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm54368396c88.10.2026.07.04.16.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 16:50:07 -0700 (PDT)
Date: Sat, 4 Jul 2026 16:50:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Adrian McMenamin <adrianmcmenamin@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 18/26] sh: maple: introduce callback_mutex in maple_device
Message-ID: <akmbL8AmfrxkHN0u@google.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-18-41e424964da5@gmail.com>
 <akkrQJfxSCvUptC4@lithos>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akkrQJfxSCvUptC4@lithos>

Hi Florian,

On Sat, Jul 04, 2026 at 05:48:16PM +0200, Florian Fuchs wrote:
> Hi Dmitry,
> 
> On 03 Jul 22:57, Dmitry Torokhov wrote:
> > The Maple bus core invokes client callbacks asynchronously from a
> > workqueue (maple_dma_handler). If a device is removed (or closed) while
> > a callback is in flight, it can lead to UAF bugs if the driver's private
> > data is freed.
> > 
> > Introduce callback_mutex in struct maple_device to synchronize
> > callback registration/modification and callback invocation.

...

> 
> Thank you so much for your efforts. I can confirm sashikos finding in my
> test (that I saw later),

Thank you for giving the series a spin!

> that this patch hangs the bus if a VMU memcard
> is inserted. So that the peripherals don't work anymore after insertion
> of the memcard. With a last log like:
> Dreamcast_visual_memory 3:01.E: VMU at (3, 1) is busy

Yes, indeed, I overlooked the vmu-flash use case. I will introduce a
lockless way of setting up the callback and a wrapper that takes the
lock and that should solve the deadlock in vmu-flash driver.

I wonder if you had a chance top try out the preceding patches and if
they worked for you? If they do and you can add your tested-by I should
be able to pick up at least the input patches that do not need maple
core changes...

Thanks.

-- 
Dmitry
