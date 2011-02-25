From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 4/4 v2] input - wacom: Support 2FGT in MT format
Date: Fri, 25 Feb 2011 15:50:46 +0100
Message-ID: <20110225145046.GB22165@polaris.bitmath.org>
References: <1297896827-2592-1-git-send-email-pinglinux@gmail.com>
 <20110220122524.GB1720@polaris.bitmath.org>
 <AANLkTindWaytcEOeyBf8t1y4=Z5t0ge_jFKkP_UOvwtN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:49706 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754361Ab1BYOuy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Feb 2011 09:50:54 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTindWaytcEOeyBf8t1y4=Z5t0ge_jFKkP_UOvwtN@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

> > How about wacom->shared->touch_down = contact_count > 0 instead?
> >
> 
> I can change to that. It doesn't change the logic though.

Yes, please do, although if you plan to keep the current logic, the
naming should be something like contact_with_no_pen_down_count
instead. ;-)

Cheers,
Henrik
