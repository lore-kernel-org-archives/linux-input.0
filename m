From: Rakesh Iyer <riyer@nvidia.com>
Subject: RE: [PATCH v1] input: tegra-kbc: Add Function keymap.
Date: Tue, 15 Feb 2011 13:55:10 -0800
Message-ID: <1FC56210173BB445BD77F608D6FB8D03165A0080DD@HQMAIL03.nvidia.com>
References: <1297198584-4282-1-git-send-email-riyer@nvidia.com>
 <20110209084948.GB7256@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080B7@HQMAIL03.nvidia.com>
 <20110215185450.GB19688@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080D8@HQMAIL03.nvidia.com>
 <1FC56210173BB445BD77F608D6FB8D03165A0080D9@HQMAIL03.nvidia.com>
 <20110215200034.GC19688@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080DA@HQMAIL03.nvidia.com>
 <20110215215402.GA24074@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:18243 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325Ab1BOVzU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Feb 2011 16:55:20 -0500
In-Reply-To: <20110215215402.GA24074@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>, "'olofj@chromium.org'" <olofj@chromium.org>, Andrew Chew <AChew@nvidia.com>

Yeah that's perfect.

Regards
Rakesh

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Tuesday, February 15, 2011 1:54 PM
> To: Rakesh Iyer
> Cc: 'linux-input@vger.kernel.org'; 'olofj@chromium.org'; Andrew Chew
> Subject: Re: [PATCH v1] input: tegra-kbc: Add Function keymap.
> 
> On Tue, Feb 15, 2011 at 01:43:45PM -0800, Rakesh Iyer wrote:
> > We do not have a special definition for that key in our system, and going by the original
> intention it seems it's a help function for the hotkeys.
> >
> > As far as our system is concerned we do not need the key to do that. Maybe I can avoid
> mapping that key. Does that seem reasonable?
> >
> 
> Let's just map it to:
> 
> #define KEY_HELP                138     /* AL Integrated Help Center */
> 
> No need to resend if you agree, I'll simply edit locally.
> 
> Thanks.
> 
> --
> Dmitry
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
