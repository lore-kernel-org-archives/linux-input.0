From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: add ThingM blink(1) USB RGB LED support
Date: Tue, 22 Jan 2013 14:45:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301221443320.20374@pobox.suse.cz>
References: <519311670.181365.1358861991305.JavaMail.root@mail.savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50488 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab3AVNpJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jan 2013 08:45:09 -0500
In-Reply-To: <519311670.181365.1358861991305.JavaMail.root@mail.savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 22 Jan 2013, Vivien Didelot wrote:

> > > > Shouldn't the name presented in the sys/class/leds directories
> > > > change
> > > > appropriately too?
> > > 
> > > The directory name for the device under /sys/class/leds is
> > > "blink(1)::<serial>",
> > > where <serial> is the last 4 digits of the device serial number
> > > (the first 4
> > > digits are always the same: "1A00"). For instance,
> > > "blink(1)::1234".
> > > Let me know if I misunderstood your question.
> > 
> > I believe that Simon's (valid) observation is that the sysfs path
> > should
> > reflect the name change, i.e. something along the lines of
> > /sys/class/leds/thingm-blink:<serial>   ... ?
> 
> The vendor's name is "ThingM" and the product's name is "blink(1)", not "blink".
> Given that, would you prefer to keep "blink(1)::1234", or would it rather be
> "thingm-blink1::1234" (avoiding parenthesis)?
> 
> I ask the same question for the driver name, which is actually "blink(1)".

Actually, for HID bus drivers, we are mostly following the convention of 
having just the vendor name in the driver, see hid-microsoft, 
hid-logitech, etc.

So it'd make most sense to me to name the driver hid-thingm, and in case 
it is driving blink(1) device (no other devices will be driven by it 
currently), let it create /sys/class/leds/blink1... 

-- 
Jiri Kosina
SUSE Labs
