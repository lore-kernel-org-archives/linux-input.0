From: simon@mungewell.org
Subject: Re: PATCH [1/6] HID: lg4ff - Move handling of Logitech wheels to
 lg4ff driver
Date: Wed, 10 Aug 2011 11:09:03 -0400
Message-ID: <d6ce6f95d26566090bc2647383debb84.squirrel@host171.canaca.com>
References: <1436421.MlUiXUhh2P@qosmio-x300>
    <a5844f7bbd833b88460daeecabbe59d8.squirrel@host171.canaca.com>
    <alpine.LNX.2.00.1108031550110.22911@pobox.suse.cz>
    <30d25cbbd1396ee543893c7ce10b359d.squirrel@host171.canaca.com>
    <alpine.LNX.2.00.1108101428070.32288@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:54006 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab1HJPJG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2011 11:09:06 -0400
In-Reply-To: <alpine.LNX.2.00.1108101428070.32288@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: simon@mungewell.org, =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>, linux-input@vger.kernel.org


> But ... what's now LOGIWHEELS_FF used to be LOGITECH_FF, which isn't
> 'default y' either.
>
> So something along the lines of patch below would be fine for you guys?
>

Yep, that makes sense and works for me...
Thanks,
Simon.

