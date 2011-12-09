From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH RFC V2 0/4] Add "scope" to power supplies
Date: Fri,  9 Dec 2011 14:43:15 -0800
Message-ID: <cover.1323454016.git.jeremy@goop.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:35589 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab1LIWnd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Dec 2011 17:43:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Hughes <hughsient@gmail.com>, Daniel Nicoletti <dantti12@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>

This series adds a "scope" attribute to power supplies, to indicate
whether it powers the whole system ("System") or just some subset of
the devices ("Device").  This allows upowerd to distinguish between
system-wide power supplies and self-powered devices such as cordless
mice.

This series also adds a "powers" link to power supplies, so that if
they're scope=Device, they can specifically indicate which device
tree they power.

Updates since last post:
 - Add more complete documentation to scope and "powers" links
 - Remove unnecessary scopes on System power supplies
 - Make HID battery supplies Device, and add "powers" pointers
   for them.

This can also be pulled from:
	git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen.git power-supply-scope

Jeremy Fitzhardinge (4):
  power_supply: add SCOPE attribute to power supplies
  power_supply: allow a power supply to explicitly point to powered
    device
  power_supply: add scope properties to some self-powered HID devices
  power_supply: add "powers" links to self-powered HID devices

 drivers/hid/hid-wacom.c            |   16 ++++++++++++++--
 drivers/hid/hid-wiimote.c          |   10 +++++++++-
 drivers/power/power_supply_core.c  |    7 +++++++
 drivers/power/power_supply_sysfs.c |    6 ++++++
 include/linux/power_supply.h       |    8 ++++++++
 5 files changed, 44 insertions(+), 3 deletions(-)

-- 
1.7.7.3

