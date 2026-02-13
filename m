Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47E20DD51
	for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771016424; cv=none; b=DsNRD6Vo3EXLh2gvRPIfuJIzTiSTstwEY+/NqwCR/JaTSohjYHkiaGIZgdS1DdoaFpeWRZEHw/s8e210UxpRT/i/y9J+v5o6kfZ1WOyC3eYOZRumm2mlbIQdmyOaAsC8Sozi5UD2Ap2WRMjKadIf2EC3CGvv4gqoFREbkSczvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771016424; c=relaxed/simple;
	bh=XqY77utnTjeKjGAGOCShWw4gK9y7YIyb6K5GIa/I3cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKStkp1G2d6huL3qrryivasXx7A9az5r1kqYyJKnOTLcqQ3IzF1Jv/i+ZHrgVQYfMTuPQpGDFEvhW+Gz7rsj7IDcIx0XVRIMDaPwUWQv8P6lMjtzzMfFaXiyE+x6bBgur8qhhXtENYJIBp4eb9fjWCvhrSAao/pZjPMdrjeM2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R85ycps7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R85ycps7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f8f2106f1so182031266b.2
        for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 13:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771016421; x=1771621221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5LwFazFqO7Yhvy+r7pTbMMeAbTSBIla9YuObeGFCN4=;
        b=R85ycps79f4nvF0LX9iG8D5IpBJ4cddnzz3Badraas5uRTDU0Y8yyfBprdQ1qmzA8P
         0I+B4qZvDtS7Fi0y9fbrQJg2hb/aCX3Bj5fm8IHEM2Pah9alUlziaIKIfqDOUSz8ZwbO
         EG8r5qTs9iqXNSL6mRP5SPyqGn7nMWs0K99iP2JFWBuiLHJqhLxVdYbB3SmJdPjKPzqz
         v2epvp82/JHbGhWl23d2brfrwNf6aLZOzKLIy/rePph1afikMqshhi19kvT5Z78+DY8+
         NPqTQvbpZgmkkqypvVA80ZZS1c0rVpDCvZay0iHop0BYGKMrtFYotISiV0GQ4QQtacdC
         4bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771016421; x=1771621221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5LwFazFqO7Yhvy+r7pTbMMeAbTSBIla9YuObeGFCN4=;
        b=eAwEdsTdIgihQMzg+94iaSTw3HABSQtzrF8KHZy1jFmGy0ehkoCVORDZsalnkviXWs
         hWfvQylj3RIjkVr+ETjJtMaH6Z6VrbkZQku63VEVVhulEakezxhtFnHIfNLsX3epSkmX
         usJfRBNZROEDQmnCe9HYKzUhvTnbNDwxA5PwwUXVWVYGRuBLk3D1IoaSAgB6wzKMA5uB
         VUIuAc2exr4a1LyWxRKF8oGEda3F284CrvJCyuwn36XwIxGdmmfkcO2sgjG2of2hihHM
         NYHqJY72BefuJSGoPFt/X8vyYRYoQXgHIMj40o1qb85gqeL4baH1Rl8cXGym4uUgQajS
         8lbg==
X-Gm-Message-State: AOJu0YyHMG6hzXJKgBVh/0/jG3mss2uspYU+q+zmPEa0L09rpmeth45E
	x9mT1TgSyO3d0LNwi6aVd6yDe8YNe8lvtD4lQJ8L+0vAF992x+ktd3qj
X-Gm-Gg: AZuq6aJNMtd1BwaHOiQshVOxJRlA9LRzt/u0cSctMfZcqK1LZdseqRymnZ2F7KUp3vK
	xjN3PHs+nMNk5U77/xJY/PXfXC40PcVetwXZpGnR4DeM5gtQ2Da1fwgQUPS535q1Ayp0EkNNFIK
	tzNYzB3T/tRe60rFQpZXnT57uelgX/GhH0W+dMHV9Am1ZhcJQ2kQbwmXr+4cQrXwfURUEpa3WxR
	8H5EWInNRBcMIdogWFFr8qlxRfJ/iv66I/O2bEAW44o89NodyLE55QaqIvGtZLSSTGSHuOv/owG
	/G7i5XQIfm8BOHpDg75YchKTzR3IjjyLJqfp1jZWXicVOFqL0mM6UEJYYV1Hyjp6hZEjGZq2O1g
	tqlKQ3WzeIB7tcnso4go5LXKz8P4trD0PAyJNzAke7cIwmyE18XZ+a4+DVNoLmSzNMN5J8M0wxH
	gYBxjPv+g6h8D0qg==
X-Received: by 2002:a17:907:268b:b0:b88:775c:bd68 with SMTP id a640c23a62f3a-b8fc3b6e571mr39956966b.28.1771016421192;
        Fri, 13 Feb 2026 13:00:21 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385e60sm1689666b.19.2026.02.13.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 13:00:19 -0800 (PST)
Date: Fri, 13 Feb 2026 23:00:18 +0200
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH 4/5] input: drv260x: Stop waiting for GO bit clearing
 after timeout
Message-ID: <aY-P_VyXDfqbm83m@jekhomev>
References: <20260211235902.4156624-1-jekhor@gmail.com>
 <20260211235902.4156624-5-jekhor@gmail.com>
 <aY4OAw_IMeta1z9e@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY4OAw_IMeta1z9e@google.com>

On Thu, Feb 12, 2026 at 09:34:51AM -0800, Dmitry Torokhov wrote:
> On Thu, Feb 12, 2026 at 01:46:54AM +0200, Yauhen Kharuzhy wrote:
> > If something goes wrong during effect playing or calibration, the GO bit
> > may not be cleared after some time, and the driver will get stuck.
> > To prevent this, add a timeout to the waiting loop.
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >  drivers/input/misc/drv260x.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> > index f08a3d6c3ed8..f7bfac6d3973 100644
> > --- a/drivers/input/misc/drv260x.c
> > +++ b/drivers/input/misc/drv260x.c
> > @@ -173,6 +173,12 @@
> >  #define DRV260X_AUTOCAL_TIME_500MS		(2 << 4)
> >  #define DRV260X_AUTOCAL_TIME_1000MS		(3 << 4)
> >  
> > +/*
> > + * Timeout for waiting for the GO status bit, in seconds. Should be reasonably
> > + * large to allow long-duration effects and a calibration cycle
> > + */
> > +#define DRV260X_GO_TIMEOUT_S 5
> > +
> >  /**
> >   * struct drv260x_data -
> >   * @input_dev: Pointer to the input device
> > @@ -339,6 +345,7 @@ static int drv260x_init(struct drv260x_data *haptics)
> >  {
> >  	int error;
> >  	unsigned int cal_buf;
> > +	unsigned long timeout;
> >  	u8 id;
> >  
> >  	error = regmap_read(haptics->regmap, DRV260X_STATUS, &cal_buf);
> > @@ -442,6 +449,7 @@ static int drv260x_init(struct drv260x_data *haptics)
> >  		return error;
> >  	}
> >  
> > +	timeout = jiffies + DRV260X_GO_TIMEOUT_S * HZ;
> >  	do {
> >  		usleep_range(15000, 15500);
> >  		error = regmap_read(haptics->regmap, DRV260X_GO, &cal_buf);
> > @@ -451,6 +459,10 @@ static int drv260x_init(struct drv260x_data *haptics)
> >  				error);
> >  			return error;
> >  		}
> > +		if (jiffies - timeout <= 0) {
> 
> time_after()
> 
> > +			dev_err(&haptics->client->dev, "GO timeout\n");
> 
> This should be a warning, not error, since we are continuing.
> 
> But actually, shouldn't we signal an error? This is probe path and if
> the controller does not ever signal readiness I do not think we should
> pretend that it will work.

Sounds reasonable. I got such a hang when selecting invalid mode/library
properties, and yes, it doesn't look like we can expect correct
functioning afterward. Will change to error.

> 
> > +			break;
> > +		}
> >  	} while (cal_buf == DRV260X_GO_BIT);
> 
> Thanks.
> 
> -- 
> Dmitry

-- 
Yauhen Kharuzhy
