Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E7191F92
	for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772082005; cv=none; b=u7uesIn0U0WLZOk0JKEQEbDBkfw+Fsj1udelh2lStstGeBetRrjGJQMl2glTKDiYdFTFqwpetJTFTjWY08Fmrv4u8f9JaYB7BMQVIvsE5recw4mpfg/aUbfxuv7K2gr/R81yhgEy8sRYzL5LZ3RwLF4lMZvdqYsu1v3W0st6A1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772082005; c=relaxed/simple;
	bh=AahixQdanSzA3kc6u8rh0gxLSTO/7yPyGXL/3EHVyiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuRmPEtPYyIVAjMu+Ludlw/Uv/pKqlL3uQ8H/lr3wE/U6fXev9zRDPpyuIZlXbL/bz2cXMKwCk98k6g6BPPWJykpPc3tHaE84YANTeXY01G5SORPr5Du70aE0pxzr7NJQoEg7FjWekBlRB5DSrdkdhR+o366CkWaFL61R1c7yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1JhsAyk; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1JhsAyk"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12758ce1e8dso1244275c88.0
        for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 21:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772082003; x=1772686803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eHYbEhbZNkwklHmAxtT71dqbWb7KBwSmjap//ylw1J8=;
        b=M1JhsAykNiSSBjOQq++NBdU7xwIziQASi7VTmf+71mG/rqq1h7bRM1NmIX8saeXghO
         EI6S8eeo4O3Lq5/rW7koMN6i2gX7J1ZvcvUtYZ7d0rDMykAM+yig2Ngh1k53aDRIgqV3
         3j8MSvPzF5I/ezeIoPm87fXbHSVPRPf9beW8h1nL7naRiol8PPVCwuSRFJLVVn2kKqeK
         +y9DB/dVa7p6Yao70lH6yshbuk6z9pbrtOAfCTKwnIGcTuBRXTQsT+U2KgoY4eWfpjdy
         G1XUgz/fJkeD68CcroGbB2JaK4o5GGd2hXbD9jeqDoBmk+KzU86VlMxrKQJJeoSeozUs
         FUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772082003; x=1772686803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHYbEhbZNkwklHmAxtT71dqbWb7KBwSmjap//ylw1J8=;
        b=UGDng+XCzbg+ZC6kV4UKQyZT8x7w6JhOMVo+QlTmD8XaeM0gCDhKbl3mszBwi+DYBQ
         TVMBQjyOrZshkYZLWe1yoePToT8Uv1BNLRrdu4Q7hptCw36yzJHusJbZ4zBch94Tp8fd
         0FCFOA5zjwPQ/q0HK//AszBFPjqb44rhD8d1K7ZqBXbY08BEzKmcMvcshbiCXebR0WEF
         Aa/6C2RSb/J6NVU26+GSlUFmQPk/KYb6LBDI7NDJTagE7boLCRABaUhllfmJ+2jJJuAJ
         7kexpKzgnHFjHDUNlVhRXnFPXHoAOFrVnxfwegE8THnV7Xi7fpx3HfvscBHNq/SXQTKu
         yhEw==
X-Forwarded-Encrypted: i=1; AJvYcCVYw12JqRPjmElLh67fAKADCZFqJ7/irk+QthwcQYTEKKU91l8qscr8uHzbqfhoDwdKoG91CIRz3+r6Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBMtCUVCL4Aboj/hFvpq1csl+7YygMunMGbeTQ0vSGzo1p55E
	fnCyBDZyqUJYE+0TB9rI69Kv9G4hVFvG0nYVTV4fn4CzkEplF5rfV8dM
X-Gm-Gg: ATEYQzwK1u1FskkTrwGbS1cktwEVRFvrJHJqLXaauHlXu/fcN/iusICsjZSfYspsGjU
	yMVpJUyZmLylG2xZmdG2sZDquJ/68lclos2SkjrZFGyyK7AVc4xxdiIJNpDLhQhVLq1MkvvD50V
	txPrBt0t6JNkw3e3/0AQLZvL82m+jl0NSAikxt4B8C6QxDfrWABqJJ+nuwdHX8zGAU4yMrwlZZa
	srMwEOF4Hoo6YbA9oIW3aPIpfCl1R57N55FgwS7DSuZL7mXQBKrd9/AsOCmC8gD2j9IdtGhj/ef
	tWP3mj+/X66fMbanwjCGRBVSia4hYWGPfFst68HnWPmq2iPuNmG6xd0UJ0hL0T8BJ0H/Nk4ROy2
	m7QvlcaFWPxV9mVV87zNrCoj2tT0UKglLmQvkHDxZlyLzndm3dIVxHn5mgtDBA4y0m2boz/FkL0
	EueK0k/aWcXWqM06u9fBdlauccA81jWm7CshcrxhAeEMnHAqQqIveq2X+XLbRk0gZMsUyLD/Xnb
	mQ=
X-Received: by 2002:a05:7301:d1c1:b0:2bd:c7bc:2d44 with SMTP id 5a478bee46e88-2bdc7bc2de0mr1158137eec.31.1772082003013;
        Wed, 25 Feb 2026 21:00:03 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:64dd:9670:711a:678e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1cf04b8sm827774eec.10.2026.02.25.21.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:00:02 -0800 (PST)
Date: Wed, 25 Feb 2026 20:59:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, 
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND 2/2] HID: i2c-hid: elan: Add parade-tc3408
 timing
Message-ID: <aZ_SqXA8ad3SAD3J@google.com>
References: <20260108063524.742464-1-yelangyan@huaqin.corp-partner.google.com>
 <20260108063524.742464-3-yelangyan@huaqin.corp-partner.google.com>
 <ffqvva5kgyh25mpquackob7fnlaxseu5stgevneqynwa7m77b3@totpb762p6te>
 <CAD=FV=XKqFTNYopxV9H8rnjEYAgDebW42Ot92aZYiex5MP1wnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XKqFTNYopxV9H8rnjEYAgDebW42Ot92aZYiex5MP1wnQ@mail.gmail.com>

On Thu, Jan 29, 2026 at 08:50:57AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jan 21, 2026 at 2:40 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Thu, Jan 08, 2026 at 02:35:24PM +0800, Langyan Ye wrote:
> > > Parade-tc3408 requires reset to pull down time greater than 10ms,
> > > so the configuration post_power_delay_ms is 10, and the chipset
> > > initial time is required to be greater than 300ms,
> > > so the post_gpio_reset_on_delay_ms is set to 300.
> > >
> > > Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > Jiri, Benjamin, another I2C hid with bindings...
> 
> I guess maybe this could go through the input tree, but it needs
> either Jiri's or Benjamin's ack? Is that the plan?

Jiri, Benjamin,

I am going to pick up the DT binding changes, do you want me to pick up
the driver changes as well or do you want to merge them through your
tree?

Thanks.

-- 
Dmitry
