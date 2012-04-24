From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Tue, 24 Apr 2012 16:35:09 +0200
Message-ID: <201204241635.10090.oneukum@suse.de>
References: <Pine.LNX.4.44L0.1204231121200.1612-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204231121200.1612-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Montag, 23. April 2012, 17:42:11 schrieb Alan Stern:
> I don't like the idea of changing the status codes.  It would mean=20
> changing usb_kill_urb too.

Why?

> Instead of changing return codes or adding locks, how about
> implementing a small state machine for each URB?
>=20
>         Initially the state is ACTIVE.
>=20
>         When the URB times out, acquire the lock.  If the state is no=
t
>         equal to ACTIVE, drop the lock and return immediately (the UR=
B
>         is being unlinked concurrently).  Otherwise set the state to=20
>         UNLINK_STARTED, drop the lock, call usb_unlink_urb, and
>         reacquire the lock.  If the state hasn't changed, set it back
>         to ACTIVE.  But if the state has changed to UNLINK_FINISHED,
>         set it to ACTIVE and resubmit.
>=20
>         In the completion handler, grab the lock.  If the state
>         is ACTIVE, resubmit.  But if the state is UNLINK_STARTED,=20
>         change it to UNLINK_FINISHED and don't resubmit.
>=20
> This is a better approach, in that it doesn't make any assumptions=20
> regarding synchronous vs. asynchronous unlinks.  If you want, you cou=
ld=20
> have two different ACTIVE substates, one for URBs which haven't yet=20
> been unlinked and one for URBs which have been.  Then you could avoid=
=20
> unlinking the same URB twice.

That would work, provided we extend the status machine by an error
code when resubmission is not desired and check for UNLINK_STARTED
also when a timeout begins. But I wouldn't call that a simple solution.

	Regards
		Oliver

--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=
=B6rffer, HRB 16746 (AG N=C3=BCrnberg)=20
Maxfeldstra=C3=9Fe 5                        =20
90409 N=C3=BCrnberg=20
Germany=20
- - -=20
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
