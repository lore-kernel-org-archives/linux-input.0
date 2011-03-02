From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] hid: Do not create input devices for feature reports
Date: Wed, 2 Mar 2011 16:02:27 +0100
Message-ID: <20110302150227.GA1973@polaris.bitmath.org>
References: <1298572259-18173-1-git-send-email-rydberg@euromail.se>
 <AANLkTi=VfSbbV5xwpacC+8yDUfjR3-S8OW47YPvtZwFX@mail.gmail.com>
 <20110224204300.GA2423@polaris.bitmath.org>
 <AANLkTi=YBYrgf66Md_G2Cas7t__BDD2nozvidYDj0p9W@mail.gmail.com>
 <20110225171911.GA22592@polaris.bitmath.org>
 <20110301175423.GC27560@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:52912 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750831Ab1CBPCq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Mar 2011 10:02:46 -0500
Content-Disposition: inline
In-Reply-To: <20110301175423.GC27560@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

> > For output devices, the only supported case is EV_LED, which passes
> > events to the input device. It is probably assumed that
> > HID_QUIRK_MULTI_INPUT is false for those devices. Jiri?
> > 
> 
> I am probably late to the party fut the above is not true. Here is an
> example of an USB keyboard (wih LEDs) that is split into two:
> 
> I: Bus=0003 Vendor=046d Product=c30e Version=0110
> N: Name="Logitech HID compliant keyboard"
> P: Phys=usb-0000:00:1d.0-1.2/input0
> S:
> Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/input/input3
> U: Uniq=
> H: Handlers=sysrq kbd event3
> B: PROP=0
> B: EV=120013
> B: KEY=1000000000007 ff800000000007ff febeffdff3cfffff fffffffffffffffe
> B: MSC=10
> B: LED=7
> 
> I: Bus=0003 Vendor=046d Product=c30e Version=0110
> N: Name="Logitech HID compliant keyboard"
> P: Phys=usb-0000:00:1d.0-1.2/input1
> S:
> Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.1/input/input4
> U: Uniq=
> H: Handlers=kbd event4
> B: PROP=0
> B: EV=13
> B: KEY=fff ffffffffffffffff 2000000 387ad800d001 1e000000000000 0
> B: MSC=10
> 
> This was done, most likely, because Logitech decided to reuse usage codes
> for different keys.

This looks like different interfaces though, which should be fine. It
is only in the odd case of mixed input and output reports on the same
interface that the MULTI_INPUT quirk would ever have any strange
effect.

Cheers,
Henrik
