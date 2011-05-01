From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: USB keyboard recognized as HID keyboard but doesn't work
Date: Sun, 1 May 2011 09:53:27 +0200
Message-ID: <201105010953.27052.oliver@neukum.org>
References: <4DBC6FA9.3080008@sieker.io>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DBC6FA9.3080008-D1akFU9K7Sphl2p70BpVqQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Adi J. Sieker" <adi-D1akFU9K7Sphl2p70BpVqQ@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Samstag, 30. April 2011, 22:23:05 schrieb Adi J. Sieker:
> Hello,
> 
> the lovely folks from #kernelnewbies suggested I write this mail since 
> they are at a loss.
> I recently got a new USB keyboard which works fine in the BIOS and also 
> in VBox Windows guests, but not on the host.
> 
> The keyboard is a Keysonic KSK-8003 UX product details here: 
> http://maxpoint.de/de/products/keyboards.php?pid=1_3_7&we_objectID=1220
> 
> The menu key and the backspace keys do work. The num lock led is on, 
> though I can't switch num lock off.
> If I attch the keyboard to a VirtualBox VM running WindowsXP as a guest, 
> it works as expected in the VM.

This indicates that it is working on the USB level.

> I'm running 2.6.32-27-generic #49-Ubuntu. I tried the Ubuntu 10.10 
> LiveCD and that also didn't work. I haven't tried 11.04 yet though.

Do you get anything on the event device? What does udev say when you
plug in the device?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
