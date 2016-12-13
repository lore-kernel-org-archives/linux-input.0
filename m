From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: i8042 - force synchronous probing of PNP drivers
Date: Tue, 13 Dec 2016 09:56:32 -0800
Message-ID: <20161213175632.GA12528@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34061 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933939AbcLMR4g (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Dec 2016 12:56:36 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org

We rely on the result of scanning PNP bus for keyboard and mouse devices to
decide whether we should continue initialization of i8042 driver or not, so
the probes can not be asynchronous.

Also, it is not a good idea to unbind either of the PNP devices while i8042
is running, so let's disable bind/unbind for the PNP drivers through sysfs
and rely on i8042 cleaning after itself properly. User can still unbind and
rebind entire i8042 and that will take care of PNP drivers as well.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 2503d01..79daea84 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -925,6 +925,10 @@ static struct pnp_driver i8042_pnp_kbd_driver = {
 	.name           = "i8042 kbd",
 	.id_table       = pnp_kbd_devids,
 	.probe          = i8042_pnp_kbd_probe,
+	.driver         = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+		.suppress_bind_attrs = true,
+	},
 };
 
 static struct pnp_device_id pnp_aux_devids[] = {
@@ -947,6 +951,10 @@ static struct pnp_driver i8042_pnp_aux_driver = {
 	.name           = "i8042 aux",
 	.id_table       = pnp_aux_devids,
 	.probe          = i8042_pnp_aux_probe,
+	.driver         = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+		.suppress_bind_attrs = true,
+	},
 };
 
 static void i8042_pnp_exit(void)
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
