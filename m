From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC] input: hil_mlc - Fix hil_mlc_serio_id file2alias
 failure
Date: Tue, 12 Oct 2010 21:17:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1010122111270.6491@ayla.of.borg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Dzianis Kahanovich <mahatma@eu.by>, Dmitry Torokhov <dtor@mail.ru>, Helge Deller <deller@gmx.de>
Cc: linux-next@vger.kernel.org, linux-input@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-parisc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Commit e288bf7c346360ac9dafbc1b6d7b6b1a82b51616 ("Input: HIL keyboard and
serio - add missing MODULE_DEVICE_TABLE()") caused the following build
failure on m68k/allmodconfig:

FATAL: drivers/input/serio/hil_mlc: struct serio_device_id is not terminated with a NULL entry!

hil_mlc_serio_id is not an array, but a single struct serio_device_id entry.
Fix the build by converting it into an array, and adding a NULL entry.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Build failure in linux-next:
http://kisskb.ellerman.id.au/kisskb/buildresult/3385851/

I'm not sure this is the right fix, as hil_mlc_serio_id is a catch-all ID.
Perhaps the MODULE_DEVICE_TABLE() should just be removed again instead?

 drivers/input/serio/hil_mlc.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index cc8e01f..43904db 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -897,11 +897,15 @@ static void hil_mlc_serio_close(struct serio *serio)
 	/* TODO wake up interruptable */
 }
 
-static const struct serio_device_id hil_mlc_serio_id = {
-	.type = SERIO_HIL_MLC,
-	.proto = SERIO_HIL,
-	.extra = SERIO_ANY,
-	.id = SERIO_ANY,
+static const struct serio_device_id hil_mlc_serio_ids[] = {
+	{
+	    /* There's only one ID, which is a catch-all */
+	    .type = SERIO_HIL_MLC,
+	    .proto = SERIO_HIL,
+	    .extra = SERIO_ANY,
+	    .id = SERIO_ANY,
+	},
+	{ 0 }
 };
 
 int hil_mlc_register(hil_mlc *mlc)
@@ -934,7 +938,7 @@ int hil_mlc_register(hil_mlc *mlc)
 		mlc->serio[i] = mlc_serio;
 		snprintf(mlc_serio->name, sizeof(mlc_serio->name)-1, "HIL_SERIO%d", i);
 		snprintf(mlc_serio->phys, sizeof(mlc_serio->phys)-1, "HIL%d", i);
-		mlc_serio->id			= hil_mlc_serio_id;
+		mlc_serio->id			= hil_mlc_serio_ids[0];
 		mlc_serio->id.id		= i; /* HIL port no. */
 		mlc_serio->write		= hil_mlc_serio_write;
 		mlc_serio->open			= hil_mlc_serio_open;
@@ -1011,7 +1015,7 @@ static void __exit hil_mlc_exit(void)
 }
 
 
-MODULE_DEVICE_TABLE(serio, hil_mlc_serio_id);
+MODULE_DEVICE_TABLE(serio, hil_mlc_serio_ids);
 
 module_init(hil_mlc_init);
 module_exit(hil_mlc_exit);
-- 
1.7.0.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
