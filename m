From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: blacklist Powercom UPSes which are not HIDs but Serial<=>USB
 things
Date: Wed, 28 Jan 2009 23:27:51 +0300
Message-ID: <4980BFC7.1040307@msgid.tls.msk.ru>
References: <1233173972.288064.6256.nullmailer@msgid.corpit.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([81.13.33.159]:46020 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754042AbZA1U14 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 15:27:56 -0500
In-Reply-To: <1233173972.288064.6256.nullmailer@msgid.corpit.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux INPUT list <linux-input@vger.kernel.org>

Michael Tokarev wrote:
> For quite some time users with various UPSes from Powercom
> were forced to play magic with bind/unbind in /sys in order
> to be able to see the UPSes.  The beasts does not work as
> HID devices, even if claims to do so.  cypress_m8 driver
> works with the devices instead, creating a normal serial
> port with which normal UPS controlling software works.
> Blacklist the device in HID to stop this all.

Ok, after some MORE testing it turned out the thing does
not work.  I.e, usbhid does not claim the device anymore,
BUT cypress_m8 still driver does not want to do so, too.
I.e., IF usbhid is loaded, cypress_m8 does not work still,
with or without this blacklist.  So this patch effectively
does not change things at all.

So the question stands, still (I asked it 2 times already):
how it should be done?  Such a trivial thing, but I have
to jump through all the hoops just because users (random
unrelated people who happen to have the same device) are
asking me because I managed to get it to work...  I for
one does not need any changes because I solved it from
userspace with bind/unbind magic.  Is it THAT difficult
to answer this question?  See, it all boils down to about
3 changed lines somewhere, but I never dealt with kernel
internals before...

Thanks.

/mjt

> Signed-off-By: Michael Tokarev <mjt@tls.msk.ru>
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index acc1abc..8beb9bd 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -348,6 +348,10 @@
>  #define USB_VENDOR_ID_PLAYDOTCOM	0x0b43
>  #define USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII	0x0003
>  
> +/* Powercom UPS which is not HID but Serial<=>USB converter (cypress_m8 drv) */
> +#define USB_VENDOR_ID_POWERCOM		0x0d9f
> +#define USB_DEVICE_ID_POWERCOM_UPS	0x0002
> +
>  #define USB_VENDOR_ID_SAITEK		0x06a3
>  #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
>  
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 5d7640e..dcd4add 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1295,6 +1295,7 @@ static const struct hid_device_id hid_blacklist[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_POWERCOM, USB_DEVICE_ID_POWERCOM_UPS) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

