From: Lars Melin <larsm17@gmail.com>
Subject: Re: [PATCH] HID: usbhid: Add a quirk for Xin-Mo Dual Arcade
Date: Sun, 25 Oct 2015 16:15:17 +0700
Message-ID: <562C9DA5.9090800@gmail.com>
References: <1445701499-13748-1-git-send-email-michele@acksyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445701499-13748-1-git-send-email-michele@acksyn.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michele Baldessari <michele@acksyn.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2015-10-24 22:44, Michele Baldessari wrote:
> The Xin-Mo Dual Arcade controller (16c0:05e1) needs this quirk in order
> to have the two distinct joysticks working.
>
> Before the change:
> $ jstest /dev/input/js0
> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> ...
> $ jstest /dev/input/js1
> jstest: No such file or directory
>
> After the change:
> $ jstest /dev/input/js0
> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> ...
> $ jstest /dev/input/js1
> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> ...
>
> Signed-off-by: Michele Baldessari <michele@acksyn.org>
> ---
>   drivers/hid/usbhid/hid-quirks.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 1dff8f0015ba..f69049314a2c 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -150,6 +150,7 @@ static const struct hid_blacklist {
>   	{ USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD, HID_QUIRK_MULTI_INPUT },
>   	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES, HID_QUIRK_MULTI_INPUT },
>   	{ USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES, HID_QUIRK_MULTI_INPUT },
> +	{ USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
>
>   	{ 0, 0 }
>   };
>

Sorry but I don't believe that XIN_MO is the owner of the 16c0 VID so 
should not be given that ownership in linux.

/Lars
