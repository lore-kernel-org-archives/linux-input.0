From: Jean-Michel Bruenn <jean.bruenn@ip-minds.de>
Subject: Re: Solution to get Gigabyte K8100 Aivia USB Gaming Keyboard
 working in Linux
Date: Sun, 24 Feb 2013 18:04:32 +0100
Message-ID: <20130224180432.ad426fe776ea113f2ec65d37@ip-minds.de>
References: <20130224171937.1bf957f01fb482186cbb134d@ip-minds.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from alia.ip-minds.de ([84.201.38.2]:60010 "EHLO alia.ip-minds.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482Ab3BXREh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Feb 2013 12:04:37 -0500
Received: from vulkan (p5B10BB7E.dip.t-dialin.net [91.16.187.126])
	by alia.ip-minds.de (Postfix) with ESMTPA id B4FFCC32092
	for <linux-input@vger.kernel.org>; Sun, 24 Feb 2013 18:05:15 +0100 (CET)
In-Reply-To: <20130224171937.1bf957f01fb482186cbb134d@ip-minds.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I just noticed something weird... It seems this keyboard has a gaming
mode and a "normal" mode. In "gaming" mode you have to higher the
MAX_HID_USAGES to get the keyboard to work...

...you can switch to normal mode by pressing: shift+ctrl+alt+n, which
makes the keyboard work in linux without the MAX_HID_USAGES highered to
64K (it took me nearly a year to find out...) - Wondering if that still
can be considered a bug which requires a fix?

To switch back you issue shift+ctrl+alt+g and the keys stop working.
Here's some more output from dmesg:

[ 2389.147309] usb 1-3.4: Manufacturer: KB
[ 2389.158002] input: KB USB Keyboard
as /devices/pci0000:00/0000:00:02.1/usb1/1-3/1-3.4/1-3.4:1.0/input/input9
[ 2389.158390] hid-generic 0003:060B:2270.000D: input,hidraw6: USB HID
v1.11 Keyboard [KB USB Keyboard] on usb-0000:00:02.1-3.4/input0
[ 2389.172128] hid-generic 0003:060B:2270.000E: usage index exceeded
[ 2389.172142] hid-generic 0003:060B:2270.000E: item 0 2 2 2 parsing
failed [ 2389.172177] hid-generic: probe of 0003:060B:2270.000E failed
with error -22

Jean
