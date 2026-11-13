Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609453;
	b=xSztgUYPwHH9LD2ZSW9WDU0o9rOMZ2kBa1CbDqtRNTY21FWnnvKpipehHoLkLmBfpU2S
	 ovkJUXw4bWJWU9xQLKSTnOo52q6n0E6tvmArJfD6Yoe4yjhHtu+e5nwQG+ieOTgYPwnl/
	 uh6nbwBuTPSFFQmOaFy6Emc5bBY+syDxToi0A+7e8shRYD3mKTStrTEKQsSmZLa3Zm6g8
	 lUK2o2DHbSwybXxhU+VF+kyMRjhIXK4tda8mnP0vjw2Td+uS9DXIMCRPvFs4JHTdpPNWQ
	 VtTYatSOSwKZww1q9U1wN3IAw+IBw1F7B7iJMn/FzF+OI+dE9kbRc2DlcYkIvTfaiGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=iu+KitSBUBQmvGXjEE7eBTsuXt7zA8pwnDBVeMtxfq0=;
	b=LZKXZ/4LDLlkGyCZozh4M1AttWhYF9UUZ6PBvc8iFgfVQgdVkp3cn/cKRLmSXhZgH2BL
	 iGOeM1hhEpq8q1eBSEvxPaXKS3qgKjlDJYNTJMW5CXvigK08EWc924cOdVocwZgX7ChOw
	 wCgCeLbNGNJ3sYIir9CKkDHNAB9WFbEw35pgmA/8EHpKd/VCxuDze/A8nSJvIG4N92G8q
	 +C37nINtnbCFiZUNKQ9dEwGulHPN5iSGHsHpoI5tBWTjbg0mDVKULYYJdsGi+669ONQ4H
	 viADl6PyeSz9Mo5dVr9BUXIkFlU8wunchDor6MOrLjFutCQ3SUN0/p5VGTS9IzT37lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irbKGu6i;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B850606A33F
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B850606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irbKGu6i
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3791619605cso3062613eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 14:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794609453; x=1795214253; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iu+KitSBUBQmvGXjEE7eBTsuXt7zA8pwnDBVeMtxfq0=;
        b=irbKGu6i1uI8ip45+TPaTGtucz6fep1borw5lZ0NbIpENwxyKd2IKLdr+TkjlJWJh3
         Yop7WpiGC1xwoDR300EiUqFOjiR8ig2oC5MdQ//lnZyzLyZaR6QOaKasEIvMn6mk0CEE
         V0cKuee2pqwFvRs4TkTuS0CQ1RWVqPzL6p4kkxm0J156LvSHiURtT4z9B4jksvxsh9oI
         pO7GHpx9Qf56qPsDSQCZMdPNkHlHKEYV+45Fmi0vseuMGvUPRbpiJVrsLjUDsA2hzMYa
         bkreL6HmYFRidUPgT8r1bNEwe30a1eJ+FcT5yD66W1Vih2mJr1RDN057dsY+nYw10I7f
         azig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794609453; x=1795214253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iu+KitSBUBQmvGXjEE7eBTsuXt7zA8pwnDBVeMtxfq0=;
        b=UXyxu+onGybeMV6dLaKBQTy8mgTxhefVFW7Oa3u+esQL9C2gEjZaq58N/UZlaybwsK
         8syZ1Oc7Yodz8VppR5wGMUV9ThSqMyCAY3biZ/j89wwPzfTAyPMucv6VJfO5LGAd6B6M
         dydVCej89vAhBjYtZV68CnNZkgerprP17CU3C9+lnxArZX5E0AQrAOpO6rGZdOmIN8F1
         ZzBFOSewvq5P8yIj+r+EdsoBgr21F12qXcVel3f4BE43i4f4Y//zMTbX9ubChQbjtvdr
         Z12D1Eh34eTGGpiWUrBR3cy72b7GDQWz1ZumK4Zl0auhMY+czol+EjyKEBSnDV9utE7l
         krrg==
X-Forwarded-Encrypted: i=1; AL+hErElW7lnLkrJLjGuOquH1vLzeLJirli4BuWy0lM7nY+1I5gAi1QMMTZ14GmJ51GLgzDm5JNpDh6/FldxNw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9yxVhimbmBFMgKAnYn+/+5Des7091SoBlhaJZzLzebMIG0kFgK
	i8y83PFaAqPvMBqXzcZJfqVpcyqTCkcYVblq8XnVTlWfeWIEAR7k3+3Y
X-Gm-Gg: AYBFou00iVUVAA0gFpa2+PmEgZzdSA0IjUoMpklAqr7wx2a74BpABRaph+eTfbkfs+3
	zZI2isf5D3rRWqKzERA0raoGSy8c14/G0ENAM8sNcaOldS3uN21in1mawsoVHPeVnaGCNu6gciZ
	8ajiwB6oTnoblhjtdnljYLk3nCIWIcFvmeKKDI+ynnthotFpNY9B978AEmUJW83SxQy9QfLCwYa
	2Evfr4wJedS0p+98DHjfmIr3QWtWXEH10gzXJCXINsP3LdQ1H5v/yq5dR7mlpNHFrwPXDo/dJBH
	cIF+Fhya8oem1gGYkGcYdNFLp29nNJSSYsKmqjC0bSkySBjARzoWZtIKlDP3Td3DDmxt9yg8nQm
	0TaqcgGCfgZfhq1Ad+dLGFqaDz1ctZ4AIbv3GSPSItU0rnjXVo8hKTLou5I3FPYYHuaUHaJ0GjC
	LAGUQVy7BkhG1l2qgZhys7M/0B9dn5lhw98K8TzKrkdw++x6DFFDOqa9VfoFTitLQfJD5tWMJbl
	awuH6opgQINUNlwHQ6VX6uKwqyvQMOvY/fSroDTU5fewQdo80snEBFDrMSypKdWtIdfGK5nh3I8
	qBa+mTcfV8yoRP6hbrW0pZUUZ2g=
X-Received: by 2002:a05:7301:f0b:b0:36c:9bc6:3ec with SMTP id 5a478bee46e88-379635648ddmr2887280eec.3.1794609452470;
        Fri, 13 Nov 2026 14:37:32 -0800 (PST)
Received: from localhost ([154.21.93.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d73dsm10591353eec.2.2026.11.13.14.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:37:31 -0800 (PST)
Date: Sat, 14 Nov 2026 06:37:27 +0800
From: Yao Yuan <yaoyuan0329os@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Vishnu Sankar <vishnuocv@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yaoyuan@linux.alibaba.com>, Jingle Wu =?utf-8?B?5ZCz6YeR5ZyL?= <jingle.wu@emc.com.tw>
Subject: Re: [PATCH v2 1/1] Input: trackpoint - Add new TP JYT_NDT device
 variant id 7
Message-ID: <aveQkso_7wCLskCY@sapienza>
References: <20261113112202.10304-1-yaoyuan@linux.alibaba.com>
 <20261113112202.10304-2-yaoyuan@linux.alibaba.com>
 <avcxUnUh17L91ny9@google.com>
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
In-Reply-To: <avcxUnUh17L91ny9@google.com>

On Fri, Nov 13, 2026 at 07:48:41AM -0800, Dmitry Torokhov wrote:
> On Fri, Nov 13, 2026 at 07:22:02PM +0800, Yuan Yao wrote:
> > The new trackpoint variant id 7 is found on Lenovo Thinkpad X14
> > Gen1 laptop(Product Name: 21XMA006CD), it belongs to JYT_NDT with
> > confirmation from Vishnu Sankar in Lenovo. now it's incorrectly
> > probed as Generic or Logitech PS/2 mouse.
> >
> > Add the variant id 7 to match the TP_READ_ID command return
> > value, probe the device as trackpoint correctly.
> >
> > BEFORE:
> > input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input63
> >
> > AFTER:
> > psmouse serio1: trackpoint: JYT_NDT TrackPoint firmware: 0xa1, buttons: 3/3
> > input: TPPS/2 JYT_NDT TrackPoint as /devices/platform/i8042/serio1/input/input8
> >
> > Signed-off-by: Yuan Yao <yaoyuan@linux.alibaba.com>
>
> Applied, thank you.

Thanks Dmitry.
And Thanks again to Jingle Wu 吳金國 and Vishnu Sankar!

>
> --
> Dmitry
