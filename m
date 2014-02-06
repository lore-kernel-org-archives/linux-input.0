From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Add Apple wireless keyboard 2011 JIS model
 support.
Date: Thu, 6 Feb 2014 10:22:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402061021170.24838@pobox.suse.cz>
References: <1391678313-2091-1-git-send-email-hiroshi@ghostsinthelab.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35731 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755780AbaBFJWz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Feb 2014 04:22:55 -0500
In-Reply-To: <1391678313-2091-1-git-send-email-hiroshi@ghostsinthelab.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Huei-Horng Yo <hiroshi@ghostsinthelab.org>
Cc: linux-input@vger.kernel.org

On Thu, 6 Feb 2014, Huei-Horng Yo wrote:

> ---
>  drivers/hid/hid-apple.c | 3 +++
>  drivers/hid/hid-core.c  | 1 +
>  drivers/hid/hid-ids.h   | 1 +
>  3 files changed, 5 insertions(+)
> 

Thanks for the patch. Please resend with:

- at least one line of changelog
- your Signed-off-by: line as described in Documentation/SubmittingPatches

so that I could apply it.

-- 
Jiri Kosina
SUSE Labs
