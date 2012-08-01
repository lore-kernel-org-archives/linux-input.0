From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: USB Creative Technology SB Arena Headset Quirk Question
Date: Tue, 31 Jul 2012 17:35:51 -0700
Message-ID: <1932702.uGcqoS09g5@dtor-d630.eng.vmware.com>
References: <50182D25.3080503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48600 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab2HAAgH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jul 2012 20:36:07 -0400
Received: by pbbrp8 with SMTP id rp8so133046pbb.19
        for <linux-input@vger.kernel.org>; Tue, 31 Jul 2012 17:36:06 -0700 (PDT)
In-Reply-To: <50182D25.3080503@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris J Arges <chris.j.arges@canonical.com>
Cc: linux-input@vger.kernel.org

On Tuesday, July 31, 2012 02:08:21 PM Chris J Arges wrote:
> Hello,
> I am trying to find the best way to resolve a hardware issue with a USB
> Creative Technology SB Arena Headset (0x41e:0x403).
> 
> The headset also has buttons on it which register as a keyboard:
> [252903.181] (II) XINPUT: Adding extended input device "Creative
> Technology SB Arena Headset" (type: KEYBOARD, id 15)
> 
> When it is plugged in, it then starts sending button 3 presses for the
> entire time it is plugged in causing input from other devices to not be
> useable.
> 
> Here is the current bug with more information:
> https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/1007575
> 
> I'd like to help fix this, and am wondering if it makes sense to quirk
> the kernel HID driver, or rather quirk the X evdev module as was
> suggested by another developer.

Since kernel emits bogus events repeatedly it should be quirked in
kernel (but if device really sends interrupts constantly it the
firmware is probable what shoudl be blamed in the first place).

Thanks.

-- 
Dmitry
