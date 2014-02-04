From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Kconfig updates for the Sony module
Date: Tue, 4 Feb 2014 15:24:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402041524090.14066@pobox.suse.cz>
References: <1391269198-8210-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55792 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbaBDOYm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 09:24:42 -0500
In-Reply-To: <1391269198-8210-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

On Sat, 1 Feb 2014, Frank Praznik wrote:

> Update the HID_SONY config with 'select POWER_SUPPLY' to fix build issues
> relating to undefined references to the  power_supply_* functions in
> certain build configurations.
> 
> Update the description text to reflect that Playstation 4 controllers are now
> supported.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

I have dropped the POWER_SUPPLY part of the patch, as I've already fixed 
that in my tree as a followup to Fengguang's report.

I have applied the rest, thanks.

-- 
Jiri Kosina
SUSE Labs
