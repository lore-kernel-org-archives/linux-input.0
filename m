Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E7347BA9
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 05:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608585; cv=none; b=lUiMLpOC/QNfR1peFMSJeVo00MDZdFPdlagoBRpvAvBlX6mhtI6DgXvamLa4dxH0GELzXxeWT2z0qxQ8fC0UiTP3UDjk4/XCXmyTOuvJXGvxfK7PzMTglFm79V03Fb87ZAX8IO0BYGuR70uh7jMPijHTVRgJCxUs2JnQfct75Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608585; c=relaxed/simple;
	bh=hIt0fix7U4Ug7V1Poe/TVuBEz3XvwXLxdfPz6owQiu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilom0wkySxu66n8vJbpmOMdh/gsQdjjbTjncpLsTYjlAaJwxUIoS1KJRUv1npy2IrYzKj6qqkDU2uUE9l0bsb3scj8WmBKEop4CJ2Y1dqHN5we4hO/noFC9T4860qoyopYy1MZ6utI+8/PioQzfrsGlTrZf9PhC0TipyfqALI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=prbZfb/Q; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prbZfb/Q"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-356b1e20700so680747eec.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 22:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791608576; x=1792213376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DW/QQM+SN8lHBKI9RQtMNJfJ5uJuPnqwaUfrmF5FFDI=;
        b=prbZfb/QR+mld1NGDvDP6vbuY+/u7T9rqwetfq3GlpUxTTFaDIFWcJ7fqAu45iZgr2
         rTjhgYqalFb4m6sHlzWOtoQHWQCTDmGy3I9iNxNsZF1U6LiBCFg2XiAqdsYZ8m9/NYMw
         v+L8P1pyNBNgBF+OvPgSjOc/OZ7xjNHbV4+DAOujcRsJLY/9aCBlsS7e4vB8jVdLGBrN
         lyVe16htYPDiH6/x+YlZ8x2Kn1t6NXps3QqZh8QzjaEDemJj+iKKA5henMsq8EkijRZo
         vXTVGTqYJLg+ryhr4wfRYSGUoGCIWUkLzHR8JaxddEe4+Gn02GTKs96oK277o4gBByxj
         KWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791608576; x=1792213376;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DW/QQM+SN8lHBKI9RQtMNJfJ5uJuPnqwaUfrmF5FFDI=;
        b=OwyjFY2ejLThYVvRn2lWIObdVS7Oo5rzMkwx1a93Oa28h6s/qdThz0dSFIbKmaPqg+
         jxV+odTedY/Hy/PHDJDOUcV9tsJIm6zc1UzlGlNFNewfcqw147j2+SFhzF7c1adNTKe+
         qnMzOJndvcATVvgdVgl365MaZ0Qrubg0wtrTTi8+frEBFrozPaPFlsUJEz+oHRFbol/z
         7FjYqOH1t+diFO/rDOqO24glnjcONlRS6THLk/1J4LRL8JlZkUjtYm/mzod/3a2CqyCt
         isY0RaggA6iwDGgFZTdQacgywHpd1mkUqOu/M4vBzLM+ZkQS3Tvf5D1BvXmIIHCaz02y
         044w==
X-Gm-Message-State: AFq9FYIOqXcZwD2CYxn/yiXdm5IevsAu2nVj0qLMionmedkxwWbzn7Eq
	N1dgbEU4VEdbrUW2xMx9eIIGTuZladQisP/WcYaKq4DXIEN6h5y1EKZv9bGwVbPR
X-Gm-Gg: AYBFou2z6qz1ckmyrfUmhGSYqwof+kS4Da+zan9/ZJVGsgE9sv3ArV+5U0WsiDaAMFQ
	LXihLKUjlEW8FlGjWzEfM01HuYH2hu0g1/RyZZBcMcQ2Xm1tc3CuvDdiQqFMwB9uviF7iGuSM7O
	XwYAdiyNRNtx4Vlr19c+tUaypZPwGjLaMgMFERoHaGqMUHBi+KCHkygkbCV9jUX8Esn7TM2k5w0
	11gBWmWQw91dSAm/UNrA/FJEuWvKgftlFRv1kfDxE69oE7cD+2podvvvz0i6fWj4hxOwitFrxP/
	wNE35kKnQAaP/sQKz8OX7soVCZ04ZVQE8C6PujeDR32NgIQapCV0EJhcl3ZCkYzljsYG+Ds5kOR
	q3BgyMW/kh65NN0HbIaD0/Y1KALtMQWrVBwGXxvpSQM1wCadhjMJTJMO6QWYh85fxDCPc4kRI0K
	NVggJbgBZw9tTaKHd4twOT1R/ZxHT+1AYipI6zt9gAWlVN5+q7s6Tf5S1oGMHh8hQK78+fd/9D5
	Z4HQgWBmrNfepScznXJmxPHvPxFukG9LhRhK62Q
X-Received: by 2002:a05:7300:aeaf:b0:341:c383:9afb with SMTP id 5a478bee46e88-3536c59ed2amr5265002eec.20.1791608575167;
        Fri, 09 Oct 2026 22:02:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7ea:19aa:c6f7:8c02])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca67b21sm11045338eec.11.2026.10.09.22.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 22:02:54 -0700 (PDT)
Date: Fri, 9 Oct 2026 22:02:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: reject parent overrides on managed input devices
Message-ID: <asnFTCpEdMmOAK-L@google.com>
References: <asmCc1VxVPLIMgY6@google.com>
 <sashiko-outbox-166252@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-166252@kernel.org>

On Sat, Oct 10, 2026 at 04:04:42AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] input: newly added parent check breaks existing managed drivers
> - [High] input: NULL pointer dereference in input_free_device()
> --
> 
> commit 5c214b0cacbe95369ec05dede9ca4ab2c7e279f1
> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Input: reject parent overrides on managed input devices
> 
> This commit adds a strict check to ensure that the parent of a managed
> input device is not overridden or cleared before registration. It returns
> -EINVAL if the parent does not match the original device that allocated
> the managed input device. KUnit tests are also added to verify this
> behavior.
> 
> > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > index 78c10eea7328d..1cca6d48f5977 100644
> > --- a/drivers/input/input.c
> > +++ b/drivers/input/input.c
> > @@ -2396,6 +2396,14 @@ int input_register_device(struct input_dev *dev)
> >  	}
> >  
> >  	if (dev->devres_managed) {
> > +		if (!dev->dev.parent ||
> > +		    !devres_find(dev->dev.parent, devm_input_device_release,
> > +				 devm_input_device_match, dev)) {
> > +			dev_err(&dev->dev,
> > +				"Parent of managed input device was overridden, refusing to register\n");
> > +			return -EINVAL;
> 
> [Severity: High]
> Does this new strict check break existing in-tree drivers that legitimately
> reparent the input device during probe?
> 
> For example, looking at da7280_probe() in drivers/input/misc/da7280.c:
> 
> da7280_probe() {
>     input_dev = devm_input_allocate_device(dev);
>     ...
>     input_dev->dev.parent = client->dev.parent;
>     ...
>     error = input_register_device(input_dev);
> }
> 
> Another example is tps6507x_ts_probe() in drivers/input/touchscreen/tps6507x-ts.c:
> 
> tps6507x_ts_probe() {
>     poll_dev = devm_input_allocate_device(&i2c->dev);
>     ...
>     poll_dev->dev.parent = tsc->dev;
>     ...
>     error = input_register_device(poll_dev);
> }
> 
> Because these drivers explicitly override dev.parent before registration,
> wouldn't this new check unconditionally fail with -EINVAL and break their
> initialization sequence?

No drivers should be doing such overrides. I already posted patches
fixing it up.

> 
> [Severity: High]
> If this error path is triggered, can it lead to a NULL pointer dereference
> or double-free when the driver cleans up?
> 
> When a managed driver's probe fails here, it will typically call
> input_free_device() in its error path.  However, input_free_device() trusts
> dev->dev.parent unconditionally:
> 
> drivers/input/input.c:input_free_device() {
>     ...
>     if (dev->devres_managed)
>         WARN_ON(devres_destroy(dev->dev.parent,
>                                devm_input_device_release,
>                                devm_input_device_match,
>                                dev));
>     ...
> }
> 
> If dev.parent was cleared to NULL before input_register_device() was called,
> wouldn't passing NULL to devres_destroy() cause a crash when it tries to
> lock the devres list?
> 
> Alternatively, if the device was reparented to a different device,
> devres_destroy() would fail to find the devres on the new parent.  Wouldn't
> this fail to untrack the devres, leading to a double-free later when the
> original devm owner is unbound?

Given that drivers should not be doing it I am not worries about this
case. They'll get an error message first.

Thanks.

-- 
Dmitry
