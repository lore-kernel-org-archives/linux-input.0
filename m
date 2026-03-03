Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95138CFEE
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530563; cv=none; b=ZXYHG1Cfh789g8K2Q8Nh7cF8zvD75DssfiPEY8d5UPdpUlviiDibEFpXV6MPMlsRKhmXyn4E+/rL5PBboqLwB0H6LqnWClrwvS5zEGOkQH/JejdPW62No0ySs70xHVZ0IpQcMMmUzNaytkv2FkiUtUgUEZAQd29NFJ+zZZYnwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530563; c=relaxed/simple;
	bh=3eU9hNd8m5qr+U3hmvFaqItaVpUSdykad2J8ZLCwPlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc5g5gjSR6+bF0dZG3kDkb2yk1O+5psAiPWHaI79EnSdkTzVKCOf7YY5dTxquCXXeJHyMUWyOioXvKLZIoAXW4e3fk6Joqdu17gAOA5LDl1yELHPHfikc9ALA6rNGCW5RIbWXdAKy0snw2ASsEkrIBox7ziCHNkzxTw14r1gjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JPjgrWlk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPjgrWlk"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439a90f194bso2099445f8f.0
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 01:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772530560; x=1773135360; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fWlXK7iDL2mkLC3p31UigGL2w2fM43aTllKU01RV7mg=;
        b=JPjgrWlkkfeII10dScvQOuzQt9L9OwwuNKA8QBjlN3HFfvrMZB3UhTIQBBKpdzneq9
         S9PjfYhjZ2gIdjCYSGzjg6VFvxnsUPj6aosM95kwBA5dmrJWZ3/pA/oKEbGTwiC7rkNV
         fhngThRTr7PNi0bfNQZGDgcaLdNOhDF0mU9aUhcwjnEvkhd1hyqQy6pyI3xYMPHz2E9W
         kEYBXOAHwnA6w9yN0fyNkXUuHA930GO/Nt3aUpi8tyNxojvHM/mc+6y73T2FOt8x/CLh
         2PPOG2tFtMe5bAWvny+W2ljKluL8ZFDojZ3lzqc1uV3ryOoIf4VTqY1VlIF0mvmbA+/b
         Y4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530560; x=1773135360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWlXK7iDL2mkLC3p31UigGL2w2fM43aTllKU01RV7mg=;
        b=WkE0UKUBvw9LQPe4juyazON+QfNBW/xCUT/VDZVG7nIscpiNxBpTsq4MiWFzjk5NCM
         381pjgc6ePlwXURVDH05r2yrpgAyO9H0XnK+wC5Qq+qlnzR3PytlzNM9/gTOGqaB2PVw
         yatjlKF6IF1U2j1ns9OdTOqvCT9McbFzVeYJhwzvUfSoICz5ajABVVQ/aTfWPT+Ysozm
         JKoQfqW8BeXUvPIerIhYaXaojyoQVGgKucKDoscbOZr9Nhfw6KnlLxyBAzJvFwitiQL5
         /riOVWBqUnL8k/4a+hUVJ/qZn1mEKUu0S7pJPu/c9ItB8OqHydrAvjaygTWWbJqVz6JG
         Iakg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Bh5lngAh1vd/8PV3GCgwBkehmW7bFsJpO5R0VpSWdbPSwJDmL+qa9T+4yDF231Gag4UJb7Q/0Whj2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2q+6EEKwHDmbrN6cektLIYw7bm+H6+0L3Boo/nuawfqd0Icm
	asLDiov1S35i+sgNx5sS+TZTW0Etk0qZP1/HBJR/g4xAHCpcrdPcoq7MZYPRogjLyg==
X-Gm-Gg: ATEYQzxJrLoMFRIfpPAFV+cUJGbKF2gG+aE8qKtaprj0Ab0fd0gOTXb34ZYcrjIkeKO
	+PZqRmWpCwToCLJdMOV000y4WpOjqwUhOPwdtNwWCSH1CfcnbY9fzmxxjDjtT4Mcrb8WWfWAt4n
	cSJXYhQ2FnOMlU7dGd4vhq7otD06zN8zgjRGdzect34DTwTGiZkDzH9NPkHDxMEj6jm+GTPolTC
	JN8AE0tINEDEJRCYDWiOXxwv44RVwzi2tKTMObl3syTwuEtzj8VVFaaKdCbirbf7AzN5GX65FLG
	zkCAbhnc/j3c7CFYC1UzmlwfnLIcF6lAk5LkGrYGJ6dBWo+2/cGINZDG9N8xMACHM3cy60crMoz
	w42O06UzpRZe0plWDh9aJHooagGAZ4rLNs/QhS/qiIEPIQnjnhRnZGJG9yTsibgtCd74SomkXOE
	1DBOBPp57RGN9ihSrOrDFI8S5B/KW2laWYcXyDRf/vpuSWS+szKqcaej8/gwftW7o=
X-Received: by 2002:a05:6000:25c6:b0:439:c14b:2100 with SMTP id ffacd0b85a97d-439c14b22d7mr2143817f8f.12.1772530559523;
        Tue, 03 Mar 2026 01:35:59 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:728e:497:b3ab:6c9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c1fc577bsm2249223f8f.19.2026.03.03.01.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:35:58 -0800 (PST)
Date: Tue, 3 Mar 2026 10:35:53 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Lee Jones <lee@kernel.org>
Cc: Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: logitech-hidpp: Prevent use-after-free on force
 feedback initialisation failure
Message-ID: <aaareetB3Hhd6xgI@google.com>
References: <20260227100939.961011-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227100939.961011-1-lee@kernel.org>

On Fri, Feb 27, 2026 at 10:09:38AM +0000, Lee Jones wrote:
> Presently, if the force feedback initialisation fails when probing the
> Logitech G920 Driving Force Racing Wheel for Xbox One, an error number
> will be returned and propagated before the userspace infrastructure
> (sysfs and /dev/input) has been torn down.  If userspace ignores the
> errors and continues to use its references to these dangling entities, a
> UAF will promptly follow.
> 
> We have 2 options; continue to return the error, but ensure that all of
> the infrastructure is torn down accordingly or continue to treat this
> condition as a warning by emitting the message but returning success.
> It is thought that the original author's intention was to emit the
> warning but keep the device functional, less the force feedback feature,
> so let's go with that.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index e871f1729d4b..eee9ab6a2fc4 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4487,10 +4487,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		if (!ret)
>  			ret = hidpp_ff_init(hidpp, &data);
>  
> -		if (ret)
> +		if (ret) {
>  			hid_warn(hidpp->hid_dev,
>  		     "Unable to initialize force feedback support, errno %d\n",
>  				 ret);
> +			ret = 0;
> +		}
>  	}
>  
>  	/*
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 

Reviewed-by: Günther Noack <gnoack@google.com>

Thanks for the patch!
—Günther
