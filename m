From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sun, 22 Apr 2012 18:51:26 +0800
Message-ID: <CACVXFVNz8uuiXWVfg3rqhE_bazCSsH1mGANc5rJCJbbejTc1dQ@mail.gmail.com>
References: <201204212128.08991.oliver@neukum.org>
	<Pine.LNX.4.44L0.1204211717310.3981-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204211717310.3981-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Apr 22, 2012 at 5:49 AM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>=
 wrote:
> On Sat, 21 Apr 2012, Oliver Neukum wrote:
>
>> > On the other hand, usbnet could call usb_unlink_urb from within a
>> > tasklet.
>>
>> No. That would introduce a race.
>> Basically whenever a completion handler resubmits itself, any timeou=
t
>> has to avoid a race. Checking for a timeout and unlinking must be at=
omic,
>> just as the completion handler must make the resubmission and noting
>> the time atomic.
>> If I cannot do this with a lock, then a much more complex pattern is=
 necessary.
>
> I see. =A0I never really understood the problem before.
>
> Although the kerneldoc doesn't actually say so, it should be safe to
> assume that usb_unlink_urb calls the completion routine directly _onl=
y_
> in cases where the unlink succeeded. =A0(We could add this to the
> kerneldoc.)
>
> Therefore: If the URB completes with status other than -ECONNRESET th=
en
> you can safely take the lock for resubmission. =A0If the URB complete=
s
> with status =3D=3D -ECONNRESET then you know it was unlinked, so you =
don't
> need to take the lock -- the race has already been lost.
>
> Does that solve your problem?

Not sure if that does work.

If the URB completes asynchronously after unlinking, its status is stil=
l
 -ECONNRESET, so extra race may be caused without holding the lock
because complete handler will access some global data.



Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
