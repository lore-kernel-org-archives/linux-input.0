From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v1  0/1] Input: elantech - fix absolute mode setting on some Asus touchpads cover
Date: Wed, 25 Mar 2015 22:27:54 +0100
Message-ID: <1427318875-12142-1-git-send-email-ulrik.debie-os@e2big.org>
References: <20150325203428.GA24094@lantern>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:48886 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbbCYV2h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2015 17:28:37 -0400
In-Reply-To: <20150325203428.GA24094@lantern>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, ulrik.debie-os@e2big.org, George Moutsopoulos <gmoutso@yahoo.co.uk>

Just one patch here ...
Patch 1 fixes problems on some Asus touchpads where set_rate sets the register
reg_07 to 0, which disables the absolute mode setting and makes the touchpad
unusable. This was seen in 3 different scenario's:
1) At startup or module load, the touchpad did not work. Value of reg_07 becomes 0.
2) When writing the content of the sysfs touchpad rate file again to the same
file (or any different value most probably), the touchpad does not work 
anymore.The value of reg_07 in the hardware becomes 0.
3) When returning from suspend to sleep, the touchpad dos not work anymore.
The value of reg_07 in the hardware becomes 0.

When writing again a 1 to the sysfs reg_07 file, the touchpad works (again).

Ulrik De Bie (1):
  Input: elantech - fix absolute mode setting on some Asus touchpads

 drivers/input/mouse/elantech.c | 22 ++++++++++++++++++++++
 drivers/input/mouse/elantech.h |  1 +
 2 files changed, 23 insertions(+)

-- 
2.1.4

