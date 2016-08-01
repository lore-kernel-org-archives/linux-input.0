From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH v2 0/2] Skip i8042 selftest on some ASUS laptops
Date: Mon,  1 Aug 2016 08:14:01 -0300
Message-ID: <1470050043-4403-1-git-send-email-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33579 "EHLO
	mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbcHALPh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Aug 2016 07:15:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Hi guys,

second version of the patch, addressing comments of Dmitry.

Changes since v1: 
Use reset parameter, instead of adding reset_mode parameter.
Change reset parameter from bool to unsigned int.

Marcos Paulo de Souza (2):
  input/serio/i8042.c: Skipt selftest on some ASUS laptops
  kernel-parameters: Update i8042.reset parameter documentation

 Documentation/kernel-parameters.txt   |  7 +++-
 drivers/input/serio/i8042-x86ia64io.h | 70 ++++++++++++++++++++++++++++++++++-
 drivers/input/serio/i8042.c           | 38 ++++++++++++++++---
 3 files changed, 106 insertions(+), 9 deletions(-)

-- 
2.7.4

