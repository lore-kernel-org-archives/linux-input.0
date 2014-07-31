From: simon@mungewell.org
Subject: Re: PATCH hid: Implement mode switching on Logitech gaming wheels
 accordingly to the documentation
Date: Thu, 31 Jul 2014 13:29:57 -0400
Message-ID: <f86b6b4fbf48ce4cbeb9b537794a4eb8.squirrel@mungewell.org>
References: <3335238.KGDcEM6DjH@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3335238.KGDcEM6DjH@sigyn>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@devoid-pointer.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, edwin@velds.nl, "elias.vds@gmail.com" <elias.vds@gmail.com>, "simon@mungewell.org" <simon@mungewell.org>, Roland Bosa <rbosa@logitech.com>
List-Id: linux-input@vger.kernel.org


> +#define LG4FF_MSW_MIN 0
> +#define LG4FF_MSW_NATIVE 0	/* Switch device to its native mode (if
> applicable) */
> +#define LG4FF_MSW_DONTSWITCH 1	/* Leave device in its current mode */
> +#define LG4FF_MSW_DFP 2		/* Switch device so that it emulates Driving
> Force Pro (only G25, G27, DFGT) */
> +#define LG4FF_MSW_G25 3		/* Switch device so that it emulates G25 (only
> G27) */
> +#define LG4FF_MSW_MAX 3

Just to let everyone know I am looking at this patch, and have emailed
Michal some questions on whether it covers all options for control.

Cheers,
Simon.
