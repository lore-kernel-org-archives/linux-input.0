From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH 1/3] Input: psmouse: Remove deprecated
 create_singletheread_workqueue
Date: Sun, 14 Aug 2016 10:53:07 +0530
Message-ID: <83fc8cbf4f5ef7b5e814353468b9ee9d5dd6d7d2.1471151622.git.bhaktipriya96@gmail.com>
References: <cover.1471151622.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1471151622.git.bhaktipriya96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Stefan Assmann <sassmann@kpanic.de>, Richard Pospesel <pospeselr@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>
Cc: Tejun Heo <tj@kernel.org>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

alloc_ordered_workqueue replaces the deprecated
create_singlethread_workqueue.

There are multiple work items on the work queue viz
&priv->dev3_register_work, &priv->recalib_wq, &psmouse->resync_work,
which require execution ordering. Hence, an ordered workqueue has been
used.

The workqueue is not being used on a memory reclaim path.
Hence, WQ_MEM_RECLAIM has not been set.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 5784e20..fb4b185 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1916,7 +1916,7 @@ static int __init psmouse_init(void)
 	synaptics_module_init();
 	hgpk_module_init();

-	kpsmoused_wq = create_singlethread_workqueue("kpsmoused");
+	kpsmoused_wq = alloc_ordered_workqueue("kpsmoused", 0);
 	if (!kpsmoused_wq) {
 		pr_err("failed to create kpsmoused workqueue\n");
 		return -ENOMEM;
--
2.1.4
