From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: quirks: use correct format chars in dbg_hid
Date: Wed, 27 Feb 2019 10:57:02 +0100
Message-ID: <CAO-hwJLrKDTrOxy3_JYKcTync_6Qis3wdMkwgMUj_WpZr2Xj-g@mail.gmail.com>
References: <20190226234853.20441-1-louis@kragniz.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226234853.20441-1-louis@kragniz.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Louis Taylor <louis@kragniz.eu>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, clang-built-linux@googlegroups.com, ndesaulniers@google.com
List-Id: linux-input@vger.kernel.org

On Wed, Feb 27, 2019 at 12:50 AM Louis Taylor <louis@kragniz.eu> wrote:
>
> When building with -Wformat, clang warns:
>
> drivers/hid/hid-quirks.c:1075:27: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   bl_entry->driver_data, bl_entry->vendor,
>                                          ^~~~~~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> drivers/hid/hid-quirks.c:1076:4: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   bl_entry->product);
>                   ^~~~~~~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> drivers/hid/hid-quirks.c:1242:12: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   quirks, hdev->vendor, hdev->product);
>                           ^~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> drivers/hid/hid-quirks.c:1242:26: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   quirks, hdev->vendor, hdev->product);
>                                         ^~~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> 4 warnings generated.
>
> This patch fixes the format strings to use the correct format type for unsigned
> ints.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  drivers/hid/hid-quirks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 94088c0ed68a..b4e49e1b6f4a 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -1071,7 +1071,7 @@ static struct hid_device_id *hid_exists_dquirk(const struct hid_device *hdev)
>         }
>
>         if (bl_entry != NULL)
> -               dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%hx:0x%hx\n",
> +               dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%x:0x%x\n",

Can you make it %04x instead?
The VID/PID are usually 4 hex chars, and without the '04' format,
you'll end up having a varying length result, which is not that nice.

Cheers,
Benjamin

>                         bl_entry->driver_data, bl_entry->vendor,
>                         bl_entry->product);
>
> @@ -1238,7 +1238,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
>                 quirks |= bl_entry->driver_data;
>
>         if (quirks)
> -               dbg_hid("Found squirk 0x%lx for HID device 0x%hx:0x%hx\n",
> +               dbg_hid("Found squirk 0x%lx for HID device 0x%x:0x%x\n",
>                         quirks, hdev->vendor, hdev->product);
>         return quirks;
>  }
> --
> 2.20.1
>
