From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH v3 0/2] Add ROHM BU21023/24 Dual touch support resistive
 touchscreens
Date: Thu, 25 Sep 2014 00:16:47 +0900
Message-ID: <20140925001647.dd48571a3c0ceda5c25ab669@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo-sg1501.iij4u.or.jp ([210.130.239.6]:40076 "EHLO
	mo-sg.iij4u.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbaIXPUa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Sep 2014 11:20:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: yuasa@linux-mips.org, linux-input@vger.kernel.org

Hi Dmitry,

I updated the driver according to your comments.
Do you have any comments?

v3 Changes:
- fix multi touch slots initialization
- fix set_bit BTN_TOUCH
- remove input_unregister_device()
- switch to __set_bit()

v2 Changes:
- remove polling mode
- switch to threaded interrupt
- switch to managed resources
- use MT-B protocol with input_mt_assign_slots
- provide ST emulation
- firmware load and device initialization are shifted at opening the device
- add error handling for IO operations

Yoichi Yuasa (2):
  input: Add ROHM BU21023/24 Dual touch support resistive touchscreens
  input: bu21023_ts: Add calibration function

 drivers/input/touchscreen/Kconfig        |   11 +
 drivers/input/touchscreen/Makefile       |    1 +
 drivers/input/touchscreen/rohm_bu21023.c |  930 ++++++++++++++++++++++++++++++
 drivers/input/touchscreen/rohm_bu21023.h |  258 +++++++++
 4 files changed, 1200 insertions(+)
 create mode 100644 drivers/input/touchscreen/rohm_bu21023.c
 create mode 100644 drivers/input/touchscreen/rohm_bu21023.h

-- 
1.7.9.5

