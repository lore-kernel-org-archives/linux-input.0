From: simon@mungewell.org
Subject: Re: PATCH [1/6] HID: lg4ff - Move handling of Logitech wheels to
 lg4ff driver
Date: Tue, 9 Aug 2011 19:35:34 -0400
Message-ID: <30d25cbbd1396ee543893c7ce10b359d.squirrel@host171.canaca.com>
References: <1436421.MlUiXUhh2P@qosmio-x300>
    <a5844f7bbd833b88460daeecabbe59d8.squirrel@host171.canaca.com>
    <alpine.LNX.2.00.1108031550110.22911@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:57778 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab1HIXfi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Aug 2011 19:35:38 -0400
In-Reply-To: <alpine.LNX.2.00.1108031550110.22911@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: simon@mungewell.org, =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>, linux-input@vger.kernel.org

>
> I am finalizing the patch review and planning to merge it.

Hi Jiri,
Saw that this is in the latest git grab, but I also noticed that (the new)
option 'LOGIWHEELS_FF' is not automatically selected if I grab an old
kernel config (say 2.6.38 on my ubuntu box) and do 'make oldconfig' with
the enter key held down.

Did Michal/myself miss something, or is it preferable to not enable by
default?

The down side is that the FF on these wheels will stop working (compared
to 3.0) if kernel builder does not enable this....

I can spin a patch if you'd like to point me the right direction.

Cheers,
Simon.

