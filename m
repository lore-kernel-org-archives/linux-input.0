From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Thu, 13 Nov 2014 12:44:48 -0800
Message-ID: <CANLzEksGg0KyWOS+WYv_U8GzSJ4C_H0LTpdXvz8Ae-8mH6K41w@mail.gmail.com>
References: <1415909806-23848-1-git-send-email-bleung@chromium.org>
	<Pine.LNX.4.44L0.1411131539330.929-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:47012 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933526AbaKMUot (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2014 15:44:49 -0500
Received: by mail-oi0-f52.google.com with SMTP id u20so10973964oif.11
        for <linux-input@vger.kernel.org>; Thu, 13 Nov 2014 12:44:48 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1411131539330.929-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: johan@kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>

On Thu, Nov 13, 2014 at 12:41 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> usbhid_stop probably doesn't need it.  And it should be possible to fix
> usbhid_close more easily just by interchanging the two lines:
>
> -                       usb_kill_urb(usbhid->urbin);
>                         usbhid->intf->needs_remote_wakeup = 0;
> +                       usb_kill_urb(usbhid->urbin);
>
> Have you tried this?

Yes, I tried that as well, and that does work.

I used the get/put because that's the way it was done in other
drivers, for example in synusb_close() in
drivers/input/mouse/synaptics_usb.c

-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
