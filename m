Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C7144239A;
	Thu, 27 Aug 2026 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832012; cv=none; b=VslCIYM4J20sM0hIdwaOi2gChrAhQGHvw2MwPC0vxZLn+Nw5XpRkg/KLgeQVq0AnLsCPUQTZ/JuBqJfIcsn3iDJr9mDyhCYhzo1GUEloYJluyxPawIg7jJuRJ85O8kHNUQcTn0/61yVCHcHqu+JBSOIaGwW+CvQQ219flEHQrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832012; c=relaxed/simple;
	bh=GTmJbqWO2G+JwtACRSzR5BR2F80bBvrZ0TXrXaxFoNg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GcGwRhYOxtvdT4YiP0nJOganeID24/lshc9lp/QVE2AQyFM9ZK+nYBXewn83Xo6rlPqfrj+d/284gGuvzEZuQXKrKv4lRafQDCQVH0EnA7usq8rLEnTrTiuHklRXztg+acFejJkQwYsmrezTWHzaagN8GseLdnI5RDp3OFbGbkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Om//ueuu; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Om//ueuu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZezuO2NgwuOKZZT46NB5n0n9jBETCPGkKkIHPY19i1k=;
  b=Om//ueuuGBuKyoMKhklNTNn/a4xt28I9NO5LMt+0G+l5vGgADzcXAgU4
   MB4LUqP6OSB2fobbg5u/4GFjEc65kv28KNklYFjbZ3pm4vrk9B7Z9IGXK
   5B7J0KEo0Gje/tIwYUs65DlS9UpTmmWZxQniNPiZEqh6ythTVUbXp1Lzx
   M=;
X-CSE-ConnectionGUID: kUUrCOlrQG+IFxsgUdOTDw==
X-CSE-MsgGUID: kt5pwAjhTl6ACnTAinlsVg==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,246,1779141600"; 
   d="scan'208";a="155185037"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 14:00:01 +0200
Date: Thu, 27 Aug 2026 14:00:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Ricardo Ribalda <ribalda@chromium.org>, cocci@inria.fr, 
    linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [cocci] [PATCH] HID: fix semantic patch and improve its
 performance
In-Reply-To: <eaca9bae-fba2-4824-9219-faad0b9f766e@web.de>
Message-ID: <ec917c17-dcee-bbed-b59f-49e3cde23cc@inria.fr>
References: <20260827112949.2431233-1-Julia.Lawall@inria.fr> <eaca9bae-fba2-4824-9219-faad0b9f766e@web.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-444202327-1787832000=:3521"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-444202327-1787832000=:3521
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 27 Aug 2026, Markus Elfring wrote:

> > Replace "expression" with "identifier" in the declaration of hdev.
> > This is necessary because hdev is used as the name of a function
> > parameter.
> …
> > +++ b/scripts/coccinelle/hid/ff_race.cocci
> …
> > -@r@
> > +@r exists@
> >  identifier probe_fn;
> > -expression hdev, flags;
> > +identifier hdev;
>
> May the following SmPL code variant be applied?
>
>  identifier hdev, probe_fn;

Yes, but it doesn't matter.

>
>
> > +expression flags;
> >  position p1, p2;
> >  @@
> >
> >  probe_fn(struct hid_device *hdev, ...) {
> > -  <...
> > +  ... when any
> >    hid_hw_start@p1(hdev, flags)
> >    ...
> > -  \(input_ff_create\|input_ff_create_memless\)@p2(...)
> > -  ...>
> > +  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
>
> How do you think about to use the following SmPL code variation?
>
> (input_ff_create@p2
> |input_ff_create_memless@p2
> )(...)

I find this completely unreadable.

julia

>
>
> > +  ... when any
> >  }
> >
> >  @script:python depends on report@
>
> Regards,
> Markus
>
--8323329-444202327-1787832000=:3521--
