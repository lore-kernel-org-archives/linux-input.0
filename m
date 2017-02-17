From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.10-rc8
Date: Fri, 17 Feb 2017 09:18:22 -0800
Message-ID: <20170217171822.GA13050@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34236 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934122AbdBQRS0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Feb 2017 12:18:26 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem: just a single change to Elan
touchpad driver to recognize a new ACPI ID.

Changelog:
---------

IHARA Hiroka (1):
      Input: elan_i2c - add ELAN0605 to the ACPI table


Diffstat:
--------

 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Dmitry

