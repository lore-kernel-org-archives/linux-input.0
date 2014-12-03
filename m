From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c-hid / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 3 Dec 2014 11:53:43 +0200
Message-ID: <20141203095343.GR28857@lahna.fi.intel.com>
References: <3331107.SjqxFqQlza@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3331107.SjqxFqQlza@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 03, 2014 at 02:56:07AM +0100, Rafael J. Wysocki wrote:
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

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
