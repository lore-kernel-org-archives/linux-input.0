From: David Dillow <dave@thedillows.org>
Subject: Re: [PATCH] HID: fold ps3remote driver into generic Sony driver
Date: Tue, 28 May 2013 09:30:47 -0400
Message-ID: <1369747847.3675.3.camel@obelisk.thedillows.org>
References: <alpine.LNX.2.00.1305281035370.3914@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1305281035370.3914@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2013-05-28 at 10:38 +0200, Jiri Kosina wrote:
> Let's follow the structure we are trying to keep for most of the specific 
> HID drivers, and let the separation follow the producing vendor.
> Merge functionality provided by ps3remote driver into hid-sony.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---

I've not had a chance to test yet, but I noticed one issue:
 
> @@ -548,6 +722,11 @@ static const struct hid_device_id sony_devices[] = {
>  		.driver_data = BUZZ_CONTROLLER },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER),
>  		.driver_data = BUZZ_CONTROLLER },
> +	/* PS3 BD Remote Control */
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE),
> +		.driver_data = PS3REMOTE },
> +	/* Logitech Harmony Adapter for PS3 */
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },

I think you need .driver_data = PS3REMOTE for the Harmony as well; it
uses the same protocol.

Also, have you given any thought to making 'make oldconfig' work? Those
of us that build are own kernels are likely to have some fun tracking
down why our remotes don't work any more...
