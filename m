From: dev-harsh1998 <harshitjain6751@gmail.com>
Subject: [PATCH 07/11] touchscreen: mc13783: Use octal permissions
Date: Sun, 22 Jul 2018 00:39:47 +0530
Message-ID: <20180721191029.25658-6-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Shyti <andi@etezian.org>, Simon Budig <simon.budig@kernelconcepts.de>, Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
+module_param(sample_tolerance, uint, S_IRUGO | S_IWUSR);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/mc13783_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index ef64f36c5ffc..4e33349f101e 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -25,9 +25,9 @@
 #define DEFAULT_SAMPLE_TOLERANCE 300
 
 static unsigned int sample_tolerance = DEFAULT_SAMPLE_TOLERANCE;
-module_param(sample_tolerance, uint, S_IRUGO | S_IWUSR);
+module_param(sample_tolerance, uint, 0644);
 MODULE_PARM_DESC(sample_tolerance,
-		"If the minimal and maximal value read out for one axis (out "
+		"If the minimal and maximum value read out for one axis (out "
 		"of three) differ by this value (default: "
 		__stringify(DEFAULT_SAMPLE_TOLERANCE) ") or more, the reading "
 		"is supposed to be wrong and is discarded.  Set to 0 to "
-- 
2.17.1
