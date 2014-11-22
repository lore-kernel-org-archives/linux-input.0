From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Fri, 21 Nov 2014 17:00:49 -0800
Message-ID: <CANLzEkvcm5g_T+FsEQF2UFzS5A2u7CWgdTiEJAxidfxgAE5bHw@mail.gmail.com>
References: <1415909806-23848-1-git-send-email-bleung@chromium.org>
	<1415956110.2640.5.camel@linux-0dmf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:38243 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbaKVBAt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Nov 2014 20:00:49 -0500
Received: by mail-oi0-f41.google.com with SMTP id a3so4563124oib.0
        for <linux-input@vger.kernel.org>; Fri, 21 Nov 2014 17:00:49 -0800 (PST)
In-Reply-To: <1415956110.2640.5.camel@linux-0dmf.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: johan@kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>

On Fri, Nov 14, 2014 at 1:08 AM, Oliver Neukum <oneukum@suse.de> wrote:
> On Thu, 2014-11-13 at 12:16 -0800, Benson Leung wrote:
>
>> In usbhid_open, usb_autopm_get_interface is called
>> before setting the needs_remote_wakeup flag, and
>> usb_autopm_put_interface is called after hid_start_in.
>>
>> However, when the device is closed in usbhid_close, the same
>> protection isn't there when clearing needs_remote_wakeup. This will
>> add that to usbhid_close as well as usbhid_stop.
>
> Interesting, but this has the side effect of waking devices
> that are asleep just to remove the flag.
>
>         Regards


If devices are already asleep with this flag enabled, that means that
they are presently configured for remote wake.

Waking the device in the case of a close() is appropriate because it
also has the effect of re-suspending the device with the capability
disabled, as it is no longer necessary.

-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
