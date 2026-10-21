Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605191;
	b=NCeQCJfcybiVGxersDbCvDFc/8yG7R5k+VlzfY7bs/4t6eAHlsRtq2QQ+y9TsAWm84M5
	 tMB3HuB9KtwH0DYTGo1GQnzLYPXcZDFAabCW0DTCx48YMgSmCbHFHSmunOIZ7za3S6jKZ
	 914j/PmsV9rQbU+HdAScOy8HC1f6jqvAfi5xvVfrSdtgNWPjnMCkP67VI7NGxbxdHwGgh
	 EtY+LapzwNhOUh0Z1qYZXBGs35BBkvJm7ZzjwjUXHGXH+seGdO2l8SQqR/fgdUfpD6jon
	 E6Z4PCZn/4bB+Sy6t5v+KrOA2mkc0+02J5PsAXI8LufcBqnrBxB/MeLGgraTp+UqDdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=weV/t3lpY+C1wlkMGy3iusRIaCsEICQ6LvTEtzN/MEM=;
	b=uqWg/QRQZhCZjldhXNBrAtxrU790oGoF14YvAEIZguyBR04gigrfPnVlHRVOBcrAWIp7
	 sgsHOYINXZmWJME7EAM1RBOyn7rpbFFgjHIZ8v/+4RvEALrlAHU/T6a+ZDqoWqocJyi9b
	 2chQYnD8EIeSyVU7qC6mQ7Hk0Lm5GyX9mgsYASp24f0EMU/gQV13IFMc6EBe2RYdotD1k
	 Rt/m/g2BE0jMq1Vcl871YvSt7Ph/m+bwfsWnmHUSTbHPZr5E5NOwVrbGiKqlGD4mFZqml
	 SrNBboH5A8ANq9ScJVbUr1cPDz93lLcCoQGyjg/1epfyUjTzI1KVqhrFSItTU2tDpmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OPWzM0l8;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E19606A31A
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 17:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E19606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OPWzM0l8
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1052415c88.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605190; x=1793209990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=weV/t3lpY+C1wlkMGy3iusRIaCsEICQ6LvTEtzN/MEM=;
        b=OPWzM0l8ptIfPVIvgbXuCW6EegEHiRBkVWJ2jiXv+CgDRuQWgxn4j8B34jOF3TbI00
         SsId14XwxZB/ca92qNcQDYAqwu0aYF+FICOSbdu+3UNLzb1l7WgSQ8TNxY+7hYqRNEhx
         ZlzCoIy68vjLJIR5HWsSYMptL6AQ05M62VP3VWTT/sQ8hhFGxWm46BSY63vo0xMor5L1
         oD9Tf2rTMd0U/iF/5kOg433PbgJj8JsrrQs5b08rEukFFnreMPj61Ryk+ztvCbHtTxVk
         UR/n1DDwNmGIfHlpAJyCkU+BFwCqC3yPe2zpJgiFympa8X1dVa8pMfSEh6m+mWbQxXYP
         KRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605190; x=1793209990;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=weV/t3lpY+C1wlkMGy3iusRIaCsEICQ6LvTEtzN/MEM=;
        b=diw3YRbuuKC/JBwtkNvC2A5ucLxr9F4BznpuuJZaNAVUAunedEEKYBO79gtP+G8YGs
         1kaKc6O+AKqwKvChF+2GryC8fElyy7vx1/PNEHIoDxohU3fFkOMphESg+9pgs4+m7YrE
         bdKfVrJVP2Sy9vGzanFPWiXLlLwm9vG/3pR/GrQzCQPCYxtWxFjfQ//zBLwRqLJO/C4M
         /dI3kr+FdFgmB1JuYpYeK0dznX9hkOL3a7fVpnpcTUmRG5778i0m6VbSfxrnZMvRo3R0
         QLXjWJlAaDrCfFyw2GfiQFFwRRRXrBh/DWydB1HkWnUAPl1RlHpD2aOz1aElUG5GJ127
         K6rg==
X-Forwarded-Encrypted: i=1; AKwUvByKHfnRI5c6dEwZnU1WlHIE2BqCL/LYj5cRG7OmwFGe+xH63Z1RO3wjfiExp8zsjeipPlpZt35oe5mC/A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLez5hPKueyDgXZRBxtybLx4g1UKkPprGoL7hYjHzrIjOMfy0wN
	2qcUVftn1xXpJpP1Q7A6LbnDwuENoK8cxiiaM+l6ZMEOXtQAZNqxTpcv
X-Gm-Gg: AYBFou3T+BYiFAZP3UEUeoCyOfbcRZsIlszgbF+jw4FUHhlh60uirLY6bp3xdQcLvtW
	uDU098XltBL4sx+OprKdy3SXbCtylCVD9hFKmBtUOZMagb/gL/kV8ZHIoG2X8tlX2lbl77itzE/
	EFVduIKmCoV5DpRqtljsBhMHgSQsMU5YrVsYr+7WKsXulmYJcFGdVEDXW5iIo6h4mTZtRBuvV3v
	9Nd1pTg7s78Vh3WPSwDE40qyl08/kunmRECnpd+tNhyhhR4LAZlji+cXA75kgxDvL8XgeJjDQSv
	M5AU2ZDAMaDfRhp0WXIn6yLSjiUWFhLrCAIpcf6vIIHByfC1bg1LWYnx+0B4LO/ieuIAMdjlghe
	C+d6ox8e6kXLHH81pAbwG4fs7cDQ0ycztlzzRjmXsA7UlYk3lXl/Wu4hLt05BkmL1Xu6M0JSrTb
	ig0EAXb9+Yoxzfv+8EG4z3yyBtsX8SYKCD0uBhlFud5eXaTGIpJg7fa1gOOM5Gz2GMV1sCJcD6k
	NsxrDxvvNOdlF0jqMBmSaaIOBJNl7WbMG/B0gBayuAE/NLSKReDtPMBUWlbL3U/km8BMpRRETU+
	9GcoUIJtxi3IdOcY2cCeYQ==
X-Received: by 2002:a05:701b:2313:b0:148:722b:7cbc with SMTP id a92af1059eb24-190a55c1a5bmr3066254c88.14.1792605189885;
        Wed, 21 Oct 2026 10:53:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180ca2sm7114896c88.6.2026.10.21.10.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:53:09 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:53:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: soc_button_array - use __free() cleanup
 facilities to free memory
Message-ID: <atj71VUZdpHO4aBT@google.com>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
 <20261021015004.1537738-2-dmitry.torokhov@gmail.com>
 <atjw4b-ICVGH3-2a@ashevche-desk.local>
 <atjyyqxnlqEvwNxh@google.com>
 <atj5pgIU0VCcrHHX@ashevche-desk.local>
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
In-Reply-To: <atj5pgIU0VCcrHHX@ashevche-desk.local>

On Wed, Oct 21, 2026 at 08:43:02PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 21, 2026 at 10:15:43AM -0700, Dmitry Torokhov wrote:
> > On Wed, Oct 21, 2026 at 08:05:37PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 20, 2026 at 06:50:00PM -0700, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > +	const union acpi_object *desc __free(kfree) = buf.pointer;
> > > 
> > > Rafael added 'acpi_object_free' for __free() (pun wasn't intended :-).
> > 
> > Not sure why it is better... It goes through ACPI_FREE() ->
> > acpi_os_free() wrappers which might be nice for ACPICA code, but has
> > limited utility in the rest of the kernel code...
> 
> Today it might be similar, tomorrow it might be different. ACPI objects should
> be freed with their proper APIs at least for the sake of consistency, no?

Fair enough. I'll add a todo to switch once it hits mainline.

Thanks.

-- 
Dmitry
