From: Ivo van Doorn <ivdoorn@gmail.com>
Subject: Re: rfkill-input understanding help
Date: Sun, 30 Dec 2007 19:59:42 +0100
Message-ID: <200712301959.42914.IvDoorn@gmail.com>
References: <200712110333.40946.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:2139 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbXL3S7u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Dec 2007 13:59:50 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2459266fga.17
        for <linux-input@vger.kernel.org>; Sun, 30 Dec 2007 10:59:48 -0800 (PST)
In-Reply-To: <200712110333.40946.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

Sorry for the late response..

> There are two buttons which control these, one for wireless, and one for 
> bluetooth. However, the wireless and bluetooth buttons on the laptop are just 
> keys - they generate KEY_WLAN and KEY_BLUETOOTH, but don't toggle the 
> wireless and bluetooth themselves (this is down to acer-wmi).

Which makes rfkill a correct solution. :)

> Registered two rfkill devices - one for wireless, one for bluetooth.
> 
> Problem:
> 
> The sysfs interface works just fine - but nothing is being toggled when I 
> press the wireless or bluetooth buttons (which are just generating KEY_WLAN 
> and KEY_BLUETOOTH).

So using the sysfs interface you can enable and disable the radios?

> From my limited understanding, rfkill_input (which is enabled in my kernel) 
> _should_ just be handling these keycodes (since userspace has not claimed 
> these rfkill devices), and then calling the necessary toggle function - but 
> AFAICT, this is not happening.
> 
> Have I misunderstood this, am I missing something, or is this particular use 
> case supposed to be handled by userspace instead (i.e. a userspace tool is 
> supposed to handle the keypress, then toggle the rfkill device via sysfs)?

Without a code example I can't say much, but have you looked to the examples
in the drivers/net/wireless/rt2x00/ and drivers/net/wireless/b43
Those are at least 2 drivers with a working rfkill implementation for WLAN,
that should give a good example on how the code should look like.

Ivo
