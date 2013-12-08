From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Xpad Driver Replacement
Date: Sun, 8 Dec 2013 15:38:18 +0100
Message-ID: <CANq1E4QePMBmWbfP5WP0C6Q6=r72fGAz68C_UXSWx4Z+rmEvKQ@mail.gmail.com>
References: <52A40F19.3020109@computerquip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39845 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab3LHOiS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Dec 2013 09:38:18 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so4511655ieb.17
        for <linux-input@vger.kernel.org>; Sun, 08 Dec 2013 06:38:18 -0800 (PST)
In-Reply-To: <52A40F19.3020109@computerquip.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zachary Lund <admin@computerquip.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Sun, Dec 8, 2013 at 7:18 AM, Zachary Lund <admin@computerquip.com> wrote:
> I created a new driver to hopefully eventually replace xpad. The driver in
> its current form can be found on github. Things it provides is cleaner
> module unload/load, possibly cleaner/more efficient code, and better LED
> support. There are caveats that I'd like to iron out before I submit a patch
> though.

Please submit the patch right away. No-one minds commenting on
preliminary ideas. On the contrary, we can tell you whether the basic
idea makes sense right from the beginning.

> For one, I do not have the original Xbox controller. I've only tested the
> official Xbox 360 Wired and Wireless controllers. So support for that is
> unfortunately missing. I'm not sure how I feel about ripping it out of xpad.
> What am I supposed to do about devices that I don't own?

The old controllers are incompatible with the 360, so I'd keep the old
driver around with only the old VID/PID combinations. Btw., if you
live in the US, you can order one used from amazon for <10$.
Unfortunately, they only ship to the US so I haven't gotten my hands
on one of these.. Maybe you can find someone else if you don't
can/want to buy it?

> Secondly, the Xbox 360 controllers claim to be HID compliant... this is not
> an HID driver. That's because the report descriptor is missing and I,
> unfortunately, do not know what to do about that. Some drivers like XBCD and
> the driver found at tattiebogle.net both provide their own report descriptor
> and work from there. While I'd like to do the same eventually, it will take
> me longer than a week to do that as I'd have to educate myself on HID and
> figure out what to do about the missing descriptors.
>
> Thirdly, I have had no other testers outside of myself. And the only
> products I've tested are the only items in the device_id list. So, if anyone
> can test, that would amazing. I've posted on several forums and IRC channels
> for help testing or new products with unfortunately zero results. Anyone who
> is able to test and just use it extensively, that would be much appreciated.
>
> The code in its current form is found on github:
> https://github.com/computerquip/xpad360wr
>
> Any advice or feedback would be much appreciated.

Please post it to the list, there's a bunch of stuff that needs to be
changed. And please turn it into an HID driver. You don't need to use
HID reports at all! The hid-wiimote driver for instance just uses raw
I/O on HID without dealing with HID report descriptors at all (just
like hidraw).

For raw HID drivers, you simply use the ->raw_event callback to parse
incoming data and dev->output_raw_report() to send raw data.

Thanks for the work! I will gladly test it with the 360 controller
once you send a proper upstream patch.

Thanks
David
