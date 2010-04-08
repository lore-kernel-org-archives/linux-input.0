From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: [PATCH 2/8] V4L/DVB: ir: Make sure that the spinlocks are properly
 initialized
Date: Thu, 8 Apr 2010 16:37:17 -0300
Message-ID: <20100408163717.678b350d@pedra>
References: <cover.1270754989.git.mchehab@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1270754989.git.mchehab@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Some spinlocks are not properly initialized on ir core:

[  471.714132] BUG: spinlock bad magic on CPU#0, modprobe/1899
[  471.719838]  lock: f92a08ac, .magic: 00000000, .owner: <none>/-1, .o=
wner_cpu: 0
[  471.727301] Pid: 1899, comm: modprobe Not tainted 2.6.33 #36
[  471.733062] Call Trace:
[  471.735537]  [<c1498793>] ? printk+0x1d/0x22
[  471.739866]  [<c12694e3>] spin_bug+0xa3/0xf0
[  471.744224]  [<c126962d>] do_raw_spin_lock+0x7d/0x160
[  471.749364]  [<f92a01ff>] ? ir_rc5_register+0x6f/0xf0 [ir_rc5_decode=
r]

So, use static initialization for the static spinlocks, instead of the
dynamic ones (currently used), as proposed by David H=E4rdeman on one
of his RFC patches.

Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

diff --git a/drivers/media/IR/ir-nec-decoder.c b/drivers/media/IR/ir-ne=
c-decoder.c
index 9d1ada9..48a86cc 100644
--- a/drivers/media/IR/ir-nec-decoder.c
+++ b/drivers/media/IR/ir-nec-decoder.c
@@ -25,7 +25,7 @@
=20
 /* Used to register nec_decoder clients */
 static LIST_HEAD(decoder_list);
-static spinlock_t decoder_lock;
+DEFINE_SPINLOCK(decoder_lock);
=20
 enum nec_state {
 	STATE_INACTIVE,
diff --git a/drivers/media/IR/ir-raw-event.c b/drivers/media/IR/ir-raw-=
event.c
index 57990a3..4ba7074 100644
--- a/drivers/media/IR/ir-raw-event.c
+++ b/drivers/media/IR/ir-raw-event.c
@@ -21,7 +21,7 @@
=20
 /* Used to handle IR raw handler extensions */
 static LIST_HEAD(ir_raw_handler_list);
-static spinlock_t ir_raw_handler_lock;
+DEFINE_SPINLOCK(ir_raw_handler_lock);
=20
 /**
  * RUN_DECODER()	- runs an operation on all IR decoders
@@ -205,8 +205,6 @@ static void init_decoders(struct work_struct *work)
=20
 void ir_raw_init(void)
 {
-	spin_lock_init(&ir_raw_handler_lock);
-
 #ifdef MODULE
 	INIT_WORK(&wq_load, init_decoders);
 	schedule_work(&wq_load);
diff --git a/drivers/media/IR/ir-rc5-decoder.c b/drivers/media/IR/ir-rc=
5-decoder.c
index a62277b..b8a33ae 100644
--- a/drivers/media/IR/ir-rc5-decoder.c
+++ b/drivers/media/IR/ir-rc5-decoder.c
@@ -29,7 +29,7 @@ static unsigned int ir_rc5_remote_gap =3D 888888;
=20
 /* Used to register rc5_decoder clients */
 static LIST_HEAD(decoder_list);
-static spinlock_t decoder_lock;
+DEFINE_SPINLOCK(decoder_lock);
=20
 enum rc5_state {
 	STATE_INACTIVE,
diff --git a/drivers/media/IR/rc-map.c b/drivers/media/IR/rc-map.c
index 2f6201c..38b3489 100644
--- a/drivers/media/IR/rc-map.c
+++ b/drivers/media/IR/rc-map.c
@@ -17,8 +17,7 @@
=20
 /* Used to handle IR raw handler extensions */
 static LIST_HEAD(rc_map_list);
-static spinlock_t rc_map_lock;
-
+DEFINE_SPINLOCK(rc_map_lock);
=20
 static struct rc_keymap *seek_rc_map(const char *name)
 {
--=20
1.6.6.1
