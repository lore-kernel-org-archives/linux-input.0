Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA5329E46;
	Wed, 20 May 2026 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304421; cv=none; b=cgoPg6DYFXRJH2ouOe/RRmVjpJI7tVrZiICa3LGAiTOHVEZr691Qs/NSThA8+zxQjTcRpG4oCd39MXhKLa66MV/9N9g9U5N7ASwQJKmg2O3aidBCd6LQXc4VmqP8t9Qe6AOvZy6HhHlTZqyZ2IXHmDH4Cn+WU63nW/yDZcsbtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304421; c=relaxed/simple;
	bh=Hm3yuBjzc9CBW5ZhsNu8uK+et4BKyO2axCxlh/hkR40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guw7hgF9YP4W+NUlKFRdiTDwzM4a4wVsn7gCNRvuitZqmg3X4fv7rNRqWbH48f4fGVx6YuQO+MgFd5B1d/3izSxzpnAA+Mm9WgSGsP6P1Q4U5O/xa05gzJWkNjMLzHftmW8uW9EypTOTr26zxb/4hEH9J2eh+Npw+ibte72V4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=provdh.com; spf=pass smtp.mailfrom=provdh.com; dkim=pass (2048-bit key) header.d=provdh.com header.i=@provdh.com header.b=EkzhNEL8; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=provdh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=provdh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=provdh.com header.i=@provdh.com header.b="EkzhNEL8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provdh.com;
	s=protonmail; t=1779304403; x=1779563603;
	bh=Hm3yuBjzc9CBW5ZhsNu8uK+et4BKyO2axCxlh/hkR40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EkzhNEL8E8GVtWWC2Rl7NapCr63o59djH1PWeTffBfmtruLBaS0zsRZkPzLfVnD9Q
	 CPWfLEUT6CB9ibL/owkNPTm8Ar4oHg89Nx4fBOulAJnh9vnCjgOXX0opNuzSvInrBU
	 MnhBKn92HLhuHkeGydztHPexfuqaqgZ7VDjNco3bvqDGf/02biSYdyyPcz9GhpHKhu
	 2MMg2R4eZs29rIW+vXz5eCE7lAQDQSKCWVLgH7GuVsxFhjMDOXZwYyfa6cgvN7KGzQ
	 aJ7bO58fMvpkm4Lgq+2sLhAYGvA1tj0/DdXvB8tcHo0Qyz8WLDEh1U7sZntLr+8w0P
	 QLRCBE1T3ZOqg==
Date: Wed, 20 May 2026 19:13:20 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: opinijm@provdh.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, "Luke D. Jones" <luke@ljones.dev>
Subject: Re: Mismatched product ids for the ASUS ROG RAIKIRI PRO
Message-ID: <KGIlBD1RRvrvSoKBEr-lAD3Aky9L2i5p8wFFVqSjC_LZ8uW6EIlGeyj9gxn6m4F69vq_4VQk6vBqLKrETVx_S2wXnnTf13kghk-umFxHGW4=@provdh.com>
In-Reply-To: <qXthrkx15NUzfYKQebMAJLqDmGXrsQJYTPFko4SvPAd--C6OBfBLWc0raywIArf-MoxJlRLg1XJna4AWORI1mmYAe2eh6eaL9K15Z0zTgMQ=@provdh.com>
References: <Zjb8RrOFLHFSk_Gv@google.com> <20260519173800.6765-1-opinijm@provdh.com> <agzSfM3TH8Pg0M4I@google.com> <qXthrkx15NUzfYKQebMAJLqDmGXrsQJYTPFko4SvPAd--C6OBfBLWc0raywIArf-MoxJlRLg1XJna4AWORI1mmYAe2eh6eaL9K15Z0zTgMQ=@provdh.com>
Feedback-ID: 181154076:user:proton
X-Pm-Message-ID: 07ef80aad883934b029a8a869387e43afd42f34f
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Wednesday, May 20th, 2026 at 3:06 PM, opinijm@provdh.com <opinijm@provdh=
.com> wrote:

>=20
> On Tuesday, May 19th, 2026 at 5:19 PM, Dmitry Torokhov <dmitry.torokhov@g=
mail.com> wrote:
>=20
> > Hi Justin,
> >
> > On Tue, May 19, 2026 at 01:37:59PM -0400, Justin Opini wrote:
> > > Hey Dimity,
> > >
> > > I had a question on the product id,
> > > { 0x0b05, 0x1abb, "ASUS ROG RAIKIRI PRO", 0, XTYPE_XBOXONE },
> > >
> > > This doesn=E2=80=99t match both my devices so I was wondering if some=
how we
> > > have similar named devices with need for different product ids or if
> > > there was a mistake in the original commit?
> > >
> > > My relevant entries from lsusb are
> > > Bus 001 Device 002: ID 0b05:1a3c ASUSTek Computer, Inc. ROG RAIKIRI P=
RO
> > > Bus 001 Device 003: ID 0b05:1a3c ASUSTek Computer, Inc. ROG RAIKIRI P=
RO
> > >
> > > On my system I have ended up using this udev rule for quite some time
> > > ACTION=3D=3D"add", ATTRS{idVendor}=3D=3D"0b05", ATTRS{idProduct}=3D=
=3D"1a3c", GROUP=3D"input", MODE=3D"0660", TAG+=3D"uaccess", TAG+=3D"seat",=
 RUN+=3D"/bin/sh -c 'echo 0b05 1a3c > /sys/bus/usb/drivers/xpad/new_id'"
> >
> > I am CC-ing Luke who added this VID/PID comboi to double check, but it
> > looks like there are many variants of this controller using the same
> > "ROG RAIKIRI PRO" name. For example
> > https://github.com/atar-axis/xpadneo/issues/612 talks about
> > 0x0b05/0x1abd.
> >
>=20
> Ah i was thinking about this more. The device has 3 modes of connection, =
there is Bluetooth(on the Github tracker), and 2.4GHz via USB receiver(whic=
h is what I use) as well as USB directly to the device. Not use if this is =
enough to introduce variants, but I thought it was worth thinking out aloud=
. Maybe Luke could chime in on usage? In any case is a patch appropriate he=
re to introduce variant?

Connected via USB I get,=20

Bus 003 Device 004: ID 0b05:1abb ASUSTek Computer, Inc. ROG RAIKIRI PRO

I can't test Bluetooth because I have a motherboard that doesn't have a sup=
ported driver yet.

>=20
> > Thanks.
> >
> > --
> > Dmitry
> >
