Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160217DE36;
	Sat, 14 Mar 2026 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489305; cv=none; b=nOjTQzjqhs0ZNZzl8rnRRF8lXzi2n0Lv0R204Lep0Njnz+tfTE8/NHBXws4vaSJXlSEgWdsFMAQTSMMZNZ0QGMMUYO4MTaKCFPcYuXynWDzMSrbGwjSnl+qCJiqej3OPBTO2CQ/9zAxNRNZo+ElFaExxQoUauK//ntvkVvD+/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489305; c=relaxed/simple;
	bh=pJOgOKhqYkMyCu3jpWPb5CRX7PU/edD4vnnMkvMLZDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MgZHlpi6IWYEbeDqYqJicf4wZvlxlwcKu91oy7lKYG8LMa/cq1zABfxiUan9tMLG2Ht3EGUICd649KwgoBqfgX7m7aStOjzx+x01NwSXTr9i4XWWjcspX8C/GacX9oh5yE6CMTTDXCx4T2Iist5N6XUIIQOUC4fRYAJL5OiY/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJUeW6pn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJUeW6pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E02C116C6;
	Sat, 14 Mar 2026 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773489305;
	bh=pJOgOKhqYkMyCu3jpWPb5CRX7PU/edD4vnnMkvMLZDc=;
	h=From:To:Cc:Subject:Date:From;
	b=iJUeW6pnknR925xaWcYFMKyPsxK2IhmMP3ZML7KUz9n2Grc/tc0f6D3Ztm2j4PJWO
	 aEz0Hh8fgBwihZYG1Cuor6zF80QTm5z1jH3iJzCUgTYyAVmuWKfycoeJloZjQfOe3f
	 kcK7wKXUzuyEmXdFyNj/1UvxfmoUV1xVY2hD2YrzjB372OHpnU6g8CQUe9iIQV+bUG
	 xgTnYhxP0yFgfaSLzAYaQ5UTWgw3eRrC+NCQ7IHNR3L/2dA/w6rF4/d91fcjOO4iuo
	 8rx7DxZkvhXn1yLrUU+D40yEGwGXyXur47xNjahmIS5lFy+CRCH5GC2Q0XNAW0EjjW
	 8I3pfmEiGt7GA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH v1] Input: atlas - convert ACPI driver to a platform one
Date: Sat, 14 Mar 2026 12:54:58 +0100
Message-ID: <3429591.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ACPI Atlas button driver to a platform
one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/input/misc/atlas_btns.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 5b9be2957746..47b31725e850 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -14,6 +14,7 @@
 #include <linux/input.h>
 #include <linux/types.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
 
 #define ACPI_ATLAS_NAME		"Atlas ACPI"
@@ -57,8 +58,9 @@ static acpi_status acpi_atlas_button_handler(u32 function,
 	return status;
 }
 
-static int atlas_acpi_button_add(struct acpi_device *device)
+static int atlas_acpi_button_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 	int i;
 	int err;
@@ -106,8 +108,9 @@ static int atlas_acpi_button_add(struct acpi_device *device)
 	return err;
 }
 
-static void atlas_acpi_button_remove(struct acpi_device *device)
+static void atlas_acpi_button_remove(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 
 	status = acpi_remove_address_space_handler(device->handle,
@@ -124,16 +127,15 @@ static const struct acpi_device_id atlas_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, atlas_device_ids);
 
-static struct acpi_driver atlas_acpi_driver = {
-	.name	= ACPI_ATLAS_NAME,
-	.class	= ACPI_ATLAS_CLASS,
-	.ids	= atlas_device_ids,
-	.ops	= {
-		.add	= atlas_acpi_button_add,
-		.remove	= atlas_acpi_button_remove,
+static struct platform_driver atlas_acpi_driver = {
+	.probe = atlas_acpi_button_probe,
+	.remove = atlas_acpi_button_remove,
+	.driver = {
+		.name = ACPI_ATLAS_NAME,
+		.acpi_match_table = atlas_device_ids,
 	},
 };
-module_acpi_driver(atlas_acpi_driver);
+module_platform_driver(atlas_acpi_driver);
 
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
-- 
2.51.0




