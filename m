From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] hid-ntrig: calibration
Date: Tue, 15 Mar 2011 16:47:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103151646120.19969@pobox.suse.cz>
References: <1299829072-19489-1-git-send-email-rafi@seas.upenn.edu> <1299829072-19489-2-git-send-email-rafi@seas.upenn.edu> <4D79D3BD.9000204@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45244 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932110Ab1COPrq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 11:47:46 -0400
In-Reply-To: <4D79D3BD.9000204@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: micki@n-trig.com, linux-input@vger.kernel.org

On Fri, 11 Mar 2011, Rafi Rubin wrote:

> On a related note, I looked into switching to usbhid_submit_report for firmware
> version polling but it looks like the report offset (or something like that) is
> wrong.
> 
> I get:
> af082500
> 
> usbmon shows the devices sends:
> 0c002508 afe10000
> 
> If I change the report offset in the field to 8, I get the desired bits:
> e1af0825
> 
> 
> I don't really know much about parsing the hid descriptors, so I don't know why
> its off by a byte.  Perhaps its worth testing a different firmware to see if
> this is specific to my current firmware.

I am not really sure I fully understand what you are saying here. Just for 
clarification:

- isn't the byte the 'report id' number here?
- does your message mean that the patch doesn't work? Or is this quite the 
contrary -- explanation why it is written the way it is (i.e. using 
usb_control_msg() instead of usbhid_submit_report())?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
