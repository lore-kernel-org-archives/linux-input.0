From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st
 insert, ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Fri, 24 Sep 2010 09:46:09 -0700
Message-ID: <20100924164609.GB16655@kroah.com>
References: <Pine.LNX.4.44L0.1009211013460.1644-100000@iolanthe.rowland.org>
 <4C98C70B.3080407@turmel.org>
 <4C98D892.7030605@googlemail.com>
 <AANLkTinQVNy4yOSW=aEbuYh6b_F8nKBLxsjxBDk8zq8O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinQVNy4yOSW=aEbuYh6b_F8nKBLxsjxBDk8zq8O-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mat <jackdachef-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Gabriel C <nix.or.die-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Guillaume Chazarain <guichaz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Bombe <aeb-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Alex Riesen <raa.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 22, 2010 at 11:47:09AM +0200, Mat wrote:
> On Tue, Sep 21, 2010 at 6:08 PM, Gabriel C <nix.or.die-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org=
> wrote:
> > On 21.09.2010 16:54, Phil Turmel wrote:
> >
> >> On 09/21/2010 10:30 AM, Alan Stern wrote:
> >>> On Tue, 21 Sep 2010, Jiri Kosina wrote:
> >>>
> >>>> I have just found out that it's actually CONFIG_USB_DYNAMIC_MINO=
RS which
> >>>> makes the difference. When unset, the problem doesn't trigger, a=
nd
> >>>> usb_find_interface() always returns the proper interface. When
> >>>> CONFIG_USB_DYNAMIC_MINORS is being used, the oops happen.
> >>>>
> >>>> I'll look into that.
> >>>
> >>> Apparently the problem is that intf->minors doesn't get initializ=
ed
> >>> properly. =A0This patch should fix it. =A0Everybody, please try i=
t out.
> >>
> >> Yes, this works for me. =A0(as did Jiri's version.)
> >
> >
> > Both versions of the patch are working fine for me too also.
> >
> >>
> >> Thank you both for the support.
> >>
> >> Feel free to add my:
> >>
> >> Tested-by: Philip J. Turmel <philip-xiX+HWoRdKcdnm+yROfE0A@public.gmane.org>
> >
> >
> > And mine if you wish.
> > Tested-by: Gabriel Craciunescu =A0<nix.or.die-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> >
> >
>=20
> confirmed !
>=20
> I also tested both and it works fine so far :)
>=20
> I don't know if it's too late already:
> Tested-by: Matthias Bayer <jackdachef-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Nope, not to late, I've added this to the patch as well, thanks for
letting us know.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
