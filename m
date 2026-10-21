Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596696;
	b=Ur0g6myQ/0Tg9Ov92xrEdWVpub1DXzT9vROR1UGWq7pT9zjU9XA+jcWaKbVpWeU2RAC1
	 caQixETX/3W311gr86uVIwk/aw+XqYovNHsxqKee9Vp8X0gmwMVHmbFHEfneYuEnHUwcF
	 quQB+oyIH/IvjsbP0w1Bco9e70ovLiiyKpVAb5ITIUspGvjM0kcy5JuIHNUDU+RFtukxG
	 JxQS27iHINbaFDikqfCf7tBv4wf7KWs+c2MTfsR8+HGZQWoSVACHeDdp0Jmzm3zeuOOB4
	 odhnLhBxFY8VG99+svJLDpoWcNPKQUPxy9fslcCRu6kpyiES3+aLClY0VvLSKH85s3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596696;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PbLaUAqi4Qq3J1XvmxKzYE8IzcX5IC1tbOzRiCo+zZ0=;
	b=suAa6+CBXDzYOSX0JQ4OHQIvQrDZPfl03Qlswv6x74XPe+06Dwbjni0i6AigQH13472Q
	 9LByXGcu9nTXDHo0/K2iYi2y8HFWoqREHMPtkA3CfHDWQG9EW0109bF+layyf1vbFrqtU
	 6tvl95i0Gy7tkCMdNhpC6qQ5x+kKdC9oewyW7Ja8e0i+jVVISdV0sHkZLC7iq1TiH/Lj/
	 +SnlryXpQul53/APnSk5AxHeWKot6ny0RWvymQVYRkjVwVW3+OPZ8lkhI3Ug/4UzUomX2
	 K3EJPddwEmpXfSfZAxbqdalOAAtaPLn2sS0i8IPtjWbIXVjBH6WjE9sSSmnb3dcOskA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bQFyhHRv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3E606A319;
	Wed, 21 Oct 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bQFyhHRv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25811F000C1;
	Wed, 21 Oct 2026 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792596695;
	bh=PbLaUAqi4Qq3J1XvmxKzYE8IzcX5IC1tbOzRiCo+zZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bQFyhHRvtFr/uBBG+fW6imD15FZ0G0ahkNtOsSM9UoUtBaqRE9vgITc7zf0lhA7FE
	 R2+DFmqyFhWP1f7uQxE2LFZPxL0sdKt2xWqS2Hzf6kcFoly2LIJWkCTs0ktxMd0Zaz
	 3p55sQWaZiHD8hM84Q+yyvqO2mlgWhNEkyohdfGQ=
Date: Wed, 21 Oct 2026 17:20:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device
 subpaths
Message-ID: <2026102104-audition-unbraided-05d1@gregkh>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-2-shlomojune6@gmail.com>
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
In-Reply-To: <20261021123146.17202-2-shlomojune6@gmail.com>

On Wed, Oct 21, 2026 at 08:31:41PM +0800, Shihuang Liu wrote:
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

Did you forget to use get_maintainer.pl for this?

