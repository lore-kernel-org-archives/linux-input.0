From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/1 v2] DRM: fix radeon suspend/resume oops
Date: Thu, 13 Nov 2008 23:09:56 +0100
Message-ID: <1226614196-17019-1-git-send-email-jirislaby@gmail.com>
References: <491CA495.7010007@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.wellnetcz.com ([212.24.148.102]:52590 "EHLO
	smtp.wellnetcz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbYKMWKp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2008 17:10:45 -0500
In-Reply-To: <491CA495.7010007@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andi Kleen <andi@firstfloor.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>, David Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@sisk.pl>

me wrote:
> As the accesses to the mmio member are not protected by anything, they
> seem to be racy with the open/clsoe anyways, setting this down there
> too.

On the second though it should be protected. Updated patch below...

+ added Rafael to cc list

--

When the driver is bound to a device and nobody opens the device node,
it will oops on suspend and resume, since it's not mapped and
dev_priv->mmio is NULL.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/gpu/drm/radeon/radeon_drv.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 71af746..7672310 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -56,6 +56,9 @@ static int radeon_suspend(struct drm_device *dev, pm_message_t state)
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
 
+	if (!dev_priv->mmio)
+		return 0;
+
 	/* Disable *all* interrupts */
 	if ((dev_priv->flags & RADEON_FAMILY_MASK) >= CHIP_RS690)
 		RADEON_WRITE(R500_DxMODE_INT_MASK, 0);
@@ -67,6 +70,9 @@ static int radeon_resume(struct drm_device *dev)
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
 
+	if (!dev_priv->mmio)
+		return 0;
+
 	/* Restore interrupt registers */
 	if ((dev_priv->flags & RADEON_FAMILY_MASK) >= CHIP_RS690)
 		RADEON_WRITE(R500_DxMODE_INT_MASK, dev_priv->r500_disp_irq_reg);
-- 
1.6.0.3

