Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654605;
	b=GNf/2qYOpfeMlj8dnwW0Jg0dSCL0yAe6bCO8+Si9BqvZwS7X8TZItzevEcsuxRP38+2E
	 Hd30C06jo+C4NBXuP0vB9p6Q/rq63Lkse9dulfPC3c30mHrfJGDEds7NDn4mrfYqfEg5W
	 DgjSptzwUzrCT4gngoQBNSUQgWSZIClmMUcOEztOUGB6s1DccQ9SamJdUYr6CuuQje7lz
	 C2NG5zhZXB+rQ5sH3ys0gAcHoY1Gby6oBg+WBhQBmTXMrUBwHL/7+sk3KldWHFpGvROuA
	 xUEkZ59gTB5vzVTUrnX6MaPRXCq4uZQJfkxB5eQAjl7cj3ld36/tykTQ7VB1QZJn78w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vhZJaErBTvR4/vMLVwCau5Oaj0vnh/Fm4H8k4FT36Fk=;
	b=HfpFkNwdjYTDovL2FcXqMCxu/cChUDWNF0+r6PJ2rVu/EMo8Rh5ULRFnA5N1aGNwOm2I
	 +PjUsOV8FW8wZoucdAlsEItSuQcu5ptmEuflJkMDYP3vDeEH6tWmilsCKTF0W/OxKVzAT
	 hcvDLsfqfR6ItKSV3+C3KOSbeOxcLR/hIjcD9ovEhQugtGgxWd7VFwLtoF+m8+N5CuOae
	 HSsLQhwtGHXBiM/J2po2nHOjS8SJMiFHgqXJ+15WM6VJGsw7MNj8eCqQM6uOjyExe1NNm
	 6xtXpGvUpNXsyTmg/PrrT7rzFYMHLedBM5PoqKJLTub+rgJoAXREIRO9Dlm3nn3+iIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dN08mXkf;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD028606A31A
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 07:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD028606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dN08mXkf
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac5f801d7cso419813a91.0
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792654604; x=1793259404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vhZJaErBTvR4/vMLVwCau5Oaj0vnh/Fm4H8k4FT36Fk=;
        b=dN08mXkf79FFDAxGBHR+VMNEFIyIUS6++BEmKBtNUdHXM63ew7nmjMsMUQn/Wa+QyB
         jwEHtTzMruw8Snt0J9YMI8P+3n2jNtTxLWbROTcI/TFckIX8xdVZ+XekmcVVnn8VoODl
         ikt1YVFz9mh+TT8fv/FA0/qBzXde1lJfmVfwvkjZ0Hax5xYGgrRPoy7vVaEpiFfrWvEq
         S6U7av0tL+2k/pCCeaON5a608/VhzdCJgqIvizv+juQmWcAhhE0nDfaW12Y6L9FvjDCg
         P5riTgwu3V09dwBwrLRd5GBeWmoryrEWaFdCz6OeXX7dCxZZxSxjc4GRo1PygV9GcRbL
         wUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792654604; x=1793259404;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vhZJaErBTvR4/vMLVwCau5Oaj0vnh/Fm4H8k4FT36Fk=;
        b=UhwJj+vNpTvtMuSyFOoJlgGMO7TM+TB0mXfqZzptVtTKn72xzI3MkomG2+e3nmAZ5x
         KxRMPffTOE9YLykysTCO/VGf0VnVOUeb1i2gqFfbPqoeakAW711eUSPd+ovZ8Mb5X865
         T+A5Ll+y/HhpPT0trLjJHsnWZrYFbmv3ASDwt83yTKJ3W/BelP4qpQi2iLhLR5HsgzyI
         c7DNNyzgcg3k2CmB2dGleds9gn+sxkmkqiCto/4EnXa/X7Eig40RC172GDe1ZFvibgzJ
         7BFvT1mxFOPATapPgMuT5OmbHVDh16wiY/6OdAbN+jSF524BT+aQ0Lmkl3xQznBcs2ny
         0a8g==
X-Gm-Message-State: AFq9FYIR6hWJqLrW7No+Jg7OCdSW6+SIRToLlcmuIF89GGzr4o6aRThQ
	Bb5EULv1HkF4F6Y+XXHsq17WtugKSVOE0U4Jch6+3eNeXhScdxbryerp
X-Gm-Gg: AYBFou3asjhl+aKCdERZWtbOGeMWKW8tMHL+5fQNOS6AgRJOwD2qqYtbz7L+4odDLNr
	U+R/FvPx8e9IZAwU1HAfp5NX4YeEQDqqzfM+Od6goyNg70zmjWt3yeetpCFDNpNz2Es03zvO5cX
	hVU4/4festysgbcwFZ9E0kKVIP4M/OXtdETAzlOpEbcJ1FKBm2MStLBoZGv8NxINSFEQ4MoBcJP
	vkXykFjhiL4q4FZ8fr6hs5PxEhHhROgi7m0UzyiOlrBvflS9Nv7Dz9CtqL9gF/r9uMEuPXOqy7w
	ueGk3A4T+w9yYo0SctQK/RB0wJMVrGaIhkion1wr6sfuin5lQ7HQwSxGOd/I4/pVCVE/Fr0fyqq
	qlEonk1FceDzNahvcJ+zf5XtLOklBcFlHL0Ezb3sGzpgpinTX55jb2NVhBAO5vZMtHZ4jNZxxA7
	vWT4xbDLGTkdTMhoTCn8xS5OaZ+Fxp7mjLMv2kk4pjL8Et/IS0yAUJXdB7Mr7TMyh4a67AHHhqx
	HOxYSc8sIqJLKdIOzhkKVYnSrq42kByNzOcKWxFRN/PKV1Za7UQb7PUTW9zA3DvIGqajZfvRlFo
	zLv65CU=
X-Received: by 2002:a17:90b:39ac:b0:3ad:85fd:711c with SMTP id 98e67ed59e1d1-3ad86ce82a7mr3886173a91.28.1792654603953;
        Thu, 22 Oct 2026 00:36:43 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48876ebsm2951117a91.1.2026.10.22.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:36:43 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:36:39 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Message-ID: <5wdnvsf6bepzpxzfizt4fs3325denwzeeksg3b3hpmzu3257tk@ms7kh4fcgz2k>
Mail-Followup-To: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-3-shlomojune6@gmail.com>
 <ati7yINv0_Z3yPMg@debian>
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
In-Reply-To: <ati7yINv0_Z3yPMg@debian>

On Wed, Oct 21, 2026 at 03:21:28PM +0200, Alejandro Colomar wrote:
> Hi Shihuang,
> 
> > Date: 2026-10-21 20:31:42+0800
> > From: Shihuang Liu <shlomojune6@gmail.com>
> >
> > The pxrc and xpad drivers build their input device physical paths
> > by appending "/input0" with strlcat() after usb_make_path().
> > 
> > In preparation for removing the deprecated strlcat() API [1],
> > replace each pair of calls with usb_make_subpath(). The helper
> > formats the USB path and the "input0" subpath in one call,
> > avoiding a separate buffer scan and append operation.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >  drivers/input/joystick/pxrc.c | 3 +--
> >  drivers/input/joystick/xpad.c | 3 +--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> > index 52d9eab667b7a..1a11e73d7cd04 100644
> > --- a/drivers/input/joystick/pxrc.c
> > +++ b/drivers/input/joystick/pxrc.c
> > @@ -169,8 +169,7 @@ static int pxrc_probe(struct usb_interface *intf,
> >  
> >  	pxrc->input->name = "PXRC Flight Controller Adapter";
> >  
> > -	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
> > -	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
> > +	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");
> 
> To be honest, I think the composed approach is more readable.  You don't
> need to learn a new _subpath function with all the details it has.
> 
> Everyone knows what a str*cat() (or str*cpy, FWIW) function does.
> 
> I'd rather improve this by adding strscat().  The reason for removing
> strlcat(3) is that it is vulnerable to DoS, and that it is inefficient,
> but it is good at producing readable code, and a replacement should not
> degrade that.
> 
> 
> Have a lovely day!
> Alex
> 
Besides that, strscat() has other issues:

- The `sizeof(buf) - len` arithmetic is a classic source of
off-by-one bugs.
- any future change means re-deriving the offsets all over again.

I'd prefer to avoid strscat() here.

Thanks
Shihuang
> >  	pxrc->input->phys = pxrc->phys;
> >  
> >  	usb_to_input_id(udev, &pxrc->input->id);
> > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> > index feb8f368f834e..0f7ca5adaeee7 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -2059,8 +2059,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
> >  	if (!xpad)
> >  		return -ENOMEM;
> >  
> > -	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
> > -	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
> > +	usb_make_subpath(udev, xpad->phys, sizeof(xpad->phys), "input0");
> >  
> >  	xpad->idata = usb_alloc_coherent(udev, XPAD_PKT_LEN,
> >  					 GFP_KERNEL, &xpad->idata_dma);
> > -- 
> > 2.43.0
> > 
> > 
> 
> -- 
> <https://www.alejandro-colomar.es>
