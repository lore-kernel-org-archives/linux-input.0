Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A932D0FC;
	Tue,  4 Aug 2026 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785824112; cv=none; b=m4if64vn3d7JyGnB+oHO+pIU2cy47D8kdND6/JwLyZeQ2k+utn5AL6jw+uSWQ3mM/7sKV0s0bsxOD602BvhdRloOMYe3BeVl2asBvBPe+wERpvNxUk/LCFcg4RKHgjgU9U6D/Jh79/FDE8s3mSq8In4dV7TkP4Iagz24NoY0J4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785824112; c=relaxed/simple;
	bh=qSPgbBsuDe7qAAI7w/bZH/2XEk3eZwmXVLlSksgHyWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JALghWPJDa4oHm2b8o5OlODpwmbGur8dnLak2Me50/euqcafBI77KLhkArBFaSIcWtBQfJukK1p8ktwkvau4//Wja2QdFr0gjPltlJlLwkg6NO01bQa2zMVGO4tR9McZ5pL/qXKeTQL2fIYNI/SF8pxlq5bqwbmFs/XER9x8sdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=AwOl4O+e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+2tMR1X; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="AwOl4O+e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+2tMR1X"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 039DFEC00EF;
	Tue,  4 Aug 2026 02:15:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 02:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785824109;
	 x=1785910509; bh=Slzxgw860fpBPhcjUcLKdYYYr3ozTG4VLQoE54TJxoE=; b=
	AwOl4O+ewHTUM5a01iw1QdIGplgEx/nfF5csNMfHhCNfOCg9RGFH8cuVW2NFITrM
	7Ttt4lRNVw/DQu+aAApCXYUlOnpYwL8DAj1IcZwyLFDx2MxhFukNedtFUZySDF5e
	GrhjYqGG66P6vBgT3BNBOXhqoDb2dc0siGpNVnNkEatSEsKU4yRLIADcAqgJHCtE
	YxjxK2zUQMH8jMsjQJzGXnCRxb2FSjVcgcPKUjgRVaGe0HPq7mK+Fh9C13oCpT65
	mTzevVVl7S7RGK5oRx3F9Jfrza8yNIAJH2w5MrIH4I/waT6omBBHmIAOdrcClh45
	RZrSS2jvhbdoJuW3yQsfiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785824109; x=
	1785910509; bh=Slzxgw860fpBPhcjUcLKdYYYr3ozTG4VLQoE54TJxoE=; b=P
	+2tMR1XVbP5DsRXyenAZ0LT45aIqQHW0i22Q9b9Qk+FhpH88T4tNIKuwZNKdY07+
	ltZv6keBO7Of7Q39gheZpqh+dQVScSIGFs1t42h8nhMXdNfl5I1j1gVOYhZwqY0U
	kLRQJ33nkIZk4d4GFk/L6jM+3/9fOGF1ZmZ/akhmyqXdzocUI9O5NWomG89lFHlc
	YwqMvl8qo769QB7jDdmBbF2L3yk0Dpwaeh0f8EHru0+gxEgggVhOfTkrotsuPyZ/
	MplxMFGQEM61PKjoTIOKhElVuEiM9f2/XcFD+bXaZ7RzSnxS3yXq6x16bh7gvkkU
	kn/C9KAHCR4xY0Ww4vZ2A==
X-ME-Sender: <xms:bINxamkN-TU73loiBIBm5WhqWck7uZ2-9NLchx9Cgy1ZWbQVgc908Q>
    <xme:bINxanJ70AsjNRcjNXUfj1hzbcQYZ4kDyb71ClwnRuLXgFMxAQdO68-X6Kmo2DIuF
    ycOiXy_MaFsJuxnmp3XPJBkSKKOuaxDjrMij3BKakbXApXgVH_1Z1M>
X-ME-Received: <xmr:bINxar7KOmYgTY5e-7pBHTdXQajLH0UzxiImO6P4dXpkslI4U8Am77AQ0oRUAA6FC4paO29Isdj-K0lAY6v906_4XCCX-HaHaw>
X-ME-Proxy-Cause: dmFkZTEpoHEY1i6LNkSpUPrTmKCwzuLASTb7f5dy0XhwfZpKarLwJFVpAOr76Q+J2kmH5F
    4k2lHxUKlyrHsjXVYNoAem9snLTGGsgXbzia5KJv+ZJg5u7fvXkcRTuKx049y6RUFnEB9w
    E2qVCzn0Zh+mIp9M6vRU2ZWrQevjvemppcI/0HdaM1HC4MNscdKyhMfsWN2GdiGQu3EXZT
    tMHt8DJU9uDZgQLE0tDtc1HVaFd3JitEHOQbtMpURZfbpVaYVWXjVz7JzO4C+JWhMsgA2u
    M4IPCHAYsXp56B6vmxHp1hlr7rYI9RfCFlDfh8dzSYSe9lLZWmsIazGUSd1jPSMNbT2fAs
    HTNz3SoK9yGyWUzn3sAlmJGc/X3UiFv1H6ehcXFE7e3ETYfQ1LHUbz5zZ/2TodQF/0RD+v
    zjr2SponqZr3KZGsKB2z9sWGArMNNSOCNukBGO3dcCKFJpEXZ8xWxIDqMKcd+paYY0CB9k
    2Yxzop1KiJrfgNhfnFEsBV5/SA6ZU43tDWXzznxQ1mRxGxTRSz0KG/5BKu85XARnVJplaW
    1omZyf1e7rzSvZLTC4TlKx2fEYznHwy3tkoDnR5E7bwTVUshdANWRYW9lzuj1AM8zFmO4R
    +FlcbMxDvyIyNyNt397O6s5KSQ2YgXiP4FXsexiOpueUQQz4NieOCexGiYKw
X-ME-Proxy: <xmx:bINxar0lh5M3qfHU3zH90WF9i_uKFerZwobx5YjWLGURNjBViq2kYQ>
    <xmx:bINxahdWt_qr_O3kQ7iyrZKKD6jMjHld-iYFfcNzYaT3XDtKAY2EMA>
    <xmx:bINxahdWasW9Qj97WGqLi6PCaiySWZ30OX6zxhYu0p1ROUYRrUGqPw>
    <xmx:bINxaswtF9JIKnjLz09gS1jRsFi6XfhrozdLleSQXavAFf2uOWnDzA>
    <xmx:bINxaqq0jzODXzV6QSUunv0Ea7XXfpXamAx7QPXRYwda6fLGO6cmatZZ>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 02:15:05 -0400 (EDT)
Date: Tue, 4 Aug 2026 16:15:00 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, David Rheinsberg <david@readahead.eu>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput/uhid - disallow control characters in phys
 paths
Message-ID: <anGA4uZMqKLEC8wy@quokka>
References: <20260717-wip-uinput-sanitize-phys-v1-1-f6459542ce4b@who-t.net>
 <1ed3a0b5-db39-4a82-b549-0ed7e2cf89c2@app.fastmail.com>
 <p3886qn6-q75n-8srq-49rp-09p86788s65o@xreary.bet>
 <anFDip3gGB4vEA8p@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anFDip3gGB4vEA8p@google.com>

On Mon, Aug 03, 2026 at 06:47:23PM -0700, Dmitry Torokhov wrote:
> On Mon, Aug 03, 2026 at 09:58:35PM +0200, Jiri Kosina wrote:
> > On Fri, 24 Jul 2026, David Rheinsberg wrote:
> > 
> > > > There is no good reason to support those, no physical device will ever
> > > > produce those. Allowing \n in phys previously triggered CVE-2026-50292
> > > > in libinput - there the PHYS udev property value was used as part of
> > > > another udev property value. The linebreak then caused the property
> > > > to be split across two lines, allowing uinput devices to inject
> > > > malicious properties. While the bug is squarely inlibinput's court
> > > > there still isn't a good reason for control characters in uinput/uhid.
> > > >
> > > > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > > > ---
> > > >  drivers/hid/uhid.c          |  1 +
> > > >  drivers/input/misc/uinput.c |  1 +
> > > >  include/linux/input.h       | 15 +++++++++++++++
> > > >  3 files changed, 17 insertions(+)
> > > >
> > > > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > > > index 37b60c3aaf66..baf1fe8290f7 100644
> > > > --- a/drivers/hid/uhid.c
> > > > +++ b/drivers/hid/uhid.c
> > > > @@ -513,16 +513,17 @@ static int uhid_dev_create2(struct uhid_device *uhid,
> > > >  		ret = PTR_ERR(hid);
> > > >  		goto err_free;
> > > >  	}
> > > > 
> > > >  	BUILD_BUG_ON(sizeof(hid->name) != sizeof(ev->u.create2.name));
> > > >  	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
> > > >  	BUILD_BUG_ON(sizeof(hid->phys) != sizeof(ev->u.create2.phys));
> > > >  	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
> > > > +	input_sanitize_phys(hid->phys);
> > > >  	BUILD_BUG_ON(sizeof(hid->uniq) != sizeof(ev->u.create2.uniq));
> > > >  	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
> > > > 
> > > >  	hid->ll_driver = &uhid_hid_driver;
> > > >  	hid->bus = ev->u.create2.bus;
> > > >  	hid->vendor = ev->u.create2.vendor;
> > > >  	hid->product = ev->u.create2.product;
> > > >  	hid->version = ev->u.create2.version;
> > > > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> > > > index d32fa4b508fc..70fe4f3e73bf 100644
> > > > --- a/drivers/input/misc/uinput.c
> > > > +++ b/drivers/input/misc/uinput.c
> > > > @@ -998,16 +998,17 @@ static long uinput_ioctl_handler(struct file 
> > > > *file, unsigned int cmd,
> > > > 
> > > >  		phys = strndup_user(p, 1024);
> > > >  		if (IS_ERR(phys)) {
> > > >  			retval = PTR_ERR(phys);
> > > >  			goto out;
> > > >  		}
> > > > 
> > > >  		kfree(udev->dev->phys);
> > > > +		input_sanitize_phys(phys);
> > > >  		udev->dev->phys = phys;
> > > >  		goto out;
> > > > 
> > > >  	case UI_BEGIN_FF_UPLOAD:
> > > >  		retval = uinput_ff_upload_from_user(p, &ff_up);
> > > >  		if (retval)
> > > >  			goto out;
> > > > 
> > > > diff --git a/include/linux/input.h b/include/linux/input.h
> > > > index 76f7aa226202..6c182f5c783f 100644
> > > > --- a/include/linux/input.h
> > > > +++ b/include/linux/input.h
> > > > @@ -527,16 +527,31 @@ int input_set_keycode(struct input_dev *dev,
> > > > 
> > > >  bool input_match_device_id(const struct input_dev *dev,
> > > >  			   const struct input_device_id *id);
> > > > 
> > > >  void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
> > > > 
> > > >  bool input_device_enabled(struct input_dev *dev);
> > > > 
> > > > +/**
> > > > + * input_sanitize_phys - replace invalid characters in a phys string
> > > > + * @phys: the phys path to sanitize (modified in place)
> > > > + *
> > > > + * Replaces any control characters and non-ASCII characters with '?'.
> > > > + **/
> > > > +static inline void input_sanitize_phys(char *phys)
> > > > +{
> > > > +	char *p;
> > > > +
> > > > +	for (p = phys; *p; p++)
> > > > +		if (*p < 0x20 || *p > 0x7e)
> > > > +			*p = '?';
> > > > +}
> > > > +
> > > 
> > > Reviewed-by: David Rheinsberg <david@readahead.eu>
> > > 
> > > I would also be fine to just reject them in uinput, but I guess this is the less intrusive option.
> > 
> > Thanks for the fix.
> > 
> > Dmitry, can you please Ack the above addition to input.h?
> 
> Jiri, as I mentioned I believe that if we need to sanitize phys we
> should also sanitize other fields, especially given that they can be
> set by userspace.

fwiw it's on my list, just hasn't made it to the top yet

> I also wonder why it needs to be inline? And what is wrong with using
> isprint() here? 

inline - it's only used in two specific instances, if it wasn't for the
uhid/uinput overlap it'd be barely worth a function. Happy to change
though.

isprint - good point, will use that in the next version. 

In regards to sanitizing the name/uniq though: I have a
device here that has the copyright symbol in the device name:
   Microsoft Microsoft® 2.4GHz Transceiver v9.0
That is outside isprint() and IMO we shouldn't mess with device names
more than absolutely necessary wo we should probably strictly reduce
this to control characters only (or maybe just \n)?

Cheers,
  Peter
