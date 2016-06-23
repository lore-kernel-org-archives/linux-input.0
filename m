From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/4] HID: merge support for ThingM blink(1) into
 hid-led
Date: Thu, 23 Jun 2016 08:52:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606230851311.6874@cbobk.fhfr.pm>
References: <dc6bbc8a-4454-fb95-4a98-6266523f320b@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48823 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbcFWGw2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 02:52:28 -0400
In-Reply-To: <dc6bbc8a-4454-fb95-4a98-6266523f320b@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Vivien Didelot <vivien.didelot@savoirfairelinux.com>

On Tue, 21 Jun 2016, Heiner Kallweit wrote:

> The hid-led driver just needs small extensions to support also devices with
> multiple independent LED's. As a first device of this category support for
> the ThingM blink(1) can be merged into the hid-led driver.
> 
> Heiner Kallweit (4):
>   HID: hid-led: add support for devices with multiple independent LEDs
>   HID: hid-led: add support for reading from LED devices
>   HID: hid-led: add support for ThingM blink(1)
>   HID: remove ThingM blink(1) driver
> 
>  drivers/hid/Kconfig      |  17 +---
>  drivers/hid/Makefile     |   1 -
>  drivers/hid/hid-led.c    | 180 ++++++++++++++++++++++++++------
>  drivers/hid/hid-thingm.c | 259 -----------------------------------------------
>  4 files changed, 154 insertions(+), 303 deletions(-)
>  delete mode 100644 drivers/hid/hid-thingm.c

Applied to for-4.8/merge-thingm-into-hid-led. Thanks,

-- 
Jiri Kosina
SUSE Labs

