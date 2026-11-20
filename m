Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191219;
	b=xDhZ6y7DoZ0yqWbCMNxUgRRl6WsmDvB8LyopMqCF8Djxfeuoh38J16hlePaAeNuetBY6
	 oY8l3Gx4HCjvxrE/mlpPz4eEr6v02qA9DxEkrgoHaEJqhZA4AnsNvNlmDvUlNHFS63Ba0
	 eruz42v5qU7oxrNkrb5VlF4jlEfTrD45LzkXW9yToAEURhSU+GDwrQojey7bMx93yiege
	 x0lUuaOsbgBzEysWga39oddqA+Qny5eL5zmludrDR7/FKsgvmBzs1PMSaxctw26/i//B3
	 QLPR2mE+se+ZOS88g5lJ9vswbbgJnGr7xUmPjvnCuK+R+VwGl0C84n0ZriXepNihf5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ske43Fh9A8yW85CHf4qvTL9iEMX6C/Nlv/vlJ5RihTM=;
	b=VSdqmRaJXchfMqQfjXEhIV0Ej0eLveO8vLqqUUwXGQopZVglXTMKUCqGwY0sjs3FAQOy
	 rNjg5KGg7eAOEhUa2Rvb3zlnWpyIiAwzO/NXFqDEovNsqo7+4Hn+waTPEzZO7D7cmROtm
	 CVhd5XO54oM6Qm0r53uir5XszEV+pIw0MiamZFvTUSFAjbRysEw95U+qlCITeqr8xXkBx
	 R1BI0wqRtXAbMx0fhXip8NCQlHS29tdcHIOoIL12HCSdPS7fRTYjkabJ3Vf0kN3C8yj2B
	 So1S1XnLj7BXspS0KeF0ogErn4umFyYC0158Kc8p1y+Co7wkj6rNqXXFPJ7mL5IXk2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=DVTGNfn0;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F14606A330
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 16:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8F14606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=DVTGNfn0
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-930c0f9c1b1so117800885a.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795191218; x=1795796018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ske43Fh9A8yW85CHf4qvTL9iEMX6C/Nlv/vlJ5RihTM=;
        b=DVTGNfn0RcRD8xfB+MwwKXCzdG/2IJTQQR9aTVOkOmsK3ahaMAX0zhRCFOIygzDqw9
         f3lz3ZzXi8QI3ehzyGCslUcbAG/gxV+tGhZ2KFcrn0+zcIopkJ4NNcm7Xoo7X9OmJfoL
         jVuQ3eimiXdBh2Ma/je3e2nCkdrkPLU8V5x5rwXabvZ+6TiAfOX0/74y3dTxKkn4KPzE
         bktoH0I6MrCWADpcafmc+zr6zdmWr0G6JB/wYAQMl08Glz5W8nAdMN0os9EN4/U0JaEn
         AYvjOMByY49vLrNOZiK51nREyf43nfkrxaHvZc8Iyd00OjdfpqYCqcwhg+MuZvgqpiLy
         KIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191218; x=1795796018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ske43Fh9A8yW85CHf4qvTL9iEMX6C/Nlv/vlJ5RihTM=;
        b=QSI3EIedgWy+UHPfUDp5fP9wTQ/3cNDaxZfBi6Zk0U6PEA7me5XahYVwLYC3oFWzZJ
         ThYHO/gdGpzUaw3ahMVu9XjNGTSr4pIIu+rPD3+6qWNeclXUPDtwxe3WMYgYCaPAyu8w
         eCsSxBKH9bkw3aOgquPCK/UK0joR/BVdfd2GZ4z+N6nPrtIrp8tuw2LQbZppfWuyyoNL
         WBuVLCUBoWq9d/lJol0Ge4WZPdx2jMPbsci3Fg0Z5qGn1p4D4vqqC0eYyj8ITa+Y/tna
         jC9eF6vibrvOYRPJzHh7rBc3L/OzcqsqAQcR3myLN6FhyAfN4QBbn/9/e4pn+FcfIZiL
         ol3Q==
X-Forwarded-Encrypted: i=1; AL+hErFS0a4ByxkVX6Nfrz+KKg/e0U/n4Jc1dUlPqaEbXiKh4YIS3bMukkeyOpu0eb/0CiV6MEsm1K2wbN+crw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9du0H25BWskz1gG63avToLcbuVFyaaorKbEYv/U9srF9nzyelT
	7GbcBYQDSVm8J8rWqAvhFnxNtOhDa+MMTqDl/X5Mpp9BXzX4V39Xz0RbK91Puaz71Q==
X-Gm-Gg: AYBFou3GIhwx6uWYG6JJYorbiZOsfCbfLIjESxhBxFJUh/OsgJBcKFegfnYxA66jlta
	GluPFBfxZNWBiufrRNAuKP5pm3lEn06KiM3PLQsU+fqYDUILU8iNjTW70kIsPquKfllfsEVMEnR
	ZFURovGDFopnF0XK3YGz1yuTaX9mqUI9OdYa0Cwo13V5GMAsSpXPNkFcAnLtbGh64h14WmhWFSV
	gZDkPI8baSEIcEwEqUgwql70tLwXcBBRVLa2grLhWPecRW+E9QoIq8T/3bCzM4PD+iz0fN9054X
	SLPnjPFovC7eGhPc67XAWQBY2PF1zVAFBofnLCUC6wcHZKx+v4WmGd8jZJoQPUu1VsuFonvGwZ3
	7s+7gxnthK1o1f6r9oKboCW3mE2nvAlNq6W1fsi6ZLUT0KlZeaE9KnjrhaARDQTSkAH2AX8dq0O
	CqsiEg6QEaYe8VeNR87eIXpB+9JjOmvLHNNtY2JxGAfYZWfSN2wazsD+qLaJ2fp+Qu4XWI26BNX
	aSZ61b6d+RQ05gmWRbnw0bRf6/4ScKOPoDkd93ZLWXH8+IwB782nxmzp7PfcdA2OFdzwYOeScpH
	7JIR4a34YasyjRD/aCKpUUD6dZn7yg==
X-Received: by 2002:a05:620a:4488:b0:949:91c6:973e with SMTP id af79cd13be357-949bab66f99mr562619185a.65.1795191217744;
        Fri, 20 Nov 2026 08:13:37 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41c105sm217536885a.39.2026.11.20.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:13:37 -0800 (PST)
Date: Fri, 20 Nov 2026 11:13:34 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shihuang Liu <shlomojune6@gmail.com>, linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>
Subject: Re: [PATCH v2 RESEND 1/6] USB: add usb_make_subpath() for formatted
 device subpaths
Message-ID: <c3579747-1dce-4444-8635-5c3e836afb6b@rowland.harvard.edu>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261022070929.20820-1-shlomojune6@gmail.com>
 <20261022070929.20820-2-shlomojune6@gmail.com>
 <2026112032-pecan-knoll-4f4c@gregkh>
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
In-Reply-To: <2026112032-pecan-knoll-4f4c@gregkh>

On Fri, Nov 20, 2026 at 02:13:53PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Oct 22, 2026 at 03:09:24PM +0800, Shihuang Liu wrote:
> > USB drivers often build device paths by calling usb_make_path() :and
> > then appending a subpath. Several callers use the deprecated strlcat()
> > API for this.
> > 
> > In preparation for removing the deprecated strlcat() API[1], add
> > usb_make_subpath() to format the USB device path.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >  include/linux/usb.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/include/linux/usb.h b/include/linux/usb.h
> > index 1da4ad1610bca..c90ccea0cdbf6 100644
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/errno.h>        /* for -ENODEV */
> >  #include <linux/delay.h>	/* for mdelay() */
> >  #include <linux/interrupt.h>	/* for in_interrupt() */
> > +#include <linux/stdarg.h>	/* for va_list */
> >  #include <linux/list.h>		/* for struct list_head */
> >  #include <linux/kref.h>		/* for struct kref */
> >  #include <linux/device.h>	/* for struct device */
> > @@ -987,6 +988,34 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
> >  	return (actual >= (int)size) ? -1 : actual;
> >  }
> >  
> > +/**
> > + * usb_make_subpath - returns a stable device path and formatted subpath
> > + * @dev: the device whose path is being constructed
> > + * @buf: where to put the string
> > + * @size: how big is "buf"?
> > + * @fmt: format string for the subpath, without the leading slash
> > + * @...: arguments for @fmt
> > + *
> > + * Return: Length of the string (> 0) or negative if size was too small.
> > + */
> > +static inline __printf(4, 5)
> > +int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> > +		     const char *fmt, ...)
> > +{
> > +	struct va_format vaf;
> > +	va_list args;
> > +	int actual;
> > +
> > +	va_start(args, fmt);
> > +	vaf.fmt = fmt;
> > +	vaf.va = &args;
> > +	actual = snprintf(buf, size, "usb-%s-%s/%pV", dev->bus->bus_name,
> > +			  dev->devpath, &vaf);
> > +	va_end(args);
> > +
> > +	return (actual >= (int)size) ? -1 : actual;
> 
> -1 is not a valid error number.  Please use a real error code, AND spell
> this if statement out.

Also, why is this an inline routine?  Why not just make it a normal 
subroutine, and put it close to where it gets used?

Alan Stern
