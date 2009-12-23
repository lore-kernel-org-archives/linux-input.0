From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] ff-memless instant starting
Date: Wed, 23 Dec 2009 11:38:06 -0800
Message-ID: <20091223193805.GB4525@core.coreip.homeip.net>
References: <1261575074.24604.31.camel@tema>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:46806 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbZLWTiY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2009 14:38:24 -0500
Received: by pzk26 with SMTP id 26so4528126pzk.4
        for <linux-input@vger.kernel.org>; Wed, 23 Dec 2009 11:38:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1261575074.24604.31.camel@tema>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jari Vanhala <ext-jari.vanhala@nokia.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Anssi Hannula <anssi.hannula@iki.fi>

On Wed, Dec 23, 2009 at 03:31:14PM +0200, Jari Vanhala wrote:
> Hi,
> 
> Looks like starting effect with low HZ machine takes considerably time
> due need to wait for system timer. Simplest way to make things faster is
> to do calculation for effect always instantly, like in stopping, but
> this makes starting multiple effects more costly.
> 
> Other solution would be making it a module parameter, so behavior could
> be controlled per machine. Optimize possible cost or speed. I attached
> small patch which will do that.
> 
> If starting priority of individual effect is needed to controlled, you
> probably need to add flag for that to effect itself... I don't know
> which way FF-api is developing, so this could be either good or bad
> thing.
> 
> Any opinions or suggestions? Other than rising HZ. =)
> 

I think we should just start playing the effect immediately, without any
additional module parameters. I'll queue such patch unless I hear
otherwise from Anssi.

-- 
Dmitry
