From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PATCH [1/6] HID: lg4ff - Move handling of Logitech wheels to
 lg4ff driver
Date: Wed, 10 Aug 2011 18:11:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108101811290.32288@pobox.suse.cz>
References: <1436421.MlUiXUhh2P@qosmio-x300>    <a5844f7bbd833b88460daeecabbe59d8.squirrel@host171.canaca.com>    <alpine.LNX.2.00.1108031550110.22911@pobox.suse.cz>    <30d25cbbd1396ee543893c7ce10b359d.squirrel@host171.canaca.com>   
 <alpine.LNX.2.00.1108101428070.32288@pobox.suse.cz> <d6ce6f95d26566090bc2647383debb84.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52276 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709Ab1HJQLu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2011 12:11:50 -0400
In-Reply-To: <d6ce6f95d26566090bc2647383debb84.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: =?ISO-8859-15?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>, linux-input@vger.kernel.org

On Wed, 10 Aug 2011, simon@mungewell.org wrote:

> > But ... what's now LOGIWHEELS_FF used to be LOGITECH_FF, which isn't
> > 'default y' either.
> >
> > So something along the lines of patch below would be fine for you guys?
> >
> Yep, that makes sense and works for me...
> Thanks,
> Simon.

Okay, applied, thanks for testing.

-- 
Jiri Kosina
SUSE Labs
