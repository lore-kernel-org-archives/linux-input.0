From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: linux-next: Tree for July 30
Date: Thu, 7 Aug 2008 20:55:28 +0200
Message-ID: <200808072055.30072.rjw@sisk.pl>
References: <20080730170635.f737ffe9.sfr@canb.auug.org.au> <20080731131056.eecc4826.akpm@linux-foundation.org> <20080807140357.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36121 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbYHGSwn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Aug 2008 14:52:43 -0400
In-Reply-To: <20080807140357.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, bzolnier@gmail.com, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thursday, 7 of August 2008, Dmitry Torokhov wrote:
> On Thu, Jul 31, 2008 at 01:10:56PM -0700, Andrew Morton wrote:
> > 
> > If that works then great.  But I think the printk could be improved. 
> > Please provide sufficient information so that users (not programmers)
> > can go off and fix things up without needing to email kernel developers.
> > 
> > One suitable approach would be
> > 
> > 	printk("see http://userweb.kernel.org/~dtor/read-this.txt")
> > 
> 
> Ok, I made a small page here:
> 
> 	http://userweb.kernel.org/~dtor/eviocgbit-bug.html

404: Not Found

> If you think this is sufficient I'd like to put the patch with the
> warning in 2.6.27 so people and distributions could start updarting
> affected programs.
