From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [TRIVIAL, PATCH] hid/hidraw: indent with tabs, not spaces
Date: Tue, 11 May 2010 10:48:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005111048180.28092@pobox.suse.cz>
References: <1272656998-29307-1-git-send-email-ospite@studenti.unina.it> <20100506110214.0c6cbb48.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53401 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757433Ab0EKIsp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 04:48:45 -0400
In-Reply-To: <20100506110214.0c6cbb48.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

On Thu, 6 May 2010, Antonio Ospite wrote:

> On Fri, 30 Apr 2010 21:49:58 +0200
> Antonio Ospite <ospite@studenti.unina.it> wrote:
> 
> > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> > ---
> >  drivers/hid/hidraw.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> > index 6eadf1a..a9becf9 100644
> > --- a/drivers/hid/hidraw.c
> > +++ b/drivers/hid/hidraw.c
> > @@ -311,7 +311,7 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
> >  						-EFAULT : len;
> >  					break;
> >  				}
> > -                }
> > +		}
> >  
> >  		ret = -ENOTTY;
> >  	}
> > -- 
> > 1.7.1
> 
> Ping.

It's already queued, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
