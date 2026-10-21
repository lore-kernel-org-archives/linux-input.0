Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603430;
	b=QAf0HbTMyHuBzpj5slnWPzIT5EVYxrvVgC1d19AU6plXiPN06Lev1E2jF5flvHvOARnk
	 rqUI2+z2rEfCey+tnECqBhkRSTVNLF0BkkIwO4PRxGuGl0cp1wx9pQg41qzdHJR5u2RHN
	 +b5krgTnsbOVvs4FXXPpiK985a/PjDZ6vIA6ETeQAXLvDrNVFd0Nr4DANSoFXh2YpF5gQ
	 SteQk2f8ZxbZZmU1KYTbU2hTJ9A5vR/z5ckvZtUSaR3PexLsF5DjRb+ZHI8HM30r612Tm
	 bHfZy/Ik90kU7TjpS07Wrrvzp8jH4f7c9e9W2qbhNJjkAzX9xhWd7SGAyLC5xrHSBHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Xq/Mntuw9H/QDRiWvp5bTN6HG/D1JEq1cQYOqHkRs9s=;
	b=mDIZT+Y86pAIx9uBKaEMT1hLS/3mfx+v4ZNZavTzVJQ5bFDXDTkEaaQbhiISorACL8uQ
	 x1ed4z9l7aoVSRXcMxTwAxiEbGBDhPrArLtSL1T31CVCRwJH8vfq2tm7xBQeb5gPuq3es
	 76egM6DbbXhJZgEx+brUs3Tu9SMlhtRB0s5bkzaUBvpjG0ltFllYyBUJa5CnPAC99gShp
	 3rqWrTwViNN8C2EYdR0cy5Vhr7gJYfFd6dcX8rzYOViB6NEI6NV/t63NEYFQwcuQImUbv
	 rLA5iN5gmT7U7neLtEuvk0fJpipqcVpuFtZJepFUAsRJH/0uGuJfPJ1xd685J54jA/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sGg2zhx8;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B4606A31A
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 17:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D3B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sGg2zhx8
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1018572c88.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792603430; x=1793208230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xq/Mntuw9H/QDRiWvp5bTN6HG/D1JEq1cQYOqHkRs9s=;
        b=sGg2zhx8XpQ8Y5VWsNzVZmU+N+t47KA2UleuuqA+pv1bdRFdvq+jMtwQ/tTGUHHEdF
         iwSdBVrtn5guZIGBqvqjI2TEM1KWoKWAafzY2dLUCwcnRt4U53jsa7f+gKX6b9N+HTd4
         SBjX6aGM6nnwgR33oZLRdcXBG2MYVs6OPxvcNIcRnC43Mr0PvcjfN2zqUYJ7AjwZqIAJ
         CcRcCll3/sl8aCkBOe6iKkQrmCH3jPlq/5YyJYkPJeVJJeX6bL1wPSFCkim1HL6vl1PF
         jJFOfHsEQwRT8pGWVKX578gxCYZFA1M0/k7THKtPhhL4s3z8EbBp9+dWN+latvtZlZ2Y
         7sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603430; x=1793208230;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xq/Mntuw9H/QDRiWvp5bTN6HG/D1JEq1cQYOqHkRs9s=;
        b=MRbIzyIJ31Nos3bPQ/lHykpr1jIiZXqEGXY/i+5yq06W/KccPqIaZR7qXAGTu+KNO/
         Hu7KwEgzHVz0FTs+U2LvTeUeKcfmtiWDeE5qczhU/8dM98E7kodX2Zk6h6IYu06X9RSt
         V7WuNFBC2Awu6Bd5q8ZDRohwLKT/UkIU2sKsSIkhxfKdzKau1jPPeMuxlBPpb46TTyWH
         hs7s128xTJ5Yb8jTF2O1SakSOcJMilP8BKLljyhT5PS5uSOyfh+xDxW+kz4ARXj8diD/
         yktOKmbdSk1db3lQKjQHt+HlmZHgTTXJ1z1qZEActRI++koYxNzmqUcxBJnTwu7qUbBI
         PX5w==
X-Forwarded-Encrypted: i=1; AKwUvBwPNyrv62BF0gsM9bNq80Vx+zdJhCnyE0xvloy1iLNondZ9l1sxu1R2YAVJXMgtiQZvcksnU2be7IIELg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLZqoufF0jR8yeA+vTbEI82BLrg8rzNDE1MvH2W+wisz5xYbyLI
	Cvxdvtztxr3I/US02U79KPZEw1lD8R7rc+pnafoaiMSREF0VxWi61bKx
X-Gm-Gg: AYBFou1QSGdmkrJObRXlOF7hy4NamEagIn6bqgMkZU+GMgmF6/mnKvjFiTDVKUmyzbn
	Po9uMEs0aSsgza+Wh8mNDV0YqKoFJQ0hXrxs3j3BZ4rsLWlkW1F72MoZMnOzaC/ksU1uLQjL1KT
	hJF++5Jp3OTzsqt2+c1OvBZjH9kwv4/n4zwJyNzFoiOA/alTohuRHLn2uVTwDgXLSeDc1u9yTGX
	FiHPg36llKLhIXtVG6VdnG2aeHOjL5t6c1Qg9YPUb9H3lXbLhWLkdnEHSS2zqsSX7K41FnFd2tt
	OqMuzEBR8r3bWDzukZdI0qnjoOeu8LFTvgIW7eqglzfiaduRbV4MEDttr/jV83F4bG8Wl51WvRU
	abzc0SV5kscbzY8k8tIMlcT67nT/zDkopiYUCPTVRF5Mh954SWDtwlbC6V5aqesT44zL9Zz9Ecf
	IEIkZdlZVvoRCaNNvQcy5tsbOFcGl77qiOhvBGxYD9o8ZKexpnurNkV7obznVaKfALsBPL0CCFG
	xXjsS/mC2sWBC8Qse0wuPMpo+qIJKUpqNOBO2cobCuxRIC/yhCSAzoCT9RAF0QIdyvmoy+f+x5s
	bDsDmmMwtCcByiXgs6jUQl5YFsJVMdtHijfdLOGZ7Ng=
X-Received: by 2002:a05:701b:4517:20b0:151:70a0:6bfd with SMTP id a92af1059eb24-190a6239183mr3020964c88.24.1792603429511;
        Wed, 21 Oct 2026 10:23:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903aefe90asm7430112c88.9.2026.10.21.10.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:23:48 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:23:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: soc_button_array - convert to software nodes
Message-ID: <atjzqdtaduFV6B7M@google.com>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
 <20261021015004.1537738-3-dmitry.torokhov@gmail.com>
 <atjypFBUGPzWv083@ashevche-desk.local>
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
In-Reply-To: <atjypFBUGPzWv083@ashevche-desk.local>

On Wed, Oct 21, 2026 at 08:13:08PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 20, 2026 at 06:50:01PM -0700, Dmitry Torokhov wrote:
> > Convert the driver from using legacy platform data to using software
> > nodes for registering 'gpio-keys' devices. This allows us to
> > transition away from platform data and use generic device properties.
> 
> ...
> 
> > +static void soc_button_remove_swnodes(struct fwnode_handle *parent)
> > +{
> > +	struct fwnode_handle *child;
> 
> > +	if (IS_ERR_OR_NULL(parent))
> > +		return;
> 
> Isn't this redundant? Because the following has it inside already.

Maybe but it really is not obvious whether the latest flavor of some API
handles error pointers or NULLs transparently or not and whether it will
continue doing this.

This is not a hot path so I can think we can spare an extra check.


> 
> > +	fwnode_for_each_child_node(parent, child)
> > +		fwnode_remove_software_node(child);
> > +
> > +	fwnode_remove_software_node(parent);
> > +}
> 
> ...
> 
> >  	const struct soc_button_info *info;
> >  	struct platform_device *pd;
> > -	struct gpio_keys_button *gpio_keys;
> > -	struct gpio_keys_platform_data *gpio_keys_pdata;
> > +	struct fwnode_handle *parent_node;
> 
> Can it be one line down, so we keep reversed xmas tree order?

Sure.

> 
> >  	const struct dmi_system_id *dmi_id;
> >  	int invalid_acpi_index = -1;
> > -	int error, gpio, irq = 0;
> > +	int error, irq = 0;
> >  	int n_buttons = 0;
> 
> ...
> 
> > +		child_props[prop_idx++] = PROPERTY_ENTRY_U32("linux,code", info->event_code);
> > +		child_props[prop_idx++] = PROPERTY_ENTRY_STRING("label", info->name);
> > +
> > +		if (info->event_type != EV_KEY)
> > +			child_props[prop_idx++] =
> 
> > +				PROPERTY_ENTRY_U32("linux,input-type",
> > +						   info->event_type);
> 
> Make it a single line, you seem use 100 limit anyway.

OK.

> 
> > +
> > +		if (info->wakeup)
> > +			child_props[prop_idx++] = PROPERTY_ENTRY_BOOL("wakeup-source");
> > +
> > +		/* These devices often use cheap buttons, use 50 ms debounce */
> > +		child_props[prop_idx++] = PROPERTY_ENTRY_U32("debounce-interval", 50);
> 
> ...
> 
> >  static void soc_button_remove(struct platform_device *pdev)
> >  {
> >  	struct soc_button_data *priv = platform_get_drvdata(pdev);
> > -
> > +	struct platform_device *pd;
> > +	struct fwnode_handle *fwnode;
> >  	int i;
> >  
> > -	for (i = 0; i < BUTTON_TYPES; i++)
> > -		if (priv->children[i])
> > -			platform_device_unregister(priv->children[i]);
> > +	for (i = 0; i < BUTTON_TYPES; i++) {
> 
> At the same time this can be transformed to
> 
> 	for (int i = 0; i < BUTTON_TYPES; i++) {
> 
> > +		pd = priv->children[i];
> > +		if (pd) {
> 
> 		if (!pd)
> 			continue;
> 
> ?

Sure, why not...

Thanks.

-- 
Dmitry
