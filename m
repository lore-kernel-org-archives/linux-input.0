From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH v4 0/2] Avoid selftests on some Asus models
Date: Sun, 25 Sep 2016 10:25:42 -0300
Message-ID: <1474809944-7357-1-git-send-email-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36332 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966236AbcIYN0G (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 25 Sep 2016 09:26:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Hi guys,

this is my forth iteration in this patch. I hope now this address all problems
and, at least, most Asus models affect by this problem.

All models affected by this problem:
A455LD
K401LB
K501LB
K501LX
R409L
V502LX
X302LA
X450LCP
X450LD
X455LAB
X455LDB
X455LF
Z450LA

Changes since v3:
Add back all Asus models, instead of the dump decision of avoiding selftests in 
all Asus laptops

Changes since v2:
Avoid selftest in all Asus laptops

Changes since v1:
Change kernel parameter i8042.reset to accept different values, instead of creating
a new kernel parameter.

Please let me know if there is something that needs more polishment.

Thanks!

Marcos Paulo de Souza (2):
  input/serio/i8042.c: Skipt selftest on ASUS laptops
  kernel-parameters: Update i8042.reset parameter documentation

 Documentation/kernel-parameters.txt   |  7 ++-
 drivers/input/serio/i8042-x86ia64io.h | 94 ++++++++++++++++++++++++++++++++++-
 drivers/input/serio/i8042.c           | 38 +++++++++++---
 3 files changed, 130 insertions(+), 9 deletions(-)

-- 
2.7.4

