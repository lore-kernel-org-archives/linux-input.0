From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] Input: elantech_query_info() can be static
Date: Fri, 6 Apr 2018 15:33:28 +0800
Message-ID: <20180406073328.GA79481@lkp-ib04>
References: <20180405132537.3218-5-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180405132537.3218-5-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org


Fixes: 3fedcdbcc4b9 ("Input: elantech - split device info into a separate structure")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 elantech.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index d485664..980dfd7 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1662,8 +1662,8 @@ static int elantech_set_properties(struct elantech_device_info *info)
 	return 0;
 }
 
-int elantech_query_info(struct psmouse *psmouse,
-			struct elantech_device_info *info)
+static int elantech_query_info(struct psmouse *psmouse,
+			       struct elantech_device_info *info)
 {
 	unsigned char param[3];
 
