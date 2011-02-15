From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1] input: tegra-kbc: Add Function keymap.
Date: Tue, 15 Feb 2011 13:54:02 -0800
Message-ID: <20110215215402.GA24074@core.coreip.homeip.net>
References: <1297198584-4282-1-git-send-email-riyer@nvidia.com>
 <20110209084948.GB7256@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080B7@HQMAIL03.nvidia.com>
 <20110215185450.GB19688@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080D8@HQMAIL03.nvidia.com>
 <1FC56210173BB445BD77F608D6FB8D03165A0080D9@HQMAIL03.nvidia.com>
 <20110215200034.GC19688@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080DA@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40438 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325Ab1BOVyL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Feb 2011 16:54:11 -0500
Received: by iwn9 with SMTP id 9so640118iwn.19
        for <linux-input@vger.kernel.org>; Tue, 15 Feb 2011 13:54:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1FC56210173BB445BD77F608D6FB8D03165A0080DA@HQMAIL03.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rakesh Iyer <riyer@nvidia.com>
Cc: "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>, "'olofj@chromium.org'" <olofj@chromium.org>, Andrew Chew <AChew@nvidia.com>

On Tue, Feb 15, 2011 at 01:43:45PM -0800, Rakesh Iyer wrote:
> We do not have a special definition for that key in our system, and going by the original intention it seems it's a help function for the hotkeys.
> 
> As far as our system is concerned we do not need the key to do that. Maybe I can avoid mapping that key. Does that seem reasonable?
> 

Let's just map it to:

#define KEY_HELP                138     /* AL Integrated Help Center */

No need to resend if you agree, I'll simply edit locally.

Thanks.

-- 
Dmitry
