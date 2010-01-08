From: "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.3
Date: Fri, 8 Jan 2010 10:43:15 -0700
Message-ID: <9a62ecfffc0d173f5f7fb8ad4c5ce14c.squirrel@intranet.cs.nmsu.edu>
References: <201001071623.o07GNOB4022157@mustang.cs.nmsu.edu>
    <20100108170450.GB8328@elf.ucw.cz> <20100108171329.GA4711@kroah.com>
    <201001080920.51979.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201001080920.51979.dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, krzysztof.h1-5tc4TXWwyLM@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Friday 08 January 2010 09:13:29 am Greg KH wrote:
>> On Fri, Jan 08, 2010 at 06:04:50PM +0100, Pavel Machek wrote:
>> > On Fri 2010-01-08 09:50:33, Rick L. Vinyard, Jr. wrote:
>> > > Pavel Machek wrote:
>> > > > Hi!
>> > > >
>> > > >> > +static DEVICE_ATTR(name, 0666, g13_name_show, g13_name_store);
>> > > >>
>> > > >> What this attribute is for?
>> > > >
>> > > > Actually, all the new files this added need to be documented.
>> > >
>> > > Which is better? A hid-g13.txt file added to Documentation/ or
>> comments
>> > > in the driver itself?
>> >
>> > Documentation. Coordinate with sysfs maintainer (gregkh).
>>
>> All sysfs files need to be documented in Documentation/ABI/  Please add
>> the documentation there for your new sysfs files.
>
> We need to have an agreement that all of them are needed first though.
>
> --
> Dmitry
>


True. I'm still working through your comments.



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
