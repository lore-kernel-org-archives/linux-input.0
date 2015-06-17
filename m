From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 11/18] drivers/input/gameport: Replace rdtscl() with native_read_tsc()
Date: Tue, 16 Jun 2015 17:35:59 -0700
Message-ID: <9e058e72f4cf1f13c6483c1360b39c3d188a2c2a.1434501121.git.luto@kernel.org>
References: <cover.1434501120.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434501120.git.luto@kernel.org>
In-Reply-To: <cover.1434501120.git.luto@kernel.org>
References: <cover.1434501120.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>, Denys Vlasenko <dvlasenk@redhat.com>, kvm@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

It's unclear to me why this code exists in the first place.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/input/gameport/gameport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index e853a2134680..abc0cb22e750 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -149,9 +149,9 @@ static int old_gameport_measure_speed(struct gameport *gameport)
 
 	for(i = 0; i < 50; i++) {
 		local_irq_save(flags);
-		rdtscl(t1);
+		t1 = native_read_tsc();
 		for (t = 0; t < 50; t++) gameport_read(gameport);
-		rdtscl(t2);
+		t2 = native_read_tsc();
 		local_irq_restore(flags);
 		udelay(i * 10);
 		if (t2 - t1 < tx) tx = t2 - t1;
-- 
2.4.2
