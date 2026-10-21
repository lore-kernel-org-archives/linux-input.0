Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602032;
	b=D1zMkL3wwAhKpDiBwWyNMK/+4w5RIwvVJT0Fxb0DMjYU9D+LM4ySJeIJe8VnASwnOloV
	 /8nCHrsV6kMhsbUAElpv2q9hhXdn9pc+MXwS0QEA0wNgxtTwKlEhTn2bz5h3OZNLHhQQJ
	 SMxdsgCMW5bcb7chA0Z5Uee4HABmjSfci848VUqkahjCnwB8pZG7joHBZKCMOkCSH0T+M
	 8L7jxP+TF+sitt7Jg6rb0TV3BM9TKeKHYmHKGkPyDu3qyWuR9+nFpoAOkc1KqgvA7eVCb
	 8oc8vtevsHZnP8Rekeq5TH8I8nkVw80eHFhvvXCfJTzKNmv6311+6DyLkds/QzLL32A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4p+sU87b0SPhlui/+SUmlIQxPYDUposWA1I/eyb2zBo=;
	b=rf4Rpv1ylcknE4x4fsjbtaA/NQIFbSlngGoPaWN3iK1Fj12j7Oqu/YDaDbEiWD1jmJ4k
	 ZYcMR1FQ+o/aBy7TCvYaSfA/H0mXoVdg2rvwCt0p4/dNqzEOni+3uMZYtDOpSq4KB7Wj/
	 Y8AY2wq49fXwpgyj52oQ23ZiJAqa8hGMjZkg1dtnmqKMVAnfV2p2uxU0yKDNhtlI9dv25
	 BrVT69OJJim91U/cgzgR7tzNSWNO4V07lvkvnLj7+TPwKY0eXSmZ8TI79dEsNO9/zcyb0
	 6zYX2Cup34ViQ3tEK5ZtONlj3LDDnEW+cb550uJYJOukTqHL+5N96fwyyMgHSMYETgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SDvSrkSX;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152E606A327
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 17:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5152E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SDvSrkSX
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35f1f76ea84so1373696eec.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602031; x=1793206831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4p+sU87b0SPhlui/+SUmlIQxPYDUposWA1I/eyb2zBo=;
        b=SDvSrkSXRN7b16uvHn0owN7P9wALOR+qF5x8hSgG0gxkjdrQLtuwhv2L5BARh97oX3
         aS1S90uq9tOtN3LVBcUJNa2t2TXEPT9VhIRziQXWF5/SVExqtLCNRjJOaR/aNcbwTcTb
         2urftg2aTjo0Ncs1SWWX1xR9l7NrXFdTLhKKnyDfYlOqypf3qKvZ50JkKfSXvX7UOwI/
         L86Pv04dIDfsNWvcSpXLhdETZ3Jc2t5BuoqjWhKgX7vQ9CyQFsYYkKT4by19rmtOpLKC
         Kej+lquPMAO/imCte++Zf4948MUu8wD2XHZZanc8LpJbGt7lCjPYGF8TMGUQcJxPSdac
         yAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602031; x=1793206831;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4p+sU87b0SPhlui/+SUmlIQxPYDUposWA1I/eyb2zBo=;
        b=XA2T+QpIs/hklfPzadglfjHRPKPQF4iBflXc4FbnrmIMalIu3fcnhHIcWKNQK2OJR2
         4bcqa/02BQkpRe+78VmIgdvCe5YotF0x3+O4vZ1GnzCvtJ12qPJG7VuY7HFpeogD5j2h
         R5weloksMxqZDH24GgXNS6vcWTOy+qGU7rDVG7uaSqAjPCh5aNtBGlETEckh1ycMhWcV
         3odnQfs/bvM6zbtHjbdOUMx9fUcxwcqwpXx0r0kcNhv8W2omY7ALkO4U1WKQmSpq4x5u
         7W0ja0IyS+jGTkm1n7vVZjpYjgDVzTW2DccuUaBKWgu7jNQaTRw0IuBttVeiykFn95Y7
         iOCw==
X-Forwarded-Encrypted: i=1; AKwUvBzM0LoNqKk5Bs7bYLIqZmJwUBA26zrgQLHRKdoMdT0o+dsg+UCHuZhLlyhigu2poKhGAx/Ug/ZbA6c5Eg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7xbXsVJUxrg1Yc6K75jvQ5KI6nnt5cqV3BEmfLoqFrw2zZeRJ
	LuQ0Vi8uOv/x/KuuEmGCGND3Jsq4KTrgmIiBHIhmgaMUaO7ZYpB8s7TR
X-Gm-Gg: AYBFou1dedJ+38w0QdoC+M3uJPe4q4YKjSrMzHp23PE12B5VhFmVDGnZC+QXpx6RQdw
	TlpoYeXjRbofpRZtcGuosVr9pEoSJQU7GK6P2nhAAfAkDuid5YgCf4bxxDdxZP8GhwxAWdsUh/0
	zJivG4ZPcUAHBIYk3Yt8GDqzxfTnTTE1z1nR7YXu8nJWEl4bC3CsITnh81X6N2fWGwZ/RjKB78w
	AUEeA4Flj4a1fqVjET2i6LDbt4/p9nlVQc2u6OfHf72tXQ8QKjeBDh6senRfDHuRGo9oobUOHyp
	IuoJjk4FUUTU2HfXNL1ghFLrkejtUDDOrsoCTInXAhOXSrxS/M8gepM2azGFTTE/MJPjx1wAs3o
	9du2nk9Zh7bUJ0Bt6gtQ06Pay432LJJGTK4/aQ/kCYKeYfmv7pNyRDfsHdJIgnP4PUqA8MKCCg6
	qhp6nouqP+bUGNHESBb9P8Y190wqZ3lkjBW5Hul7twDm+75BzHhRX+7002ahWMc58DPuZQMDKPp
	1w7p1sCG8INHis630LiXccCEQL/XzvNz8xy09CEJuIlQEmdFaNqjzjYjMwc7Qv8WZK1xypfN94k
	Gae1Rcr7htxKS++W6e0zXQ==
X-Received: by 2002:a05:693c:414b:20b0:367:5e31:ce29 with SMTP id 5a478bee46e88-3675e31ce6bmr3904222eec.20.1792602031067;
        Wed, 21 Oct 2026 10:00:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ee5e3sm8459829eec.4.2026.10.21.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:00:29 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:00:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Shihuang Liu <shlomojune6@gmail.com>, linux-input@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Message-ID: <atjvKMOXQY_psYcF@google.com>
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

Well, there is absolutely no performance concerns in this code, so
another option is to simply leave it as is. I see no benefit here from
using yet another variant of str*cat().

Thanks.

-- 
Dmitry
