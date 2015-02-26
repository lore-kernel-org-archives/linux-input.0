From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 02/20] power_supply: Move run-time configuration to
 separate structure
Date: Wed, 25 Feb 2015 17:10:07 -0800
Message-ID: <20150226011007.GA25965@dtor-ws>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
 <1424692061-30624-3-git-send-email-k.kozlowski@samsung.com>
 <20150226003409.GA885@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:64808 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbbBZBKM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 20:10:12 -0500
Content-Disposition: inline
In-Reply-To: <20150226003409.GA885@earth>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Thu, Feb 26, 2015 at 01:34:09AM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Feb 23, 2015 at 12:47:23PM +0100, Krzysztof Kozlowski wrote:
> > Add new structure 'power_supply_config' for holding run-time
> > initialization data like of_node, supplies and private driver data.
> > 
> > The power_supply_register() function is changed so all power supply
> > drivers need updating.
> > 
> > When registering the power supply this new 'power_supply_config' should be
> > used instead of directly initializing 'struct power_supply'. This allows
> > changing the ownership of power_supply structure from driver to the
> > power supply core in next patches.
> > 
> > When a driver does not use of_node or supplies then it should use NULL
> > as config. If driver uses of_node or supplies then it should allocate
> > config on stack and initialize it with proper values.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > [for the nvec part]
> > Reviewed-by: Marc Dietrich <marvin24@gmx.de>
> > 
> > [for drivers/platform/x86/compal-laptop.c]
> > Reviewed-by: Darren Hart <dvhart@linux.intel.com>
> > ---
> >  drivers/acpi/ac.c                     |  2 +-
> >  drivers/acpi/battery.c                |  3 ++-
> >  drivers/acpi/sbs.c                    |  4 ++--
> >  drivers/hid/hid-input.c               |  2 +-
> >  drivers/hid/hid-sony.c                |  2 +-
> >  drivers/hid/hid-wiimote-modules.c     |  2 +-
> >  drivers/hid/wacom_sys.c               |  5 +++--
> >  drivers/platform/x86/compal-laptop.c  |  2 +-
> >  drivers/power/[...]                   |  lots of changes
> >  drivers/staging/nvec/nvec_power.c     |  7 ++++---
> >  include/linux/power_supply.h          | 16 ++++++++++++++--
> >  67 files changed, 211 insertions(+), 158 deletions(-)
> 
> I would like to merge this via the power supply tree.
> 
> Rafael, Dmitry, are you ok with this change?

Hmm, I do not see anything affecting input here, you want Jiri for HID I
guess...

-- 
Dmitry
