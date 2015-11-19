From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: sony: Remove the size check for the Dualshock 4
 HID Descriptor
Date: Thu, 19 Nov 2015 16:38:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511191637560.20111@pobox.suse.cz>
References: <1446842153-4231-1-git-send-email-frank.praznik@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34864 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757815AbbKSPiO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 10:38:14 -0500
In-Reply-To: <1446842153-4231-1-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, 6 Nov 2015, Frank Praznik wrote:

> Sony has modified the HID descriptor in new revisions of the Dualshock 4 which
> causes the size check in the descriptor replacement function to fail.  Remove it
> so that new revisions of the controller will work correctly.
> 
> The module is completely replacing the descriptor instead of patching it, so the
> size check isn't really necessary anyways.
> 
> Signed-off-by: Frank Praznik <frank.praznik@gmail.com>

Applied to for-4.5/sony, thanks.

-- 
Jiri Kosina
SUSE Labs

