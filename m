Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA7330668
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415182; cv=none; b=dtZL/TAL63bs7lgTNLEZPiU5BYR4TX4j5mOwVXM8WuP1iqNN3sU7kCGQeV/Cvt5S+Kzg0ASN8MeT2SLUcap3hb1Y+G57BbJm65F/Em8q4ZOOtw1w2/+jqo5fSmBSgUIvKt3X2f/P5Aof1EXrB3Av+efSmQFgzPUY0pydd6QFZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415182; c=relaxed/simple;
	bh=68KtwaVgG7YT5uaY6FkpMTgksL0UJpvFapAzT8vuUYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC2Umc1E8jgrWb5WIPJ5PFgJhZKpIKWi/6FrUEogDML4R3uxN5GwyX3qrh2VxhxOBYYX+HOqfYt8VaSDaDZEirdESItW1L3ADfNXd364BcJwLlNB0lAUkJ8dkpL180sBaJfikOk7h2+MzOM0zP8fnnr/heoKWR6d7TWkOHPdZLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ys0PtHh9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ys0PtHh9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c19bad03so36545355e9.2
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2026 02:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783415179; x=1784019979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b5SemckqR+RbELmdvJiNqgdbo6JbgxB0VBziPWlK0PM=;
        b=Ys0PtHh9TT6ZLN/Pce/yyKZOo2Kr+jTTkV0BVkg6YozBv4GJOWqpumr2e/SdAU4zCV
         lOGFOYC6rxKI7JnUSHYbl6VL3OYkriqCQyk3CLLDBRjGh5cL5BHsPuguj/Ky44RB7QjM
         taMZiq1rbmgicivTmnLSjn48eQqzxuQpsbGZbZHai6l3C+ziDeN0CDSnXPi+gEb9tIyQ
         CcFxuovHsd0kUdolyXk5977zBGgV0FqFPvsDPwmht42NhATZvn3uBeKeixkQeFcuqWSM
         VIjqBDgkjbVrTlhyAASe37n+MvRVHvVqi6gbsKoxMWPisdKG10ws4pK1VaashmPTwcjR
         7ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415179; x=1784019979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5SemckqR+RbELmdvJiNqgdbo6JbgxB0VBziPWlK0PM=;
        b=QR4d83FXVLPm5HgS6czOIXhleMCMTT+xsRCo2/yVUo6RVcY+s6ACn8N/Bju/Rs4mH1
         znihulAGBI29/HNRac0noOylZduhOCPnVgIdJZo5QBpyxyJqc8+WP9QhDMLkNOlPHfzy
         G6H1koFTRmVglxijpfwYOrmuRXr0yb1L8pih1sz8cYjFu8YpmE1Lpetd8HGGVky+MxPP
         ZgB+6V+0liyGY2EJq9KASYvO0tk2h9E7s1kVlxNzyrw6s6Ivr5b1jt3oIrintSgvC2nM
         KA/qIMHSmpfI68sZe7WZrkIvCozmQRzivkdU/MjUUUGStygL47GdC4/vUMgjmD8ZtOh0
         6f1g==
X-Forwarded-Encrypted: i=1; AHgh+Rq979C/7Kxz75Fvy3gor4wRx3xklqp98i6oXPSM9xNTc70ZRwAZEfjY/27MuHYteCpWjZxDYtWqGvJ2dw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RIwTZHxnKSQIoUNInRNhfTZeKRhDCB+E4EwQA2+e4s/i5dnk
	22PHPnc8dWiOuKduW+bwb3ZB2D9CNpEZKXSDGk840ojIwuxj/qQ7YC8I/88YDf/9Wg==
X-Gm-Gg: AfdE7cm7Ryt4I1B+kfhQBzPoi0qNhK5+nFg91JwUEXsOtnbm5fSxCD6Ul88Ln+smD1O
	l6Jtes7RuPDg4Qbb379sEMe2Ghz/kyd7T59TnaZRYJVAG4RyhJUpAE7LgP6mnroM2Dj5lFQgw2C
	NqHIdhzqDMQRbOhHklWmwVrU49lPJSsAXkiG7nva+ecyotjqRYqIH/j4w1WisFEAWjxlrIMDH5X
	uktDnK1XnbQ+Wk+TxzsZIB2F4P3Ta3R011Q8NHIqId4zJYS8hLqjYPB8ZFkXSBHdx9GHqoeYGHW
	su4dNYT4UZ1ZvQ/Un4bE6UKmlYNK7SORzfnOdSmWSptAc2QsPtrSEw5FxTW1s0xoRnj2XFA45BY
	P8uhne4hrspDAcxwbnAzOXu2u/a5t9zuGBUWNryE/i+b/1hEiyWiXrOylf6eWjFXdWhGhmCnGfx
	eTlIhUQ9ZWcY8ci0raeYI00VbBjRgCEGfWxrmQ4DM85GNMEZL1NceMIQ==
X-Received: by 2002:a05:600c:5611:b0:493:de89:61b with SMTP id 5b1f17b1804b1-493df077f31mr35685135e9.26.1783415178361;
        Tue, 07 Jul 2026 02:06:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:c86d:9b87:b8af:84e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm62148475e9.13.2026.07.07.02.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:06:17 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:06:12 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Manish Khadka <maskmemanish@gmail.com>, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, sashiko-reviews@lists.linux.dev,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Lee Jones <joneslee@google.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v2] HID: hid-lenovo-go: cancel cfg_setup work in
 hid_go_cfg_remove()
Message-ID: <akzBhKTOVpaTb4nT@google.com>
References: <20260515174511.78486-1-maskmemanish@gmail.com>
 <20260515182347.6C82FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515182347.6C82FC2BCB0@smtp.kernel.org>

Hello Derek and Mark!

May I please draw your attention to this issue in the hid-lenovo drivers,
which was pointed out by Sashiko:


On Fri, May 15, 2026 at 06:23:46PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential issue(s) to consider:
> - [Critical] Hardware state corruption and crashes due to use of a static global struct for device data.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


> > diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> > index d4d26c7833563..b9d8cde531365 100644
> > --- a/drivers/hid/hid-lenovo-go.c
> > +++ b/drivers/hid/hid-lenovo-go.c
> > @@ -2408,6 +2408,15 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
> >  
> >  static void hid_go_cfg_remove(struct hid_device *hdev)
> >  {
> > +	/*
> > +	 * cfg_setup is scheduled from hid_go_cfg_probe() with a 2 ms delay
> > +	 * and dereferences drvdata.hdev.  Drain it here before tearing
> > +	 * down so the workqueue cannot run after hid_destroy_device()'s
> > +	 * put_device() has released the underlying hdev and dereference
> > +	 * a stale drvdata.hdev pointer.
> > +	 */
> > +	cancel_delayed_work_sync(&drvdata.go_cfg_setup);
> 
> This isn't a bug introduced by this patch, but does the driver use a global
> static variable (static struct hid_go_cfg drvdata) to store device state?
> 
> A second device probe would unconditionally overwrite drvdata.hdev and
> re-initialize both drvdata.cfg_mutex and drvdata.go_cfg_setup.
> 
> Re-initializing an active mutex destroys its wait lists, and re-initializing
> an active delayed work overwrites its linked list pointers, leading to
> immediate memory corruption and kernel panics.
> 
> Should the device state be dynamically allocated per-instance instead?


This is the same issue which was also introduced in hid-oxp, which I
pointed out in [1].  As the review-bot points out above, while the data in
your static drvdata variable is maybe only necessary once (but that
also seems questionable?), I think the mutex and workqueue shouldn't
just get re-initialized in the middle of being used, when a second device is
plugged in and the probe() hook runs again.

This pattern is used in both the drivers hid-lenovo-go.c, hid-lenovo-go-s.c,
as well as in the newer hid-oxp discussed in [1].

Shouldn't the drvdata just be allocated with one of the devm_*alloc() variants
as in the other drivers?

—Günther


[1] https://lore.kernel.org/all/akfGTjId84EjV141@google.com/
