Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180437;
	b=Wc8L3zjwXZpPmnav5bTci3YxCe2ZUBkYqMboRpmU3iSdAGsrnXRrkY5P0z4UDWnG53nP
	 XLIKKwj30p5AlivqcCuZGYUajQ/ewz+1CVIYnTENCyMuo4EYivzOx6KO+o8B4ktw53E/3
	 bdfNb+yMGZ6ukJFBMqkIjfGNsn0l2Ywp48iLd/OI8vfZf8sUpzF4qRMKZVMObPXZFbl5t
	 P7Gn9Xa6jLFWTZniD0P+qX37gBkRmVEq+u8u78X0lkcXbcK7hNErMjTMS1EZl0x/dBQT/
	 uJw9vKiq0h6CkSbSBGyBoLnbhOt42lgl0ABWyqhzVLy+vA6lTN/ykcmsAp0JWpG3o3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180437;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tlEm898c3RTEH5485EhuXjYcv+V6JoSnqzGBIcz5A3Q=;
	b=TK6chdW5yi/qT+s5QwDu+B8RUkgbhRVgzBXVmLbF63dbK2avxHN1gjkhRIWzHoPup9Yi
	 H7hiV+NkIEIO5rJSe3aVP/Me9AeEvdVEdo9xqX1Sj7w6CokoPeOcnjrSqzh9IwKqSY4Hg
	 ewyTPcKAqvG8s1JeLFOgyKk0MAz0UtBu3VxZMIna342FaFfA2JWLtLo7CHXXSUnRcLu/y
	 QkQ55hCGVIj1T913EDhJ4FoOocgdWLJGmQec7yokw6SJlyyDr1OzfP/Khlr3ZLchYM4DQ
	 y1QdED9a/nc4VZcpYJK0vTI2liCGdX7VGq+jt6oLSZuKuOkPAykRsf2Xynf6WjUAClQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mJO1eOf0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150DC606A320;
	Fri, 20 Nov 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mJO1eOf0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA46C1F000CA;
	Fri, 20 Nov 2026 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795180436;
	bh=tlEm898c3RTEH5485EhuXjYcv+V6JoSnqzGBIcz5A3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mJO1eOf0v04y68J9JZ4bmNrCvSNo2hIOzfJkwVOgV4vurJjv/q+qv/pGfd14CFfKc
	 2+T8BZ4JL3dccXPO5nO7VCPRRpA3IP+mYA5sUWi1glCjOp2MPjx7Ny25RBzOABCKtX
	 qyhAk+eRkgauhXG1FouZHeueKDqe3IJUUfyNq0Eo=
Date: Fri, 20 Nov 2026 14:13:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>
Subject: Re: [PATCH v2 RESEND 1/6] USB: add usb_make_subpath() for formatted
 device subpaths
Message-ID: <2026112032-pecan-knoll-4f4c@gregkh>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261022070929.20820-1-shlomojune6@gmail.com>
 <20261022070929.20820-2-shlomojune6@gmail.com>
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
In-Reply-To: <20261022070929.20820-2-shlomojune6@gmail.com>

On Thu, Oct 22, 2026 at 03:09:24PM +0800, Shihuang Liu wrote:
> USB drivers often build device paths by calling usb_make_path() :and
> then appending a subpath. Several callers use the deprecated strlcat()
> API for this.
> 
> In preparation for removing the deprecated strlcat() API[1], add
> usb_make_subpath() to format the USB device path.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> ---
>  include/linux/usb.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 1da4ad1610bca..c90ccea0cdbf6 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>        /* for -ENODEV */
>  #include <linux/delay.h>	/* for mdelay() */
>  #include <linux/interrupt.h>	/* for in_interrupt() */
> +#include <linux/stdarg.h>	/* for va_list */
>  #include <linux/list.h>		/* for struct list_head */
>  #include <linux/kref.h>		/* for struct kref */
>  #include <linux/device.h>	/* for struct device */
> @@ -987,6 +988,34 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
>  	return (actual >= (int)size) ? -1 : actual;
>  }
>  
> +/**
> + * usb_make_subpath - returns a stable device path and formatted subpath
> + * @dev: the device whose path is being constructed
> + * @buf: where to put the string
> + * @size: how big is "buf"?
> + * @fmt: format string for the subpath, without the leading slash
> + * @...: arguments for @fmt
> + *
> + * Return: Length of the string (> 0) or negative if size was too small.
> + */
> +static inline __printf(4, 5)
> +int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> +		     const char *fmt, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +	int actual;
> +
> +	va_start(args, fmt);
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +	actual = snprintf(buf, size, "usb-%s-%s/%pV", dev->bus->bus_name,
> +			  dev->devpath, &vaf);
> +	va_end(args);
> +
> +	return (actual >= (int)size) ? -1 : actual;

-1 is not a valid error number.  Please use a real error code, AND spell
this if statement out.

thanks,

greg k-h
