From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Input updates for 3.5-rc0
Date: Thu, 24 May 2012 14:07:29 -0700
Message-ID: <CA+55aFybQDXjGaEK0k=60gS88bxwE8vC7XvOffaQAf3de9cCfg@mail.gmail.com>
References: <20120524083216.GD10562@core.coreip.homeip.net>
 <CA+55aFxw0HRpizzJZxhhA2oqPpzg4DPUvH2r7YoYfctXS6K=WQ@mail.gmail.com>
 <20120524180154.GA15036@core.coreip.homeip.net> <CA+55aFx0ww=BtYAj9WEbqMT2R30ZZpjd014cYCpC=b+HRtUf_A@mail.gmail.com>
 <20120524195851.GA15306@core.coreip.homeip.net> <CA+55aFxX+xidcuVXb1h4oFTemtHo+ANECaoOw=vxtKN231N+cA@mail.gmail.com>
 <20120524203647.GA16024@core.coreip.homeip.net> <CA+55aFz9Fp2J=oCkoDAwNTnEJoBeKC9tn+5dqMCKf4C22CAi6Q@mail.gmail.com>
 <20120524205952.GA16621@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35228 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005Ab2EXVHu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 17:07:50 -0400
In-Reply-To: <20120524205952.GA16621@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, May 24, 2012 at 1:59 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> I was concerned about the _next_ device (the one that will be created
> the moment I plug in the tablet back into the same port) having exact
> same name as the one that is half dead and clashing in sysfs and
> elsewhere. We used to have issues with this.

Ok, that's certainly a valid concern.

It's still - I think - really sad/wrong that the device name is then
so useless than the drivers end up basically not using it.

                      Linus
