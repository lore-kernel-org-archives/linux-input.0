From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] input: push down scancode negative checking
Date: Tue, 01 Jul 2008 10:23:25 -0700
Message-ID: <1214933005.5764.6.camel@localhost.localdomain>
References: <1214854426-20442-1-git-send-email-dwalker@mvista.com>
	 <20080630154701.ZZRA012@mailhub.coreip.homeip.net>
	 <1214855780.5764.3.camel@localhost.localdomain>
	 <alpine.LNX.1.10.0807010950250.4593@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:57225 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbYGARX0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 13:23:26 -0400
In-Reply-To: <alpine.LNX.1.10.0807010950250.4593@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philippe Troin <phil@fifi.org>, "Adolfo R. Brandes" <arbrandes@gmail.com>, linux-input@vger.kernel.org


On Tue, 2008-07-01 at 09:51 +0200, Jiri Kosina wrote:
> On Mon, 30 Jun 2008, Daniel Walker wrote:
> 
> >> Hmm, I wonder if we just need to type these as unsigned.
> > I think it would make sense, because AFAIK scancodes don't really have a
> > concept of signed-ness anyway .. I almost did it that way, but I wasn't
> > sure enough about the reasoning for the signed int ..
> 
> That would be the option I'd prefer too.

Do you guys want me to send another patch for this?

Daniel

