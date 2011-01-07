From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: introduce 'notimeout' blacklist for Dell Vostro
 V13 (was Re: Synaptics touchpad on Dell Vostro V13)
Date: Fri, 7 Jan 2011 09:28:47 -0800
Message-ID: <20110107172847.GA28785@core.coreip.homeip.net>
References: <8583070.26.1294325869588.JavaMail.root@butch.jtdata.net>
 <alpine.LNX.2.00.1101071105350.26685@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1101071105350.26685@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "James T. Dickson" <james.dickson@jtdata.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 07, 2011 at 11:06:41AM +0100, Jiri Kosina wrote:
> On Thu, 6 Jan 2011, James T. Dickson wrote:
> 
> > Correct .. Suspend worked fine when the touchpad was a generic mouse.
> > 
> > However, this appears a symptom of the synaptics driver. I was able to 
> > overcome it with this script from 
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/59867 .
> > 
> > Placing it in /etc/pm/sleeps.d/ .
> > 
> > #!/bin/sh
> > #
> > # Reload the AT keyboard interface.
> > 
> > case "$1" in
> >         hibernate|suspend)
> >                 rmmod psmouse
> >                 ;;
> >         thaw|resume)
> >                 modprobe psmouse
> >                 ;;
> >         *)
> >                 ;;
> > esac
> 
> I have already came across reports of this being needed for synaptics 
> touchpads on several different machines already, so this seems to be 
> rather unrelated problem to me.

Right, but it would be nice if we could find the problem...

> 
> Dmitry, what is your current plan with the notimeout thing for V13, 
> please? Still .38 material?

Yeah, especially given that not all V13 seem to suffer from
suspend/resume issue.

-- 
Dmitry
