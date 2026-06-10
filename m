Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F135D1A08A3
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131766; cv=none; b=Ktg6Q2xhixAID8ESi8T8VBp5Ah3xlqlQQMO92wle/YFjYKqGH1g37KsUMbEFRAwWzoCz2y7a10X1z3KytEYt6JnWU3t7JuAjY63SARTMUxkur9ot+zvw8Wck/gX0h6yiTA/e+M9pwBKrKx+7hWGK+FiLrsQ6xYnvsCaBkgAW1k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131766; c=relaxed/simple;
	bh=1PEvYimnnfu6ohlckfJTtchNHDrtL/9OzpWiqGX9eJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ/I8a5I0ftyglmVTfgM3PHr23HAhacZOtS18thF53abXcJMg5dN7oqnhvMD0AxdG8IRpdF3qS31/Yl54DjLNunH4jm2f+gRDdWT3UFqrtaudtgm/RZMuPW3LZ9DSt3szTrthkOZ5LXekKdTJi/eqd+1x0QUHqRVMVbP3tmp8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4dckmNC; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4dckmNC"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137eb0d76beso262042c88.0
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781131764; x=1781736564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRNR2mBBmAJgE0gr5kmnJQaoZqFLdnUhAYZlZp7wX3A=;
        b=f4dckmNCmGB4iMyC1tCtDHFNSBBSmUFzxKQeSMoAMP2KTnEyYvD+b0ggqM7kWN5m9G
         bkN4sEvpRwoqMAZQZHrsnoiyK02Vbmoj9UFdO8gvbhrNr1hH6MAqCSsNUDBiHBPu4GnP
         XxSTeJkuXLOE0LT2sa4wKUStGwQ5u+dyhFYzbdlzA0aBe6KdSUq/f1rXaiqbZ87Aakmy
         wl3jH71y55yUQ8l6zvh60VQMy8UFMZiz/hrlb/vWs3P38Yf+mTAkDCryeQOZ9rlX6/EW
         FAPk71c5zXNrvkL4gk6xQh6tOQMePTkdc9sfj4GuBdavBo0LIMmYhTVzYGAb6JtITBhP
         a4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781131764; x=1781736564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRNR2mBBmAJgE0gr5kmnJQaoZqFLdnUhAYZlZp7wX3A=;
        b=aTI0HIZgzwPKNeWUw3SzRGJNS7hrGEUsUvoVi0l2GlbMQRZIivoyYTpWKAjoVH09HU
         qom8IwJudPP2r/FSDTwr79Ov9t+Ps+AgVTgz14Sv61tQifCgbbxK6hgvw1iTbO8OaJhK
         /N3IGj7x3yG2PTQKkge1vEaNd0KxDOlcoNpOs840Co4bwfHBJO0TYprESj8TVI1XGO8H
         mO/nI+6gFeMqK0P5150xJlMV38M/11cOE0BypxZ2itivqoZgDfUe7m5gPRe0EOXmazy3
         kP55yZbRrPajfsBX27jMYRrO0IfuEEEj65b4zCPjLDp4SI2YPBMI5sts9HQc9SqA7uDc
         wU9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9zda5DbTVTLkupj6TMwB4m+VMu6d+bh7Wgf3O9TrL0e2qJCtqWcKuJkiuYPWitGvuZiPhibFrYtILXug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUDi06ZvaP7yRYF1abWaUprZRQLpl3Ck7N7kr63lVRAP9PRN+
	0F95gQJOotc5AqgYnPJgK+KGxXTcEstbM0kohdy2O8zK0yuOdQvi4RZQ
X-Gm-Gg: Acq92OF5E2JUBCrQkvISayFGWt+cvt2hC9HUX12UONtrxI9Z3OLgc65xxWd1fcEMjBc
	4LbpCOQ9YQe10R1iw98AW2ktHSeGQ34OGB8AOLwlf09h/bpjivdxV3RnnXeNxVD5evydfTVHFK1
	XpRiIQjoxlzy0CAavPjFYd7UvApu5fGfBH1DjDbQgYewSxsuaOhFQ3MteUnvMq2CZoda12HKM/3
	/paO7d5mA81PddlOFB2a9smY7NEW1YN7QCiNugRy+JCZuaOab/+9Fk1bCfD9apDgxqwm3SuAizW
	wEje9frMZtjqpeo1rUFdcWjNOqYnK9YUPwzmLuUqp1zUYz/vau2pibxY5gL0wPsx7Lk/BsT5ED5
	2Ak449y5lS793eVoQ8FuLcHmnOxOgt4n4AWp2GrhPbTBLv1yV46aY8cUEVmJtD76itEGMJOjXFS
	1ji/VMNpE6ovF9+tu86AT+qSZN5W8KiFRCpdpZM5InMKCmjI3/BSZpIaThUOZv71WS0vlS8pDms
	+w=
X-Received: by 2002:a05:7022:411:b0:137:24c9:fb7a with SMTP id a92af1059eb24-13842e261e1mr29648c88.2.1781131763957;
        Wed, 10 Jun 2026 15:49:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f548ade9sm19216733c88.2.2026.06.10.15.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:49:23 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:49:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Kris Bahnsen <kris@embeddedts.com>, linux-input@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, Marek Vasut <marex@nabladev.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ads7846 - consolidate coordinate filtering logic
Message-ID: <ainpywl0lj_K2_Lx@google.com>
References: <afl3WtbabMFNjE24@google.com>
 <cf9e30d8-f51b-4a19-ae7d-914e6bccb265@embeddedTS.com>
 <afzo03UP-shPfNMe@google.com>
 <aimsXWeg3wouoiB9@darkstar.musicnaut.iki.fi>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aimsXWeg3wouoiB9@darkstar.musicnaut.iki.fi>

On Wed, Jun 10, 2026 at 09:26:37PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Thu, May 07, 2026 at 12:35:04PM -0700, Dmitry Torokhov wrote:
> > I think if you pull 'next' branch of my tree, then the following patches
> > seem to apply cleanly on 7.0:
> > 
> > c68bc840f06c ("Input: ads7846 - restore half-duplex support")
> > 011bdf9f3a9d ("Input: ads7846 - consolidate coordinate filtering logic")
> > 
> > I hope they also build ;)
> > 
> > c68bc840f06c should appear in linux-next soon too.
> 
> Did you forgot to push this, or was it dropped? Because I fail to see
> it any any tree...

Well, that explains why Kris could not find them... Pushed out.

Thanks.

-- 
Dmitry
