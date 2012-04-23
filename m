From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Mon, 23 Apr 2012 10:24:58 +0200
Message-ID: <201204231024.58168.oneukum@suse.de>
References: <CACVXFVPR76O+zFtL3pBc-KyhN85xN6AkgTT_Md1kG2wWwjosiw@mail.gmail.com> <Pine.LNX.4.44L0.1204211327090.475-100000@netrider.rowland.org> <CACVXFVOQpYcHUj3XApyCVWDuvUEKi+RSWC8Ly4Dnj7vrun68cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVOQpYcHUj3XApyCVWDuvUEKi+RSWC8Ly4Dnj7vrun68cg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Sonntag, 22. April 2012, 13:53:32 schrieb Ming Lei:
> >> Then we can have a uniform lock requirement and no changes are inv=
olved
> >> on host controller drivers.
> >
> > The return values would not be correct.
>=20
> If you run 'git grep -n usb_unlink_urb drivers/usb/', it may show tha=
t
> most of callers do not check its return value, and the others only ch=
eck
> for dumping warnings. If usb_unlink_urb is converted into tasklet
> implementation, we still can dump these warnings inside its tasklet f=
unction.

That is a very bad idea. You make implementing a proper reference count=
 next
to impossible this way. And it makes no sense. If you use a work queue =
you
can use usb_kill_urb() anyway.

	Regards
		Oliver

--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)=20
Maxfeldstra=DFe 5                        =20
90409 N=FCrnberg=20
Germany=20
- - -=20
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
