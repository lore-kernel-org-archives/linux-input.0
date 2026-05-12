Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96AE3128B8;
	Tue, 12 May 2026 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603217; cv=none; b=kmKFJY8Ln00omjUOY/IvHMgMX03FLCctV/MG3em3AGShvguIMHc2giIluBXzmRskljtCyVUd2Hco3tDjsAu6hA9meZdQB9MeYtYohI6YL39eGVB+gCJI++PwXDIVjp2dgn8MXez7oK2Mo2kRiP8k2JO9OGzdwJO7ng8pxcywoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603217; c=relaxed/simple;
	bh=CrjnqKrl9EXY2GuxK9ACnCl+sFPD2qsuimDGOTo/0sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WHMczZ9mGneQuInR6FFzWiYOCvXwVn1+QU+lrzxw7kkjxmUi5A8Ak1cWsviERURb1UxJ1nHnCwvHkkJIhsznws97AOZAN3aFhGjtE53lujmuLbNsqaZL9shjQm05IP0JBQX5dz4YMyX/puxLYcoFQFXJ/SZ/dYHnHY5b92T85kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKg2CEOj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKg2CEOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C057C2BCB0;
	Tue, 12 May 2026 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778603217;
	bh=CrjnqKrl9EXY2GuxK9ACnCl+sFPD2qsuimDGOTo/0sw=;
	h=From:To:Cc:Subject:Date:From;
	b=PKg2CEOjUacZ1A7y5f9DRbkRnSGk9J/2hyDSrR6qDNeoJIAAdfdieRjGgsIxjddSj
	 Po9ZqdaTmRwZC0bsm6ukcYUM1idnWKHp1XsAZfv/3KCHiMGES0omnb8oOc2sVfTVt1
	 FLLgCRZH/GX7uHrnY/EA3V2A0c5szABQoNq70Q1nOEl95sdOsA0DpUrss0CQNv9NBp
	 pZFSGtHZow25Q/VFg6uiS3QaQV5k1mJoxBLuSnMKBQYyC4iIgNAJoWGxPyc1YSZ+C9
	 Otf0AD4aaQ5b2xxTgye1rSf8I5P8xTLjwAyexavDtOSEm84YEDyF61d3pPelJB+IMQ
	 9zdFEg/fYK2aA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] Input: atlas - Check ACPI_COMPANION() against NULL
Date: Tue, 12 May 2026 18:26:54 +0200
Message-ID: <8696590.T7Z3S40VBb@rafael.j.wysocki>
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

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
atlas_btns driver.

Fixes: b8303880b641 ("Input: atlas - convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/input/misc/atlas_btns.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -60,11 +60,15 @@ static acpi_status acpi_atlas_button_han
 
 static int atlas_acpi_button_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device;
 	acpi_status status;
 	int i;
 	int err;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	input_dev = input_allocate_device();
 	if (!input_dev) {
 		pr_err("unable to allocate input device\n");



