From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/5] HID: sony: misc fixes and cleanups
Date: Wed, 18 Feb 2015 21:41:32 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502182137240.28769@pobox.suse.cz>
References: <20150216150659.db522f3d.cand@gmx.com> <1424106744-12872-1-git-send-email-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36236 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbbBRUlg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 15:41:36 -0500
In-Reply-To: <1424106744-12872-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, Lauri Kasanen <cand@gmx.com>, Frank Praznik <frank.praznik@oh.rr.com>

On Mon, 16 Feb 2015, Antonio Ospite wrote:

> Hi,
> 
> here are a few cleanups for hid-sony.
> 
> Changes are meant to follow the patch titled:
> [PATCHv4] HID: sony: Enable Gasia third-party PS3 controllers
> 
> Frank, hi, I'd like to have your explicit ack at least for patch 1 and
> 2.
> 
> Thanks,
>    Antonio
> 
> 
> Antonio Ospite (5):
>   HID: sony: Fix a WARNING shown when rmmod-ing the driver
>   HID: sony: Use the minimum accepted size for feature report 0xf2
>   HID: sony: Don't use magic numbers in sixaxis_set_operational_usb()
>   HID: sony: Use __u8 * for the buffer in sixaxis_set_operational_usb()
>   HID: sony: Coding style cleanups in sixaxis_set_operational_usb()

I have applied 1/5 to for-3.20/upstream-fixes and 2-5 to for-3.21/sony. 
Thanks,

-- 
Jiri Kosina
SUSE Labs
