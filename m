From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.12-rc6
Date: Sat, 24 Jun 2017 22:49:21 -0700
Message-ID: <20170625054921.GA33226@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35913 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdFYFt1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 25 Jun 2017 01:49:27 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a quirk to i8042 to ignore timeout bit on Lifebook AH544
- a fixup to Synaptics RMI function 54 that was breaking some Dells
- a fix for memory leak in soc_button_array driver

Changelog:
---------

Andrew Duggan (1):
      Input: synaptics-rmi4 - only read the F54 query registers which are used

Daniel Drake (1):
      Input: i8042 - add Fujitsu Lifebook AH544 to notimeout list

Hans de Goede (1):
      Input: soc_button_array - fix leaking the ACPI button descriptor buffer

Diffstat:
--------

 drivers/input/misc/soc_button_array.c | 20 ++++++++++++++------
 drivers/input/rmi4/rmi_f54.c          | 17 +++++++----------
 drivers/input/serio/i8042-x86ia64io.h |  7 +++++++
 3 files changed, 28 insertions(+), 16 deletions(-)

Thanks.


-- 
Dmitry
