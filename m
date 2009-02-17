From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input: xpad.c - Xbox 360 wireless and sysfs support
Date: Tue, 17 Feb 2009 10:39:54 -0800
Message-ID: <20090217183954.GA22850@kroah.com>
References: <5aa163d00902160522r3a22412je3f5202076f57a0a@mail.gmail.com> <20090216161331.GB5008@kroah.com> <5aa163d00902161009l15dae120le96436d40f998d33@mail.gmail.com> <20090216185914.GA6239@kroah.com> <5aa163d00902161130r2030adb8h6eb1ec08bda92744@mail.gmail.com> <20090216202215.GA6543@kroah.com> <5aa163d00902161853x27d98a83l3c2c02abe651fe1e@mail.gmail.com> <20090217031813.GD8343@kroah.com> <5aa163d00902162057l106c001bo519a5241c79b5e96@mail.gmail.com> <5aa163d00902171027o139ba751r8103f948f3f492bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5aa163d00902171027o139ba751r8103f948f3f492bb-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 17, 2009 at 01:27:48PM -0500, Mike Murphy wrote:
> On Mon, Feb 16, 2009 at 11:57 PM, Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org> wrote:
> > Unless that is some common error that is obvious from its description,
> > I will have to chase the bug down tomorrow or Wednesday. It's getting
> > a bit late here.
> >
> 
> Fixed... the function signature was wrong. Should have been:

Ah, always pay attention to complier warnings :)

> static ssize_t xpad_show_dead_zone(struct device *dev, struct
> device_attribute *attr, char *buf)
> 
> Incidentally, both Documentation/driver-model/device.txt and
> Documentation/filesystems/sysfs.txt appear to be wrong. The former
> defines the device attribute structure as:

<snip>

Care to send a patch to fix up the documentation?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
