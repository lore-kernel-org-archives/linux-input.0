From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] OLPC: psmouse: touchpad driver
Date: Fri, 1 Aug 2008 14:34:51 -0400
Message-ID: <20080801143150.ZZRA012@mailhub.coreip.homeip.net>
References: <20080801142004.2d3d1349@fred>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:25852 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759369AbYHASe5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Aug 2008 14:34:57 -0400
Received: by an-out-0708.google.com with SMTP id d40so187454and.103
        for <linux-input@vger.kernel.org>; Fri, 01 Aug 2008 11:34:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080801142004.2d3d1349@fred>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

On Fri, Aug 01, 2008 at 02:20:04PM -0400, Andres Salomon wrote:
> 
> This adds support for OLPC's touchpad.  It has lots of neat features,
> none of which are enabled because the hardware is too buggy.  Instead,
> we use it like a normal touchpad, but with a number of workarounds in
> place to deal with the frequent hardware spasms.  Humidity changes,
> sweat, tinfoil underwear, plugging in AC, drinks, evil felines.. All
> tend to cause the touchpad to freak out.
> 
> Stuff like this keeps me from getting bored.
> 

Good stuff, thank you. I bet you named the module olpc and gave pregix
hgpk to all the functions to mess with mt feeble brain ;) Maybe we
should rename the module to hgpk as well?

> From psmouse-base, we use psmouse_set_state quite a bit, as well
> as piggy-backing off of kpsmoused_wq; so, this also makes those
> available to protocol extensions.
>

Do you think we should provide assessor functions to deal with
kpsmoused instead of playing with it directly? I was thinking about
starting it on-demand for protocols that may use it and shut it off by
default.

-- 
Dmitry
