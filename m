From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PATCH hid: Implement mode switching on Logitech gaming wheels
 accordingly to the documentation
Date: Tue, 12 Aug 2014 15:10:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1408121509550.15220@pobox.suse.cz>
References: <3335238.KGDcEM6DjH@sigyn> <f86b6b4fbf48ce4cbeb9b537794a4eb8.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f86b6b4fbf48ce4cbeb9b537794a4eb8.squirrel@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "simon@mungewell.org" <simon@mungewell.org>
Cc: =?ISO-8859-15?Q?=22Michal_Mal=FD=22?= <madcatxster@devoid-pointer.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, edwin@velds.nl, "elias.vds@gmail.com" <elias.vds@gmail.com>, Roland Bosa <rbosa@logitech.com>
List-Id: linux-input@vger.kernel.org

On Thu, 31 Jul 2014, simon@mungewell.org wrote:

> > +#define LG4FF_MSW_MIN 0
> > +#define LG4FF_MSW_NATIVE 0	/* Switch device to its native mode (if
> > applicable) */
> > +#define LG4FF_MSW_DONTSWITCH 1	/* Leave device in its current mode */
> > +#define LG4FF_MSW_DFP 2		/* Switch device so that it emulates Driving
> > Force Pro (only G25, G27, DFGT) */
> > +#define LG4FF_MSW_G25 3		/* Switch device so that it emulates G25 (only
> > G27) */
> > +#define LG4FF_MSW_MAX 3
> 
> Just to let everyone know I am looking at this patch, and have emailed
> Michal some questions on whether it covers all options for control.

Hi guys,

did you reach any kind of conclusion here?

-- 
Jiri Kosina
SUSE Labs
