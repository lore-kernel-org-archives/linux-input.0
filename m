Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207404;
	b=vtx30fNgqDM+MmPQWjfWrhWk7G/WPf2a+FxQXiRxn7worAe/ugwcZzmf719Rb5voihzh
	 tE+Vje3KLWXVu0exfmO06qMxjBGUDzNxjNPTrSVbROP8MibS8T7wGOYy0jGg1Cw32NWBD
	 GydogV6/4hSxvMAGOOoLiHOrSKbdMVOkMIimFsiDdoE+3pjgkea5RlqM1mR2+WWnMV4Yp
	 MNFkPpXmoXWtlZ9A2BBSGT0Luv/p2fT8ZGIP9RQCVfljRrfTt/sCSYI8kkAMydSC+AqPx
	 iZkHcs85nGtrWn1mH52lt82Kul3YT+gjZfjmdkVDfJVDVpoewBj2DLnRQEOEyc963/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SzNNzVDXWgiSV1/YGhcZlrCyI10PMQDXKdaQ8ngsDPE=;
	b=ZAET7qXBqUwjSXde3cQIjH4UotZ4eRpn3FbsSLGXwowAZDO2LF3ahNrAaPXSWHPJR0md
	 0fABQ+ghNPnjNa6XXnxq83J+lCxCZ1sVAt98rlApS2pH2aDlc+XCC7qupaTPn88P/v3L8
	 CTXJtM5lwbmwSjrFmZ5+jQD0sFOW/Qc0+NLFDqOZ3Z6z4HX4PekawILj5Z/7RMSik0v/T
	 GrS3Z4kJ21UWayCvMZn7oNcYnfJdBCkow7mfORZK1/kMdEkTlUdWb17labkfAuQi+AXrd
	 3PJ5vZOdZSiMa9ETQwdE2N5WS7NLLh7YPgwPQobajd8PRgDwYqVQlfnGXQvlRqJw3iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y2+CUOiK;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580E606A321
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 17:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4580E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y2+CUOiK
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535a54bed9so1771918eec.1
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207403; x=1793812203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzNNzVDXWgiSV1/YGhcZlrCyI10PMQDXKdaQ8ngsDPE=;
        b=Y2+CUOiK+rdCHsUnimafxxE1iYgLSjGd7A0Bzh16RaF+HJWB7N+oQ1579sakDOI8A9
         RA0RA0HmXAK5PFAp721QH8n7yyLReE9WgWZwNEloKPS016ZZ9zqDgQHhVWp0Ow8WdCIJ
         bKandakugFBx4lNGYX96JfJaXdm/2MLToFJ1I3GCTY7MuPySCg9WXFbuYYsPRuxVMxdb
         nfnFMy5ErGAyAIGG4s6VQUk4pb3Z9VagqaGYuANDVPH/KJ95uAjn0kv6TMdCv5oVl1fm
         2LHV9/I5uAESzr7/HfnyiNJcfUfWWLWfJfKQWM94GoPzh+rtCOWeDAq6eSdFu9Tg7cqp
         eJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207403; x=1793812203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzNNzVDXWgiSV1/YGhcZlrCyI10PMQDXKdaQ8ngsDPE=;
        b=rDNV2T9z9tQSwASoebKHgY+s7W/HgvWREPw1/A9C62XflF0DYLuAiq2zzTYu0W8NUK
         mUEjhqkPfkKzZNEnGiL4RAa+R3iX1kzYgSINex5B3SKq5e6yfBhs6hQDQqQ+dkLeDDYW
         p5M2m/v7JTD7se+MZ7cVj/vjdryZe5tpnbV5Bfb4L05DvcxF6Zz6t+vOWOpXtIR0qPXY
         IMRSEPCt0DQaOIJdxah8mdngLfX6uBIx44d137t8OJ3HitpgzgXFbqPFq3RRwsd9pc0t
         85UbB479cNNt9mQKRD4Mn58fTe4Mdy5U+tczrINHrQfr7s5DjqligdqDvGOp6qFjovQp
         yiaw==
X-Forwarded-Encrypted: i=1; AKwUvBzkfgEeDBjR+pUl/s7AtYyHop3pqQfTKvBirOfjCTPIRsCnTYmgttCGXu7UyEKFdkixipQl0yV9N8Xiwg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL1cH5te1Xjejn/YMqNQbfzOig1LEa+QHoY3XF33bs9mCjGMkyL
	tyC4EsXsSo7lGKNcajh3kEakDNjMl/lM+0cby2OWRTE5waXpIIkFA8/jsB22FA==
X-Gm-Gg: AYBFou2GG2+UkT8qxZYF/tiu4CDRzvzgz0cf12UTrGNm8b+TnKkZJWZ0/SBU4z3oSyy
	siHe0Gz6LxZH9PeqKOKl9c8wUWZDluQ2lmkLQcmNpeBAE0IzAzEx3bqzemiKnH9jJ55jI3x/GO7
	YMPmJhrfs6B8GcBHsu+pCAJJX1G3jPRJvGM7RUJSAl5vPETE9bk/dEN2OfaMnAdagiEWzTxE+s6
	GEOhNfR+vK2YWHXHr3v9tyPRj5+wiVt6vfAMdlnlCnnMWFBrL/BNaOy6Xy9Oqn9vFNzfSQmYHja
	hAeRW0E/XFUEroS0NMHqBkHQhFTepuZEed0vWyenlt7jAjVmX26cOCisAWZBG6+/XH/qh63G2dL
	Re20WUTiciywaRZpdnTFcQqGUWjrms45XM26YoUl4BwcbYLP/whHbGkLgOXJTRAzHbdcuY+1Gna
	mnxM/ZapF8BnrazNmEbHIikagIiFrQ35CejVOVIz51mU4//OvNHYDxt8bbfinZDcm1XqZXfQeom
	v9odjJnslY0ECuK7GF/M18XbudjOU0JoklUjdnAyczQtGwXQ9UQ1opN4ubx80UHTlmc4Zmlt3YC
	o++UerAiyt7cVQZ4j2fhoJguQ1aHJbVoGYsemnbS+ngbXfp9Dd79D2WcDBsveHL6yeaYH24=
X-Received: by 2002:a05:7300:e9c4:20b0:36a:13e1:c889 with SMTP id 5a478bee46e88-36a20427d57mr4718660eec.36.1793207402170;
        Wed, 28 Oct 2026 10:10:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:9958:9525:7799:82b5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm12474280eec.23.2026.10.28.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:10:01 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:09:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: serport - defer write wakeups to a worker
Message-ID: <auIsPu4hA0f1SpRX@google.com>
References: <20261028-submit-serport-write-wakeup-v1-v2-1-c05d96259985@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-submit-serport-write-wakeup-v1-v2-1-c05d96259985@gmail.com>

Hi James,

On Wed, Oct 28, 2026 at 01:14:19AM -0600, James Hilliard wrote:
> @@ -54,6 +56,11 @@ static int serport_serio_open(struct serio *serio)
>  	guard(spinlock_irqsave)(&serport->lock);

I changed this to scoped_guard() and applied.

>  	set_bit(SERPORT_ACTIVE, &serport->flags);
>  
> +	if (serio->drv->write_wakeup) {
> +		enable_work(&serport->write_wakeup);
> +		set_bit(TTY_DO_WRITE_WAKEUP, &serport->tty->flags);
> +	}
> +
>  	return 0;
>  }

Thanks.

-- 
Dmitry
