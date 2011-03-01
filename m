From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid: Do not create input devices for feature reports
Date: Tue, 1 Mar 2011 09:54:23 -0800
Message-ID: <20110301175423.GC27560@core.coreip.homeip.net>
References: <1298572259-18173-1-git-send-email-rydberg@euromail.se>
 <AANLkTi=VfSbbV5xwpacC+8yDUfjR3-S8OW47YPvtZwFX@mail.gmail.com>
 <20110224204300.GA2423@polaris.bitmath.org>
 <AANLkTi=YBYrgf66Md_G2Cas7t__BDD2nozvidYDj0p9W@mail.gmail.com>
 <20110225171911.GA22592@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48144 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab1CARyb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2011 12:54:31 -0500
Content-Disposition: inline
In-Reply-To: <20110225171911.GA22592@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 25, 2011 at 06:19:11PM +0100, Henrik Rydberg wrote:
> Hi Benjamin,
> 
> > after some quick tests, I can deal with our two options (changing
> > feature_mapping signature or not, and so calling feature_mapping
> > before or after input_mapping).
> 
> Good, good.
> 
> > So, my questions are:
> > - do we really need to change feature_mapping signature?
> > - is feature_mapping tied to an input or to a device?
> 
> The input, output and feature reports are all found on the same level
> in the HID protocol, so it makes sense to associate all reports with
> the device itself, without any assumed association between different
> reports. From a practical point of view, we may assign different input
> nodes (input devices) to different input reports, so it is clear that
> the mapping between hid device and input device is not 1-to-1.
> 
> For output devices, the only supported case is EV_LED, which passes
> events to the input device. It is probably assumed that
> HID_QUIRK_MULTI_INPUT is false for those devices. Jiri?
> 

I am probably late to the party fut the above is not true. Here is an
example of an USB keyboard (wih LEDs) that is split into two:

I: Bus=0003 Vendor=046d Product=c30e Version=0110
N: Name="Logitech HID compliant keyboard"
P: Phys=usb-0000:00:1d.0-1.2/input0
S:
Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/input/input3
U: Uniq=
H: Handlers=sysrq kbd event3
B: PROP=0
B: EV=120013
B: KEY=1000000000007 ff800000000007ff febeffdff3cfffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=046d Product=c30e Version=0110
N: Name="Logitech HID compliant keyboard"
P: Phys=usb-0000:00:1d.0-1.2/input1
S:
Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.1/input/input4
U: Uniq=
H: Handlers=kbd event4
B: PROP=0
B: EV=13
B: KEY=fff ffffffffffffffff 2000000 387ad800d001 1e000000000000 0
B: MSC=10

This was done, most likely, because Logitech decided to reuse usage codes
for different keys.

Thanks.

-- 
Dmitry
