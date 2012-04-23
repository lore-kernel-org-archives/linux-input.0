From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Mon, 23 Apr 2012 11:42:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204231121200.1612-100000@iolanthe.rowland.org>
References: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35677 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753240Ab2DWPmM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 11:42:12 -0400
In-Reply-To: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Oliver Neukum <oliver@neukum.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Sun, 22 Apr 2012, Ming Lei wrote:

> On Sun, Apr 22, 2012 at 8:50 PM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:
> > On Sun, 22 Apr 2012, Ming Lei wrote:
> >
> >> > Although the kerneldoc doesn't actually say so, it should be saf=
e to
> >> > assume that usb_unlink_urb calls the completion routine directly=
 _only_
> >> > in cases where the unlink succeeded. =A0(We could add this to th=
e
> >> > kerneldoc.)
> >> >
> >> > Therefore: If the URB completes with status other than -ECONNRES=
ET then
> >> > you can safely take the lock for resubmission. =A0If the URB com=
pletes
> >> > with status =3D=3D -ECONNRESET then you know it was unlinked, so=
 you don't
> >> > need to take the lock -- the race has already been lost.
> >> >
> >> > Does that solve your problem?
> >>
> >> Not sure if that does work.
> >>
> >> If the URB completes asynchronously after unlinking, its status is=
 still
> >> =A0-ECONNRESET, so extra race may be caused without holding the lo=
ck
> >> because complete handler will access some global data.
> >
> > That would be a completely separate race, right? =A0So maybe it can=
 use a
>=20
> Not sure, at least in both usbnet and usbhid cases, the lock is held =
before
> usb_unlink_urb, and the same lock is to be acquired in the URB comple=
te
> handler.
>=20
> > different lock for protection -- and this other lock could be dropp=
ed
> > before usb_unlink_urb is called.
>=20
> If the lock which is to be acquired in the URB complete handler is dr=
opped
> before calling usb_unlink_urb, one new submitted URB in complete hand=
ler
> may be unlinked, as mentioned by Oliver already.

We are now talking about two locks.  One of them is held during the=20
call to usb_unlink_urb; the completion handler does not acquire that=20
lock if the URB's status is -ECONNRESET.  The other lock is dropped=20
before usb_unlink_urb is called, so the completion handler can safely=20
grab it.


On Mon, 23 Apr 2012, Oliver Neukum wrote:

> > If the URB completes asynchronously after unlinking, its status is =
still
> >  -ECONNRESET, so extra race may be caused without holding the lock
> > because complete handler will access some global data.
>=20
> That is the race. And you need not invoke global data. The original
> race opens again if you are submitting a new URB without the lock
> held.
> This is because we cannot be sure that the same URB is unlinked
> only once. A subsequent timeout may kill the wrong URB if the
> first is unlinked so that the callback really comes in interrupt.
>=20
> But the basic idea is brilliant. It's just that the one way logical i=
mplication:
> recursive direct call of the callback -> status =3D=3D -ECONNRESET
> is not strong enough. But that is very easy to fix. As we know whethe=
r
> the callback is directly called or not, all we need to do is differen=
tiate
> the cases in urb->status, by introducing a new error code.

I don't like the idea of changing the status codes.  It would mean=20
changing usb_kill_urb too.

Instead of changing return codes or adding locks, how about
implementing a small state machine for each URB?

	Initially the state is ACTIVE.

	When the URB times out, acquire the lock.  If the state is not
	equal to ACTIVE, drop the lock and return immediately (the URB
	is being unlinked concurrently).  Otherwise set the state to=20
	UNLINK_STARTED, drop the lock, call usb_unlink_urb, and
	reacquire the lock.  If the state hasn't changed, set it back
	to ACTIVE.  But if the state has changed to UNLINK_FINISHED,
	set it to ACTIVE and resubmit.

	In the completion handler, grab the lock.  If the state
	is ACTIVE, resubmit.  But if the state is UNLINK_STARTED,=20
	change it to UNLINK_FINISHED and don't resubmit.

This is a better approach, in that it doesn't make any assumptions=20
regarding synchronous vs. asynchronous unlinks.  If you want, you could=
=20
have two different ACTIVE substates, one for URBs which haven't yet=20
been unlinked and one for URBs which have been.  Then you could avoid=20
unlinking the same URB twice.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
