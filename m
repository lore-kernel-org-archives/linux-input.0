From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] Tiny modification of i2c-hid
Date: Thu, 13 Oct 2016 11:30:43 +0200
Message-ID: <1476351045-8829-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753226AbcJMJbR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 05:31:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jiri,

David and I are facing an issue in RHEL with the HP Zbook 15 Studio mWS.
This laptops uses the pinctrl-sunrisepoint controller for the GPIOs and
it failed on RHEL. We found out what the issue was, but in the meantime
realized that part of the code we have in i2c-hid is not required anymore.

The actual issue is fixed here: https://lkml.org/lkml/2016/10/12/493
but it would be more convenient (for us) and cleaner (fo everybody) to just
remove the extra boiler-plate in i2c-hid and let i2c-core handling the
attributions of the IRQ.

Cheers,
Benjamin

David Arcari (2):
  Revert "HID: i2c-hid: Add support for ACPI GPIO interrupts"
  HID: i2c-hid: exit if the IRQ is not valid

 drivers/hid/i2c-hid/i2c-hid.c | 78 ++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 53 deletions(-)

-- 
2.7.4

