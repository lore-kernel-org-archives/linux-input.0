From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [PATCH v2] HID: add ThingM blink(1) USB RGB LED support
Date: Mon, 21 Jan 2013 14:31:55 -0500 (EST)
Message-ID: <1270977623.602972.1358796715392.JavaMail.root@mail.savoirfairelinux.com>
References: <d76e4c014234c2f0e8ef1328f0e7572a.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:34548 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206Ab3AUTb5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jan 2013 14:31:57 -0500
In-Reply-To: <d76e4c014234c2f0e8ef1328f0e7572a.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org

Hi Simon,

> > +++ b/Documentation/ABI/testing/sysfs-driver-hid-blink1
> > @@ -0,0 +1,23 @@
> > +What:		/sys/class/leds/blink(1)::<serial>/rgb
> > +Date:		January 2013
> > +Contact:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> > +Description:	The ThingM blink(1) is an USB RGB LED. The color
> > notation is
> > +		3-byte hexadecimal. Read this attribute to get the last set
> > +		color. Write the 24-bit hexadecimal color to change the current
> > +		LED color. The default color is full white (0xFFFFFF).
> > +		For instance, set the color to green with: echo 00FF00 > rgb
> > +
> 
> Shouldn't the name presented in the sys/class/leds directories change
> appropriately too?

The directory name for the device under /sys/class/leds is "blink(1)::<serial>",
where <serial> is the last 4 digits of the device serial number (the first 4
digits are always the same: "1A00"). For instance, "blink(1)::1234".
Let me know if I misunderstood your question.

Thanks,
Vivien
