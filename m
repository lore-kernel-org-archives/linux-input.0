Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793648DB49
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174615; cv=none; b=c1Tjfz7Qec/NnOpXjQ2LkNmjgD+H9qKiWo6N99a/qU7ppOna+IS14AZdv64Upx/clV/kdfyqIc+hl0S+G0l9CZ+vNHxW/bUm8aaOGAMgXCxqCeX6RXVGyfaU6JV0BV1c0eo7JjYVI0zzLBoqC8DQR/W68rSlD7zMcqkDR4O73zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174615; c=relaxed/simple;
	bh=jwx6jBRjTpzEH1P7oEb4BrgdmEHEUfzaC8Bp/2eitdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOR6pUXgGCMg2ObPrUTa94xSQ8U8phvKKPXbjLNlW3ED6itjN+I27ggkppXwwVUwKqDOmAEribSKxGJDFbeoPiHe6t64yLc7STEQ1Hgp2uA1Lu/oXBDj0nP1cfIFq8oE97nzZ+e/DjpUm2RcIGldhHf5VPynlCWBdu8ae/Cf+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASm2gonr; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASm2gonr"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-17bc533fda3so229407c88.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792174614; x=1792779414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3p4ECn3lIOQmDtAocqLgwI+XAjA3TkgnXps1pr1IWI8=;
        b=ASm2gonr2srwmHZjJvEg8jyrSgmVXT47ylSp5KoTE0CRVQuRLb7udDY1XqILS+qNsC
         gDCyD/5oRbUAKtqchu3Q1Sq3nTbiqp2JKjRSX5XWGG080MUDowplbes2r1X0EUs1l7i/
         zi3o4A9CD3AQIYMSLvYnoK9vqI+bFL0pD2EqFfLfN0cTC8XOTCKpMVaAX0PNiFVeIIRb
         aODDy08B96IA9T4LCT/m3lHi6oFJ6RwPWVZpWMBJjpMxXt4YpTqcMIRT6tSUusVKWcS3
         Ymtgeaq+ZlWZEUIrglrS+tUQ+786C9gW20kEzFgZ9XTjbeu2DOjhladWkXfLr0njgzM5
         bfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792174614; x=1792779414;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3p4ECn3lIOQmDtAocqLgwI+XAjA3TkgnXps1pr1IWI8=;
        b=CGE7wkP3YhO1GtM9P1zUn29jwbsUELFwCcZsQC4oES8TmEo1u5JgB9VIgD1wOwH6NC
         ztHm5Jq++p3F/FijjNguL8ZDkbhpAHmVuHql2Ni3yOKFlMB9UwEbSyEDEoZFdLJeGPjB
         YBvulfZcxOL+nzEE0/XTy6p4NPmhLT+wkWks+//wyWjCKTxZIVHcZSq2cNEBB2dDGK3c
         G6u8Wj+Nh6LyVk6s3vrduOT6XbSZcBKM2GZUcaSGQbJXbUqrZJqxNOSCqPKUqX1Txjc8
         JSc9KRpjmtNIWFUk+Dp44A+mq0QCB5iWCMRkh0BQVfZWvEmOIGVgAfGC8Vid5J41zuAX
         ffSA==
X-Forwarded-Encrypted: i=1; AKwUvBxGZecocEjeUxrDnxMRgFUme2eSb9E5DXRuvQLyMwobDm/u6Uq7j6duiu6oEczjAXG/0wpfhHM/28WUYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmwkJOTGYOcT//LX1CF52nHVy2YjRPDUQCS5bDJFgBfzHtNkbo
	DlQqcFl5dUOvnUxga7hGfK9maVx9xFs/2ydjmPQWNlyFKH7K2MB0B4nY
X-Gm-Gg: AYBFou3ioYhuJzpUZagz94X2QgRgRDx8BapzvxyKakhYuIuiFFc1JeftYpHCEwy0LQx
	cdOweDy567J/64yoxQ3soOVkT/FGfcz//x9gbRo7zxd2NnWYngE++HyadfCvS5arLwOArexssDr
	mVeHmk+4FKwQFX4Dza6FwhJyauv/QRtjlytC1K4nrviqkktz9EsuuQnb3tYXb9Hx2/q9WdI2i13
	1aHsRDmt0E2/3kiDd6HZtZAeCG6ayameJeGAlYn3NMXGSB+dK4cBKq7ZMWPrx83eRUiy+AyyS4t
	INNl19sX025WeQ3AMjoqzDYUGX11aoJtWuElqJW/UmrPOvGU+1OzXlVtmx3BhcgyB3uo0HeIEST
	kRC8ukNX8ty7YIMa8rAIpX8LtIjwgZaxatIt1JzloTz41Uoj4n+v/W+SbXfwh1SLmVlWJ3zDPch
	i7oMCEfvC9Rkr9f0R2XNWnkr5K5ZuuJ3HHcRAhYzg0bI30Y5ij8a63j1P1Auduv4jPp7kx56VqS
	NE6QU/I3xvCUceB9RVyM/yfi0cZFPMIxm8laK5b
X-Received: by 2002:a05:701b:4204:10b0:144:f85a:a188 with SMTP id a92af1059eb24-1850c5f8391mr847757c88.2.1792174613831;
        Fri, 16 Oct 2026 11:16:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e6ab:aea2:fd2a:caf4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f5a13sm9076869c88.12.2026.10.16.11.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:16:51 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:16:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/2] HID: haptic: reorder try_module_get/get_device
 before input_ff_create
Message-ID: <atJSOv7fRdtyeoH7@google.com>
References: <20261016151343.3120300-1-qwe.aldo@gmail.com>
 <20261016163349.3293666-1-qwe.aldo@gmail.com>
 <20261016163349.3293666-2-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016163349.3293666-2-qwe.aldo@gmail.com>

Hi Aldo,

On Fri, Oct 16, 2026 at 01:33:48PM -0300, Aldo Ariel Panzardo wrote:
> Move try_module_get() and get_device() before input_ff_create() in
> hid_haptic_init().  The original order placed them after
> input_ff_create(), and failures went to input_free which called
> input_ff_destroy() without ever setting ret.  The caller saw ret == 0
> on failure and kept a dangling pointer to the haptic struct.

How about we simply stop pretending that these can fail? I.e. replace
try_module_get() with __module_get() 

As far as get_device() it cannot fail and is redundant:

- get_device(&hdev->dev) only returns NULL if its argument is NULL,
  which is impossible here since hdev was already dereferenced
  throughout hid_haptic_init()

- In hidinput_allocate(), input_dev->dev.parent is set to &hdev->dev.
  The driver core will already hold a reference to &hdev->dev
  (dev->parent) that will only released in device_release() after
  input_dev_release() -> input_ff_destroy() -> hid_haptic_destroy()
  finishes.

Additionally I think we should simply fail probe if hid_haptic_init()
fails instead of trying to limp along without it.

Thanks.

-- 
Dmitry
