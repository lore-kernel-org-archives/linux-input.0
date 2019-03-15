From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [Xen-devel][PATCH] Input: xen-kbdfront - signal the backend that we disconnect
Date: Fri, 15 Mar 2019 11:23:48 +0200
Message-ID: <20190315092348.32613-1-andr2000@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jgross@suse.com, boris.ostrovsky@oracle.com
Cc: andr2000@gmail.com, Volodymyr_Babchuk@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

While disconnecting from the backend we clean up shared resources
(event channel, ring buffer), but never let the backend know about
that. This may lead to inconsistent backend state and/or shared
resources use.
Fix this by explicitly letting the backend know that frontend has
destroyed shared resources by changing its Xen bus state accordingly.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/input/misc/xen-kbdfront.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 24bc5c5d876f..ecb6e719e0e2 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -488,6 +488,8 @@ static int xenkbd_connect_backend(struct xenbus_device *dev,
 
 static void xenkbd_disconnect_backend(struct xenkbd_info *info)
 {
+	xenbus_switch_state(info->xbdev, XenbusStateClosing);
+
 	if (info->irq >= 0)
 		unbind_from_irqhandler(info->irq, info);
 	info->irq = -1;
-- 
2.21.0
