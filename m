From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: introduce 'notimeout' blacklist for Dell Vostro
 V13 (was Re: Synaptics touchpad on Dell Vostro V13)
Date: Fri, 7 Jan 2011 11:06:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101071105350.26685@pobox.suse.cz>
References: <8583070.26.1294325869588.JavaMail.root@butch.jtdata.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42762 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632Ab1AGKGn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Jan 2011 05:06:43 -0500
In-Reply-To: <8583070.26.1294325869588.JavaMail.root@butch.jtdata.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "James T. Dickson" <james.dickson@jtdata.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 6 Jan 2011, James T. Dickson wrote:

> Correct .. Suspend worked fine when the touchpad was a generic mouse.
> 
> However, this appears a symptom of the synaptics driver. I was able to 
> overcome it with this script from 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/59867 .
> 
> Placing it in /etc/pm/sleeps.d/ .
> 
> #!/bin/sh
> #
> # Reload the AT keyboard interface.
> 
> case "$1" in
>         hibernate|suspend)
>                 rmmod psmouse
>                 ;;
>         thaw|resume)
>                 modprobe psmouse
>                 ;;
>         *)
>                 ;;
> esac

I have already came across reports of this being needed for synaptics 
touchpads on several different machines already, so this seems to be 
rather unrelated problem to me.

Dmitry, what is your current plan with the notimeout thing for V13, 
please? Still .38 material?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
