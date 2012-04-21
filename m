From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sat, 21 Apr 2012 21:40:15 +0800
Message-ID: <CACVXFVPR76O+zFtL3pBc-KyhN85xN6AkgTT_Md1kG2wWwjosiw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1204202032530.19313-100000@netrider.rowland.org>
	<201204211225.05846.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35430 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab2DUNkT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Apr 2012 09:40:19 -0400
In-Reply-To: <201204211225.05846.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Sat, Apr 21, 2012 at 6:25 PM, Oliver Neukum <oliver@neukum.org> wrot=
e:
> Am Samstag, 21. April 2012, 02:37:35 schrieb Alan Stern:
>> On Fri, 20 Apr 2012, Oliver Neukum wrote:
>>
>> > As I said, I'd very much appreciate sane semantics for usb_unlink_=
urb().
>>
>> Aside from the practicality issue of altering a large number of
>> existing drivers, changing the semantics the way you want would be
>> difficult because it would force the HCDs to defer some giveback
>> operations to a bottom half or timer routine.
>
> Or a work queue, which would have to be dedicated to avoid deadlocks
> with storage.
>
>> Think about what happens if the URB being unlinked hasn't been
>> presented to the hardware yet. =A0Once it has been removed from the =
HCD's
>> internal lists, there's no reason not to give it back right away. =A0=
And
>> there's no natural time to give it back later.
>
> Now. The question is not when, but from which context.
> The context should be uniform, so that the requirements
> for locking should also be uniform.

How about always scheduling a tasklet to run what usb_unlink_urb does?
just implement usb_unlink_urb as something like
tasklet_schedule(unlink_tasklet).

Then we can have a uniform lock requirement and no changes are involved
on host controller drivers.


Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
