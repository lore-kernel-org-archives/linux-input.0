From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sun, 22 Apr 2012 21:52:28 +0800
Message-ID: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com>
References: <CACVXFVNz8uuiXWVfg3rqhE_bazCSsH1mGANc5rJCJbbejTc1dQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1204220848020.15283-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37211 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab2DVNwb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Apr 2012 09:52:31 -0400
In-Reply-To: <Pine.LNX.4.44L0.1204220848020.15283-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Sun, Apr 22, 2012 at 8:50 PM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
> On Sun, 22 Apr 2012, Ming Lei wrote:
>
>> > Although the kerneldoc doesn't actually say so, it should be safe =
to
>> > assume that usb_unlink_urb calls the completion routine directly _=
only_
>> > in cases where the unlink succeeded. =A0(We could add this to the
>> > kerneldoc.)
>> >
>> > Therefore: If the URB completes with status other than -ECONNRESET=
 then
>> > you can safely take the lock for resubmission. =A0If the URB compl=
etes
>> > with status =3D=3D -ECONNRESET then you know it was unlinked, so y=
ou don't
>> > need to take the lock -- the race has already been lost.
>> >
>> > Does that solve your problem?
>>
>> Not sure if that does work.
>>
>> If the URB completes asynchronously after unlinking, its status is s=
till
>> =A0-ECONNRESET, so extra race may be caused without holding the lock
>> because complete handler will access some global data.
>
> That would be a completely separate race, right? =A0So maybe it can u=
se a

Not sure, at least in both usbnet and usbhid cases, the lock is held be=
fore
usb_unlink_urb, and the same lock is to be acquired in the URB complete
handler.

> different lock for protection -- and this other lock could be dropped
> before usb_unlink_urb is called.

If the lock which is to be acquired in the URB complete handler is drop=
ped
before calling usb_unlink_urb, one new submitted URB in complete handle=
r
may be unlinked, as mentioned by Oliver already.



Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
