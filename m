From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.13-rc5
Date: Thu, 17 Aug 2017 13:40:14 -0700
Message-ID: <20170817204014.GA16870@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33874 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdHQUkS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 16:40:18 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

KT Liao (1):
      Input: elan_i2c - Add antoher Lenovo ACPI ID for upcoming Lenovo NB

Kai-Heng Feng (1):
      Input: elan_i2c - add ELAN0608 to the ACPI table

Oscar Campos (1):
      Input: trackpoint - assume 3 buttons when buttons detection fails

Diffstat:
--------

 drivers/input/mouse/elan_i2c_core.c | 4 ++++
 drivers/input/mouse/trackpoint.c    | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

Thanks.


-- 
Dmitry
