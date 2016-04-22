From: Mark Laws <mdl@60hz.org>
Subject: [PATCH] Input: i8042 - Fix console keyboard support on Gen2 Hyper-V VMs
Date: Fri, 22 Apr 2016 22:00:59 +0900
Message-ID: <1461330060-35567-1-git-send-email-mdl@60hz.org>
References: <CADemMPMSYfdbt5U6mgj=kdbBQKP_nWrah3M5ZuyZZk6soWJGjg@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34109 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbcDVNBZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Apr 2016 09:01:25 -0400
Received: by mail-pa0-f68.google.com with SMTP id yl2so6248085pac.1
        for <linux-input@vger.kernel.org>; Fri, 22 Apr 2016 06:01:24 -0700 (PDT)
In-Reply-To: <CADemMPMSYfdbt5U6mgj=kdbBQKP_nWrah3M5ZuyZZk6soWJGjg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: haiyangz@microsoft.com
Cc: Mark Laws <mdl@60hz.org>, devel@linuxdriverproject.org, linux-input@vger.kernel.org

This is an updated version of the original patch from this thread.  It
fixes the style issues Dan Carpenter brought up.

Mark Laws (1):
  Input: i8042 - Fix console keyboard support on Gen2 Hyper-V VMs

 drivers/input/serio/i8042.c | 50 ++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 16 deletions(-)

-- 
2.8.0

