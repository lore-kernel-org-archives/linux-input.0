From: Keith Rutkowski <rutkowski-T1p9dGDnAHDoS6w7zS32OEtZW7PLQM7H@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 14421] New: CH Products joystick detected but
 not functional
Date: Mon, 19 Oct 2009 15:09:31 -0400
Message-ID: <4ADCB96B.9060604@signatureresearchinc.com>
References: <200910191634.09047.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030303010407040803020404"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200910191634.09047.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------030303010407040803020404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/2009 10:34 AM, Oliver Neukum wrote:
> Am Montag, 19. Oktober 2009 15:55:49 schrieb Keith Rutkowski:
>    
>> I have not found any patches for this specific device.  It is an
>> industrial class joystick, so probably not as common as the CH Products
>> consumer class joysticks.
>>
>> However, this patch seems to address a similar issue with other more
>> common CH Products joysticks:
>>      
> Yes, that's the patch. Could you try to also add your device to the blacklist?
>
> 	Regards
> 		Oliver
>
> .
>
>    

Ok, I blacklisted the joystick as the patch did with the other 
joysticks, built the kernel, and verified that the joystick works again 
after the modification.

Attached is the patch file that I applied to Fedora's 2.6.30.8-64 kernel.

- Keith

-- 

Keith Rutkowski
Software Engineer

Signature Research, Inc
www.signatureresearchinc.com

Email: rutkowski-T1p9dGDnAHDoS6w7zS32OEtZW7PLQM7H@public.gmane.org
Phone: (906) 337-3360
Fax:   (906) 337-0023


--------------030303010407040803020404
Content-Type: text/x-patch;
 name="linux-2.6-blacklist-ch-products-joystick.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-2.6-blacklist-ch-products-joystick.patch"

diff -uNrp kernel-2.6.30.orig/drivers/hid/hid-ids.h kernel-2.6.30.new/drivers/hid/hid-ids.h
--- kernel-2.6.30.orig/drivers/hid/hid-ids.h	2009-10-19 11:39:11.506562098 -0400
+++ kernel-2.6.30.new/drivers/hid/hid-ids.h	2009-10-19 11:30:56.272437148 -0400
@@ -117,6 +117,7 @@
 #define USB_DEVICE_ID_CH_PRO_PEDALS	0x00f2
 #define USB_DEVICE_ID_CH_COMBATSTICK	0x00f4
 #define USB_DEVICE_ID_CH_FLIGHT_SIM_YOKE	0x00ff
+#define USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK	0x00d3
 
 #define USB_VENDOR_ID_CHERRY		0x046a
 #define USB_DEVICE_ID_CHERRY_CYMOTION	0x0023
diff -uNrp kernel-2.6.30.orig/drivers/hid/usbhid/hid-quirks.c kernel-2.6.30.new/drivers/hid/usbhid/hid-quirks.c
--- kernel-2.6.30.orig/drivers/hid/usbhid/hid-quirks.c	2009-10-19 11:39:28.337562028 -0400
+++ kernel-2.6.30.new/drivers/hid/usbhid/hid-quirks.c	2009-10-19 11:30:40.810436422 -0400
@@ -53,6 +53,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_COMBATSTICK, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FLIGHT_SIM_YOKE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_PEDALS, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },

--------------030303010407040803020404--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
