From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH 0/2] Fix elantech touchpad after suspend/resume
Date: Mon, 25 Jul 2016 14:27:25 -0300
Message-ID: <1469467645-2602-1-git-send-email-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35496 "EHLO
	mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbcGYR1x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 13:27:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, aurelien@francillon.net, rafael.j.wysocki@intel.com, tiwai@suse.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Hi guys,

this is an attempt to fix problem os Asus laptops which touchpads
stop to work after a suspend/resume. It's kind of a big hammer, but I couldn't
find any other way to do it.

As described in the first patch, when i8042 controller receives a selftest in some
models of elantech touchpads, the elantech driver fails to detect the device.

Is there any other alternative to fix this problem in a more elegant way?

Thanks,

Marcos Paulo de Souza (2):
  input/serio/i8042: Skip selftest on i8042 controller in some ASUS
    laptops
  kernel-parameters.txt: Add new entry for i8042.noselftest

 Documentation/kernel-parameters.txt   |  3 ++
 drivers/input/serio/i8042-x86ia64io.h | 57 +++++++++++++++++++++++++++++++++++
 drivers/input/serio/i8042.c           | 10 ++++++
 3 files changed, 70 insertions(+)

-- 
2.7.4

