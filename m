From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: Re: [PATCH] HID: roccat: Add support for Roccat Kone[+]
Date: Fri, 05 Nov 2010 18:42:42 +0100
Message-ID: <1288978962.2585.15.camel@neuromancer>
References: <1287943025.2623.16.camel@neuromancer>
	 <alpine.LNX.2.00.1011041418530.15851@pobox.suse.cz>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1011041418530.15851@pobox.suse.cz>
Sender: linux-doc-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Stephane Chatty <chatty@enac.fr>, Don Prince <dhprince-devel@yahoo.co.uk>, Dmitry Torokhov <dtor@mail.ru>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello,

Am Donnerstag, den 04.11.2010, 14:25 -0400 schrieb Jiri Kosina:
> On Sun, 24 Oct 2010, Stefan Achatz wrote:
> 
> > This patch adds support for Roccat Kone[+] gaming mouse. Kone[+] is an enhanced version
> > of the old Kone with more memory for macros, a better sensor and more functionality.
> > This driver is conceptual similar to the existing Kone and Pyra drivers.
> > Userland tools can soon be found at http://sourceforge.net/projects/roccat
> 
> Seems like there is a lot of duplicate code with Roccat Kone.
> Is there any reason this couldn't be merged with the Roccat Kone 
> counterparts?

In fact the Kone[+] seems to be nearer to the Pyra than the old Kone.
Looks like the manufacturer changed the firmware programmer between some
devices. I wanted to wait until I see more devices of this manufacturer
if some kind of genealogy might be visible and remove code duplication
based on that.

> > +static ssize_t koneplus_sysfs_read_profile5_settings(struct file *fp,
> > +		struct kobject *kobj, struct bin_attribute *attr, char *buf,
> > +		loff_t off, size_t count)
> > +{
> > +	return koneplus_sysfs_read_profilex_settings(fp, kobj,
> > +			attr, buf, off, count, 4);
> > +}
> > +
> 
> This is really ugly. Can't you have just one read() function and 
> distuingish according to bin_attribute->private?

The patch comes in a view moments, if you like it I'll do the same for
Kone and Pyra.

> 
> > diff --git a/drivers/hid/hid-roccat-koneplus.h b/drivers/hid/hid-roccat-koneplus.h
> > new file mode 100644
> > index 0000000..bf750fa
> > --- /dev/null
> > +++ b/drivers/hid/hid-roccat-koneplus.h
> > @@ -0,0 +1,229 @@
> > +#ifndef __HID_ROCCAT_KONEPLUS_H
> > +#define __HID_ROCCAT_KONEPLUS_H
> > +
> > +/*
> > + * Copyright (c) 2010 Stefan Achatz <erazor_de@users.sourceforge.net>
> > + */
> > +
> > +/*
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the Free
> > + * Software Foundation; either version 2 of the License, or (at your option)
> > + * any later version.
> > + */
> > +
> > +#include <linux/types.h>
> > +
> > +#pragma pack(push)
> > +#pragma pack(1)
> 
> Why?

What?

Have a nice day,
Stefan

