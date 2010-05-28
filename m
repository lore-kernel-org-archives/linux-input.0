From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Input updates for 2.6.35-rc0
Date: Fri, 28 May 2010 07:23:03 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005280720450.11382@i5.linux-foundation.org>
References: <20100520165243.GA20861@core.coreip.homeip.net> <alpine.LFD.2.00.1005271837050.11382@i5.linux-foundation.org> <AANLkTiklv48cDWNqKlFfh5RVtxxNH8shH_JjDypPgeHA@mail.gmail.com> <alpine.LFD.2.00.1005272108210.11382@i5.linux-foundation.org>
 <20100528050716.GB2663@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42217 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750842Ab0E1O0c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 May 2010 10:26:32 -0400
In-Reply-To: <20100528050716.GB2663@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, Florian Ragwitz <rafl@debian.org>, Arjan Opmeer <arjan@opmeer.net>, Eric Piel <eric.piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org



On Thu, 27 May 2010, Dmitry Torokhov wrote:
> 
> So I take it we can leave the touchpad in Enaltech mode for now?

Oh yes, no problem.  Now it's more of a gnome issue than anything else, 
but I don't care deeply. It was the change of behavior that threw me and 
made it look like a kernel regression. If it had always worked that way, 
I'd probably even have noticed the touchpad configuration when installing 
the machine.

		Linus
