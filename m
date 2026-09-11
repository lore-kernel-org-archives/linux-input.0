Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3631E85E;
	Fri, 11 Sep 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135616; cv=none; b=CyGGUxEDWUspNCkOj96uyZiNUm+5IxVeybvWDfE6k0LcMFmzuRIGhguoUY235M/DePDIt4JYBFrs6zgo9PIk3xvBgWH/9vGIWlQiYUdTkOIkkBhnhxyUjxcF6Gu5G7LBJz7ENwLLKUoKT+q/Ged53ycHe6hwA0Bjj/HCC3ouDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135616; c=relaxed/simple;
	bh=uFqW20vU82y6vJWn4DmV4ieV8qoFT45RFy4hufnBE/A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Nfxd+/syBzbw/lLzEXTjqwda0INXe/5MZdM3X+QGZybmmfzIXkCPZ05VB2H+G0UYewhkw80bprP0xmDRxqfkO18+nuNU1dUU3lVhmSoiptWUJEkNKCJAm4sR7aW1AJNB7/cgGpFICKkaRVRrLx2GfBIKlrTURInypVFiuG+Qm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYmYiXCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYmYiXCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4891F000FF;
	Fri, 11 Sep 2026 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135615;
	bh=QXvIZ2CHp3yZqp7gA/u1N2bGVLDVS3P7UsydxPQOR7s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=kYmYiXCWuQQYrdgv/xTDgqXVl8fQTNDp8j2JWeg8xcyoaVhL4tvQ5Xormm2lg60o9
	 OP2cDZm/iK5HGBaOFRdaQyZ6jrVmq13muP1aAgpnFWzb0cMtodcdQowRMfJHqrNHZm
	 mMOz0pUIHx1N2C+O5OkzLh1qpqj/aTo2G4jj7sLbS4TDnTsusA1eJZaP0eABn4DOS0
	 xQfa6BlrtoSKbvN7g+/fcZx9FRSyeN+vFY7dnSV2WHIlBaSSXQuZ5EdsM1VWtuJxsY
	 U0Y4uYExk7NQg/UVC6C/aUeCqfdPHwkSE1EVv3dwNA377QjeylJWnavnOM+axvayRf
	 JAwmRuWC95iAQ==
Date: Fri, 11 Sep 2026 16:06:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: core: check field offset before dumping input
In-Reply-To: <CADhLXY4_M62zOXOCyk8BcBU924+7_TxZ_GkbE=V5ME3ZbDsVag@mail.gmail.com>
Message-ID: <28q6s6q6-4o3n-3r07-ps06-rp9o73359r72@xreary.bet>
References: <20260809040629.12666-1-kartikey406@gmail.com> <CADhLXY4_M62zOXOCyk8BcBU924+7_TxZ_GkbE=V5ME3ZbDsVag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 21 Aug 2026, Deepanshu Kartikey wrote:

> > hid_set_field() passes field->usage + offset to hid_dump_input() before
> > validating offset against field->report_count. field->usage is allocated
> > with exactly report_count entries, so a larger offset is read out of
> > bounds before the existing check rejects it:
> >
> >   BUG: KASAN: slab-out-of-bounds in hid_dump_input+0xcb/0xd0
> >   Read of size 4 at addr ffff88802ab28fc0 by task kworker/1:2/48
> >
> > Move the bounds check above the hid_dump_input() call so the function
> > returns before the dereference.
> >
> > Reported-by: syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=a942efa43c928a1e3daa
> > Tested-by: syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> >  drivers/hid/hid-core.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index cf123347a2af..7ea1fb62b9d4 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -1933,13 +1933,14 @@ int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
> >
> >         size = field->report_size;
> >
> > -       hid_dump_input(field->report->device, field->usage + offset, value);
> > -
> >         if (offset >= field->report_count) {
> >                 hid_err(field->report->device, "offset (%d) exceeds report_count (%d)\n",
> >                                 offset, field->report_count);
> >                 return -1;
> >         }
> > +
> > +       hid_dump_input(field->report->device, field->usage + offset, value);
> > +
> >         if (field->logical_minimum < 0) {
> >                 if (value != snto32(s32ton(value, size), size)) {
> >                         hid_err(field->report->device, "value %d is out of range\n", value);
> > --
> > 2.43.0
> >
> 
> Gentle Reminder. Please let me know the status of this patch

I believe this was already fixed in 7.3 via a13cdb19fcb2.

-- 
Jiri Kosina
SUSE Labs

