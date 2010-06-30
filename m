From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Add support for the Wacom Intuos 4 wireless
Date: Wed, 30 Jun 2010 15:30:30 +0100
Message-ID: <1277908230.26120.9.camel@localhost.localdomain>
References: <1271857920.1960.5.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1004211553220.7579@pobox.suse.cz>
	 <1271858866.17421.3575.camel@localhost.localdomain>
	 <alpine.LNX.2.00.1004211619310.7579@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:33805 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756288Ab0F3ObA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 10:31:00 -0400
Received: from mrelay2-d.mgt.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 4C3CC8730A
	for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 16:30:56 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1004211619310.7579@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Wed, 2010-04-21 at 16:19 +0200, Jiri Kosina wrote:
> On Wed, 21 Apr 2010, Bastien Nocera wrote:
> 
> > > How about addition of this VID/PID combination to hid_blacklist[]?
> > 
> > My mistake, that needs to be done as well obviously.
> > 
> > Will send an updated patch shortly.
> 
> No problem, I'll fix that up myself.

Hmm, I did something stupid there. The Intuos 4 wireless uses a
different protocol from the Graphire wireless. Another driver will need
to be written...

Could you please revert that patch?

Cheers

