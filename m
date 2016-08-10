From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCHv3 0/2] Skip selftest on Asus laptops
Date: Wed, 10 Aug 2016 00:25:43 -0300
Message-ID: <1470799545-1102-1-git-send-email-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35777 "EHLO
	mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932538AbcHJD0P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Aug 2016 23:26:15 -0400
Received: by mail-qt0-f193.google.com with SMTP id q11so1231325qtb.2
        for <linux-input@vger.kernel.org>; Tue, 09 Aug 2016 20:26:15 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

So, here we are, third version.

Changes since v2:
* Due to the number of devices with problems related to selftest, let's
  disable selftest for any laptop device
* Fix condition on reset/resume calls of i8042 controller
Changes since v1: 
* Use reset parameter, instead of adding reset_mode parameter.
* Change reset parameter from bool to unsigned int.

Please let me know if I missed something.

Marcos Paulo de Souza (2):
  kernel-parameters: Update i8042.reset parameter documentation
  input/serio/i8042.c: Skipt selftest on ASUS laptops

 Documentation/kernel-parameters.txt   |  7 ++++++-
 drivers/input/serio/i8042-x86ia64io.h | 21 +++++++++++++++++--
 drivers/input/serio/i8042.c           | 38 +++++++++++++++++++++++++++++------
 3 files changed, 57 insertions(+), 9 deletions(-)

-- 
2.7.4

