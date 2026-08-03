Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16653A4539;
	Mon,  3 Aug 2026 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787119; cv=none; b=Z/rSwlf6bKhvtSTh+2UmB/wMlIJS4IMCvCZ2QKPafIUkpuh8rQBKbexL0ughI9M7ON8YH7vh6wCdRNTOPIQ9vrRchphxZecKud1xFm2wM6vq2+R1mOje9V4awbu/oOPDNjfvvJ8yBiUV5kHP5Osx2IUHrzDJRv0gecX6ux7HFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787119; c=relaxed/simple;
	bh=1Yxh/nI9UTuxaJ1cPm31VI6QDdTLTcV8KTG/h+pWdK8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PA3GAL12cgSpAV/lDvzGRrEQ9cvy1GwJqx0L0KeDXiIz6boaKNIq+Bp1VDu1n4Q0H/HpxryIYtOT+urg91RBkUNHaBdDMxhsETdCMMTv1FEJyvgMqcJrpxy7O/tu+sk/0tkXa2W1mOjGHag1J5smjvN4G5h1EkhIMAZoexeLRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3yD2zks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3yD2zks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480271F000E9;
	Mon,  3 Aug 2026 19:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785787117;
	bh=L4nGtoUzDz+6nem43DZwip881CxemQJYiY5/Lt1umig=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=P3yD2zksdYQ440n4fCeHE0ltt5v+Egz0FJTVYfbzvgah0g0Ini5qLYIU2BxA/cnuw
	 QSoQINIZXAxDR3j93IrMaCTGWuNN2daKSs6QdqG2th9t2YTdSwDaZFnshLb9emKWUm
	 LquYWJWJ9qg9VyBGgRZmrjTVjGjWmuXumN/PvDzsI5DV16A+L0YSay9162bsUE+8qs
	 PD4FEvuR3C21NHv+DxW4XYoC86aLBs6LN7utl1jdc1v6zQdLRssZ6Y8xJcPdyBZgZa
	 sOsEtkyF1XmDj6ch2ObdkPz35oBQy1iTaLZnNMMGjlzLVvEsUCduRvsOAoyCNbxELC
	 ScOfRaxHl8sEw==
Date: Mon, 3 Aug 2026 21:58:35 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: David Rheinsberg <david@readahead.eu>
cc: Peter Hutterer <peter.hutterer@who-t.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput/uhid - disallow control characters in phys
 paths
In-Reply-To: <1ed3a0b5-db39-4a82-b549-0ed7e2cf89c2@app.fastmail.com>
Message-ID: <p3886qn6-q75n-8srq-49rp-09p86788s65o@xreary.bet>
References: <20260717-wip-uinput-sanitize-phys-v1-1-f6459542ce4b@who-t.net> <1ed3a0b5-db39-4a82-b549-0ed7e2cf89c2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Jul 2026, David Rheinsberg wrote:

> > There is no good reason to support those, no physical device will ever
> > produce those. Allowing \n in phys previously triggered CVE-2026-50292
> > in libinput - there the PHYS udev property value was used as part of
> > another udev property value. The linebreak then caused the property
> > to be split across two lines, allowing uinput devices to inject
> > malicious properties. While the bug is squarely inlibinput's court
> > there still isn't a good reason for control characters in uinput/uhid.
> >
> > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > ---
> >  drivers/hid/uhid.c          |  1 +
> >  drivers/input/misc/uinput.c |  1 +
> >  include/linux/input.h       | 15 +++++++++++++++
> >  3 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > index 37b60c3aaf66..baf1fe8290f7 100644
> > --- a/drivers/hid/uhid.c
> > +++ b/drivers/hid/uhid.c
> > @@ -513,16 +513,17 @@ static int uhid_dev_create2(struct uhid_device *uhid,
> >  		ret = PTR_ERR(hid);
> >  		goto err_free;
> >  	}
> > 
> >  	BUILD_BUG_ON(sizeof(hid->name) != sizeof(ev->u.create2.name));
> >  	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
> >  	BUILD_BUG_ON(sizeof(hid->phys) != sizeof(ev->u.create2.phys));
> >  	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
> > +	input_sanitize_phys(hid->phys);
> >  	BUILD_BUG_ON(sizeof(hid->uniq) != sizeof(ev->u.create2.uniq));
> >  	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
> > 
> >  	hid->ll_driver = &uhid_hid_driver;
> >  	hid->bus = ev->u.create2.bus;
> >  	hid->vendor = ev->u.create2.vendor;
> >  	hid->product = ev->u.create2.product;
> >  	hid->version = ev->u.create2.version;
> > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> > index d32fa4b508fc..70fe4f3e73bf 100644
> > --- a/drivers/input/misc/uinput.c
> > +++ b/drivers/input/misc/uinput.c
> > @@ -998,16 +998,17 @@ static long uinput_ioctl_handler(struct file 
> > *file, unsigned int cmd,
> > 
> >  		phys = strndup_user(p, 1024);
> >  		if (IS_ERR(phys)) {
> >  			retval = PTR_ERR(phys);
> >  			goto out;
> >  		}
> > 
> >  		kfree(udev->dev->phys);
> > +		input_sanitize_phys(phys);
> >  		udev->dev->phys = phys;
> >  		goto out;
> > 
> >  	case UI_BEGIN_FF_UPLOAD:
> >  		retval = uinput_ff_upload_from_user(p, &ff_up);
> >  		if (retval)
> >  			goto out;
> > 
> > diff --git a/include/linux/input.h b/include/linux/input.h
> > index 76f7aa226202..6c182f5c783f 100644
> > --- a/include/linux/input.h
> > +++ b/include/linux/input.h
> > @@ -527,16 +527,31 @@ int input_set_keycode(struct input_dev *dev,
> > 
> >  bool input_match_device_id(const struct input_dev *dev,
> >  			   const struct input_device_id *id);
> > 
> >  void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
> > 
> >  bool input_device_enabled(struct input_dev *dev);
> > 
> > +/**
> > + * input_sanitize_phys - replace invalid characters in a phys string
> > + * @phys: the phys path to sanitize (modified in place)
> > + *
> > + * Replaces any control characters and non-ASCII characters with '?'.
> > + **/
> > +static inline void input_sanitize_phys(char *phys)
> > +{
> > +	char *p;
> > +
> > +	for (p = phys; *p; p++)
> > +		if (*p < 0x20 || *p > 0x7e)
> > +			*p = '?';
> > +}
> > +
> 
> Reviewed-by: David Rheinsberg <david@readahead.eu>
> 
> I would also be fine to just reject them in uinput, but I guess this is the less intrusive option.

Thanks for the fix.

Dmitry, can you please Ack the above addition to input.h?

Thank you,

-- 
Jiri Kosina
SUSE Labs

