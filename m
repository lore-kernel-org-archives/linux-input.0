Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E32FFFB5
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641828; cv=none; b=gTF1MWuOYgYciCSo0HARjOEBnIcBgkUaGiuPWTw7eI3AebUt+exGT3u/fIaPe+Ug8IA9Hhx0p5vDalUVS1VtYaCtj0JL1SUWzZtcehHAFZ0lCZGYfRfF2xnaO3jpRbEHn4UoqSzNkCPm81qc99J1fjZd1usIjsmZHFNRJUhrzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641828; c=relaxed/simple;
	bh=iTSPMAeQrpjFWfeljOV725ZN4ntpVe2c116ViBdRmPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/y65Cq+iCfIwoADS2xt9PjAg5sb+Gi47w4M2bbS5+FxokJ591qTdTbZdISjqfn4nsdm9fKwkHLZa5vUtUNRS1GCpKVUCv5kcccUYsODF9MYBzUzxJxNXKlnOCSUqK++1DXwJvs+l9/XFOCnFuulti1s/SP9i2Yoxmbf66vejWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNHUtJn1; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNHUtJn1"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bcc877b4cso310511eec.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781641826; x=1782246626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yu5KqpwRFlb6PqVWTtq8wU6g+sZqF0g3U3cqmuRimF8=;
        b=nNHUtJn1Ca1tyGEAl6JBYllXZE7Vw8IK7ph4EYnhPH4s8xYKFyvDBi6K0ee8NAxxHR
         o4V6uXaHejmlmzwBaEAkDD/L3FxfzaN/jxQRf5ENrcFg5CR1/OcEOEK6mcmK0ptvLP3U
         6FPMLmPqxiLNwjKXBFGhI4lZQyDedzjD+W76ImoaGv49uF/Ltp6YhpgPUBfKG/yYPeHK
         Vhj4zQTv7Zbx8C8m7SdhutO2plhZt7VgNQKnOInUwloe1z9PwNYDkO9QPTkNzdgjOzNS
         SC7CTMUCHkyCzd33BYwtdMZB3qYHW0kiwXZrO4SreNkxIgbIC1LHJDE/qOM+CI0QjdDB
         fr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781641826; x=1782246626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yu5KqpwRFlb6PqVWTtq8wU6g+sZqF0g3U3cqmuRimF8=;
        b=pey9rI1qSdnuLFgpYV6rdeyWgw/YAX3TPPJGLC66V6HmwzMMkAlcuNnmBqi/t4xlUs
         XZidpt1N0TDxYGqfGsITAfdZtTBCzlP89JErwEjExAiUxE01vK42Io14IXzKZbA2/WCk
         KxNqtIwogtvOjonmuEgqwHvtcVKRZ8BjyLJ1V4x1PcvC8BAfgoT7NFQ4QBtbOepiyNQj
         u4rcp4x0fEH4hW6BS1CvKBHCILB92wd6+IrwX3a1dZFGF18jSulQA7Li1LE9j7KzzzBJ
         QLKS/GU+qCokCP95AZp8xf44Dh6URIOpGxU/pS01sCiqYU3ARJURhdeaTeYRKCR53Rmu
         eVFA==
X-Gm-Message-State: AOJu0YxSENPPcZ0Fgtx11AEa45qv8dqsxhzXIcqrqtCr70+Oz3RQs7aI
	97X7CYkkWbrfwa7gwkhIc8RJDBaJ+bUuZauY4uQb5nZFzpZV4/DgpYFi
X-Gm-Gg: Acq92OHCpiFt7KbRHq0zpN2NwDFddK1QtTUERnT5ZKaOHJcN9fBThz3Jw0OA3SLeHkc
	ljxEwWFe9cf+1Tbs+vVIuXf5DRZsRp3jTCoB3JbaFUup+j0i7VHRpGG9L/MnMZbcfQiVSF3sVf4
	SOcRkT8+eS5DRtcDMkfcdhWQQqN80lcS3gwJoUI881cbv6pVwC1yXK95nuEOl4YVSi7pQxnzpvi
	4u0PBNgR/Y4kTdIpxNcOKl9iIVZrijqNlovfv7uN1kpTkvFEuQPioxow/pGLaboiAwKcYvvRQCp
	OIVld+CT8T8skfk1SEBnPAOnhXnkkfAgb38S6C7H9LWPc1rYHuHaQuTc7lH5Iv/PCbm6V2UtnvY
	YPrm28nZ3TG69hPLJtsr6B1nz9z9CUqhwvPm78t/LpUwLghq/eItzzasIc91ZfuoG3NII2BYyxA
	CENmh9pEqCCTPZNhEN/UY94OYJfVbMHispeyugvhhFvV78xDwjspw9xDGHXTaT1jQ=
X-Received: by 2002:a05:7301:7c0e:b0:307:91f5:9377 with SMTP id 5a478bee46e88-30bc9ab99b7mr588995eec.9.1781641826182;
        Tue, 16 Jun 2026 13:30:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:cbae:d24:189c:2cb9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48bfa7sm20265356eec.5.2026.06.16.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 13:30:25 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:30:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH v5 2/2] Input: isa1200 - new driver for Imagis ISA1200
Message-ID: <ajGk5YxRTFycFc1G@google.com>
References: <20260512102445.55372-1-clamor95@gmail.com>
 <20260512102445.55372-3-clamor95@gmail.com>
 <CAPVz0n3Dw6Vtqqn8if=MYkBbYittXqsBKbDvrs1ntbD5Zn6iig@mail.gmail.com>
 <CAPVz0n3iCSeT3xJ2XkwZ6PYofwSLkc0gfm+iYo4xbKBkAtihcQ@mail.gmail.com>
 <ajDEsU8oZWT7KB9d@google.com>
 <CAPVz0n26H2t=pi_C+t8jP_cWXGSa5pk=1cpTZtkBh3=RQsUk2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPVz0n26H2t=pi_C+t8jP_cWXGSa5pk=1cpTZtkBh3=RQsUk2g@mail.gmail.com>

On Tue, Jun 16, 2026 at 09:45:25AM +0300, Svyatoslav Ryhel wrote:
> 
> I have tested your code on my P895 and it works perfectly fine. Should
> I resend with these changes or you can integrate them while picking
> patchset?

I think there was an update requested by Rob for the bindings?

> 
> Thank you for your suggestions and efforts!

Thank you for your patience.

-- 
Dmitry
