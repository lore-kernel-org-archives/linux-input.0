From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/6] Complete the mrst touchscreen tidy
Date: Fri, 23 Jul 2010 14:51:43 +0100
Message-ID: <20100723134852.19151.6999.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1810 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759189Ab0GWOYM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jul 2010 10:24:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: greg@kroah.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

If these are all ok it can then move from staging
---

Alan Cox (1):
      mrst_touchscreen: clean up input side

Alek Du (1):
      *	Register platform interface

Andy Ross (1):
      Simplify en/disable of interrupts for NEC.

Arjan van de Ven (2):
      fix channel allocation in the touch screen driver
      mrst-touchscreen: Fix use before initialize in mrst_touch   [Fix bug 2561]

Dmitry Torokhov (1):
      Input: mrst - more fixes


 drivers/staging/Makefile                           |    2 
 drivers/staging/mrst-touchscreen/Kconfig           |    2 
 drivers/staging/mrst-touchscreen/Makefile          |    2 
 drivers/staging/mrst-touchscreen/TODO              |    2 
 drivers/staging/mrst-touchscreen/intel-mid-touch.c |  941 ++++++++------------
 5 files changed, 384 insertions(+), 565 deletions(-)

--
"What they forget is their girlfriends don't care if they've got a brand new
 iPhone4, they care if they remember to phone..." 

