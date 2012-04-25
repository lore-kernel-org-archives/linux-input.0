From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 08:27:55 +0800
Message-ID: <CACVXFVNH7kGpHEBD6TcrOu8WjCd1dfvDFUHp4B2QGiccw7vuMg@mail.gmail.com>
References: <CACVXFVNhPKbFZN5AjT3BNdNP+3bZP7miJZrBEER97scMR5nNAQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1204241110160.1511-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204241110160.1511-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 24, 2012 at 11:20 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org=
> wrote:
> On Tue, 24 Apr 2012, Ming Lei wrote:
>
>> > Instead of changing return codes or adding locks, how about
>> > implementing a small state machine for each URB?
>> >
>> > =A0 =A0 =A0 =A0Initially the state is ACTIVE.
>> >
>> > =A0 =A0 =A0 =A0When the URB times out, acquire the lock. =A0If the=
 state is not
>> > =A0 =A0 =A0 =A0equal to ACTIVE, drop the lock and return immediate=
ly (the URB
>> > =A0 =A0 =A0 =A0is being unlinked concurrently). =A0Otherwise set t=
he state to
>> > =A0 =A0 =A0 =A0UNLINK_STARTED, drop the lock, call usb_unlink_urb,=
 and
>> > =A0 =A0 =A0 =A0reacquire the lock. =A0If the state hasn't changed,=
 set it back
>> > =A0 =A0 =A0 =A0to ACTIVE. =A0But if the state has changed to UNLIN=
K_FINISHED,
>> > =A0 =A0 =A0 =A0set it to ACTIVE and resubmit.
>> >
>> > =A0 =A0 =A0 =A0In the completion handler, grab the lock. =A0If the=
 state
>> > =A0 =A0 =A0 =A0is ACTIVE, resubmit. =A0But if the state is UNLINK_=
STARTED,
>> > =A0 =A0 =A0 =A0change it to UNLINK_FINISHED and don't resubmit.
>>
>> Sounds a smart solution, but extra care should be put on submit urb
>> in other context, maybe the lock is to be held to check URB state be=
fore
>> submitting it because the lock is released during usb_unlink_urb.
>
> Don't you face a similar problem right now? =A0What happens if the
> timeout expires while the URB completion handler is running? =A0Then =
the
> timer routine could end up unlinking the resubmitted URB instead of t=
he
> original transfer.
>
> You need a sort of "generation number", or something like that, to
> prevent this kind of mistake. =A0The same mechanism should work with =
the
> state machine.
>
> Are you saying that every place where the URB is submitted, the state
> has to be set to ACTIVE first, and this has to done with the lock hel=
d?

Maybe it is not enough. If the URB state is set as UNLINK_STARTED
and the lock is released, will you continue the submitting?

> Yes, that's right.
>
>> Also basically the URB state is maintained by device driver, so look=
s
>> better to add the state into specific device driver instead of struc=
t URB to
>> save each URB storage, but if so, the solution will become more
>> complicated than the way of adding lock.
>
> Why? =A0In one case you add a state variable, in the other case you a=
dd a
> spinlock. =A0One isn't much harder than the other.

I mean the whole URB state machine is to be maintained by device driver=
,
not simply adding a state variable.  But for the way of adding lock, ju=
st
several lines of spin_lock/spin_unlock with check on urb->status are
enough.

Looks both ways are generic enough to avoid the problem, and adding
lock is simpler.

Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
