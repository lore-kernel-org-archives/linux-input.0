From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Fri, 21 Nov 2014 16:44:06 -0800
Message-ID: <CANLzEkuPr0hhjecVHaMkGfX7_DZr4wUV=-yP2+V6uBaYdAkhXw@mail.gmail.com>
References: <CANLzEksHgo_tQiwJoUtXd0iV7tDXq0ieNrAXgtXwPtxxPBWrgw@mail.gmail.com>
	<Pine.LNX.4.44L0.1411141008020.1043-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:56992 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbaKVAoH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Nov 2014 19:44:07 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so4918216obc.1
        for <linux-input@vger.kernel.org>; Fri, 21 Nov 2014 16:44:06 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1411141008020.1043-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: johan@kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>

Hi Alan,

On Fri, Nov 14, 2014 at 7:17 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> The reason for the get/put is to force a call to autosuspend_check().
> But in this case, if killing the interrupt URB causes
> autosuspend_check() to run then the get/put isn't needed.
>
> On the other hand, I don't see why killing the interrupt URB would
> cause autosuspend_check() to run.  Can you explain that?

Sorry for the delay in my response. I did some more checking of my
particular failure, and my commit message is incorrect. The
usb_kill_urb is actually not the cause of this problem. It does not
result in autosuspend_check() itself, and is only serving to add some
delay.

hidraw_release() in hidraw.c calls drop_ref(), which calls the
following in sequence upon clearing the last reader :
/* close device for last reader */
hid_hw_power(hidraw->hid, PM_HINT_NORMAL);
hid_hw_close(hidraw->hid);

hid_hw_power results in a usb_autopm_put_interface. In this case, the
reference count is decremented to 0, and a delayed autosuspend request
is attempted.
hid_hw_close leads to usbhid_close, which clears needs_remote_wakeup.

However, there's no guarantee that the clear of needs_remote_wakeup
will occur before the delayed work ( runtime_idle() ->
autosuspend_check() )  runs. Moving usbhid->intf->needs_remote_wakeup
= 0 to before the usb_kill_urb(usbhid->urbin) only serves to reduce
the amount of time between these events and makes this particular
failure less likely.

The correct solution is to put get/put around each change of
needs_remote_wakeup, as that will correctly trigger another delayed
autosuspend_check(), whose result is affected by the state of
needs_remote_wakeup.

Since autosuspend_check() occurs as delayed work, I think it is
appropriate to add get/put around the clear in usbhid_stop as well.

-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org

On Fri, Nov 14, 2014 at 7:17 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 13 Nov 2014, Benson Leung wrote:
>
>> Hi Alan,
>>
>> On Thu, Nov 13, 2014 at 2:11 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > Wait a minute -- in your previous email you said this approach didn't
>> > work.  So does it work or doesn't it?
>>
>> Sorry for the confusion. The approach *does* work.
>>
>> That was actually my original idea to fix the problem, but I saw other
>> places in the kernel where it was done with a get/put.
>
> The reason for the get/put is to force a call to autosuspend_check().
> But in this case, if killing the interrupt URB causes
> autosuspend_check() to run then the get/put isn't needed.
>
> On the other hand, I don't see why killing the interrupt URB would
> cause autosuspend_check() to run.  Can you explain that?
>
> Alan Stern
>
>
>



-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
