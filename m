From: Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: Question about usbtouchscreen
Date: Sun, 18 Sep 2011 16:24:35 +0200
Message-ID: <4E75FF23.4090705@gmx.ch>
References: <CAKw_OUXO_2unWSEra0eg+nfvj0+hMrtwJ_uETd8nqGGyK9374g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:53141 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752614Ab1IROYi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Sep 2011 10:24:38 -0400
In-Reply-To: <CAKw_OUXO_2unWSEra0eg+nfvj0+hMrtwJ_uETd8nqGGyK9374g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Sung <penmount.touch@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Hi John

On 2011-09-16 11:45 , John Sung wrote:
> Dear Daniel,
> 
> This is John from PenMount Touch Solutions. I have some question about
> the usbtouchscreen driver, and found your email in the source file, so
> decide to contact you. Would you help us by answering some questions ?
> 

Note that I have not touched that driver (or the Linux kernel in general)
in quite a while.

> Our company have a new product PenMount 6250 touch controller, and
> would like to add support to the usbtouchscreen. But we are not sure
> if this is what we should do, because the features of PenMount 6250.

That's great to hear.

> The PenMount 6250 is a HID device, so it can be supported by the
> usbhid driver with single touch. We would like to add the PenMount
> 6250 multi-touch support. But since it does not use standard
> multi-touch HID usages like others does, we cannot use the
> hid-multitouch driver.
> 
> The PenMount 6250 reports additional information such as touch ID.
> However, This ID information is not listed as a HID usage in the
> PenMount 6250 HID report descriptor, so
> that these data will be dropped by the hid driver. When we look at the
> existing usbtouchscreen driver, however, it does not contain any other
> multi-touch device support, so we are wondering if adding support to
> the usbtouchscreen driver is what we
> should do.

I think usbtouchscreen is the wrong place. It has no multitouch support so
far and is basically for all the non-HID devices. hid-multitouch on the
other hand sounds more like the right place. I don't know that driver,
but looking at it, it has some vendor-specific code in it already. So if
your device is basically HID with some extensions, I think it makes sense
to extend hid-multitouch. Another possibility would be an extra HID driver
like hid-wacom or hid-magicmouse.

I don't know much about the HID protocol and these drivers, so I Cc'ed
the lists linux-input and linux-usb...people there will be able to give
you better help than I do :)

Cheers
-daniel
