From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [PATCH] hid: ignore all recent SoundGraph iMON devices
Date: Fri, 31 Jul 2009 21:41:38 +0300
Message-ID: <4A733AE2.5000508@gmail.com>
References: <200907311056.36729.jarod@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:47063 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbZGaSmA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2009 14:42:00 -0400
In-Reply-To: <200907311056.36729.jarod@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Jarod Wilson wrote:
> After some inspection of the Windows iMON driver, several additional
> device IDs were added to the lirc_imon driver. At least a few of these
> have been seen in the wild, and require manual quirking to keep the
> usbhid driver from binding to them. Rather than list out every single
> device, ignore the entire device ID range, 0x0034 - 0x0046. Some of
> these may not advertise themselves as HID devices, but no harm done to
> such devices anyway. Does the right thing in brief testing w/my 0x0045
> device.

I'm not sure this is a good idea. I have a 0x0038 device and I'm
developing a proper HID driver for it. If and when I'll submit it for
kernel inclusion, this kind of ID range blacklisting may get ugly.

-- 
Anssi Hannula
