From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sun, 22 Apr 2012 19:53:32 +0800
Message-ID: <CACVXFVOQpYcHUj3XApyCVWDuvUEKi+RSWC8Ly4Dnj7vrun68cg@mail.gmail.com>
References: <CACVXFVPR76O+zFtL3pBc-KyhN85xN6AkgTT_Md1kG2wWwjosiw@mail.gmail.com>
	<Pine.LNX.4.44L0.1204211327090.475-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37056 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab2DVLxg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Apr 2012 07:53:36 -0400
In-Reply-To: <Pine.LNX.4.44L0.1204211327090.475-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Sun, Apr 22, 2012 at 1:31 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sat, 21 Apr 2012, Ming Lei wrote:
>> How about always scheduling a tasklet to run what usb_unlink_urb does?
>> just implement usb_unlink_urb as something like
>> tasklet_schedule(unlink_tasklet).
>>
>> Then we can have a uniform lock requirement and no changes are involved
>> on host controller drivers.
>
> The return values would not be correct.

If you run 'git grep -n usb_unlink_urb drivers/usb/', it may show that
most of callers do not check its return value, and the others only check
for dumping warnings. If usb_unlink_urb is converted into tasklet
implementation, we still can dump these warnings inside its tasklet function.

>
> On the other hand, usbnet could call usb_unlink_urb from within a
> tasklet.

Sorry, you mean tasklet_schedule can't be called inside a tasklet?

Thanks,
--
Ming Lei
