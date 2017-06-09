From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn-yOkvZcmFvRU@public.gmane.org>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no longer works
Date: Fri, 09 Jun 2017 10:52:42 +0200
Message-ID: <8760g5ilut.fsf@miraculix.mork.no>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk>
        <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
        <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com>
        <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
        <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm>
        <20170609082703.GA29271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170609082703.GA29271-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> (Greg KH's message of "Fri, 9
        Jun 2017 10:27:03 +0200")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input@vger.kernel.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> writes:

> On Fri, Jun 09, 2017 at 10:21:47AM +0200, Jiri Kosina wrote:
>> Longer-term, we'd ideally make 'generic' driver special and let it attac=
h=20
>> as a 'last resort driver' if none of the specific driver picked the devi=
ce=20
>> up during probe. But I don't think our current driver model allows this=
=20
>> easily ... or is there way I am not seeing?
>
> Nope, the driver model does not provide a way for this, sorry, it's been
> a complaint from the very beginning that we don't really know how to
> handle, except to make sure the order of the drivers loaded are the
> priority list, and that's not really a solution at all.

Add a 'priority' field to struct device_driver and sort the list by this
field instead of load order?


Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
