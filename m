From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: logitech-dj: Fix build error without CONFIG_USB_HID
Date: Thu, 25 Apr 2019 09:42:08 +0200
Message-ID: <CAO-hwJ+hfza_e9ZsouqczO2PHva_bokAuz+ZekF3AuqEGwk4=w@mail.gmail.com>
References: <20190425073942.36980-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425073942.36980-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yue Haibing <yuehaibing@huawei.com>
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On Thu, Apr 25, 2019 at 9:40 AM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> During randconfig builds, I occasionally run into an invalid configuration
>
> drivers/hid/hid-logitech-dj.o: In function `logi_dj_probe':
> hid-logitech-dj.c:(.text+0x32dc): undefined reference to `usb_hid_driver'
>
> This is because CONFIG_USB_HID is not set, So this
> patch selects it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: da12b224b7d5 ("HID: logitech-dj: deal with some KVMs adding an extra interface to the usbdev")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks a lot, but I already scheduled
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-5.2/logitech&id=c08f38e9fd0b5486957ed42438ec8fa9b6ebbf4f
in for-next.

It's weird it doesn't show up in your bot... :/

Cheers,
Benjamin

> ---
>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 76d8206..c3c390c 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -521,6 +521,7 @@ config HID_LOGITECH
>
>  config HID_LOGITECH_DJ
>         tristate "Logitech Unifying receivers full support"
> +       depends on USB_HID
>         depends on HIDRAW
>         depends on HID_LOGITECH
>         select HID_LOGITECH_HIDPP
> --
> 2.7.4
>
>
