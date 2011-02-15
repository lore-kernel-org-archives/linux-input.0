From: Rakesh Iyer <riyer@nvidia.com>
Subject: RE: [PATCH v1] input: tegra-kbc: Add Function keymap.
Date: Tue, 15 Feb 2011 13:49:21 -0800
Message-ID: <1FC56210173BB445BD77F608D6FB8D03165A0080DC@HQMAIL03.nvidia.com>
References: <1297198584-4282-1-git-send-email-riyer@nvidia.com>
 <20110209084948.GB7256@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080B7@HQMAIL03.nvidia.com>
 <20110215185450.GB19688@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080D8@HQMAIL03.nvidia.com>
 <1FC56210173BB445BD77F608D6FB8D03165A0080D9@HQMAIL03.nvidia.com>
 <20110215200034.GC19688@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080DA@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:9974 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab1BOVt2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Feb 2011 16:49:28 -0500
In-Reply-To: <1FC56210173BB445BD77F608D6FB8D03165A0080DA@HQMAIL03.nvidia.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rakesh Iyer <riyer@nvidia.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>, "'olofj@chromium.org'" <olofj@chromium.org>, Andrew Chew <AChew@nvidia.com>

To add, Does the rest of the patch look okay esp sent as Patch v3?

Regards
Rakesh
> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On
> Behalf Of Rakesh Iyer
> Sent: Tuesday, February 15, 2011 1:44 PM
> To: 'Dmitry Torokhov'
> Cc: 'linux-input@vger.kernel.org'; 'olofj@chromium.org'; Andrew Chew
> Subject: RE: [PATCH v1] input: tegra-kbc: Add Function keymap.
> 
> We do not have a special definition for that key in our system, and going by the original
> intention it seems it's a help function for the hotkeys.
> 
> As far as our system is concerned we do not need the key to do that. Maybe I can avoid
> mapping that key. Does that seem reasonable?
> 
> Thank and Regards
> Rakesh
> 
> > -----Original Message-----
> > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > Sent: Tuesday, February 15, 2011 12:01 PM
> > To: Rakesh Iyer
> > Cc: 'linux-input@vger.kernel.org'; 'olofj@chromium.org'; Andrew Chew
> > Subject: Re: [PATCH v1] input: tegra-kbc: Add Function keymap.
> >
> > On Tue, Feb 15, 2011 at 11:49:12AM -0800, Rakesh Iyer wrote:
> > > Just wanted to add  -> some of the keys on the extreme right are not present in our
> > keyboard (Euro and Dollar) and some others such as PgUp, PgDown are laid out
> differently.
> > >
> >
> > OK, sp what is the intended function of that '?' key? Should it produce
> > question mark or is it a hotkey for invoking help function?
> >
> > Thanks.
> >
> > --
> > Dmitry
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
