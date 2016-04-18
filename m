From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/5] fixes for twl6040-vibra
Date: Mon, 18 Apr 2016 21:55:36 +0200
Message-ID: <cover.1461009340.git.hns@goldelico.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:8420 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbcDRTzt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 15:55:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org

There are some small bugs in the twl6040-vibra driver and differences to how twl4030 vibra works.

This patch series addresses them.


H. Nikolaus Schaller (5):
  input: twl6040-vibra: fix DT node memory management
  input: twl6040-vibra: add handler to unregister input if module is
    removed
  input: twl6040-vibra: fix NULL pointer dereference by removing
    workqueue
  input: twl6040-vibra: ignore return value of schedule_work
  input: twl6040-vibra: remove mutex

 drivers/input/misc/twl6040-vibra.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

-- 
2.7.3

