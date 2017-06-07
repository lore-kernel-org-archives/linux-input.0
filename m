From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/8] HID: Consolidate serializing ope/close in
 transport drivers
Date: Wed, 7 Jun 2017 11:45:39 +0300
Message-ID: <CAHp75Vfhf4vfrJP4uorMyqNVYBFr3X8U0iZWuk1jCnw2qPoB=A@mail.gmail.com>
References: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 7, 2017 at 9:59 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> This originally came about as report of uhid sending duplicate open and
> premature close when hidraw was used alongside of input. After looking at
> the drivers I think we should consolidate user tracking inside of the HID
> core. While implementing this, there were a few cleanups as well.
>
> V2:
>
> - added greybus hid changes
> - added error handling in hiddev around hid_hw_open which is __much_check

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Dmitry Torokhov (8):
>   HID: hiddev: use hid_hw_open/close instead of usbhid_open/close
>   HID: hiddev: use hid_hw_power instead of usbhid_get/put_power
>   HID: usbhid: do not rely on hid->open when deciding to do IO
>   HID: serialize hid_hw_open and hid_hw_close
>   HID: i2c-hid: remove custom locking from i2c_hid_open/close
>   HID: usbhid: remove custom locking from usbhid_open/close
>   greybus: hid: remove custom locking from gb_hid_open/close
>   HID: remove no longer used hid->open field
>
>  drivers/hid/hid-core.c        |  89 +++++++++++++++++++++++++
>  drivers/hid/i2c-hid/i2c-hid.c |  32 +++------
>  drivers/hid/usbhid/hid-core.c | 150 ++++++++++++++++++++----------------------
>  drivers/hid/usbhid/hiddev.c   |  24 +++----
>  drivers/hid/usbhid/usbhid.h   |  15 +++--
>  drivers/staging/greybus/hid.c |  43 ++++--------
>  include/linux/hid.h           |  73 +++-----------------
>  7 files changed, 214 insertions(+), 212 deletions(-)
>
> Thanks.
>
> --
> Dmitry
>



-- 
With Best Regards,
Andy Shevchenko
