From: Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org>
Subject: Re: [PATCH] input: xpad.c - Xbox 360 wireless and sysfs support
Date: Mon, 16 Feb 2009 14:30:01 -0500
Message-ID: <5aa163d00902161130r2030adb8h6eb1ec08bda92744@mail.gmail.com>
References: <5aa163d00902142008g138826br80d3ea989e7af691@mail.gmail.com>
	 <200902160931.34771.oliver@neukum.org>
	 <5aa163d00902160522r3a22412je3f5202076f57a0a@mail.gmail.com>
	 <20090216161331.GB5008@kroah.com>
	 <5aa163d00902161009l15dae120le96436d40f998d33@mail.gmail.com>
	 <20090216185914.GA6239@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090216185914.GA6239-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 16, 2009 at 1:59 PM, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
>
> Put it on the logical device, as given to you.
>
>> I tried not to break existing functionality.  Additionally, struct
>> usb_xpad contains two device pointers: one to the actual USB device,
>> and one to an input device (see source of the in-tree xpad.c). So I
>> followed your kobject.txt documentation and samples to create a new
>> object whose sole purpose in life is to expose the sysfs interface,
>> without interfering with the existing device entries in the driver.
>> I'm not sure I see a clean way to use a single struct device here....
>
> Put it on the input device, which is what is the per-device thing.  It's
> much simpler than creating a new struct kobject.  You can even create a
> subdirectory for your attributes if you use an attribute group (which
> you should be doing anyway, it's much simpler that way.)
>

OK, one thing I'm not clear on: is there a clean API for adding
attributes to an existing struct device, or do I need to "subclass" it
(the C containment and delegation approach)?

This may take me a few days or a week or so, depending on how things
go. It's dissertation proposal season....

> And document the attributes please.
>

Will do... still need to nail down what the interface should look like.

> thanks,
>
> greg k-h
>

Thanks,
Mike
-- 
Mike Murphy
Ph.D. Candidate and NSF Graduate Research Fellow
Clemson University School of Computing
120 McAdams Hall
Clemson, SC 29634-0974 USA
Tel: +1 864.656.2838   Fax: +1 864.656.0145
http://cirg.cs.clemson.edu/~mamurph
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
