Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BA337B8F;
	Tue,  3 Feb 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120024; cv=none; b=ZP5EHdYoSh+HjJJJXbdqSHBGoF7ZDYTM/gb1xX0qsPx4LtnOe0uhJY5fSPBKhaZ27+LnAePbfICWm67/bKRmMqqRpcUsf2haZEh3kTuLmGPSlaPZUGdV/LGhKaOuRHZdzdDY2NIUUXzeYCg1uA4Am6g1LlWmAvWNU4CvakRVuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120024; c=relaxed/simple;
	bh=yCCU+DvWpf3LJfse1GGtLeSuFfLtuaZGyh1ZRLHPv6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD2Ms0wNVOBHxmujl/Pw4UNUglr8vfSvlhsC6DBtyKKRjVRfL9GBp7Tzfd1sfF+xr566jNtVvZkwKsVkrl7zoEhFD8ax72ldVZWqPSGfoKiXXhr2IDncjJscFZIZE84p1q8+3oGy7xvFHbT3LBuLQNsllfe+W+lzmsz//JDuia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BFsYpk5Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BFsYpk5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175B1C116D0;
	Tue,  3 Feb 2026 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770120023;
	bh=yCCU+DvWpf3LJfse1GGtLeSuFfLtuaZGyh1ZRLHPv6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFsYpk5YsCjQrxctryV88+vNiA78r+2EPOoK5PJ/byNU2kNxDd44uzJGjVP6LlJhY
	 ihl1qvC8kMjUs8c/ZrpwMw5p3gaZVcWAHkZr9TlLb92yaXa7OmIWxqqmoN+a2DUnME
	 BgQZYUb+vZCuvKQmSqrdfXV/ZcbS25Qf7loKbgyQ=
Date: Tue, 3 Feb 2026 13:00:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sebastian Reichel <sre@kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/9] misc: Support Asus Transformer's EC access device
Message-ID: <2026020346-ashamed-campfire-b483@gregkh>
References: <20260201104343.79231-1-clamor95@gmail.com>
 <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh>
 <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>

On Tue, Feb 03, 2026 at 01:54:58PM +0200, Svyatoslav Ryhel wrote:
> вт, 3 лют. 2026 р. о 13:41 Greg Kroah-Hartman <gregkh@linuxfoundation.org> пише:
> >
> > On Sun, Feb 01, 2026 at 12:43:36PM +0200, Svyatoslav Ryhel wrote:
> > > --- /dev/null
> > > +++ b/drivers/misc/asus-dockram.c
> > > @@ -0,0 +1,327 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * ASUS EC: DockRAM
> > > + */
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/err.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/mfd/asus-ec.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/string.h>
> > > +#include <linux/sysfs.h>
> > > +#include <linux/types.h>
> > > +#include <linux/unaligned.h>
> > > +
> > > +struct dockram_ec_data {
> > > +     struct mutex ctl_lock; /* prevent simultaneous access */
> > > +     char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> > > +};
> > > +
> > > +int asus_dockram_read(struct i2c_client *client, int reg, char *buf)
> > > +{
> > > +     int rc;
> > > +
> > > +     memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> > > +     rc = i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM_ENTRY_BUFSIZE, buf);
> > > +     if (rc < 0)
> > > +             return rc;
> > > +
> > > +     if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> > > +             dev_err(&client->dev, "bad data len; buffer: %*ph; rc: %d\n",
> > > +                     DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > +             return -EPROTO;
> > > +     }
> > > +
> > > +     dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
> > > +             DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(asus_dockram_read);
> >
> > No documentation for these new public symbols?
> >
> 
> These functions are mainly used in communication between the dockram
> device, asus-ec and its subdevices. Export is used here because all
> mentioned devices can be built as modules. I can add descriptions of
> functions into header if needed, but they should never be used outside
> of dockram-EC complex. Same applies to 2 export functions in the EC
> MFD.

Then you should properly document this :)

> > > +static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SIZE);
> > > +static DEVICE_ATTR_RW(control_reg);
> >
> > You did not document your new sysfs files in Documentation/ABI/ which is
> > required.
> >
> > Also, why do you need a brand new user/kernel api at all?  Who is going
> > to use this and for what?
> >
> 
> These api were used mainly for debugging/logging purposes and descend
> from original downstream EC driver. I can both add documentation into
> ABI or remove them if that is absolutely necessary.

Debugging should not be in sysfs, please put this type of stuff into
debugfs instead if you really need it.

thanks,

greg k-h
