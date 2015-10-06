From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [RESEND] [PATCH] HID: quirks: add MULTI_INPUT quirk for Dragonrise
 GameCube adapter
Date: Tue, 6 Oct 2015 16:04:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510061602530.2758@pobox.suse.cz>
References: <f270fa45a9d6a9f6ce175f7ef084bc41@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59888 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbbJFOEU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Oct 2015 10:04:20 -0400
In-Reply-To: <f270fa45a9d6a9f6ce175f7ef084bc41@pobox.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Rodland <andrew@cleverdomain.org>
Cc: linux-input@vger.kernel.org

On Tue, 6 Oct 2015, Andrew Rodland wrote:

> This device (aka Mayflash GameCube Adapter) has 4 controller ports, and
> without the quirk they all become one very large joystock device. With the
> quirk they're recognized as 4 separate joysticks.
> 
> Signed-off-by: Andrew Rodland <andrew@cleverdomain.org>

Sorry, the formatting is still damaged, please fix your client and resend 
the patch.

For some common ones, there are some hints in

	Documentation/email-clients.txt

-- 
Jiri Kosina
SUSE Labs

