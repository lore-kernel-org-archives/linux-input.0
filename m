Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FDF37E301
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800024; cv=none; b=hXJA57gAMuLFVK8j+4m+75iXTIX5CE9vydZJuMzbIJCVZkpMuR3yEI2sP/sW87Hm6gDDXGobGnLENS8RYp9rihS+j/tdL76YQCyyeFWd7oIx3s7AbhXjowv9o3oI3dialTpVg/97Bute0Ll8Kb6iDy/xm4YR5a5JyTwZVHmzAoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800024; c=relaxed/simple;
	bh=MgBl1tjaTrOko8MnuN3rOVFNmFaTGLEvWTS5I1o0Blg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUmL7AUzZaxXzCISxsToQVvQpJQ3ZA5/rqlzo+DyUDST0aPj+A74/Js0UiIdv3KRrsXuJsLOQajSDUeNRDfFr8U5fg6+GK2uKjTYMx40KoEsH2tLPNlnohVJ6TkzPzgY0spILuxidRnDwUrA79JimLV2w6kZNM96+BTMl9dV+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUfAjpW5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUfAjpW5"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9e7391839cso3479450a12.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 16:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800021; x=1786404821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QeqgW/4lTIg3SEDE03Q3XP4TRyhw16cUEWUdFHbkHtU=;
        b=CUfAjpW5UsBgcHH5Jm8/6yCif3diFamGY9jWV5MxlMlWa+R0hg3c88k96LSNQuZyev
         hEiS3ujDxnV+sOXAAzY39b4JosEUxh7SaP3ss4MlyBp+NGJfe2XYC2XTrqDspJrFv7gC
         QnXR49uVztlS3cI2YIJD7UcNYCNx35aLqhWFMuoD+uGuDkrJFelPTCSDdWdkJPs/dbzR
         PXJQAR6zpwAL1Mww24gGUG4ajVYlxtk7igLMBSGvYUefXeXRyOu7J+/rz8KQYSSyTjCN
         ZL8FQY5UQwPCecQzJLpPEsyv44Pm9rPmWdCBAyQ1WOgM3JLQpM7g9n6sTEfA+ux/2CcL
         8B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800021; x=1786404821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QeqgW/4lTIg3SEDE03Q3XP4TRyhw16cUEWUdFHbkHtU=;
        b=WZCS4WLmBIIeiBi/hwWRjRgbTliq/kSpmpgh9rd6/ese1Hq6Nxfz72bnoCbf9Pam1s
         QsTynapX/370/CPC2VJJS6XOWzPjOMr0t4nyZfoNJLZsgMS0ApMZM+o41S2V1mdnwQWk
         ilyun0147r5ThgJ1h9hGO7cG+TgtpR4HNtNsp052KOadklp5N1PMejtGpqI0kYlZA4Ye
         1Fd5D0Yc1m1BVbWNQb4ao0AZsTND1XH9pijcwSgT7YbU13SL/dOTZexxO646ULPtzRep
         Wscl4hlJja84xSkSAEIWQn0ObEZFj1O7CrbBVB4rtOvzBkrzbH2GOc9p5VKCD+8zw/3U
         9KFA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+OMeGi3b2ltWwccmJO1FcM5FicsxjxI5yJuOQ7DtvvdDyZwUxU38vSlmcawJaZS/wU839j/VwkTOpDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweLTn1d0C3OwN/vektBIKVkOL3eOe93t+XAnA+khBQVohRPVFI
	n3mq6hTVUNRJXWjtUG2tfuTIrcAyrBviX+rUyTAOQxr6JEfUni4kB6bL
X-Gm-Gg: AR+sD13BK7G7yVsdOYNIHHC5734mxpaz2T/9A0l7WQC3dNL73kGjEBSU0h1ZekpKyGm
	p6tJ8OdIS/Mx7c51z2fCjmVCsnJoHv1YNgZxVkkiAhCdd2YNgZXWGomvfDh9T+FkL3CY1bGr7Tn
	CGKKz8G065SaWROYmbrL0hV43bBmHIqiyy0FCGxU3jGIpvlD8aGK5ZifBrzGlOwHY02cwzseBsy
	5h3IevTdoxJtmiW1T1bkUuerv8jXNsyVMGcHBclWMIFEvIqZkbvCnKapWByWI964+dUxZXNDYv6
	lyspEGnSXSw+md6idN+nd1nA6JJhDicWvJxTF5LXeAYOAfDT6GYGXNTJmgjXALl0Y45QjU/nCTs
	d9g+hfTEijVAF22khKkCB9X/dCVYh+Lv+Bje4x+ZSG1FV5Z+AYyGBMU9jsmSl6W5UrU9k1ic1l9
	WH8dLscW5sab7QMI7XSRfsIBfVsfXCHYI2VJ7/jmdEUhk6UIJ6WwYJqmRvaJuxKDs2UJ/hTrLcD
	cSgSuIhf6qXt2m/GJayM/PcelUxPE7Ge10CQNs/
X-Received: by 2002:a05:6a21:a89:b0:3b3:223f:d3fc with SMTP id adf61e73a8af0-3c92a864c77mr11650058637.45.1785800021346;
        Mon, 03 Aug 2026 16:33:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f88fsm41168805eec.20.2026.08.03.16.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:33:40 -0700 (PDT)
Date: Mon, 3 Aug 2026 16:33:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: hid-oxp: fix UAF on pending work in remove()
Message-ID: <anElA4get_VxNuB4@google.com>
References: <20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc>

Hi Shengzhuo,

On Tue, Aug 04, 2026 at 07:15:32AM +0800, Shengzhuo Wei wrote:
> oxp_cfg_probe() arms drvdata.oxp_mcu_init to run 50 ms after probe, and
> oxp_mcu_init_fn() dereferences drvdata.hdev to issue MCU output reports
> (oxp_set_buttons()/oxp_gen_2_property_out() -> hid_hw_output_report(),
> each followed by msleep(200)). oxp_hid_remove() cancels it with the
> non-synchronising cancel_delayed_work(), so a worker already running is
> not waited for; removing the device while the worker is asleep then frees
> the hid_device underneath it, leaving drvdata.hdev stale -- a
> use-after-free when the worker wakes.
> 
> The oxp_rgb_queue and oxp_btn_queue workers, wired up the same way and
> also cancelled with cancel_delayed_work() in oxp_hid_remove(), have the
> same problem.
> 
> Drain all three works with cancel_delayed_work_sync() in oxp_hid_remove()
> so they have exited before the hid_device is freed.
> 
> Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
> Fixes: e4c850a6e750 ("HID: hid-oxp: Add Button Mapping Interface")
> Fixes: 2f424f28fb39 ("HID: hid-oxp: Add Second Generation Gamepad Mode Switch")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
> Same delayed-work use-after-free class as the 7.2-rc6 sweep
> (hid-lenovo-go, hid-lenovo-go-s, hid-lg-g15, hid-appleir, hid-letsketch);
> hid-oxp was missed. The fix mirrors the cancel_delayed_work_sync()
> approach already used by hid-lenovo-go / hid-lenovo-go-s.
> ---
>  drivers/hid/hid-oxp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 20a54f337220dc2aee3483a14d542b66c487bd60..d8fb6a69d40d43f2595179df1067d42b4b3e166a 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
>  
>  static void oxp_hid_remove(struct hid_device *hdev)
>  {
> -	cancel_delayed_work(&drvdata.oxp_rgb_queue);
> -	cancel_delayed_work(&drvdata.oxp_btn_queue);
> -	cancel_delayed_work(&drvdata.oxp_mcu_init);
> +	cancel_delayed_work_sync(&drvdata.oxp_rgb_queue);
> +	cancel_delayed_work_sync(&drvdata.oxp_btn_queue);
> +	cancel_delayed_work_sync(&drvdata.oxp_mcu_init);

What stops these jobs from re-arming? Should it use
disable_delayed_work_sync() instead?

Thanks.

-- 
Dmitry
