From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH] Input: psmouse - change log messages from psmouse.c to psmouse
Date: Fri, 07 Oct 2011 17:30:13 +0800
Message-ID: <871uupi1y2.fsf@emc.com.tw>
References: <1317273295-4931-1-git-send-email-jj_ding@emc.com.tw> <4E83FF81.700@cn.fujitsu.com> <20111007063926.GA32142@core.coreip.homeip.net> <4E8EB52E.2080005@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:12401 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759613Ab1JGJf7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 05:35:59 -0400
In-Reply-To: <4E8EB52E.2080005@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>

Hi Dmitry, Wanlong,

On Fri, 07 Oct 2011 16:15:42 +0800, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
> On 10/07/2011 02:39 PM, Dmitry Torokhov wrote:
> 
> > Hi JJ, Wanlong,
> > 
> > On Thu, Sep 29, 2011 at 01:17:53PM +0800, Wanlong Gao wrote:
> >> On 09/29/2011 01:14 PM, JJ Ding wrote:
> >>
> >>> From: JJ Ding <dgdunix@gmail.com>
> >>>
> >>> psmouse.c had long been renamed to psmouse-base.c back in 2003, when we
> >>> were still at Linux 2.5.xx. This change makes the log less misleading.
> >>>
> >>> Signed-off-by: JJ Ding <dgdunix@gmail.com>
> >>
> >> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> >>
> > 
> > Actually, I (and other people) wanted to go through psmouse logging and
> > make it all consistent. What do you think about the patch below?
> > 
> > Thanks.
> > 
> 
> 
> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Yes, it's much nicer this way. Thanks.

Reviewed-by: JJ Ding <dgdunix@gmail.com>

> It seems better.
> I can patch to all except input/mouse/elantech.c now, maybe I need
> *git pull*?

I fetched Dmitry's input/next and this patch applied cleanly.

Thanks,
jj

> 
> Thanks, Dmitry
> -Wanlong Gao
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
