From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sat, 21 Apr 2012 21:28:08 +0200
Message-ID: <201204212128.08991.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1204211327090.475-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204211327090.475-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Samstag, 21. April 2012, 19:31:20 schrieb Alan Stern:
> On Sat, 21 Apr 2012, Ming Lei wrote:
>=20
> > >> Think about what happens if the URB being unlinked hasn't been
> > >> presented to the hardware yet. =EF=BF=BDOnce it has been removed=
 from the HCD's
> > >> internal lists, there's no reason not to give it back right away=
=2E =EF=BF=BDAnd
> > >> there's no natural time to give it back later.
> > >
> > > Now. The question is not when, but from which context.
> > > The context should be uniform, so that the requirements
> > > for locking should also be uniform.
> >=20
> > How about always scheduling a tasklet to run what usb_unlink_urb do=
es?
> > just implement usb_unlink_urb as something like
> > tasklet_schedule(unlink_tasklet).
> >=20
> > Then we can have a uniform lock requirement and no changes are invo=
lved
> > on host controller drivers.
>=20
> The return values would not be correct.
>=20
> On the other hand, usbnet could call usb_unlink_urb from within a=20
> tasklet.

No. That would introduce a race.
Basically whenever a completion handler resubmits itself, any timeout
has to avoid a race. Checking for a timeout and unlinking must be atomi=
c,
just as the completion handler must make the resubmission and noting
the time atomic.
If I cannot do this with a lock, then a much more complex pattern is ne=
cessary.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
