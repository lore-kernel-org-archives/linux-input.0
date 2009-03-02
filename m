From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: PATCH [1/3] drivers/input/xpad.c: Improve Xbox 360 wireless
	support and add sysfs interface
Date: Mon, 2 Mar 2009 15:13:43 -0800
Message-ID: <20090302231343.GA31663@kroah.com>
References: <5aa163d00902282053h38b0febbyb37fc30855fdc985@mail.gmail.com> <20090302130425.23cc628d.akpm@linux-foundation.org> <20090302211820.GA21489@kroah.com> <20090302133551.1266f725.akpm@linux-foundation.org> <5aa163d00903021359x3a4693f5tbb7f1e3fec4d88b8@mail.gmail.com> <20090302223916.GA31381@kroah.com> <5aa163d00903021504l1965ecdi3423a43134de10d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5aa163d00903021504l1965ecdi3423a43134de10d0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Mar 02, 2009 at 06:04:00PM -0500, Mike Murphy wrote:
> On Mon, Mar 2, 2009 at 5:39 PM, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> >
> > I tried to create such an interface years ago, and the macro tricks
> > involved ended up being horrible, and in the end, it didn't work. =A0=
But
> > if you can come up with something, I'd love to see it.
> >
> > thanks,
> >
> > greg k-h
> >
>=20
> I could probably give it a shot, but possibly not until May... once
> the current semester ends. I really need to understand the kernel typ=
e
> system -- or at least the types that "should" be exposed to userspace
> -- before thinking about the design too much. Maybe that's the
> question that needs to be asked first: in general, what does a sysfs
> interface into a driver look like? It's certainly flexible enough to
> do a lot, and the existing interfaces allow it to do a lot, but is
> there a simplification that covers some large percentage of cases?

Look at some of the easy things, like integers.  If you could get those
working, the hwmon drivers could be simplified a lot more.

The problem I ran into was that the attribute show/store functions deal=
s
with a "struct device" which you need to cast into some other structure
type, and then determine the offset of the integer you are needing to
access.

Hm, maybe that wouldn't be that hard with 2 offset_of() values, I think
I was only trying to do one, but that was a long time ago...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
