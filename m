From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Reset ps/2 port should	psmouse_probe	fail	before	retrying
Date: Thu, 22 Apr 2010 14:55:17 -0700
Message-ID: <20100422215517.GB28213@core.coreip.homeip.net>
References: <1271723857.6652.6.camel@lovely>
 <4BCE17CC.8020804@canonical.com>
 <20100421063328.GJ4364@core.coreip.homeip.net>
 <4BCF2263.40306@canonical.com>
 <20100421171055.GB10566@core.coreip.homeip.net>
 <4BCF5453.5060703@canonical.com>
 <20100421195238.GA10641@core.coreip.homeip.net>
 <4BCF69CB.7010000@canonical.com>
 <1271953731.4566.27.camel@lovely>
 <4BD0C425.5030609@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:61961 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab0DVVzX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Apr 2010 17:55:23 -0400
Received: by pxi17 with SMTP id 17so754298pxi.19
        for <linux-input@vger.kernel.org>; Thu, 22 Apr 2010 14:55:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BD0C425.5030609@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org, rubini@cvml.unipv.it

On Thu, Apr 22, 2010 at 05:48:21PM -0400, Peter M. Petrakis wrote:
> Hi,
> 
> This one is a winner. with regards to your follow up. I wouldn't
> want to reset something unless we have cause to. This code
> seems to be doing the right thing e.g. I see "unable to query
> synaptics hardware" followed by it's (re)discovery on return
> from S3.
> 
> When it's fully supported by the Synaptics driver, the initial
> reconnect will succeed and we'll never get to this additional
> failsafe code which is essentially a catch all for the bleeding
> edge.
>

I am confused here... what protocol does the kernel select upon fresh
boot? It is SynPS/2 or PS/2? I fit is SYnPS/2 then the touchpad is being
driven by SYnaptics protocol even though we do not fully support
multitouch version of SYnaptics touchpads. And i fi ti is the case then
the workaround shoudl go into synaptics-sepcific reconnect function, not
generic psmouse one.

Thanks.

-- 
Dmitry
