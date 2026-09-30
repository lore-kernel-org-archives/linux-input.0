Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8E363086
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745290; cv=none; b=Wwd7NH+IdfyyQjkyN2LYQuTevs8SehKTaHZWA/TLPtGEDcr6WyuzBd+DiopRzEXYmy8GHDXi6IlAypOPmMxS6ED/dfwKq02NVQi2DrVaKXm4sbgaIp+SCqcyc3C8viLmFE4GedVUYiuzGBxkXGjB6IoF1cqPHiQz1fO+ixLbtiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745290; c=relaxed/simple;
	bh=0DwyDbiXHFs6nzuVuyMWZLug6XA5RmgSBkppMkUsuCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUn1yqB8fg1sVSKQO763MwBW4gUDg355HoIKKdViaothHC4piIlnEeXUZjSEaY1hg+GLI0tjr0f6MAh3dlz91svMT7eb9XoSaaI8xITcCF1sNe9+KBlt25jarekeyZ9WjUMF+aIp0x/zqIEL8OXEZvvXEWHttE3TnLOEvmSef5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVZhn7VL; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVZhn7VL"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd04be87so1107030c88.1
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 22:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790745288; x=1791350088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9KLD/n4FOKEHxzSj3ZLLw0Kd4SGiqNFcDpZxx8Aapk=;
        b=aVZhn7VLDhvIy9uYubldd6aLLoQZq7CKJMTQcw2LX18Bcnidw6XR3mx4QYLup2+CzM
         0EBcOc2TkcSYnhT6QkP2kEczqQzst48BtafaylldFnNP/4P/xyJ3cMDJDm7d0bmKXYr9
         8e+gRjSVjUV4Bq3hlVM/mn68MHXEFfj5vPVtm5vPHjM1jmhx132DHouXLFO3iBlTDzHN
         cCTAqVSmJktilg5IjEhF//6t5RhXk5uJ3ozngGahkPVxsp2w6GCuvb7boU8Ms50ImPfE
         GisRAfpjrbKiORSvYnhIbC1HCY8wEFrArhzhIMXuvGpINj6ucXhqQMB7k4ravKQOFmNO
         t+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790745288; x=1791350088;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9KLD/n4FOKEHxzSj3ZLLw0Kd4SGiqNFcDpZxx8Aapk=;
        b=CsjgX761/PfZYGhYPMKo6yIEeWDQnYa+BQZ3CGyOPgO7mRNRNstgWsvSY9A2AqHmNl
         2HHaNN4YmHwu2nxHbEtEBx6szcxV66+0FEd/xkjWvbTQP5lF/3mn+hWL8ugWHbN1jxj0
         bgf3AUtzq7VIx3HlZqGPCgqtJnY4elah+1ZfXfyigl1dpkJ7zShGre2LukFh1IYudPgC
         QSw0QMRO3u/grY26T8Ftid2fYBS6YVMVxS6CeQYmxwG9goaTQBGa+nSIOyA7qqXX2OLL
         rfBQe3MooV/4XuLtBuuxgsjo2xEkGeLKXir9UZYXng4Um/Tu7vaGujC6doyqlZEOI7EB
         GGxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSpz9B2VrsYB56wo6eOmPMe6TNHBVjgwvhfH/awuFwO+KX1UjvO3fc6FOpdlh9ZP2K1kEMl10WGOjPBg==@vger.kernel.org
X-Gm-Message-State: AFuF++l6HCSLhXEznMyzCP7T1IOTp46v0LH8ejwFeuT5X6kYAVrQa5Ki
	Ph22lOcsFAS5uU03EdPMWZgTF1ysvQIeJFkhQxUe3rfjCXDmp+EMXIyo
X-Gm-Gg: AYBFou1tygQVWVoCmr/1A/UYHpiVvwWob4mPh62LzOjCzP88Tb16mXGTlGk/maEGntI
	tLZkmLL6EsdN6gZMMycOYOlv+3Vj9g06XDYYGPZJMdOSDxfG0BynU6Ie1qcU8do6TcMtdy9vHjZ
	IIU3WqHicpoF1mz1F5FW5Vm+0t1ijy51V4pOqHjY2FMdTUp1pFkGza3D2wrrqlH+VAK6cd6jbQE
	Y9ka8MVv0RANV3aZtTgf+AeHLadhCoI/6qX9M0XmCfJOE5RdG9GlmtS3rnN8WcBitgmXUzYn8Et
	LvryK6QEkNOgikhK358KkXL9UEU2PoT3FTaCoXAp8270Oh3ah+qlj7InpjnT0rdhIRDHOh9SnZ0
	ne87+I4nsosFxZHoxcfKZQC/XbGAo1s/wj7LuEn1o7QsiVFaXWYLsyFlC3tHTeYR+aj1T1aGDCK
	undjZJn8nGiYQ38TXfUFMZUzs9YRiaSNIRfivmVjGFGqFIo8+vJ87qUZtFWERV8vn+86G43EHBp
	Q0eVeCqk5DJwXPER/2C5A7iRd8N4sXXW+rqzeTM
X-Received: by 2002:a05:7023:a4b:20b0:143:342a:3d3d with SMTP id a92af1059eb24-14d2d8b8ac8mr124363c88.0.1790745288339;
        Tue, 29 Sep 2026 22:14:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:101a:5ce6:a15e:d8ca])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d089da7e0sm1218538c88.10.2026.09.29.22.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 22:14:47 -0700 (PDT)
Date: Tue, 29 Sep 2026 22:14:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org
Subject: Re: [PATCH v2] Input: s6sy761 - fix resume ordering and restore
 sensing
Message-ID: <aryaRAaXNJTv0yUG@google.com>
References: <20260926-s6sy761-suspend-v2-1-8f00a96ee6e8@ixit.cz>
 <20260926203744.82FAA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926203744.82FAA1F000FF@smtp.kernel.org>

On Sat, Sep 26, 2026 at 08:37:44PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] input: permanent IRQ disable on s6sy761_power_on() failure
> --
> 
> commit e5e3e44a0960351c54b4dc02894567b7b504952c
> Author: David Heidelberg <david@ixit.cz>
> 
> Input: s6sy761 - fix resume ordering and restore sensing
> 
> This commit alters the resume ordering to power on the controller before
> unmasking the interrupt, addressing an issue where the boot-complete
> event was consumed prematurely. It also ensures SENSE_ON is re-sent upon
> resume if the input device is already open.
> 
> > diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
> > index 0f24a9b730635..899c179fb2d31 100644
> > --- a/drivers/input/touchscreen/s6sy761.c
> > +++ b/drivers/input/touchscreen/s6sy761.c
> > @@ -500,10 +500,22 @@ static int s6sy761_suspend(struct device *dev)
> >  static int s6sy761_resume(struct device *dev)
> >  {
> >  	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> > +	int err;
> > +
> > +	err = s6sy761_power_on(sdata);
> > +	if (err)
> > +		return err;
> 
> [Severity: Medium]
> Will this early return permanently disable the interrupt if power on fails?
> 
> If s6sy761_power_on() fails (for example, due to a transient I2C error
> during resume), this early return skips enable_irq(). However, the PM core
> will still clear the suspended state despite the error.

It looks like the PM core never implemented properly trackign device
state and not calling suspend on devices that has not resumed. That
means that we need to do it ourselves. We definitely do not want to keep
interrupts enabled if powering up the device failed.

I'll send out a patch fixing this.

Thanks.

-- 
Dmitry
