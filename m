From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Add support for the Wacom Intuos 4 wireless
Date: Tue, 20 Jul 2010 17:53:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007201752570.4741@pobox.suse.cz>
References: <1271857920.1960.5.camel@localhost.localdomain>  <alpine.LNX.2.00.1004211553220.7579@pobox.suse.cz>  <1271858866.17421.3575.camel@localhost.localdomain>  <alpine.LNX.2.00.1004211619310.7579@pobox.suse.cz>
 <1277908230.26120.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35436 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932442Ab0GTPxH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jul 2010 11:53:07 -0400
In-Reply-To: <1277908230.26120.9.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

On Wed, 30 Jun 2010, Bastien Nocera wrote:

> > > > How about addition of this VID/PID combination to hid_blacklist[]?
> > > 
> > > My mistake, that needs to be done as well obviously.
> > > 
> > > Will send an updated patch shortly.
> > 
> > No problem, I'll fix that up myself.
> 
> Hmm, I did something stupid there. The Intuos 4 wireless uses a
> different protocol from the Graphire wireless. Another driver will need
> to be written...
> 
> Could you please revert that patch?

Reverted, thanks for letting me know.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
