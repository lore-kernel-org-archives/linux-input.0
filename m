From: Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Scale up touch width and height values
	for Intuos Pro
Date: Wed, 25 Sep 2013 16:22:27 -0700
Message-ID: <1380151347-1031-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxwacom-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxwacom-devel>,
	<mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxwacom-devel>
List-Post: <mailto:linuxwacom-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxwacom-devel>,
	<mailto:linuxwacom-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: linuxwacom-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linuxwacom-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

The width and height values reported by the Intuos Pro are not in
surface units as required by the MT protocol. A simple multiplier
of 100x seems to be approximately correct based on my tests.

Signed-off-by: Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/tablet/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 9c8eded..3f75f1d 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1151,8 +1151,8 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 		int width, height;
 
 		if (features->type >= INTUOSPS && features->type <= INTUOSPL) {
-			width  = data[5];
-			height = data[6];
+			width  = data[5] * 100;
+			height = data[6] * 100;
 		} else {
 			/*
 			 * "a" is a scaled-down area which we assume is
-- 
1.8.4


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
