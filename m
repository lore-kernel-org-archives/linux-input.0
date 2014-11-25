From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Tue, 25 Nov 2014 10:24:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411251022141.976-100000@iolanthe.rowland.org>
References: <CANLzEkuZYrF_tLq5k3xBBkSmtszL851ZK7VW8Jav3vKdw9JLMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45175 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750856AbaKYPY0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 10:24:26 -0500
In-Reply-To: <CANLzEkuZYrF_tLq5k3xBBkSmtszL851ZK7VW8Jav3vKdw9JLMA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: johan@kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>

On Mon, 24 Nov 2014, Benson Leung wrote:

> Hi Alan,
> 
> 
> On Sat, Nov 22, 2014 at 7:55 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > There is no USB wrapper for pm_runtime_idle calls, but one could be
> > added.  Still, in the meantime can you check to see what happens if you
> > add
> >
> >         pm_runtime_idle(&usbhid->intf->dev);
> >
> > in usbhid_close() just after needs_remote_wakeup is set to 0?  You can
> > do the same thing in usbhid_stop() if you want.
> 
> I tried using this in lieu of usb_autopm_get/put_interface:
> 
>     usbhid->intf->needs_remote_wakeup = 0;
>     pm_runtime_idle(&usbhid->intf->dev);
>     pm_runtime_idle(usbhid->intf->dev.parent);
> 
> It did not work. I see the autosuspend_check() that was kicked off as
> a result of hid_hw_power, which falls into the "remote wakeup needed
> for autosuspend" branch, but I don't see another autosuspend_check()
> that picks up the updated value of  needs_remote_wakeup.

Well, why not?

In order to work on the kernel effectively, you need the right 
mind-set.  Don't just tell people when something goes wrong -- figure 
out why the problem occurred and propose a way to fix it.

Alan Stern

