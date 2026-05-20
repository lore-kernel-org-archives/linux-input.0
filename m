Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17943F9F5E
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303986; cv=none; b=gwHwFiGmvPaSXZoC6AGDTs26dySyCFNRQhS7w/R9Pjdk/YoSdVhwB35kxf2wlBPqKTQ4K84/yAe0FrKrdPXA3rvuajlx64zsrH9+ny072iSo9ojcq98O7Fg5YMKh/8fSVH1iAq+lvyFBrIWqaKmymwZMkBiJiAJBd3+rXd7Io1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303986; c=relaxed/simple;
	bh=RHn6R6b40XVZCeHmeSbM7xbjlot59ktq1KNBqruLBEQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIgIKqJ3X3lZZPawd/sUY+XP4F6ifHRkjHlvRVOjJjbHcS3/Jl6/Ui4llbyIeNYZiijxaDT9lTQJjL1Sw/43yxzAD2QYpU+aVYRRyGKqZyih4knThgHhxLLthZYL268P0mVRClasYdXibCb1p5k32sjtLnZpqf4l6GLLRa//RnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=provdh.com; spf=pass smtp.mailfrom=provdh.com; dkim=pass (2048-bit key) header.d=provdh.com header.i=@provdh.com header.b=LBKX9x63; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=provdh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=provdh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=provdh.com header.i=@provdh.com header.b="LBKX9x63"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provdh.com;
	s=protonmail; t=1779303967; x=1779563167;
	bh=k4tON+ZnfndUQDWS7Mx69d0u+DfNHTj806P3Uo35Z74=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LBKX9x63rFVkpI21MWkmUSSJL5dYNaSsG6fH1G3t1cA7XRe4NazJpc1CNkVpBZmwD
	 mVO3PW5VnkpFXMs+AgwFrjRB3czRklC1MNC93XytLHL8Lg2/KeiNsne2sZYG51nWnX
	 ozWkGSS7dyxNJKE6L0sWEe7ZiFbq1Laa4M4iew8LfNGRqYo1WvFf6I/tp+/wQJ/i0N
	 rr1JNiYWfD0VyVOOnKUV5ReNYHL5mvclohpmp+zAejKuh3y47ymk54yNqCjUhLLIGH
	 cnkBPBcMTsmSWXbZDqFVH6eBZAILprQjK1+j3gDmxXZBUNGkeuQOcoLQLiWMhJeSUF
	 ic+mJwKqu3Ltw==
Date: Wed, 20 May 2026 19:06:05 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: opinijm@provdh.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, "Luke D. Jones" <luke@ljones.dev>
Subject: Re: Mismatched product ids for the ASUS ROG RAIKIRI PRO
Message-ID: <qXthrkx15NUzfYKQebMAJLqDmGXrsQJYTPFko4SvPAd--C6OBfBLWc0raywIArf-MoxJlRLg1XJna4AWORI1mmYAe2eh6eaL9K15Z0zTgMQ=@provdh.com>
In-Reply-To: <agzSfM3TH8Pg0M4I@google.com>
References: <Zjb8RrOFLHFSk_Gv@google.com> <20260519173800.6765-1-opinijm@provdh.com> <agzSfM3TH8Pg0M4I@google.com>
Feedback-ID: 181154076:user:proton
X-Pm-Message-ID: 1687bd7dcd34c899947acdda764d9d363e4f1301
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tuesday, May 19th, 2026 at 5:19 PM, Dmitry Torokhov <dmitry.torokhov@gma=
il.com> wrote:

> Hi Justin,
>=20
> On Tue, May 19, 2026 at 01:37:59PM -0400, Justin Opini wrote:
> > Hey Dimity,
> >
> > I had a question on the product id,
> > { 0x0b05, 0x1abb, "ASUS ROG RAIKIRI PRO", 0, XTYPE_XBOXONE },
> >
> > This doesn=E2=80=99t match both my devices so I was wondering if someho=
w we
> > have similar named devices with need for different product ids or if
> > there was a mistake in the original commit?
> >
> > My relevant entries from lsusb are
> > Bus 001 Device 002: ID 0b05:1a3c ASUSTek Computer, Inc. ROG RAIKIRI PRO
> > Bus 001 Device 003: ID 0b05:1a3c ASUSTek Computer, Inc. ROG RAIKIRI PRO
> >
> > On my system I have ended up using this udev rule for quite some time
> > ACTION=3D=3D"add", ATTRS{idVendor}=3D=3D"0b05", ATTRS{idProduct}=3D=3D"=
1a3c", GROUP=3D"input", MODE=3D"0660", TAG+=3D"uaccess", TAG+=3D"seat", RUN=
+=3D"/bin/sh -c 'echo 0b05 1a3c > /sys/bus/usb/drivers/xpad/new_id'"
>=20
> I am CC-ing Luke who added this VID/PID comboi to double check, but it
> looks like there are many variants of this controller using the same
> "ROG RAIKIRI PRO" name. For example
> https://github.com/atar-axis/xpadneo/issues/612 talks about
> 0x0b05/0x1abd.
>=20

Ah i was thinking about this more. The device has 3 modes of connection, th=
ere is Bluetooth(on the Github tracker), and 2.4GHz via USB receiver(which =
is what I use) as well as USB directly to the device. Not use if this is en=
ough to introduce variants, but I thought it was worth thinking out aloud. =
Maybe Luke could chime in on usage? In any case is a patch appropriate here=
 to introduce variant?

> Thanks.
>=20
> --
> Dmitry
> 
