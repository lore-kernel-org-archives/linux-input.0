From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Tue, 19 Sep 2017 18:39:44 -0700
Message-ID: <CAKdAkRSNqhMBx8-2wO0ZAVtDEuW0pxjVisgr86Wr+rPWD4y=3A@mail.gmail.com>
References: <20170908174337.GA13616@dtor-ws> <1504942552.10395.2.camel@suse.com>
 <20170911200252.GB41615@decatoncale.mtv.corp.google.com> <20170911232907.GA92445@decatoncale.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:47437 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbdITBjp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Sep 2017 21:39:45 -0400
In-Reply-To: <20170911232907.GA92445@decatoncale.mtv.corp.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@google.com>
Cc: Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

On Mon, Sep 11, 2017 at 4:29 PM, Benson Leung <bleung@google.com> wrote:
> Hi Oliver,
>
> On Mon, Sep 11, 2017 at 01:02:52PM -0700, Benson Leung wrote:
>> Thanks for the pointer. I'll respin the patch with the no_resume version of
>> usb_autopm_get_interface and retest.
>>
>
> I went and tried this patch but with usb_autopm_get_interface_no_resume instead
> and the original bug I was trying to fix with a Yubikey hid security key came
> back, so something is still wrong here.
>
> I went ahead and filed a bug to track this here:
> https://bugs.chromium.org/p/chromium/issues/detail?id=764112
>
> I'll find some time to dig into this deeper and understand why this device
> ends up getting stuck in active instead of suspending when all handles are
> closed.

Meh, it is problem in hidraw that basically does
usb_autopm_put_interface() before letting usbhid_close() to run. Once
I swap  hid_hw_power() and hid_hw_close() it autosuspends properly.

I just sent out a patch.

Thanks.

-- 
Dmitry
