From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] hid: corsair: Driver simplification and new supported
 device
Date: Thu, 24 Mar 2016 15:30:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603241527510.3656@cbobk.fhfr.pm>
References: <cover.1458744569.git.clement.vuchener@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43135 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbcCXOaW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2016 10:30:22 -0400
In-Reply-To: <cover.1458744569.git.clement.vuchener@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Cl=C3=A9ment=20Vuchener?= <clement.vuchener@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 23 Mar 2016, =?UTF-8?q?Cl=C3=A9ment=20Vuchener?= wrote:

> So, I decided to move all USB related features in user-space (as far as 
> I know, I was the only user, but if someone is looking for a 
> replacement, I wrote a small tool available here: 
> https://github.com/cvuchener/corsair-usb-config). This simplification 
> only leaves the usage code remapping part and the driver no longer 
> depends on USB and LED subsystems. This should make the driver easier to 
> maintain or to add new supported devices.

While you are performing this move, is there anything that's actually 
preventing you from doing the remapping from userspace as well?

HID subsystem has for long time been providing the setkeycode() hook for 
remapping usages, and udev (well, more precisely, that s*****d thing) is 
actually shipping a lot of hw-specific remap data these days.

Thanks,

-- 
Jiri Kosina
SUSE Labs

