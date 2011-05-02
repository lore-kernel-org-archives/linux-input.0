From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] G27_support
Date: Mon, 2 May 2011 21:21:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105022119220.26214@pobox.suse.cz>
References: <1299842104.2550.24.camel@slim-one-desktop>  <1300769820-16198-1-git-send-email-simon@mungewell.org> <1304363877.5713.17.camel@slim-one-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58499 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423Ab1EBTVd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 May 2011 15:21:33 -0400
In-Reply-To: <1304363877.5713.17.camel@slim-one-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter <peter@slim-one.de>
Cc: linux-input <linux-input@vger.kernel.org>, Olivier Michel <Olivier.Michel@cyberbotics.com>, Simon Wood <simon@mungewell.org>

On Mon, 2 May 2011, Peter wrote:

> Hi,
> 
> here's a small patch to add support for the Logitech G27 wheel, since
> the prior patch only added FF support for the Driving Force Pro and G25.
> The patch contains the changes from the G25 and DFP, too, since they
> were not in linux/kernel/git/jikos/hid.git.
> I tested the changes with wine/LFS and got full support for all axes and
> buttons.

Thanks a lot for the patch.

Could you please send it altogether with proper From: and Signed-off-by: 
lines, so that I could apply it?

Thanks,

-- 
Jiri Kosina
SUSE Labs
