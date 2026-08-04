Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2EF283FD4
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808049; cv=none; b=AAfyFu9Owas3tSXSPhNBXI0+o5yFXLDxLn/YVpzotvW+PJwnmW2L0I3KX2BfWfKxAOh0LlPlTHsYEvHdz7hCUCQLSTGNz/uqKE85i1B2PZ4ZgGWa8GEXAwFKwcmkiCukDDCrZRy9PLz9kiQUK0hk86NmKS5aCg7NWcrPmKHk0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808049; c=relaxed/simple;
	bh=AlNJyTnQ+/4lHutdhmK/M1oi40ml9td+PGCVh1fLE0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuO4OyAkOhO7F7NdJJBbQx+2Uu1LiqIuu4FMx8+zCSgNIMpPzeSrP9oGhjmHxxmFVUjuJMQ57Uw8MFVdZqMy1+mlaDAGzkGnP9978LFRWYMPrfcuYvSZag0BK3m2V7HDtJL/+K26V5atSd//WTIX2zMh2PIh0DVwQOuSbw4xARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiTMHqYJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiTMHqYJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccf2360620so35801465ad.3
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 18:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785808047; x=1786412847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PJCid5QSTmLmbjEgfYWoSErYZcDK6ekrRH1upJJmdlQ=;
        b=FiTMHqYJdS5M5olrNnWK10C0QLdjACPXEQFwc/tpT4CqGEHFD25t7hbBTZiNmhdTNX
         2AaXv9jCZ2CO7+F0npeTkxGBIFx8+6xlgj6atIGpR+U0gdreapWg6CSVs3eKLKonKtil
         6edysg0sriKLF6Q/jN1Ac4AL8mGGo05yHRX8316F0BzfS/kqjAvKmrvDGxdwuqaNMq4y
         az7AuDoAV/YVoChXclV9mWRFw8ZfyNVjKZIxhzJchTbviXxMJ47ONVatoRWSIFpWL1w9
         EnxoYPokdQIo9f3+jb+bD/F06QmlUKMzv2aOLJd5ShCOH0iCTYUXHVwbQ+KjYGo3170h
         FIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785808047; x=1786412847;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJCid5QSTmLmbjEgfYWoSErYZcDK6ekrRH1upJJmdlQ=;
        b=rJo9lK7YLV40RJJa2B8rEj2/xXJvIq+vFDemskJt5l6p4dAmsFbCf/YntzBXUIArd5
         RWIdmWTEZETQT+OjNs7f0hlxTWdsZosQaJKA1mnMQbb5Trr+4h/L8YtjKyorGVvR+SdV
         WSbZVWQZhlWHvgdmQuSA41WQcapykjGYO30kigO8u+NuCLVOV2Mxli4ASrPNWgDKfUJW
         Z9yiQ9/P4o3SiIf7+hC1+GFert0IWuSuBf4jVdC4kBBR4+a7RTsLoQx3V/hj/J/uqB26
         +YZRaBycS/lAdwu9Wv0/Z+RfJOKW6X69gmyxc2Lz4mJAv9SjnnUq/ifF/3FWLC8d5uJk
         sZRw==
X-Forwarded-Encrypted: i=1; AHgh+RoLuOIN4IXv2dUgzpoU5/MwySr3mJgVlnGpqApNVyd95XOJmYJDFFTio/CD7RWbwYLou6QHsf4kfCfm0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0af5NN8YqvOFkjp689EcWDYBXI8cYOQg2sAE9f/RbOedR0ps
	ULM+UIDXPaXytA4pQ5Y+LgAG4eEuKxM1+Jyz6CsMCIBkmzTyUD/b/Eeq
X-Gm-Gg: AR+sD111yPmtH50foUsnmp69PAY11BCPAGG5AaXyL6Unxj1VSIJ5KrhV427oLgpMpuD
	rFQwFpPWp38AgBVw307ch/lDx59qhBLWEN/4+/zTzS8jm94dq6D08cuRVcF8oeCCkSh1G/9cSM/
	Z+n+zkmhOntHsetxwnFXQWGGD1nWiOrzVhitulZC7crWVO6JQ7NHMkwiDk52HaOlbXwFL4D0j//
	zvEEW7cHCYpHgNQPQq1v6ykNWo3cDKtM18G3CjZHEY9P7cX5+fGGMtXbh9J/8oBFov8YZAUeSGA
	U0uLqJQgm8+iu5hUmRGYgEazvH8n+/x4/5nRzHiBpFvRudsVurvkh+t3nnLJfsXofE6SrbXNTpJ
	Sf9ooqAYlsdE3lK0WR1cZOghdqjTL/ZJvFv1UjXVH7JpwaVVXLwLfdbsydIjP6rscAVLm8bRTlp
	3/vFhHE/mxEQXIMnhKtVr8Rzq5sudv8uzRdqpMuGQqmJCWmj203ZAgR6Bo1ytuvPkDzg4lClczW
	3CsCRR/hCPh3fpV+A7Y2A6gRjrhIg==
X-Received: by 2002:a17:903:3c27:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2d05219f8fcmr126095735ad.5.1785808047215;
        Mon, 03 Aug 2026 18:47:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm39860651eec.14.2026.08.03.18.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 18:47:26 -0700 (PDT)
Date: Mon, 3 Aug 2026 18:47:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: David Rheinsberg <david@readahead.eu>, 
	Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput/uhid - disallow control characters in phys
 paths
Message-ID: <anFDip3gGB4vEA8p@google.com>
References: <20260717-wip-uinput-sanitize-phys-v1-1-f6459542ce4b@who-t.net>
 <1ed3a0b5-db39-4a82-b549-0ed7e2cf89c2@app.fastmail.com>
 <p3886qn6-q75n-8srq-49rp-09p86788s65o@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p3886qn6-q75n-8srq-49rp-09p86788s65o@xreary.bet>

On Mon, Aug 03, 2026 at 09:58:35PM +0200, Jiri Kosina wrote:
> On Fri, 24 Jul 2026, David Rheinsberg wrote:
> 
> > > There is no good reason to support those, no physical device will ever
> > > produce those. Allowing \n in phys previously triggered CVE-2026-50292
> > > in libinput - there the PHYS udev property value was used as part of
> > > another udev property value. The linebreak then caused the property
> > > to be split across two lines, allowing uinput devices to inject
> > > malicious properties. While the bug is squarely inlibinput's court
> > > there still isn't a good reason for control characters in uinput/uhid.
> > >
> > > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > > ---
> > >  drivers/hid/uhid.c          |  1 +
> > >  drivers/input/misc/uinput.c |  1 +
> > >  include/linux/input.h       | 15 +++++++++++++++
> > >  3 files changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > > index 37b60c3aaf66..baf1fe8290f7 100644
> > > --- a/drivers/hid/uhid.c
> > > +++ b/drivers/hid/uhid.c
> > > @@ -513,16 +513,17 @@ static int uhid_dev_create2(struct uhid_device *uhid,
> > >  		ret = PTR_ERR(hid);
> > >  		goto err_free;
> > >  	}
> > > 
> > >  	BUILD_BUG_ON(sizeof(hid->name) != sizeof(ev->u.create2.name));
> > >  	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
> > >  	BUILD_BUG_ON(sizeof(hid->phys) != sizeof(ev->u.create2.phys));
> > >  	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
> > > +	input_sanitize_phys(hid->phys);
> > >  	BUILD_BUG_ON(sizeof(hid->uniq) != sizeof(ev->u.create2.uniq));
> > >  	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
> > > 
> > >  	hid->ll_driver = &uhid_hid_driver;
> > >  	hid->bus = ev->u.create2.bus;
> > >  	hid->vendor = ev->u.create2.vendor;
> > >  	hid->product = ev->u.create2.product;
> > >  	hid->version = ev->u.create2.version;
> > > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> > > index d32fa4b508fc..70fe4f3e73bf 100644
> > > --- a/drivers/input/misc/uinput.c
> > > +++ b/drivers/input/misc/uinput.c
> > > @@ -998,16 +998,17 @@ static long uinput_ioctl_handler(struct file 
> > > *file, unsigned int cmd,
> > > 
> > >  		phys = strndup_user(p, 1024);
> > >  		if (IS_ERR(phys)) {
> > >  			retval = PTR_ERR(phys);
> > >  			goto out;
> > >  		}
> > > 
> > >  		kfree(udev->dev->phys);
> > > +		input_sanitize_phys(phys);
> > >  		udev->dev->phys = phys;
> > >  		goto out;
> > > 
> > >  	case UI_BEGIN_FF_UPLOAD:
> > >  		retval = uinput_ff_upload_from_user(p, &ff_up);
> > >  		if (retval)
> > >  			goto out;
> > > 
> > > diff --git a/include/linux/input.h b/include/linux/input.h
> > > index 76f7aa226202..6c182f5c783f 100644
> > > --- a/include/linux/input.h
> > > +++ b/include/linux/input.h
> > > @@ -527,16 +527,31 @@ int input_set_keycode(struct input_dev *dev,
> > > 
> > >  bool input_match_device_id(const struct input_dev *dev,
> > >  			   const struct input_device_id *id);
> > > 
> > >  void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
> > > 
> > >  bool input_device_enabled(struct input_dev *dev);
> > > 
> > > +/**
> > > + * input_sanitize_phys - replace invalid characters in a phys string
> > > + * @phys: the phys path to sanitize (modified in place)
> > > + *
> > > + * Replaces any control characters and non-ASCII characters with '?'.
> > > + **/
> > > +static inline void input_sanitize_phys(char *phys)
> > > +{
> > > +	char *p;
> > > +
> > > +	for (p = phys; *p; p++)
> > > +		if (*p < 0x20 || *p > 0x7e)
> > > +			*p = '?';
> > > +}
> > > +
> > 
> > Reviewed-by: David Rheinsberg <david@readahead.eu>
> > 
> > I would also be fine to just reject them in uinput, but I guess this is the less intrusive option.
> 
> Thanks for the fix.
> 
> Dmitry, can you please Ack the above addition to input.h?

Jiri, as I mentioned I believe that if we need to sanitize phys we
should also sanitize other fields, especially given that they can be
set by userspace.

I also wonder why it needs to be inline? And what is wrong with using
isprint() here? 

Thanks.

-- 
Dmitry
