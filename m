From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: wacom: Improve generic name generation
Date: Fri, 19 May 2017 14:56:16 +0200
Message-ID: <20170519125616.GD1098@mail.corp.redhat.com>
References: <20170517175208.14233-1-killertofu@gmail.com>
 <20170518072026.GB18288@mail.corp.redhat.com>
 <9eaeb638-c7a9-2288-0786-b4732f67d857@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbdESM4X (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 08:56:23 -0400
Content-Disposition: inline
In-Reply-To: <9eaeb638-c7a9-2288-0786-b4732f67d857@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On May 18 2017 or thereabouts, Jason Gerecke wrote:
> On 05/18/2017 12:20 AM, Benjamin Tissoires wrote:
> > On May 17 2017 or thereabouts, Jason Gerecke wrote:
> >> The 'wacom_update_name' function is responsible for producing names for
> >> the input device nodes based on the hardware device name. Commit f2209d4
> >> added the ability to strip off prefixes like "Wacom Co.,Ltd." where the
> >> prefix was immediately (and redundantly) followed by "Wacom". The
> >> 2nd-generation Intuos Pro 2 has such a prefix, but with a small error
> >> (the period and comma are swapped) that prevents the existing code from
> >> matching it. We're loath to extend the number of cases out endlessly and
> >> so instead try to be smarter about name generation.
> >>
> >> We observe that the cause of the redundant prefixes is HID combining the
> >> manufacturer and product strings of USB devices together. By using the
> >> original product name (with "Wacom" prefixed, if it does not already
> >> exist in the string) we can bypass the gyrations to find and remove
> >> redundant prefixes. Other devices either don't have a manufacturer string
> >> that needs to be removed (Bluetooth, uhid) or should have their name
> >> generated from scratch (I2C).
> >>
> >> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> >> ---
> > 
> > Thanks Jason.
> > 
> > I am not a big fan of the "real USB" check (I would believe enhancing
> > struct hid_device would make something more generic), but it seems to be
> > doing the job OK.
> > 
> > Just giving out 2 ideas to achieve the same, so you could decide keeping
> > this or not:
> > 
> > - adding .product_name to struct hid_device directly
> > - exporting usb_hid_driver in usbhid/usbhid.h and comparing hdev->ll_driver
> >   with it (this can be achieved in an inlined function in usbhid.h).
> > 
> > I would believe having the second option above would provide several
> > benefits:
> > - the wacom module will not have to check against all usb devices
> > - other drivers would be able to quickly tell if they are using a low
> >   level USB device, and not a uhid one. This way, we can remove some
> >   errors when we emulate a HID device on a HID driver that expects USB
> >   to be the actual transport layer
> > 
> > Your function works too, but I would believe this will be faster and
> > better (I also get the concern of having something self consistent for
> > easier backporting).
> > 
> 
> Ah, I think I misunderstood your earlier reply. I avoided a generic
> approach since it seemed this naming issue was unique to the USB bus and
> our driver. Backporting concerns also entered the picture, though we can
> always conditionally compile this "real USB" function as fallback code
> like we do in other cases where we have to work with older kernels.
> 
> I would be tempted to take the second option as well (I was quite
> disappointed when I realized such a check wasn't already possible), but
> using definitions from usbhid.h or other non-system headers isn't ideal.
> We'd have to require users to have a full source tree instead of just a
> "kernel-devel" package in order to build an input-wacom backport (or
> have the "real USB" function used even when compiled with upstream
> kernels :().

You can also define locally the function with this implementation if you
do not want to change usbhid.h

> 
> A modification of the second option that might be a bit better is to
> have hid.h expose a function that does the comparison on behalf of the
> caller. I presume that someone else could someday want to know if their
> e.g. I2C device is really from uhid, so I'd probably also change the
> logic to be "return hid->ll_driver == uhid_hid_driver". That way we
> don't have to export and compare against every transport driver...

I'd rather ask: "are you of such type?" than "are you not on such
type?".

The problem with the negation is that as soon as you want to target only
Bluetooth for instance, then you'll need to ask for "bluetooth and not
uhid".

OK, that is not clear. An other way of saying it is that you are
interesting in casting a pointer into a pointer type from the low level
transport driver. So if you are not absolutely sure about it, then you
should not cast it.

> 
> A different option I'd considered and am rather fond of would be to
> define something like "HID_QUIRK_UHID" (or "HID_QUIRK_VIRTUAL"?) which
> the uhid driver could set on devices that it creates. It'd be trivial to
> implement and check and seems like it'd fit right in with the other
> device quirks. Thoughts?

I locally have a patch that achieves that by changing the hdev->type. But
I am not so sure it is good because we would change HID_TYPE_OTHER,
HID_TYPE_USBMOUSE, or HID_TYPE_USBNONE into HID_TYPE_UHID... Also I do
not like much the fact that the transport layer has to change something
in hdev if only one does such a change.

So I would believe it's better to ask usbhid if it handles the device
currently than asking uhid if it is not handling it.

Cheers,
Benjamin

> 
> Nitpicks noted for an eventual V3 :)
> 
> Jason
> ---
> Now instead of four in the eights place /
> you’ve got three, ‘Cause you added one /
> (That is to say, eight) to the two, /
> But you can’t take seven from three, /
> So you look at the sixty-fours....
> 
> > Besides that, small nitpicks:
> > 
> >>  drivers/hid/wacom_sys.c | 90 ++++++++++++++++++++++++++++++++-----------------
> >>  1 file changed, 60 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> >> index 838c1ebfffa9..c68458e44139 100644
> >> --- a/drivers/hid/wacom_sys.c
> >> +++ b/drivers/hid/wacom_sys.c
> >> @@ -14,6 +14,7 @@
> >>  #include "wacom_wac.h"
> >>  #include "wacom.h"
> >>  #include <linux/input/mt.h>
> >> +#include <linux/usb.h>
> >>  
> >>  #define WAC_MSG_RETRIES		5
> >>  #define WAC_CMD_RETRIES		10
> >> @@ -2020,6 +2021,29 @@ static size_t wacom_compute_pktlen(struct hid_device *hdev)
> >>  	return size;
> >>  }
> >>  
> >> +
> >> +static int __wacom_is_usb_parent(struct usb_device *usbdev, void *ptr)
> >> +{
> >> +	struct wacom *wacom = ptr;
> >> +	struct device *parent = wacom->hdev->dev.parent;
> >> +	struct usb_host_config *config = usbdev->actconfig;
> >> +	int i;
> >> +
> >> +	for (i = 0; i < config->desc.bNumInterfaces; i++) {
> >> +		if (&config->interface[i]->dev == parent)
> >> +			return 1;
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >> +/*
> >> + * Distinguish between real USB devices and uhid-created doppelgangers
> >> + */
> >> +static bool wacom_is_real_usb(struct wacom *wacom) {
> >> +	return wacom->hdev->bus == BUS_USB &&
> >> +	       usb_for_each_dev(wacom, __wacom_is_usb_parent);
> >> +}
> >> +
> >>  static void wacom_update_name(struct wacom *wacom, const char *suffix)
> >>  {
> >>  	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
> >> @@ -2028,41 +2052,47 @@ static void wacom_update_name(struct wacom *wacom, const char *suffix)
> >>  
> >>  	/* Generic devices name unspecified */
> >>  	if ((features->type == HID_GENERIC) && !strcmp("Wacom HID", features->name)) {
> >> -		if (strstr(wacom->hdev->name, "Wacom") ||
> >> -		    strstr(wacom->hdev->name, "wacom") ||
> >> -		    strstr(wacom->hdev->name, "WACOM")) {
> >> -			/* name is in HID descriptor, use it */
> >> -			strlcpy(name, wacom->hdev->name, sizeof(name));
> >> -
> >> -			/* strip out excess whitespaces */
> >> -			while (1) {
> >> -				char *gap = strstr(name, "  ");
> >> -				if (gap == NULL)
> >> -					break;
> >> -				/* shift everything including the terminator */
> >> -				memmove(gap, gap+1, strlen(gap));
> >> -			}
> >> +		char *product_name = NULL;
> >>  
> >> -			/* strip off excessive prefixing */
> >> -			if (strstr(name, "Wacom Co.,Ltd. Wacom ") == name) {
> >> -				int n = strlen(name);
> >> -				int x = strlen("Wacom Co.,Ltd. ");
> >> -				memmove(name, name+x, n-x+1);
> >> +		if (wacom->hdev->bus == BUS_USB) {
> >> +			if (wacom_is_real_usb(wacom)) {
> > 
> > wacom_is_real_usb() already checks for BUS_USB, so the first test is
> > redundant.
> > 
> >> +				struct usb_interface *intf = to_usb_interface(wacom->hdev->dev.parent);
> >> +				struct usb_device *dev = interface_to_usbdev(intf);
> >> +				product_name = dev->product;
> >>  			}
> >> -			if (strstr(name, "Wacom Co., Ltd. Wacom ") == name) {
> >> -				int n = strlen(name);
> >> -				int x = strlen("Wacom Co., Ltd. ");
> >> -				memmove(name, name+x, n-x+1);
> >> +			else {
> > 
> > this else shoule be on the previous line
> > 
> >> +				product_name = wacom->hdev->name;
> >>  			}
> >> +		}
> >> +		else if (wacom->hdev->bus == BUS_BLUETOOTH) {
> > 
> > likewise
> > 
> >> +			product_name = wacom->hdev->name;
> >> +		}
> > 
> > How about?:
> > 	 if (wacom_is_real_usb(wacom)) {
> > 		struct usb_interface *intf = to_usb_interface(wacom->hdev->dev.parent);
> > 		struct usb_device *dev = interface_to_usbdev(intf);
> > 		product_name = dev->product;
> > 	} else if (wacom->hdev->bus == BUS_BLUETOOTH ||
> > 		   wacom->hdev->bus == BUS_USB) {
> > 		product_name = wacom->hdev->name;
> > 	}
> > 
> >>  
> >> -			/* get rid of trailing whitespace */
> >> -			if (name[strlen(name)-1] == ' ')
> >> -				name[strlen(name)-1] = '\0';
> >> -		} else {
> >> -			/* no meaningful name retrieved. use product ID */
> >> -			snprintf(name, sizeof(name),
> >> -				 "%s %X", features->name, wacom->hdev->product);
> >> +		if (!product_name) {
> >> +			snprintf(name, sizeof(name), "%s %X",
> >> +			         features->name, wacom->hdev->product);
> >> +		}
> >> +		else if (strstr(product_name, "Wacom") ||
> > 
> > else should be on the previous line
> > 
> >> +			 strstr(product_name, "wacom") ||
> >> +			 strstr(product_name, "WACOM")) {
> >> +			strlcpy(name, product_name, sizeof(name));
> >>  		}
> >> +		else {
> >> +			snprintf(name, sizeof(name), "Wacom %s", product_name);
> >> +		}
> >> +
> >> +		/* strip out excess whitespaces */
> >> +		while (1) {
> >> +			char *gap = strstr(name, "  ");
> >> +			if (gap == NULL)
> >> +				break;
> >> +			/* shift everything including the terminator */
> >> +			memmove(gap, gap+1, strlen(gap));
> >> +		}
> >> +
> >> +		/* get rid of trailing whitespace */
> >> +		if (name[strlen(name)-1] == ' ')
> >> +			name[strlen(name)-1] = '\0';
> >>  	} else {
> >>  		strlcpy(name, features->name, sizeof(name));
> >>  	}
> >> -- 
> >> 2.12.2
> >>
> > 
> > Cheers,
> > Benjamin
> >
