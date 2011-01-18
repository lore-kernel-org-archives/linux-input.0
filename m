From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [Patch] aureal remote quirk to fix an bogus HID report
 descriptor
Date: Tue, 18 Jan 2011 14:19:45 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101181416430.26685@pobox.suse.cz>
References: <4D2F4B65.1020807@openelec.tv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55099 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab1ARNTq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Jan 2011 08:19:46 -0500
In-Reply-To: <4D2F4B65.1020807@openelec.tv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephan Raue <stephan@openelec.tv>
Cc: linux-input@vger.kernel.org

On Thu, 13 Jan 2011, Stephan Raue wrote:

> Remote Controls shipped with some new Jetway ION system has two event
> interfaces : Keyboard and Mouse. Mouse buttons work but keyboard buttons
> doesn't.
> 
> The remote identifies itself as :
> 
> Vendor:Device 0x0755:0x2626
> Cy se W-01RN USB_V3.1
> 
> the Remote Control has a bogus HID Report Descriptor. According to that report
> descriptor, the maximum logical value for key events is 1 and not 101 (101
> keys).
> 
> This quirk fixes this wrong Report Descriptor and is basically the same found
> in hid-elecom.c.
> 
> This patch is originally from
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/607062 with changes to
> not oops on linux-2.6.37.
> 
> 
> Signed-off-by: Stephan Raue <stephan@openelec.tv>

Hi Stepahn,

thanks for the driver! 

A few comments though, before I can apply the driver

- please always CC me on patches against drivers/hid/
- you are adding driver with Copyright of Franco Catrin 
  <fcatrin@gmail.com>, but you are providing your own Signed-off-by only. 
  What is the origin of the code, please?
- additions to hid-ids.h don't really qualify for copyright
- please don't add any new HID drivers with the 'EMBEDDED' stuff in 
  Kconfig. You can read some explanation in the changelog text of commit 
  73d5e8f77e88a4d3a154dfdbb4ed2cf461b7bf21 ("HID: fix up 'EMBEDDED' mess 
  in Kconfig").
- please send the patch inline in the message text, not attached

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
