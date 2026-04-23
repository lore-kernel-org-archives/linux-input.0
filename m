Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D23E4C7E;
	Thu, 23 Apr 2026 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936604; cv=none; b=tcI/YZrQTnSEsIu5+j1AoJQuKVnegAMOnd+ne2z9LQC+sb8HC8FUZSAQe7+5dwcXWeiflSIgIVtXFYHgK96Zn6GFpnAhpF5wg+fHwRqJHG3RqHznDHWkKbn6Z8wnEUMVP0lT1y/g/TGi3knnH+nWmIJvKzwbgIJfP9rObkXMb48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936604; c=relaxed/simple;
	bh=Wi5/rBKURpnNc2R9Vdfej9cuoowcDYrMRwgp5zTNKlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhVpj4wPEXmX8oVe4Ozsi+7hanGI+ETkmeUkLujJ0QA/IivBnhm+JJQTGtKF//YLGTZljw9PrGkGV62Ni7aa4Li+Vjl1vR4QpuuK4igKJtSsbcd6zdguQYQMZzcC5N+C63icLo44KDuV1z+lWfLgpa0rFBaIKs7s7E+3AtAXCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=fVQgsPnf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuZLdphI; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="fVQgsPnf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuZLdphI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A03CD7A01A8;
	Thu, 23 Apr 2026 05:30:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Apr 2026 05:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776936601; x=1777023001; bh=yjmwU5OqE8
	utfq4q/myWomZazCtRFydVgM1omsCuU44=; b=fVQgsPnfsPAGzhsAC+6U7FzQGE
	SrbuL/lwDyEVmE+lNf/DO8ruCqoAJNKd9E5SYH6Yxv6AdkbSROxigVJgS/cT5fam
	eDr/rHO/Y9Vwak8Lx+YNm7gKsCRf6RrTLkRr/3e0T82MIZPHqFw2TJie9DMHQZ7U
	DM0Lc1leFjFm1ejDbtI4VpWLFdvCbzqO6yOYEVO/qx9lIqsFm8cuDkUWgCm8JWVo
	vFffmDsX1leXqM69Wr5xWnp5Mb1ZvESGY3FeV4gGP54d/YdsbfMV0vsQDRjVfDOR
	rXdIt2SMUC3g1bFCvhflZZqmqqWuPTdxbXf5QiXJ3Ee6MY7PHFV/pYVxJOCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776936601; x=1777023001; bh=yjmwU5OqE8utfq4q/myWomZazCtRFydVgM1
	omsCuU44=; b=fuZLdphIyVhEA/nk5XEU5EItX+KoLx1sVCwy/uJJqUImlZKjZc+
	GOzLrnWsnlJOvJBql4ub1/VebvXCsaRCuWP20Eg1gzQHIkQ4NSmgdQtDmTrkv71O
	7lUmtS2ptXPPUhPPcd6nAiJj0M3os429e0dZQ9kjlSVhrbnere1o3RHi7HwGnEJe
	p7K3pE+4/Q0W7sUkRJ5Q/Er3zHJ0ODdNRobjsrNdFdWW1Qc+q6vT2Vt3cKEF5/R4
	nUcyiFwlPg4JqOfTmW+KNqcyXxpEyIBQkQKui7TmMDzqIwWCN+O1lJZ/q/1q7mRj
	0x5LCvCJdHKeXaiTjq556ldNGK21SqbpYrA==
X-ME-Sender: <xms:mObpaZDCW9vyv1SerQ8AIxrSBrYsgZculc2K7im2djHgGTX8hHbjbw>
    <xme:mObpaW9bBi-tyt9F1Z7LLuEiyoW6nQHU4kSPqg-QOyB4N_MqXH48hk4cD41iws8_I
    1FYiAu1lNWFea7jdEkZ_nwYTovtJ2DvG5OdYezIA0V6jutbGg>
X-ME-Received: <xmr:mObpaVqtWdzY4Tw6CT35dVHR5eWVIkn1xOxNrchRJqXMgKKE8jREAM230psPr_c_p9XNbuYl6p0trGM4kJIJfFLt_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiieejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpedvjefhvefhje
    ejfeefleejteegtedvgeeghfeuveevgfffueelhffhhedugffhkeenucffohhmrghinhep
    ghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedugedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughnrghimhestggrtghhhihoshdroh
    hrghdprhgtphhtthhopehtrgihlhhorhesvgigphhonhgvnhhtrdguihhgihhtrghlpdhr
    tghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhtih
    hssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhssgesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mObpaYEekHIyOGC9WqVYWaA4zZU-Y-4LNQNl-_wedf7iQgRdQCZzjA>
    <xmx:mObpaR9TlKBGW8EMQzatAK8QXmTbSyM0PHMo_ksUI5kKF-8kqQgsTA>
    <xmx:mObpadQN-3pqowZ_SnVrP3rgJ0aUC_LblXQ_51_zjct0Lv5avmNJQA>
    <xmx:mObpaeplbJ1tUGYFR-g5vwVsnf1SlsQa0wuvAQWjiGCOwOyBDRyDUQ>
    <xmx:mebpabxoVgI1fn53R-YbRO7OcOC_iqWHwuaPMkDvAcoq5Z7OtqwkyBIM>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 05:30:00 -0400 (EDT)
Date: Thu, 23 Apr 2026 11:29:58 +0200
From: Greg KH <greg@kroah.com>
To: Eric Naim <dnaim@cachyos.org>
Cc: Taylor Hewetson <taylor@exponent.digital>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: sanitize hid->uniq against non-printable
 bytes
Message-ID: <2026042330-underarm-reusable-effa@gregkh>
References: <20260418025823.21767-1-taylor@exponent.digital>
 <2026041845-approve-pelvis-9845@gregkh>
 <81ef5ca0-b070-4afc-bda7-3e5a49677115@cachyos.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ef5ca0-b070-4afc-bda7-3e5a49677115@cachyos.org>

On Thu, Apr 23, 2026 at 05:55:00AM +0000, Eric Naim wrote:
> On 4/18/26 3:14 PM, Greg KH wrote:
> > On Sat, Apr 18, 2026 at 02:58:23PM +1200, Taylor Hewetson wrote:
> >> Some USB HID devices (observed on ASUS ROG Azoth via its 2.4GHz
> >> dongle, USB ID 0b05:1a85) report an iSerialNumber string whose
> >> USB string descriptor declares a longer length than the actual
> >> serial, leaving uninitialized firmware memory - including control
> >> characters such as 0x18 - appended to the returned string.
> >>
> >> These non-printable bytes propagate into hid->uniq, which in turn
> >> populates /sys/class/input/inputN/uniq. Downstream userspace
> >> components (systemd sd-device property_is_valid(), and by extension
> >> mutter input enumeration on GNOME Wayland sessions) reject devices
> >> with control characters in their uniq, rendering otherwise-
> >> functional input devices unusable in graphical sessions despite
> >> the kernel input layer correctly translating keypresses.
> >>
> >> Truncate hid->uniq at the first byte outside the printable ASCII
> >> range (0x20..0x7e) after the serial is read.
> > 
> > Why aren't we doing this in the USB core instead of forcing all users of
> > this to do it instead?
> 
> Should it be up to the kernel to do this as well? Currently this is only a
> problem with systemd because they added this check, and it looks like they
> have something in mind to fix it as well [1].
> 
> [1] https://github.com/systemd/systemd/issues/41339#issuecomment-4266429563

It's either up to the kernel, or every single userspace program that
reads the strings from a device.  Might as well do it in one place,
right?

thanks,

greg k-h
