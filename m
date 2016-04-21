From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/4] fixes for twl6040-vibra
Date: Thu, 21 Apr 2016 13:43:46 +0200
Message-ID: <cover.1461239029.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-input@vger.kernel.org

Changes V2:
* remove 2 patches already accepted
* keep DT memory management patch until we know if there is a better solution in the library
* suggestions by Dmitry Torokhov:
	* add cancel_work to make removal of mutex safe
	* replace "unregister handler" patch by "do not reparent" patch
* new: add fix for atomic schedule bug

V1: 2016-04-18 21:55:44: There are some small bugs in the twl6040-vibra driver and differences to how twl4030 vibra works.

This patch series addresses them.


Dmitry Torokhov (1):
  Input: twl6040-vibra - do not reparent to grandparent

H. Nikolaus Schaller (3):
  input: twl6040-vibra: fix DT node memory management
  input: twl6040-vibra: remove mutex
  input: twl6040-vibra: fix atomic schedule panic

 drivers/input/misc/twl6040-vibra.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

-- 
2.7.3
