From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [PATCH 2/2] HID: sony: Update device ids
Date: Wed, 5 Oct 2016 22:09:57 -0600
Message-ID: <d036f01a80c7d947f2958744ff36a844.squirrel@mungewell.org>
References: <1475720335-17447-1-git-send-email-roderick@gaikai.com>
    <1475720335-17447-2-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:36792 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbcJFEKD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 00:10:03 -0400
In-Reply-To: <1475720335-17447-2-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Wed, October 5, 2016 8:18 pm, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>
>
> Support additional DS4 model.
>
>
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> ---
> drivers/hid/hid-ids.h  | 1 + drivers/hid/hid-sony.c | 4 ++++ 2 files
> changed, 5 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h index
> cd59c79..27f82cc 100644 --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -899,6 +899,7 @@
> #define USB_DEVICE_ID_SONY_PS3_BDREMOTE		0x0306
> #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
> #define USB_DEVICE_ID_SONY_PS4_CONTROLLER	0x05c4
> +#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2	0x09cc
> #define USB_DEVICE_ID_SONY_MOTION_CONTROLLER	0x03d5
> #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
> #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER		0x0002
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c index
> c9916cc..3acdb68 100644 --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -2639,6 +2639,10 @@ static const struct hid_device_id sony_devices[] =
> {
> .driver_data = DUALSHOCK4_CONTROLLER_USB },
> { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY,
> USB_DEVICE_ID_SONY_PS4_CONTROLLER),
> .driver_data = DUALSHOCK4_CONTROLLER_BT },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY,
> USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
> +		.driver_data = DUALSHOCK4_CONTROLLER_USB },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY,
> USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
> +		.driver_data = DUALSHOCK4_CONTROLLER_BT },
> /* Nyko Core Controller for PS3 */
> { HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE,
> USB_DEVICE_ID_SINO_LITE_CONTROLLER),
> .driver_data = SIXAXIS_CONTROLLER_USB | SINO_LITE_CONTROLLER },

I think you also need to patch hid-core.c, like:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-core.c?id=refs/tags/v4.8#n2057

Great that these patches are coming... thanks.
Simon

