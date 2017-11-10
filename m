From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.14-rc8
Date: Thu, 9 Nov 2017 23:44:00 -0800
Message-ID: <20171110074400.oxsabo23rmrtqbdy@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:53824 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdKJHoE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Nov 2017 02:44:04 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a new ACPI ID for Elan touchpad found in yet another Ideapad model;

- Synaptics RMI4 will allow binding to controllers reporting SMB version
  3 (note that we are not adding any new ACPI IDs to the Synaptics PS/2
  drover so unless user explicitly enables intertouch support there is
  no user-visible change);

- a fixup to TSC 2004/5 touchscreen driver to mark input devices as
  "direct" to help userspace identify the type of device they are
  dealing with.

Changelog:
---------

Kai-Heng Feng (1):
      Input: elan_i2c - add ELAN060C to the ACPI table

Martin Kepplinger (1):
      Input: tsc200x-core - set INPUT_PROP_DIRECT

Yiannis Marangos (1):
      Input: synaptics-rmi4 - RMI4 can also use SMBUS version 3

Diffstat:
--------

 drivers/input/mouse/elan_i2c_core.c      | 1 +
 drivers/input/rmi4/rmi_smbus.c           | 4 ++--
 drivers/input/touchscreen/tsc200x-core.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

Thanks.


-- 
Dmitry
