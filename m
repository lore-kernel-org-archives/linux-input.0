Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C11624C0
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771037791; cv=none; b=JoNWkScFmUsheHsZjUV+b9TySiBNbWaYOArkkUmo6NW66ELoPEG6RcmsqTe3l60dSea48t8poR2mav1b9D5LOo2tQAeVsF2iOcUOZPXpPd9P1Iy66T6BHaY4wuAoHOgSr3l8PRPDhQTdKrpSU4Nw7bxayUaQhUUJcXLO1o56n1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771037791; c=relaxed/simple;
	bh=KTDGJVYmDZSXfP/2WzJDnslgbBTZyGYAswRuq1RR0S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHmiRdknu/5Ju/5zRjPJJukSwucQ3qr6AdgTG9JcVhwKMiN0RGw6K+HdbQ6ai5kmJW7t7u/4pvvd2McfCj1DCPxzILkbv6CqZjeFW/mKzZb38S+E3mMuTjuAyuhvyr5fPgQFiQZsEfSXvq3QPkrb93UdhFhUipkxnV6pm5wIRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOEYenhf; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOEYenhf"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso3064577eec.1
        for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 18:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771037789; x=1771642589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4OOYCvwfV/ZZkqRNanf+Wv41fObk0+e62UXZX+6ZZvs=;
        b=fOEYenhfzYm+IyYCSEcYT+JgPVzCoN4RBtlrnCgMg+hCOahj0/6XuIrWw341FqXqVL
         DtlUtF+jQs05j4oIVoOZJSxR0BWt8Gw5HVRCGSEIUak6KZNV8jPRyt9LXiM3fFllIC7f
         vSUR7jb8Z/qrD0PNK//skJDSzXQQwGb/oJc1v7N3dQj8JJqpgvhowJRF5HbpYEKaoFe2
         5F5wPla8RdVM6L65buLYPGdxxFZMyaoeeOvpWDXGFcTrACiXy0Gy7RlQFCUulsg4TAlu
         rQ0EWRX5cFGwEcBsTc7h2d3rQkzjPV97fCR0BEl3TDP8nxPE0bdTPxADS8tEmU2vKuYR
         wNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771037789; x=1771642589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OOYCvwfV/ZZkqRNanf+Wv41fObk0+e62UXZX+6ZZvs=;
        b=BWpvz0jNo2c/cJEtifF+VmrFQbf+FHNHhcEySNBKmnx2UNkpugaPoYR6JSQT4kb1jp
         icDp8oAK5cgZmR0NW+AboDVJxm4g/esYky5c1z2UZbltVys37xCQOObVt7KJcmSz7Xpx
         ACzePoZhRHHvyg0Gp6f6mg7DlP4ndq7Ilg1ZMpy1THj6rD0pwiQibwltqp0k57bQGY8V
         VJZmXDb7lv9bZY2tEk+YTwGkbBvCQwzz5RC45IMPWLYAGH6GnEECLJ5Ib4VhSYm6YbGI
         y2IQSx0CbqLZSUarc4cmadnCy8CQqy4mpyXV64ooO3TC7O5Qr18bQgeDSrLjyxtWSyVY
         oRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiojafIXdyymeUvBSeau5rd+sOroxYqtCMfDhmgG82aY8oUSIBvBO4W+wHH7rK+czTGio/ixOwOaN9dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXRxjx/nlLABl/EQoWrdwNHugYsQQPBiRd6zlWLqL7Vq9BMfjp
	3jyNgmrlTQjzwQqNrjo1Rd9AtDbpS7ctOmnFSHks9TKOW2y0cSEZmnun
X-Gm-Gg: AZuq6aJpCO/0Ix9ymsKNQEzphoTucfdy2agKgUFe5tPFFnlJJgNAxW1ObUHeWQZ8zAv
	wzRSLGu2qZtqxLzwcTUe5Kqs4tJzGVmiuDwfBdhIJSoAiZKoGIizSXpOIoLg5EJqJQShR5bmNsK
	zRhhWhKRQE4WshNBJU3JdEkXzC9Tw6IC+/uEFTTjKdMlPhOaTfXMDZwzwJTkQMCmWy1J9gycx79
	3k/06z7UzWAuE2EGqeB1tzsOSw5LrWcnMJEpp7WiI0EO8ikGKtkq4+Q+mFWiyDvz79cb5/shNwq
	B3Mtg0fQpBs7EWnm7h2wEJYhh3AArsoxK7ZtuPV8OBJzkPfJeGntkEKhK6mzRjjrImTO4TkxPpT
	WrxM4YSYzBbnwHwH38/NgCh63MsMHPw879fL9eDUmTq0BUDNwJ1kXHVy4AkPC5c8m470yKLqE8t
	l2l1hWt32liDQQK1qZmKtYxsCCCEImZotaFC0Ia8OoYRRDzOtuS9csKS4O4xN0DHDSdWgct5Fnd
	88=
X-Received: by 2002:a05:7300:dc91:b0:2b7:f522:992f with SMTP id 5a478bee46e88-2babc3ba41fmr1324474eec.10.1771037789323;
        Fri, 13 Feb 2026 18:56:29 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:b713:5e7b:5963:d2ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb669f7dsm590737eec.23.2026.02.13.18.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 18:56:28 -0800 (PST)
Date: Fri, 13 Feb 2026 18:56:26 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sean@geanix.com, Frank.Li@nxp.com, linux-input@vger.kernel.org, 
	samuel.kayode@savoirfairelinux.com
Subject: Re: [patch 1/1] drivers/input/misc/pf1550-onkey.c: fix build with
 CONFIG_PM_SLEEP=n
Message-ID: <aY_kM08DusJ7Y_Zf@google.com>
References: <20260214003828.BD1A5C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214003828.BD1A5C116C6@smtp.kernel.org>

Hi Andrew,

On Fri, Feb 13, 2026 at 04:38:28PM -0800, Andrew Morton wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: drivers/input/misc/pf1550-onkey.c: fix build with CONFIG_PM_SLEEP=n
> Date: Fri Feb 13 02:39:04 PM PST 2026
> 
> riscv randconfig:
> 
> drivers/input/misc/pf1550-onkey.c:154:12: error: 'pf1550_onkey_resume' defined but not used [-Werror=unused-function]
>   154 | static int pf1550_onkey_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~
> drivers/input/misc/pf1550-onkey.c:133:12: error: 'pf1550_onkey_suspend' defined but not used [-Werror=unused-function]
>   133 | static int pf1550_onkey_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Picked the following fix for this:

https://patch.msgid.link/20251210211149.543928-1-vaibhavgupta40@gmail.com

Thanks.

-- 
Dmitry
