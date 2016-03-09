From: Gregor Riepl <onitake@gmail.com>
Subject: Re: Getting a functional driver for Mad Catz Fightstick TE 2 (Xbox
 One version)
Date: Wed, 9 Mar 2016 12:43:06 +0100
Message-ID: <56E00C4A.4000304@gmail.com>
References: <20160308214512.ls7d4rs4jrs6paiy@myarchbang>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38158 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbcCILnJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2016 06:43:09 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so66989256wml.1
        for <linux-input@vger.kernel.org>; Wed, 09 Mar 2016 03:43:08 -0800 (PST)
In-Reply-To: <20160308214512.ls7d4rs4jrs6paiy@myarchbang>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Silvan Jegen <me@sillymon.ch>, linux-input@vger.kernel.org

Hi Silvan,

> when plugging it in. Simply adding the line
> 
> { 0x0738, 0x4a01, "Mad Catz FightStick TE 2", 0, XTYPE_XBOXONE },
> 
> (where the two Hex values are VENDOR_ID and PRODUCT_ID) to xpad_device[]
> in xpad.c does not help either (which I naively hoped it would).

If the controller is not 100% proprietary - which I doubt, or it would hardly
work on the Xbox without special vendor support - "abusing" xpad seems
perfectly reasonable.

> I realized that the stick does not conform to the USB HID interface
> after looking more closely at the lsusb -v output (pasted below).
>
> The Fightstick seems to use a "Vendor Specific Class" and not the HID
> interface.

This may be because Xbox One controllers require a special initialisation
sequence to make them send input reports at all.

As far as I know, xpad does this for Xbox One pads, but the commands sent may
not be sufficient for the Mad Catz. This may also be the reason why it doesn't
show up as a HID device: It's possible that the device descriptor changes as
soon as initialisation is complete.

> The device is relatively simple having only about 10 buttons and a digital
> stick and the Xbox One driver for Windows works for it so xpad.c should
> be able to deal with it I assume. Worst case I would have to reverse-
> engineer the USB protocol it uses on my Window installation though I
> hope that will not be necessary given that the much more sophisticated
> Xbox One controller works on Linux already.

I think this is a good idea. Watch the initial data sent closely and compare
what xpad does in the case of a Xbox One controller.

Perhaps the logic is there already, and it just needs to be triggered?

Regards,
Gregor
