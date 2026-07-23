Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521C395AD8
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829198; cv=none; b=FlzH+dcgGD4Pn/zRDhg0e8o/vmQKna+Sd4Pg0Ir4gC7LGuLCAiwMVh3D5TuSdUdpfR45ZWVJGPGIX6oiXirCmInbL9kiLhcY7V2rV6nWq7yfa0DBOijAsJOt0dy0AsjWolQU3KIo96W+0h/SOTHTcxHNQCmK1nBfGZRfcllmmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829198; c=relaxed/simple;
	bh=bXt8BWHoi6WjvH9J91ZlaE14yN7FYK0b5KP8qFrl3dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JApYBtqAra09kDeN4dXjkTyyFc9YhcoImnOA/oSBLoPfmGSxJyfAIpr+khFtJZ8CqE2xhgdOUDHINOHP7mAK64IsYXIeU/B7sMhvWm7oiM+4pZA31gpQj5Df1YGGvmNswz43EI2Xe3dXctbwcikwHMx84wIHbSvc/vrpJlqreUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BomhkimH; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BomhkimH"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca957432c7fso727928a12.1
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784829196; x=1785433996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PiY9z17CCWjVP+IRPI5g7TJ4J7BNOU9OnVtXhkrBfb4=;
        b=BomhkimHo5G63zj0i+tvd3YeleNWFIgHUwbhV5oAYftbvMQCx6G37EYKeF7J2NxqsP
         w9+/DwaFXW6m0peskpIM6Guj/Bn01zkRkhT7LyP7OMqb+K0c1msL9TlJleQbExvJuETU
         +tAiwqw39efTUyHvlwJbAXN36ycVAACUpgZXpIvcmdJm6WZafY9HalTxNkNFAcxfiLgA
         9XA4OiW6oY6fs7yqRLi8R/heBeAKHotxmZVvVd+OO/GRJOGllr0pkZ9ncNdkXUCJf3/J
         avU9R1op6XDdqwOqI7t0uDWnaI5AEayFxe85x2XWQi7WSnylKM0pm0tkLZ2UNhq7w98p
         xJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829196; x=1785433996;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiY9z17CCWjVP+IRPI5g7TJ4J7BNOU9OnVtXhkrBfb4=;
        b=k7NXTkvaJlByzHIEyBuSTTy+hEjKkI3tGMVi5KEWCOTtZidP2C8PI7WTuTSWgGmSTC
         WB3mfNOKP3Rnnqi1LG9HRwNXCg2IELY5yca4wOVsohdMoqa8Z8J/a39FcWKmv8dnruWZ
         c+AgmZO/8GeZz58FBRZ6lqQ5/GHsGNdC/FXB/ED3g1JVD5vP0yw7pyla/svuqj5uPCRr
         dTUOBpx9s/ftuENEMuc2trsKntG6T3WbCXFuLa99SbvplROkk7Qp8MKK6Bot+LuSRb6g
         fhgFOUSY/DOFphF7Rw3cJX7B3grR50v522DnEEYJPVzDPp8CZMBzraZMJJwIiqYrhGt3
         +xdg==
X-Gm-Message-State: AOJu0YwDGRn6tu0Cn6leLd/SSceojB5ZRC+JWycLpi0ExH+mPbRhANRw
	1t5F1K18sUSJ8NY8/zbexq466gDgmtbbAVYAFy87N6EPXu6k20sjW76u
X-Gm-Gg: AR+sD10LxlCBS4QiPh9JiLmWucs3DtEh/aHP+EJPAs3hEn8Xa7Xt1pKHUr4JyO+uDut
	xGKRJhGBf9PV08kxAF8GjYUjxJE50xOdpM6gZ3OxPLszLkaRA0NskiTo0cGIaqiJwlcjPhps7h4
	BUuO2NQnT/aZYoIvK1NjOj3u+iNtm0643z8vytIQx/27SEUafA72A4wq1cJg8tE2QLgFWdw7Wpo
	zrr6NfMruHGm7fVLaH0BMnKyQr73S02P63wz0DgsB8DmsfO0Hv7KZ6vt6bVtPNZDRrfIRLtEqMR
	OKJaMv6v8pv5ZZ7gVx+ENY/2ZzOttZKIrEEejNx3bRshMZxMzDde9YBpPb40pxO8lG+4c2cIrbW
	v+gyqvjXRLLhkL+IP1D8O2K+zEZEsMqcm1rfgnNum8MSsxm8X5H0L/lP/mRpLpYKtUDegZYCMQl
	U3O/pHGaJ7nlTfb+b+LTm/7qPpn9Ta/ANUjQY40m+kYg==
X-Received: by 2002:a05:6a20:4323:b0:3c3:c07b:5322 with SMTP id adf61e73a8af0-3c44b0148b0mr4288981637.34.1784829196286;
        Thu, 23 Jul 2026 10:53:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f5d:dfe5:9bb9:71ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1c9289sm22178711eec.29.2026.07.23.10.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:53:15 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:53:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kyohei Kadota <lufia@lufia.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - add support for ZENAIM LEVERLESS
Message-ID: <amJUufz21YuUCO4E@google.com>
References: <CAFMepckDUuOHiDDVVhUYc-UqJMeCqrWSfCuxbJ2x2sGgdDD4nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFMepckDUuOHiDDVVhUYc-UqJMeCqrWSfCuxbJ2x2sGgdDD4nw@mail.gmail.com>

Hi Kyohei,

On Thu, Jul 23, 2026 at 07:55:57PM +0900, Kyohei Kadota wrote:
> Add the VID/PID for the ZENAIM LEVERLESS controller to xpad_device and
> the VID to xpad_table.
> 
> Signed-off-by: KADOTA, Kyohei <lufia@lufia.org>

Your editor or mailer converted tabs to spaces. I fixed it up and
applied, but just wanted to let you know in case you'd want to submit
more patches in the future.

Thanks.

-- 
Dmitry
