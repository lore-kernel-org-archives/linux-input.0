From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: push down scancode negative checking
Date: Mon, 7 Jul 2008 15:00:53 -0400
Message-ID: <20080707150041.ZZRA012@mailhub.coreip.homeip.net>
References: <1214854426-20442-1-git-send-email-dwalker@mvista.com> <20080630154701.ZZRA012@mailhub.coreip.homeip.net> <1214855780.5764.3.camel@localhost.localdomain> <alpine.LNX.1.10.0807010950250.4593@jikos.suse.cz> <1214933005.5764.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:17326 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbYGGTBD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jul 2008 15:01:03 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1037700ywe.1
        for <linux-input@vger.kernel.org>; Mon, 07 Jul 2008 12:01:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1214933005.5764.6.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Philippe Troin <phil@fifi.org>, "Adolfo R. Brandes" <arbrandes@gmail.com>, linux-input@vger.kernel.org

On Tue, Jul 01, 2008 at 10:23:25AM -0700, Daniel Walker wrote:
> 
> On Tue, 2008-07-01 at 09:51 +0200, Jiri Kosina wrote:
> > On Mon, 30 Jun 2008, Daniel Walker wrote:
> > 
> > >> Hmm, I wonder if we just need to type these as unsigned.
> > > I think it would make sense, because AFAIK scancodes don't really have a
> > > concept of signed-ness anyway .. I almost did it that way, but I wasn't
> > > sure enough about the reasoning for the signed int ..
> > 
> > That would be the option I'd prefer too.
> 
> Do you guys want me to send another patch for this?
> 

Yes please.

-- 
Dmitry
