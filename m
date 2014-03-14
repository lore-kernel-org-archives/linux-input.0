From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 0/8] HID: sony: More Sony controller fixes and
 improvements.
Date: Fri, 14 Mar 2014 15:42:21 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1403141541540.3690@pobox.suse.cz>
References: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33365 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754301AbaCNOmW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Mar 2014 10:42:22 -0400
In-Reply-To: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, dh.herrmann@gmail.com

On Thu, 6 Mar 2014, Frank Praznik wrote:

> v2 rebases the previous set of patches against Benjamin Tissoires' latest patch
> set and adds some additional changes:
> 
> - Adds a patch setting the new HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP for the
>   Sixaxis and DualShock 4 when they are connected via Bluetooth.  This adds
>   support for sending output reports via hidraw.
>   
> - A patch with a new union/struct is introduced for the Sixaxis output report.
>   This improves readability, particularly in the later blink support patch.
>   
> - Adds an IDA id allocator and uses it to assign the number at the end of the
>   battery string and set the default LED values relative to other Sony
>   controllers.
> 
> - Drops the LED trigger patch as it probably doesn't belong in kernel space.
>   
> - Addresses various issues raised during code review of the previous patch set.

Frank,

just to make things clear -- I am waiting for v3 due to baddr changes 
planned for 6/8.

Thanks,

-- 
Jiri Kosina
SUSE Labs
