Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A922A7F6
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573060; cv=none; b=tpef0m1ZEhA2gBDVenxN4XCwzmYPCAORjaf+f2mCxO1Uzza5tCQEwjk/eaUZy7r5CRAHMfSTehIGzyhg9c1KBR1AdJ7bvpT+AS8KmYuZbPAWu1PbDwIwDqhFGNTVdPgjsscbV4EO3BUQ61Fbt+QSivTLK6CMpGjcJ0iDneEXdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573060; c=relaxed/simple;
	bh=OW3IsxBl6tCqKKAnstBEUrLHOa6AKWtDkVy2NAn8chY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em6/jriJtoUEBeGa8l3C4XIe+WMYmE3MULj9nKg1PL9N1fXyx/QGVWRCXLRYRKmxz9hAtKyHa2dBi27GmBQQJw42Ct0gmQxga1AcnbGi0hyeOS+6ckrAMkod3mjw7vv9BniTpqGPg9CMFk5Y0+uwmz/wOf84ofUO/fMtqumvYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG1rWeNN; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG1rWeNN"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd04edb5so4399040c88.2
        for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 22:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790573057; x=1791177857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CcMHtJq/SKFUMlfzan7qThpVdoDXAq0IWpnhSiUtUuM=;
        b=kG1rWeNN94iz/oRwmPRjYsa+KaOoclyv2dWKUpy+QHdSMayLY4TM8cyl6AJ3a9fnlB
         VjtwOE0hGiUBmUSmaHIl4h3Kg87XBX0W53XEpLO7xvQ6z9yCQD5yWisMlLLLBNzV5+U/
         iHr4PTaRx6yvstCQmIKw03Onbss087HDAK1+hL6ehF7nKaNQ8oifPgP9ossCHqgXwfql
         hGNagzrf7t8+IWieI0GQr8k95sRAD0otVRKx12YPqCHBJZRJhsoSG/mwM/tEoNmKML0H
         rR1dT8eyjb/lWuImWsWZ50fOBe57vluOnENmIXHW/Xgs0q+YJ7U5suyRLb2Q7rYTyRE2
         V/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790573057; x=1791177857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcMHtJq/SKFUMlfzan7qThpVdoDXAq0IWpnhSiUtUuM=;
        b=KZhEiQDOn1qsBe+x/mO6966+TzFksVPnRS3nzimfslAzZsoXEt6hdcrTpKC7h1PpWE
         gljZtSvLCCI+br6G1MX597tllP2pSVUJFup35Mjo+5hJv3OAYuQEOVwo82VZHCgGCVah
         Npi+fY39xe7cYSw8H6Ps6FctiuZmOjL/Pu0XT71lP64N7P6m6Qm0z+WyMd/IMqXfHlS1
         1BIqYuS/AvCmAzC3FUbcdzmnOSI8js+oac9YNhOxqzOOoQn3rkEGmFuxD8HGDVtw4Dha
         QYouj+Fd1w23GjLXvjvTyOTEkVnMf8N6hKMgRuMnFoRg6OsH004iOZifqQUNZe9wzk7o
         wkDA==
X-Forwarded-Encrypted: i=1; AKwUvBxo99Yn3UD3pu85WGCodS/wCdgrD7f0ZV7yvxegzO+0vJ+nfU0Wdn5kNkaxrQGQsSV9ztZbntz8qxiP9w==@vger.kernel.org
X-Gm-Message-State: AFuF++lLuM/eWKL4j6DZ0qNtKe+67QVLdJK6C9sjcsO0VsjMdBs1Riad
	RTlpNUxX9PBv+6VgWpITmGykKMxfGgAuuoQJNL4emK8EOLJCJFEaF9Aa
X-Gm-Gg: AYBFou3M4Nit7CTHjb8hXju8tcajMU7WdFI5oISYLWZpyG1nfq/6NBFv+AD4W6FrIaa
	P5xBIVyriRF6WHbdYwH+VcxlPpegUZ8PUPHTb/TM4Pwbjkk2Gy7JpAt9Kn/wff7ZAflKW14T576
	PoVL8VdZtPwD8EhK300YSKIzZ5tTqzuY1q77nyWSzlFtibvoSv/C2ZESO3q3H1tdTG6HxP9xsqO
	rwCU1UU4OiwPuMnqmoW/E+ZCemdsxH/ohdacwoO23aaOrjuzlJbCim/CgsK77SY5Q5S7SVIFPZ1
	pkc2bj9khofvFJyPxvwBPZmv4rPzxP5lTzWE+tb5oT84AghYjvKTVAVVndnhGumImAc8LhB5Flj
	DEqM4TRfURgsQ3TrTIbNkKofXnY0aymtkDM3aQpxCd05JrPvW1w79USMdd2J3r2bd2g0OgAEJCy
	cSmVEUZObHy85boNrBAuU3wgWniJFBSc1dM/Gc3sbJsAPfQ057CfSrmbTWn/3M426XDhCFzq8c8
	GsLARr4/UkLR5IH+y5cJrlnB3L40ukqwGVr4jH7eXHVFwEkYrY=
X-Received: by 2002:a05:701b:4346:b0:144:ed03:7c6a with SMTP id a92af1059eb24-146ce680bf8mr9028371c88.15.1790573057171;
        Sun, 27 Sep 2026 22:24:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:526d:2f94:503b:aada])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14745215c88.9.2026.09.27.22.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:24:15 -0700 (PDT)
Date: Sun, 27 Sep 2026 22:24:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: microsoft: cancel the rumble work on removal
Message-ID: <arn5XTGp7XIOmdB2@google.com>
References: <20260927011220.4193-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927011220.4193-1-danishkhateeb03@gmail.com>

Hi Danish,

On Sat, Sep 26, 2026 at 08:12:20PM -0500, Danish Khateeb wrote:
> Commit 1cfc77a64b71 ("HID: microsoft: move FF initialization to
> .input_configured()") removed ms_remove_ff() along with ms_init_ff(),
> and with it the only cancel_work_sync() of ff_worker. Nothing waits for
> the rumble work any more before devres frees struct ms_data and the
> report buffer that the work fills in.
> 
> Removing the device queues the work itself: hid_hw_stop() unregisters
> the input device, and if an effect is playing, input_ff_flush() stops
> it through ms_play_effect(). The work usually runs before remove()
> returns, but nothing guarantees it.
> 
> Cancel the work again after hid_hw_stop(), when the input device is gone
> and nothing can queue it any more. Initialize it in ms_probe(), so that
> it can be cancelled for devices without force feedback too.
> 
> Fixes: 1cfc77a64b71 ("HID: microsoft: move FF initialization to .input_configured()")
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
> 
> Notes:
>     Tested in QEMU on a next-20260925 KASAN kernel with uhid devices bound
>     to hid-microsoft: an Xbox Wireless Controller (BT 045e:0b13) destroyed
>     while a rumble effect was playing and its evdev node was open (20
>     cycles), a Natural Ergonomic 4000 (no force feedback, 5 cycles), then
>     rmmod. Tracing shows the removal queuing ff_worker. There are no
>     warnings with or without this patch: I could not reproduce the
>     use-after-free, as the work always ran before remove() returned. A W=1
>     build is clean.
> 
>  drivers/hid/hid-microsoft.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index a7d3493a6141..1b527954937d 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -335,7 +335,6 @@ static int ms_input_configured(struct hid_device *hdev, struct hid_input *hidinp
>  		return 0;
>  
>  	ms->hdev = hdev;
> -	INIT_WORK(&ms->ff_worker, ms_ff_worker);
>  
>  	ms->output_report_dmabuf = devm_kzalloc(&hdev->dev,
>  						sizeof(struct xb1s_ff_report),
> @@ -358,6 +357,7 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return -ENOMEM;
>  
>  	ms->quirks = quirks;
> +	INIT_WORK(&ms->ff_worker, ms_ff_worker);
>  
>  	hid_set_drvdata(hdev, ms);
>  
> @@ -384,7 +384,11 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  }
>  static void ms_remove(struct hid_device *hdev)
>  {
> +	struct ms_data *ms = hid_get_drvdata(hdev);
> +
>  	hid_hw_stop(hdev);
> +	/* Unregistering the input device stops rumble, which queues the work */
> +	cancel_work_sync(&ms->ff_worker);

I think this is too late: by this time the hardware is shut off so if
the work is still running and tries to access the hardware there may be
failures.

I think I will add support for "slow" effect playback to memoryless
handling so that the drivers do not need to worry about managing their
private work items.

Thanks.

-- 
Dmitry
