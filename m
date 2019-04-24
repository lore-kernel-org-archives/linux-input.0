From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: logitech-dj: add usbhid dependency in Kconfig
Date: Wed, 24 Apr 2019 15:18:37 +0200
Message-ID: <CAO-hwJLVrC0i5dn+opLTm9haZ6HP5-g+ncUd-3VPrhNSf=siuQ@mail.gmail.com>
References: <20190424131636.8320-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424131636.8320-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, kbuild test robot <lkp@intel.com>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 24, 2019 at 3:16 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> An oversight from me.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I went ahead and pushed it already to for-5.2/logitech

Cheers,
Benjamin

> ---
>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 76d82063d8d2..c3c390ca3690 100644
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
> 2.19.2
>
