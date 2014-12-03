From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] i2c-hid / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 3 Dec 2014 08:31:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412030830530.2524@pobox.suse.cz>
References: <3331107.SjqxFqQlza@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50248 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbaLCHbA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Dec 2014 02:31:00 -0500
In-Reply-To: <3331107.SjqxFqQlza@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-input@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, 3 Dec 2014, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
> 
> Replace CONFIG_PM_RUNTIME with CONFIG_PM in drivers/hid/i2c-hid/i2c-hid.c.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
> PM_SLEEP is selected) which is only in linux-next at the moment (via the
> linux-pm tree).
> 
> Please let me know if it is OK to take this one into linux-pm.

Acked-by: Jiri Kosina <jkosina@suse.cz>

Please take it through linux-pm.

Thanks,

-- 
Jiri Kosina
SUSE Labs
