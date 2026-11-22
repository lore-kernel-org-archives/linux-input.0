Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795385639;
	b=BSpj8IjwPH7wrSYQ7lKhKdhhrGdrgwAWGMfXO4tbx1jWpz5THUcjWs2KaIJJM1dFGgas
	 fFxGDnBn/8bapXuSS1czFD+17YhAwjEi2pDeascwwUuPmqL5IV/2C4ewfDlbaqELbcZ1O
	 rjgd+dUjj3OFAChs3RZz8WHuudHNy3zsTAWp+iVnX6uduCTW/eXLPQZys2qF89dlI+T+I
	 N9X9VTF53FXu6iEllyqLKei5h/mADnez/SAr42BWK9suy9LX8jRt9fcAduFiKqgNJkhYA
	 OYeqf/ta9lflwatCz/yS0ovWU1nUM5r6SQj0oZrWzKp5mLpC6Ypw8C+FsdtM32PSlAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795385639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=b0kJw802gh5uy3Pr7DaE+7uxe9KZuq1T1lj2n5oppe8=;
	b=pSjgpSNOFEsShv7Cif8WsEoKQQdZJdaH+ir4uwGuY9UCm634kjQw0gC5HO2Unn0VfB/1
	 5B64R/ugfbJi/Kesy8Vv4KVgvm8X3/yLXWC/4KJUPByzYHlTqAQgZmAUB5eCd5RpE0mVC
	 Rcm31JspXIkce89tvsPW+614iB3EadGCsaFvFlLsUaAvwTQamwH6q5Ij30mS7uxDj6Icc
	 HZco0uOcU1RlLWdQvx3jsHaLWEaUYhmcCuzoMxspwE5G1LlzmVFl9xXJVHNPbjDTiYD4w
	 YtVT6BVvnNhcG1PaK0nJgnoTEKsIqaK57fhJjJTyWFRWSu3tLseT9XHiLNUxu7bntQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEoxDNjf;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2774C606A31D
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 22:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2774C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEoxDNjf
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-385c497bf94so822815eec.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795385638; x=1795990438; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b0kJw802gh5uy3Pr7DaE+7uxe9KZuq1T1lj2n5oppe8=;
        b=YEoxDNjfmSNdYkLMgwYovHLULl2T8UFnl97qapp9oxPQs4yPVY1VTXqDcPl0qCaY4L
         3aKI3+Tj/pgxPgZAnzg0sZD8w2KfMeUYI0tp5TOBcLzvO+fsqt48QSI2dyTbha5IvEad
         X0fLmJpDuELJ0MyHbRIZOBREheTjNFT/UUrkK0fu5RDFxH85WNylOQ9XftVK9VMgT20F
         68KPtthsqnf3mmmsBf9bldSGAD3FO4PZfxCZ8yhbfpNH3vcXUwDD+AhQr3GN7xzzQsOk
         C3lqAnNrN/X/joFDQerIc0QZjiFycMOPP6DBk+VMLZS+2z1c81ItTP0wD7H2sXB3BkvL
         il9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795385638; x=1795990438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b0kJw802gh5uy3Pr7DaE+7uxe9KZuq1T1lj2n5oppe8=;
        b=Wy/9htNUXDuEjk0LrqPqb1a+IXtsvxfOlv3mmDgmjwKN/YqfLnV98ysndPSpEsRsFs
         desEl+3EMYE8eJBx0Nmv9O5lnDHbYLsn8SRJsyo7dLzc0oKwKcAaGo97cg7pLweD2l9w
         hRsWQoB3OhNIuzze4zl2EtAs2RqtTDHBPT4lyidQ2GfQxkfZqdOu5h5Ip9jgW+Aj2AcG
         RlaxD+8qlmbzIafToQP6aO8uD31HybhpURlijN0NXH5ZiGbP07ZnFgEOsNCj9PAbKEjh
         sFl3OeXcr8LPd0wrN1lZybpv8YwjeECHRArUhLoO/ey8Z0y+IalHpltwvwFtvMfC3s5L
         tWVQ==
X-Forwarded-Encrypted: i=1; AL+hErE8/3fmwXzb7yohcENldUegMbOjYDx13BzxjcomqzcnzZDaMO3saHCxoISs82vSghlVpidlnJiuUG017Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+8KgKoo8ILo6tEpgJQccwd+ghZm0eyHcMpXsQfUN+gpit2e767
	69vj/97D3vS+hWO68Wyl8eQPbgPRXTgCYpmG7Af4aTyf4FbS2zXxFOgj
X-Gm-Gg: AZFdTZfxFzINNuvJaVqRh3LtmJjLrErIIZ1330Bc2HmwwoUEfyv7CtySPVYtlfiuA5v
	AHVfOxuHz5VNI/NxEHI++l+FJPhZIVtvLJeZ9hgW4I40dqsEB/dlsxT1y27ym2IqNOoTi2LYrLL
	Pyz4G9Z226UkW+aUiqysLtyWMOPGSSNDRMEabTIyEmtzr9e+CTZihRNGD72RxU5MbXYBMWniEqn
	/cue+z8SN0LGc+82Fj6YGqsMHuYUeU9zvxOKF29eSU5cQUaknjh7qnirGErMu2nM6G2Xvttkoe2
	TIY6MebHOz70hEdt4+mwh9VXsdkN1UUalUes7WOTYc4yf0J6qXxXSeXYM6qToE05yaoJHWTzRF8
	1IzGFOUcBl4ztZhlnbRUX1Rgb1L9yd5mJJxxfxkQlXKGxEdl/i0k2iEozxBbwW0XOhJUfK39DrS
	ggpKUR1qxmdFIMZoT50u+QWWBxiNkX9kdkUn6bHNi1wAvlWyj3V0ZfSypJ6rybgaN+9gj2F8HhS
	pHV3YkEmNiOHvPLl+C/7nt0f3bJNqnHkbmTJ1PVhtouuY8LaALWlRnyGwhZlAT1weINmXYTxN/E
	yjVFGnd9BGNHDidyP7vnVDWyAlc9YVRVhkbK3WQXsyhd6mGmDonnUitu6mjG69JK6/1laog=
X-Received: by 2002:a05:7301:dd86:b0:351:2958:1740 with SMTP id 5a478bee46e88-3856fb641famr10062602eec.37.1795385638023;
        Sun, 22 Nov 2026 14:13:58 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm1957225eec.27.2026.11.22.14.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:13:57 -0800 (PST)
Date: Sun, 22 Nov 2026 14:13:54 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Siarhei Vishniakou <svv@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Input: add ABS_TWIST and support it in HID and Wacom
Message-ID: <awNosbiWPFdsbUN5@google.com>
References: <20261110020632.4003499-1-svv@google.com>
 <avKAaJxlxE8gOYVV@google.com>
 <CAKF84v00nJ_+2Tf8m66LhGEKvqnHb26YD6p+FRUXK5juYEPQZA@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKF84v00nJ_+2Tf8m66LhGEKvqnHb26YD6p+FRUXK5juYEPQZA@mail.gmail.com>

On Tue, Nov 10, 2026 at 10:57:31AM -0800, Siarhei Vishniakou wrote:
> пн, 9 нояб. 2026 г. в 18:25, Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> >
> > Hi Siarhei,
> >
> > On Mon, Nov 09, 2026 at 06:06:29PM -0800, Siarhei Vishniakou wrote:
> > > Some styli can report rotation along their long ("barrel") axis,
> > > commonly referred to as "twist". While the HID specification defines
> > > this usage as HID_DG_TWIST (0x000d0041) in the Digitizers page, there is
> > > currently no corresponding evdev axis code to expose it to userspace.
> > >
> > > Because evdev has no MSC_SCAN equivalent for axes, drivers and OEMs
> > > currently work around this by mapping stylus twist onto unrelated axes
> > > such as ABS_Z or ABS_RZ. As a result, userspace input stacks must
> > > maintain device-specific workarounds to know which axis carries twist.
> >
> > How is it different from orientation?
> >
> > Thanks.
> >
> > --
> > Dmitry
> 
> ABS_MT_ORIENTATION describes the 2D angle of the contact ellipse (or
> tool projection) on the surface of the touchscreen. Looking strictly at that
> initial sentence in multi-touch-protocol.rst, it sounds promising:
> 
> > ABS_MT_ORIENTATION ... The value should describe a signed quarter of a
> > revolution clockwise around the touch center.
> 
> However, the rest of the section clarifies that this is the alignment of
> the contact ellipse with the X/Y axes, not the "twist" of the finger
> itself. In fact, the docs note that orientation can be omitted if the
> contact area is circular - even though a circular finger or stylus tip
> could still spin in place, and that rotation would not be conveyed.
> 
> For a stylus, orientation is equivalent to the tilt
> projected onto the touchscreen plane (which single-tool stylus drivers already
> capture via ABS_TILT_X / ABS_TILT_Y).
> By contrast, the proposed ABS_TWIST can be thought of as keeping the
> stylus at a fixed position and tilt angle, and using two fingers to roll
> it in place like a pencil.
> 
> This also matches the HID Digitizers specification, which defines
> Azimuth (0x3f, rotation of the tool projection around the surface Z
> axis) separately from Twist (0x41, clockwise rotation of the tool around
> its own major axis), and hid-multitouch already maps HID_DG_AZIMUTH to
> ABS_MT_ORIENTATION. Since styli can report tilt/azimuth and twist at the
> same time (and single-tool pen devices don't use ABS_MT_* events), twist
> needs a dedicated axis.

OK, let's add it then. But we need a more precise definition of what the
values mean (i.e. is rotation clock- or counterclockwise, only positive
or negative, what 0 means).

Can we also move it below ABS_SND_PROFILE in the doc?

Thanks.

-- 
Dmitry
