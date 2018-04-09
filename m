From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 5/9] Input: elantech_query_info() can be static
Date: Mon,  9 Apr 2018 11:10:47 +0200
Message-ID: <20180409091051.2944-6-benjamin.tissoires@redhat.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---
new in v2, raised by kbuild test robot
---
 drivers/input/mouse/elantech.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index d485664f1563..980dfd7e861e 100644
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
 
-- 
2.14.3
