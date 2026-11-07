Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095957;
	b=5WM26MtfzlRSYDu9g0W42ARNr1JPw3Y7Ckq32kfmAx+veypUsCssPi1AzINdXQeR/3sL
	 tFtyFWlwuO+904qEI83Hil8fli5SarQoyeWq/nM2xVKyVIzN1GnKI9MxYhLX2TMYKCqW2
	 nNMEfMFQ2H+JQf7Ex+2cEwKOMKIfAMSBhgx3f73HWC4pezSvI167pEBuFMHyCstNvwQMZ
	 +tBHikorX9MkssfK4G+0OSW+oGWmsanyca3C7cOuUEhEp5BTBKW+ZXgnb99ALyEhshSL5
	 x94GI9CWSSXm7y/e0qwvKW81ugCNg6Yk08C5uK8i5j9ALykZkOj6HRU0YB0DAKhXzNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kCOZc6iAcXWp2hiznIFFu5kx2ZnmhlZFlmxyVqS3+No=;
	b=UNbwIcATJKcVHdqzmtrIlV2aVGaaOMtdEWtFMW9ZVwWbO7PAiwlM6TYib6YYJrdsSXvK
	 my3SVp2mGJi+r11JteiKpR3T2pN8PVvFBWSVrxWqSwMF97nyfcClo/nrt90Jp/4junj8y
	 kI/Ivo91T96WqscBrsgd6zZrXS+l4poAFfrERwqjblIvpqNT1/wLNSdFS9hbUzRruQ4vj
	 AeKR5OilKLKoPVnNeSM1bIqkKw+m0cQmP4TlkBiR5F536pZEgLeax4ZG9ZGRu4pjbXNcW
	 Pe3WvZ3TUb3n2IuqFYUMcVXWOOEWAr5mYseApAjVOCGNf4QzmkodIk4pq6PViSGL6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWZk7947;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F77606A326;
	Sat,  7 Nov 2026 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWZk7947
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5BE1F0089F;
	Sat,  7 Nov 2026 23:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794095957;
	bh=kCOZc6iAcXWp2hiznIFFu5kx2ZnmhlZFlmxyVqS3+No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PWZk7947Eka/Od4m8tnPaUmdGGsPIyF9eff4iSNWZwpX3g5wkQOPWKhUt+O5574nZ
	 7O+pdGgsNBGGMdK5/tWtxgh0bOK71muEcTyxQ1Hbb2P2bcWRYbv1fVw3RwHJL+IdtR
	 SVCxKs38Uaqoju1nZNt8Wlb6glCSZoYQRM8FDm6WOQyO0OKk435w25OmIkBAvIsNey
	 pBxudCOK+6Cg4aa2BE73arJsBeDiekSrWE7r/eqkMV8vQu9bdfBFeShxJrekpqocvz
	 ljtxk1w4k9hagcFQwy3NHgTWb85WulDaY/Jg9eQ4ZlmEOkScoc5ghGzR1rJIu57/kJ
	 H/3h1V4GT0/wg==
Date: Sun, 8 Nov 2026 00:59:12 +0100
From: Thorsten Blum <blum@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: amijoy - mark amijoy_phys as __initconst
Message-ID: <au-7ULg8TnNUBSRM@kernel.org>
References: <20261107174739.369375-2-blum@kernel.org>
 <f7574ee1581d609d45e0ff35e6d908b0@gmail.com>
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
In-Reply-To: <f7574ee1581d609d45e0ff35e6d908b0@gmail.com>

Hi Dmitry,

On Sat, Nov 07, 2026 at 03:19:38PM -0800, Dmitry Torokhov wrote:
> Hi Thorsten,
> 
> On Sat, Nov 07, 2026 at 06:47:38PM +0100, Thorsten Blum wrote:
> > amijoy_phys is only read by the __init function amijoy_init().
> >
> > Also declare amijoy_phys as const.
> ...
> > -static char *amijoy_phys[2] = { "amijoy/input0", "amijoy/input1" };
> > +static const char * const amijoy_phys[2] __initconst = {
> > +	"amijoy/input0",
> > +	"amijoy/input1",
> > +};
> 
> While this technically works because __initconst only places the pointer
> array itself into .init.rodata and leaves the string literals in .rodata,
> I find it too subtle and fragile. input_register_device() retains the
> dev->phys pointer for the entire lifetime of the input device, so if
> anyone later turns amijoy_phys into a 2D char array to avoid pointer
> indirection, the strings themselves will move into .init.rodata and
> dev->phys will become a dangling pointer after init (with no warning
> from modpost since the reference is inside amijoy_init()).

Thanks for the feedback.

> Could we either just mark amijoy_phys as const without __initconst (it
> is only 8 bytes on m68k), or drop amijoy_phys altogether and do:
> 
> 	amijoy_dev[i]->phys = i ? "amijoy/input1" : "amijoy/input0";
> 
> in amijoy_init() (which stays in .init.text anyway)?

I prefer to drop it then. v2 is here:
https://lore.kernel.org/lkml/20261107234349.382944-3-blum@kernel.org/

Thanks,
Thorsten
