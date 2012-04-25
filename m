From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 15:02:58 +0800
Message-ID: <CACVXFVMEttnWo34ZxBsm4vdW1y5f5mBjY1s6BVbbsjck-4cSbA@mail.gmail.com>
References: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com>
	<201204242057.29100.oliver@neukum.org>
	<CACVXFVOuSamcBrPT=K9Q3fAXULjz57e-1W9pi9AW1gAKxyCT7g@mail.gmail.com>
	<201204250819.32642.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49373 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2DYHDD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 03:03:03 -0400
In-Reply-To: <201204250819.32642.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Wed, Apr 25, 2012 at 2:19 PM, Oliver Neukum <oneukum@suse.de> wrote:

>> @@ -546,8 +557,13 @@ static void __usbhid_submit_report(struct
>> hid_device *hid, struct hid_report *re
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* no race because thi=
s is called under
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* spinlock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, us=
bhid->last_out + HZ * 5))
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, us=
bhid->last_out + HZ * 5) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 !usbhid->urbout->unlinked) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unloc=
k(&usbhid->lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_unli=
nk_urb(usbhid->urbout);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(=
&usbhid->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>
> Same objection. You are just making the race unlikelier. The flag
> needs to be set under a lock you hold while checking time_after().

urb->unlinked is checked with holding both the two lockes, but set with
holding the unlink lock or the lock or both, looks it is enough to
avoid the race, isn't it?

> We'd be back at the original proposal.

Introducing a new flag to describe 'unlinked' is still OK, but
borrowing urb->unlinked is better, the bad is that it is private.

Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
