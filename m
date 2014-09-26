From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/6] mfd: core: fix platform-device id generation
Date: Fri, 26 Sep 2014 12:55:33 +0200
Message-ID: <1411728933-13351-7-git-send-email-johan@kernel.org>
References: <1411728933-13351-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411728933-13351-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-input@vger.kernel.org

Make sure to always honour multi-function devices registered with
PLATFORM_DEVID_NONE (-1) or PLATFORM_DEVID_AUTO (-2) as id base. In this
case it does not make sense to append the cell id to the mfd-id base and
potentially change the requested behaviour.

Specifically this will allow multi-function devices to be registered
with PLATFORM_DEVID_AUTO while still having non-zero cell ids.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mfd/mfd-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 892d343193ad..79f25633d7db 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -87,9 +87,15 @@ static int mfd_add_device(struct device *parent, int id,
 	struct platform_device *pdev;
 	struct device_node *np = NULL;
 	int ret = -ENOMEM;
+	int platform_id;
 	int r;
 
-	pdev = platform_device_alloc(cell->name, id + cell->id);
+	if (id < 0)
+		platform_id = id;
+	else
+		platform_id = id + cell->id;
+
+	pdev = platform_device_alloc(cell->name, platform_id);
 	if (!pdev)
 		goto fail_alloc;
 
-- 
1.8.5.5
