From: Ferruh Yigit <fery@cypress.com>
Subject: [PATCH 2/2] Input: cyttsp - add missing handshake
Date: Fri, 10 May 2013 16:32:49 +0300
Message-ID: <1368192769-24067-2-git-send-email-fery@cypress.com>
References: <1368192769-24067-1-git-send-email-fery@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay-s04-hub003.domainlocalhost.com ([74.115.207.102]:20857
	"EHLO relay-S04-HUB003.domainlocalhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752868Ab3EJNiU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 May 2013 09:38:20 -0400
In-Reply-To: <1368192769-24067-1-git-send-email-fery@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: ttdrivers@cypress.com, Ferruh Yigit <fery@cypress.com>, Javier Martinez Canillas <javier@dowhile0.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

For the devices that has blocking with timeout communication, these
extra handshakes will prevent one timeout delay in startup sequence

Tested-by: Ferruh Yigit <fery@cypress.com> on TMA300-DVK
Signed-off-by: Ferruh Yigit <fery@cypress.com>
---
 drivers/input/touchscreen/cyttsp_core.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 97ba891..7007f58 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -116,6 +116,13 @@ static int ttsp_send_command(struct cyttsp *ts, u8 cmd)
        return ttsp_write_block_data(ts, CY_REG_BASE, sizeof(cmd), &cmd);
 }

+static int _cyttsp_hndshk(struct cyttsp *ts, u8 hst_mode)
+{
+       if (ts->pdata->use_hndshk)
+               return ttsp_send_command(ts, hst_mode ^ CY_HNDSHK_BIT);
+       return 0;
+}
+
 static int cyttsp_load_bl_regs(struct cyttsp *ts)
 {
        memset(&ts->bl_data, 0, sizeof(ts->bl_data));
@@ -167,6 +174,10 @@ static int cyttsp_set_operational_mode(struct cyttsp *ts)
        if (error)
                return error;

+       error = _cyttsp_hndshk(ts, ts->xy_data.hst_mode);
+       if (error)
+               return error;
+
        return ts->xy_data.act_dist == CY_ACT_DIST_DFLT ? -EIO : 0;
 }

@@ -188,6 +199,10 @@ static int cyttsp_set_sysinfo_mode(struct cyttsp *ts)
        if (error)
                return error;

+       error = _cyttsp_hndshk(ts, ts->sysinfo_data.hst_mode);
+       if (error)
+               return error;
+
        if (!ts->sysinfo_data.tts_verh && !ts->sysinfo_data.tts_verl)
                return -EIO;

@@ -344,12 +359,9 @@ static irqreturn_t cyttsp_irq(int irq, void *handle)
                goto out;

        /* provide flow control handshake */
-       if (ts->pdata->use_hndshk) {
-               error = ttsp_send_command(ts,
-                               ts->xy_data.hst_mode ^ CY_HNDSHK_BIT);
-               if (error)
-                       goto out;
-       }
+       error = _cyttsp_hndshk(ts, ts->xy_data.hst_mode);
+       if (error)
+               goto out;

        if (unlikely(ts->state == CY_IDLE_STATE))
                goto out;
--
1.7.9.5

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
