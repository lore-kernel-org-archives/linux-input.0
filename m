From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PATCH [1/6] HID: lg4ff - Move handling of Logitech wheels to
 lg4ff driver
Date: Wed, 10 Aug 2011 14:33:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108101428070.32288@pobox.suse.cz>
References: <1436421.MlUiXUhh2P@qosmio-x300>    <a5844f7bbd833b88460daeecabbe59d8.squirrel@host171.canaca.com>    <alpine.LNX.2.00.1108031550110.22911@pobox.suse.cz> <30d25cbbd1396ee543893c7ce10b359d.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38281 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737Ab1HJMd3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2011 08:33:29 -0400
In-Reply-To: <30d25cbbd1396ee543893c7ce10b359d.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@gmail.com>, linux-input@vger.kernel.org

On Tue, 9 Aug 2011, simon@mungewell.org wrote:

> Hi Jiri,
> Saw that this is in the latest git grab, but I also noticed that (the new)
> option 'LOGIWHEELS_FF' is not automatically selected if I grab an old
> kernel config (say 2.6.38 on my ubuntu box) and do 'make oldconfig' with
> the enter key held down.
> 
> Did Michal/myself miss something, or is it preferable to not enable by
> default?
> 
> The down side is that the FF on these wheels will stop working (compared
> to 3.0) if kernel builder does not enable this....
> 
> I can spin a patch if you'd like to point me the right direction.

We normally don't do 'default y' for newly added HID options (I had quite 
some argument about this with Linus several times already :) ).

This one could be different, as it's a split-off from an option that has 
existed before.

But ... what's now LOGIWHEELS_FF used to be LOGITECH_FF, which isn't 
'default y' either.

So something along the lines of patch below would be fine for you guys?




From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: make CONFIG_LOGIWHEELS_FF default to CONFIG_LOGITECH_FF

Do this for backwards compatibility reasons (LOGIWHEELS_FF has
been split-off from LOGITECH_FF), so that users don't have
regressions with 'default' kernel configs.

Reported-by: simon@mungewell.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6ae234f..410eaa9 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -282,6 +282,7 @@ config LOGIWHEELS_FF
 	bool "Logitech wheels configuration and force feedback support"
 	depends on HID_LOGITECH
 	select INPUT_FF_MEMLESS
+	default LOGITECH_FF
 	help
 	  Say Y here if you want to enable force feedback and range setting
 	  support for following Logitech wheels:
-- 
1.7.3.1

