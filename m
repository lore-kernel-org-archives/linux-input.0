From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH -next] hid: fix hid-logitech-dj build error
Date: Tue, 7 May 2019 09:04:53 +0200
Message-ID: <CAO-hwJKueMUp=4ioCNhgkX2+HWsd9GV4bkKi_+uvzpOV_UED8A@mail.gmail.com>
References: <e2154a13-0ec5-d39c-52cf-db98867b0496@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e2154a13-0ec5-d39c-52cf-db98867b0496@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, kbuild test robot <lkp@intel.com>
List-Id: linux-input@vger.kernel.org

Hi Randy,

On Tue, May 7, 2019 at 3:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build error in hid-logitech-dj by making it depend on
> USB_HID, like several other HID drivers do.
>
> Fixes this build error:
>
> ERROR: "usb_hid_driver" [drivers/hid/hid-logitech-dj.ko] undefined!
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/hid/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- mmotm-2019-0425-1630.orig/drivers/hid/Kconfig
> +++ mmotm-2019-0425-1630/drivers/hid/Kconfig
> @@ -522,6 +522,7 @@ config HID_LOGITECH
>  config HID_LOGITECH_DJ
>         tristate "Logitech Unifying receivers full support"
>         depends on HIDRAW
> +       depends on USB_HID

this is already scheduled in the HID PR:
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-linus&id=c08f38e9fd0b5486957ed42438ec8fa9b6ebbf4f

Cheers,
Benjamin

>         depends on HID_LOGITECH
>         select HID_LOGITECH_HIDPP
>         ---help---
>
>
