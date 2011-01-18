From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/3] Input: add support for DragonRise PID 0011 gamepad
Date: Tue, 18 Jan 2011 14:14:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101181413000.26685@pobox.suse.cz>
References: <1294945003-7687-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54772 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab1ARNOO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Jan 2011 08:14:14 -0500
In-Reply-To: <1294945003-7687-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>

On Thu, 13 Jan 2011, Nikolai Kondrashov wrote:

> These patches add support for a DragonRise Inc. gamepad with USB PID 0x0011.
> 
> The patches are made against 2.6.37. I'm almost sure it is wrong, but I wasn't
> able to figure out for certain which branch of which repository to use.
> 
> Please tell me which one I should use, if I'm wrong. Thanks.

Hi Nikolai,

two comments:

1) please always CC me on patches against drivers/hid/*, as can be guessed 
from MAINTAINERS file
2) please send me the patch based on more-or-less current Linus' tree, as 
that's what development is happening on top of.

Otherwise, the series looks fine and I am willing to apply it. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
