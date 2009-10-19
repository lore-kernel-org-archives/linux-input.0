From: Keith Rutkowski <rutkowski-T1p9dGDnAHDoS6w7zS32OEtZW7PLQM7H@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 14421] New: CH Products joystick detected but
 not functional
Date: Mon, 19 Oct 2009 09:08:11 -0400
Message-ID: <4ADC64BB.2040209@signatureresearchinc.com>
References: <200910162331.37533.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200910162331.37533.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 10/16/2009 05:31 PM, Oliver Neukum wrote:
> Am Freitag, 16. Oktober 2009 23:20:09 schrieb Andrew Morton:
>    
>>> Plugged joystick in and kernel detects device (from /var/log/messages):
>>>    kernel: usb 3-6: new low speed USB device using ohci_hcd and address 3
>>>    kernel: usb 3-6: New USB device found, idVendor=068e, idProduct=00d3
>>>    kernel: usb 3-6: New USB device strings: Mfr=1, Product=2,
>>> SerialNumber=0 kernel: usb 3-6: Product: CH OEM 3 AXIS 5 BUTTON JOYSTICK
>>>    kernel: usb 3-6: Manufacturer: CH PRODUCTS
>>>    kernel: usb 3-6: configuration #1 chosen from 1 choice
>>>    kernel: input: CH PRODUCTS CH OEM 3 AXIS 5 BUTTON JOYSTICK as
>>> /devices/pci0000:00/0000:00:02.0/usb3/3-6/3-6:1.0/input/input8
>>>    kernel: generic-usb 0003:068E:00D3.0004: input,hidraw3: USB HID v1.00
>>> Joystick [CH PRODUCTS CH OEM 3 AXIS 5 BUTTON JOYSTICK] on
>>> usb-0000:00:02.0-6/input0
>>>
>>> HAL also detects the device (from lshal): attached as hal.txt
>>>
>>> Functionality was checked for under jstest, jscal, KDE 4 joystick section
>>> in System Settings, and by cat-ing the device.  In all tests the axis
>>> values did not change, and the button states did not change when joystick
>>> manipulated
>>>        
>
> Do you see traffic with usbmon as you move the stick or press buttons?
>
> 	Regards
> 		Oliver
>
> .
>
>    

No traffic was shown from usbmon other than the connect/disconnect stuff.

- Keith


-- 

Keith Rutkowski
Software Engineer

Signature Research, Inc
www.signatureresearchinc.com

Email: rutkowski-T1p9dGDnAHDoS6w7zS32OEtZW7PLQM7H@public.gmane.org
Phone: (906) 337-3360
Fax:   (906) 337-0023

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
