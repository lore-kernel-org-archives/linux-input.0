From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] Input: hid_cmd_state can be static
Date: Wed, 13 Dec 2017 19:37:50 +0800
Message-ID: <20171213113750.GA51727@ivb43.lkp.intel.com>
References: <20171201153957.13053-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201153957.13053-2-mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com
List-Id: linux-input@vger.kernel.org


Fixes: 68d0bd1e4815 ("Input: Add driver for Cypress Generation 5 touchscreen")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 cyttsp5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index a41feea..9694ae41 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -139,7 +139,7 @@ struct cyttsp5_sensing_conf_data {
 	u8 max_tch;
 };
 
-enum { HID_CMD_DONE, HID_CMD_BUSY } hid_cmd_state;
+static enum { HID_CMD_DONE, HID_CMD_BUSY } hid_cmd_state;
 
 enum cyttsp5_tch_abs {	/* for ordering within the extracted touch data array */
 	CY_TCH_X,	/* X */
