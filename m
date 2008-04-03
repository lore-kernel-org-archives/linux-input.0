From: "Stefan Schweizer" <genstef-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: suspend
Date: Thu, 3 Apr 2008 17:44:19 +0200
Message-ID: <e79639220804030844w40d50824q8fbb8352ac3c0f3b@mail.gmail.com>
References: <dd18b0c30804012331oc548416k113e492d7dc9c189@mail.gmail.com>
	 <200804031029.26635.oliver@neukum.org>
	 <e79639220804030153q46fa82c7jb79bedbe88b30df7@mail.gmail.com>
	 <200804031231.19193.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804031231.19193.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Cannot seem to find the persist attribute even after this patch applied :((

CONFIG_USB_PERSIST is enabled, but other drivers do not provide it.
However this is 2.6.24 - I will try it on 2.6.25 now.

macbook linux # ls -dl /sys/bus/usb/devices/1-2\:1.1/driver
lrwxrwxrwx 1 root root 0  3. Apr 17:12
/sys/bus/usb/devices/1-2:1.1/driver ->
../../../../../../bus/usb/drivers/appletouch
macbook linux # find /sys/bus/usb/devices/1-2\:1.1/ | grep power
/sys/bus/usb/devices/1-2:1.1/power
/sys/bus/usb/devices/1-2:1.1/power/wakeup
/sys/bus/usb/devices/1-2:1.1/input/input7/power
/sys/bus/usb/devices/1-2:1.1/input/input7/power/wakeup
/sys/bus/usb/devices/1-2:1.1/input/input7/mouse2/power
/sys/bus/usb/devices/1-2:1.1/input/input7/mouse2/power/wakeup
/sys/bus/usb/devices/1-2:1.1/input/input7/event7/power
/sys/bus/usb/devices/1-2:1.1/input/input7/event7/power/wakeup
/sys/bus/usb/devices/1-2:1.1/usb_endpoint/usbdev1.5_ep81/power
/sys/bus/usb/devices/1-2:1.1/usb_endpoint/usbdev1.5_ep81/power/wakeup

Best regards,
Stefan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
