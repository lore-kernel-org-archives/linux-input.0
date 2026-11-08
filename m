Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173512;
	b=D9lqked1/8EnsYCTp+klU0lxZ31+9xG13ML8+Tx0PSAr0UqhBASi56aRlC8+3C19D8uS
	 tI1jin/A4SaT+dbh3xxfINnt4QPD+xlJfY040GJ0um6+SxhLTkeKAKK35ZzIwh85UXmsz
	 JO+T0+MfJ6NWt+DiS2F9riCb/XRUlFY5GPZiXkZMT3YRS5XPJ9WGJrr2vqKSrb3D1tLLj
	 EUQoKALbl5+WaY4PryMPoCvB8Ec9o8jEvvjGXXmE4S3l5Z9Mh5DmPt5AS8shoRD5ojT2j
	 jC9DLKvw2G96LZqDrrEQbCu/ToEsCZFjhaE9SoxU0lJPyf/vD6BYhtfR4AdddLy7F0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rBMGVypFbtv6OA3tQuoT/CFxuNnCbyC8FkABPLfi7Vw=;
	b=0SjCsIGgO3j76Xh4PjBiQuMfD/EDi13PdWSeppzJVpZiDQv0D1FLEpBXuPtDe1AjAUYl
	 yjnUmNvffnlpE+kq4dYf8w4TD4G2Pfj3zshS+L9RcenJbST7pXLWtAGf53UGGat61mLJ2
	 pFc8e+W+MBrUvyGdmWgvIUQ0wGwYtB/7P5vJBC0MZhNAIFTmlQAYL3KFJ+21iZ0E1rdy6
	 Gwn//4/1XSph2C0CNmDZTRIMmNnSnCrlXpmppodxKFdHKVK9zyDaqf/9jJcVfjqoDxPmp
	 nO5EceO1fiNyy8Dxf7zwgvC5E35XT9nX2Y+YwhubMzV6P19wPUpD60LOTbDDgs3UzeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCMpf8kV;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F84606A320
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 21:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5F84606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCMpf8kV
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14394530ec6so245622c88.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 13:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173511; x=1794778311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rBMGVypFbtv6OA3tQuoT/CFxuNnCbyC8FkABPLfi7Vw=;
        b=MCMpf8kVOPjbb/SHSHLMyb3YAsSrk5Ygen+7axWUq9EERpWUWmh1pKPThjwRKn33RB
         e3pld9f2GzDScf75GDhERsYay2xXa/g63NHXlJvP+8I2WSQQ8juMRU7Udf8P3iFb75BB
         ucpaoTMO/lXhzEF00DMmocN+mPMwYawtEIHlxzvf5b7cB0bp9qSgqK0qoHBl8bEpC1dH
         fln7ngajmHHuw5cKXqRWof/6tU8OYAHgxvQ2Fr4KGlAsnfXZnthr9u/Fah5iG7NsWi5v
         dU8goz797H541pLrKkvITXyYb1OMS6PgC+32/iDLC0Nqw4DGHBHisW58MSmpyZkOCKIS
         v/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173511; x=1794778311;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBMGVypFbtv6OA3tQuoT/CFxuNnCbyC8FkABPLfi7Vw=;
        b=cVV/cAMqHJZwuT/cO0KciUhSCGnrLoV3mKGvx3vvUvw64/2p/h5XTgHmnElaF6V7DF
         kjV/2VA+tndFD4Ea+998aBKMIEUPecC/148Wb2BliyrjwYwGkKPngeLXbhm9gYv6AtMS
         SgX0Rw/6mvX0QR8U0m89ksV7DwyN+z+1e9q7Squ6h4bheR3JoKn1ii/0SNHZcNb64Aaq
         IdLmh/+QYIWezxptLsLtggqFe+H8fTjJ6CYiD0R8UfkZJQOSTA9ZEqswqaz8RFhD5IoL
         1QA3On1fyH3T3wFKUxgn68aywg+FLZi+0DnyOEqDDrv8iHpBkiLwTdX6CapzAy8ISTcH
         CFKQ==
X-Forwarded-Encrypted: i=1; AL+hErEA9HTPDQ9ivPen1iH2/HdFXM3udf67ot0Bv6lE0DeYtWlWyZH+x1WFR5XZ9mN3IAW4zhDyTH4DjDCZ2Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+aywGgHmPnZo1YTHVzTsBt4e1TwTsn6TnQLhfQmU7mOeyZ8CQC
	NIuLKfaHng1Sccgj5TPIf1hn6ocE1dJlpH9O5QUT7aykOF9JsoydPBJh
X-Gm-Gg: AYBFou280hnxXPTj91lDfOE9YcxI3VaUj8eJPmyoyJkeOhSwhkyF5oPPL6oaFcSyTFF
	twh6r0YQBj76/Dq/bG9XTq/8o478qe4cOsP4L293CD5RWOPtwXVwuMwOxlZMw2htIvQSdeH+V4c
	4WxY8cF4ZYk8BZyWQFcHo6aGxKDPpGtqwEqnHks9emD4/7nIhU0dADkyfK4t8udBxGSVtHylrp0
	HRkRbLh5qoC9dEdajffWDih85c7/meXYUOPkooxizNlcJYt9lbewCbd5goN01B7pjiz/HXFIwVg
	EmGCoquhV1zTD2ljOJ9dLA+9wuISE/3JNAQiOcPPHfHKavrZwCqnpzcDmOKTOhBEQI4YODnhK8k
	JuHVwEXBUfphk4f6bdHJ7ZjiqLUcM8an/j3e1M4TClDOGweWxFoRqnugCQnTpB8WjXsXqfXtSvP
	n8n2WZvMOX+N5a018kHSIOE6JJNYXETEuySnzJOZGsT+TwtG/atETeEzYOy/iJXxvZPdVejeRL4
	H6/a0DeuAqtyGdMxw8CLx0NLXpqHPi296ShSxE9FTv7dOH9OJCLTQpqrXHEXhNZSH4kze1oz6gN
	9rGLCPdkceo90uEhRyvCoGWzdBWsPSD7qWFNn5jRTWSaxjdXDj/lxWtF+UOY16vbBnnP
X-Received: by 2002:a05:7022:3a8a:b0:1b2:4da6:bccd with SMTP id a92af1059eb24-1b39fef46eamr3757834c88.34.1794173510833;
        Sun, 08 Nov 2026 13:31:50 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37560d95dsm7077840c88.11.2026.11.08.13.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:31:50 -0800 (PST)
Date: Sun, 8 Nov 2026 13:31:46 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Nizat Mikayilli <nacht@dxdmail.cc>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/5] Input: s6sy761 - apply the touchscreen inversion and
 swap properties
Message-ID: <avDoui7Foj0eVcaF@google.com>
References: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
 <20261108-b4-s6sy761-fts1ba90a-v1-1-999b3cfaf82d@dxdmail.cc>
 <sashiko-outbox-203649@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-203649@kernel.org>

On Sun, Nov 08, 2026 at 08:38:24AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [High] Input: s6sy761 - premature input_sync() in
>   s6sy761_report_coordinates() [1]
> --
> 
> commit a5e7ac4e0cb3d02e12af7f249f64b3074df9f280
> Author: Nizat Mikayilli <nacht@dxdmail.cc>
> 
> Input: s6sy761 - apply the touchscreen inversion and swap properties
> 
> This commit replaces raw X and Y coordinate reporting with
> touchscreen_report_pos() so touchscreen inversion and axis swap properties
> take effect.
> 
> > diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
> > index 1afa38850f12f..967fd222f0d62 100644
> > --- a/drivers/input/touchscreen/s6sy761.c
> > +++ b/drivers/input/touchscreen/s6sy761.c
> > @@ -153,8 +153,7 @@ static void s6sy761_report_coordinates(struct s6sy761_data *sdata,
> >  	input_mt_slot(sdata->input, tid);
> >  
> >  	input_mt_report_slot_state(sdata->input, MT_TOOL_FINGER, true);
> > -	input_report_abs(sdata->input, ABS_MT_POSITION_X, x);
> > -	input_report_abs(sdata->input, ABS_MT_POSITION_Y, y);
> > +	touchscreen_report_pos(sdata->input, &sdata->prop, x, y, true);
> >  	input_report_abs(sdata->input, ABS_MT_TOUCH_MAJOR, major);
> >  	input_report_abs(sdata->input, ABS_MT_TOUCH_MINOR, minor);
> >  	input_report_abs(sdata->input, ABS_MT_PRESSURE, z);
> 
> [Severity: High]
> This problem wasn't introduced by this patch, but does calling
> input_sync() at the end of s6sy761_report_coordinates() and
> s6sy761_report_release() fragment multi-finger updates [1]?
> 
> drivers/input/touchscreen/s6sy761.c:s6sy761_report_coordinates() {
> 	...
> 	input_report_abs(sdata->input, ABS_MT_PRESSURE, z);
> 
> 	input_sync(sdata->input);
> }
> 
> When s6sy761_irq_handler() loops over batched events, emitting SYN_REPORT
> inside each per-slot helper splits a single multi-finger hardware update
> into multiple torn frames for userspace.
> 
> [1] https://sashiko.dev/#/bug/linux-c1c813ff-e5e5-43df-a3c3-af15e2a7dad5

The driver does not use INPUT_MT_DROP_UNUSED so it is OK to emit
SYN_REPORT per contact. 

Thanks.

-- 
Dmitry
