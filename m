From: Mark Laws <mdl@60hz.org>
Subject: [PATCH] Input: i8042 - Fix console keyboard support on Gen2 Hyper-V VMs
Date: Tue, 19 Apr 2016 00:23:35 +0900
Message-ID: <cover.1460985538.git.mdl@60hz.org>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33133 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbcDRPXz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 11:23:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id e190so17258460pfe.0
        for <linux-input@vger.kernel.org>; Mon, 18 Apr 2016 08:23:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kys@microsoft.com, haiyangz@microsoft.com
Cc: Mark Laws <mdl@60hz.org>, devel@linuxdriverproject.org, linux-input@vger.kernel.org

Hi,

Please keep me Cc:ed in any replies as I'm not on these lists.

Description of the fix is in the commit message for the patch.

Discussion:

Given that most distributions were already statically linking i8042.c,
having it not unload even if there is no i8042 device seems a better fix
than the alternatives:

a) requiring users build a kernel with CONFIG_SERIO_I8042=y;
b) duplicating the needed bits from atkbd.c in hyperv-keyboard, or;
c) this patch, but with a "stay_resident=1" option to enable the
   workaround.  Detecting presence of Hyper-V could be handled by udev,
   which would pass this option, but every distribution would need to
   fix their rules (certainly we don't want to check for Hyper-V in
   i8042.c)

Mark Laws (1):
  Input: i8042 - Fix console keyboard support on Gen2 Hyper-V VMs

 drivers/input/serio/i8042.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

-- 
2.8.0
