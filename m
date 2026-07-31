Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03B45628C;
	Fri, 31 Jul 2026 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521624; cv=none; b=AKKL3vwNvvTm8IoazkEI/f0itRQ8pwykz6628tIqRLBLML1xY5rnqo+MR/+pEMEPVHub1rmgBEAofYUf2uClUL/EFuPNy5d3VGE6nqsKVpqnU3KHHMoAv9OxRylr4JKIhCCVceUWks984k9FIfmgWF/FxRazMB9/BjGH/wGut2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521624; c=relaxed/simple;
	bh=nxKCitRBdhRFYrqzR4Nz0UpPkFjaxXyXjUdCT7aiPK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIpBIP4W/8hCZmk1dk1dzLF4a0ZtfXolY2waO1iPBTFUKUvscomo4D/A+8rpy5B82BXd+En7NhvwxCypuhqhxoyXk084YlRPNjgo16evORzOFT+OTnTfphn/KoUJ5DITNMN34hweEgJisBewNAH/+NEAe8tILYOeJ+NmYN0CC9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q49+8U3P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q49+8U3P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9749EC2BCF5;
	Fri, 31 Jul 2026 18:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785521623;
	bh=nxKCitRBdhRFYrqzR4Nz0UpPkFjaxXyXjUdCT7aiPK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q49+8U3P+wZpNKZbOltnCftjC520D2sdQ7izxAbDN7kea/S1bEMh31nvsGzRWHYuo
	 zgSLVOec1Vq9jNpszH76WRvRLlsl5lz4sAGpQqOHL9kfpyf54xxHS6Z8ChymUkRdB/
	 2hNqIVwj33TIKue7YhaEGJRhy+F6iX2dQycakDJT7IUwGG/8FN5rU5xIACsunmBivf
	 6EQGG3C+mzFN70EZmEsC2FxnPLlVJojV4ET9yOJD4kza86mD8B9xEMnhA9REqefF+H
	 pTC3Qb26qyPdLi7Blyx4ggeaUvDhX6FQMBUYj/T5xrOlwWIupsVQTfj5jH/yp/m3NS
	 U5g92NGxll9NQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F28C55175;
	Fri, 31 Jul 2026 18:13:43 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 31 Jul 2026 20:13:42 +0200
Subject: [PATCH 2/2] Input: rmi4 - fallback to platform data for x/y-mm in
 F12
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-respect-x-y-mm-v1-2-3e85a4bec745@ixit.cz>
References: <20260731-respect-x-y-mm-v1-0-3e85a4bec745@ixit.cz>
In-Reply-To: <20260731-respect-x-y-mm-v1-0-3e85a4bec745@ixit.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=FHkjKLPSxXK4iS4yiWmJ/MFTnc2JaT4CfcKwjt/EYzk=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqbOXWzlXUJRaASEN9halIiggO1xueDsO71jPpA
 SVyrkG0wXKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCamzl1gAKCRBgAj/E00kg
 cv5OEACEXcIpioN0gy0GimILBfxT0MBmMM1g67cEX+Mp6G+zGgPDV33FddT1ZiQe5xJcDiK7ZN0
 dXgxHIZ+e6BVPI2708brv8GvDnNCUNQock4bvxQ9K3gmU7p8bgLO2C8qI0JaDsndWXUoZx3uI3R
 3mGhiP6Ijva99By/1MQzyRDkgym1yyi2lzmqvfH4/eAT/USZMBCOGXUZlupeoNbZq/N36rz2SPg
 x2xKpSD3pfKM3BEaTfmcBEv++kaj8iNPqGFsPk+JwIFoTZAQR88CRZpbmOeyc9yGgPTEiOX7Ikq
 a1qHqDeMDsRUUFfAmk21QId/jpyuYLUlg6UrLrd9bSuyztfNNNDE5XwlRaj7emLATe75+l0zg7h
 KDnEDBivGv0QvDEgRoUewiDQ8ecSJhRHCvWv+WL288joZF+mqLR+mn6jdUD54N3gk/S11F80EzS
 AETXWwZ8noHXnhQ0Hu/exB3+CeuI7yz4ja5pextQFm9k+EGa7b7bc4+4xG0CYolDXqowlQGTcsr
 W4Ony28qAQlWl2epBxfN5t1FFnKrNtzmaaz/kVFcGdbpmVuST5cKOCwGUadJpeLhofzZth8FWig
 G8/XFTTiYMWcCHa0piHA7ZJRyBUpVu5uDFLwcWbou4L4MKUcGn/nFG4vyS7vhlPDdIyVPl3NV9V
 kxTDhhSFC1zr3fQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

When detection for touchscreen-x-mm / y-mm returns 0, fallback to the
platform data, so we get meaningful values.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/rmi4/rmi_f12.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 88797556e738c..6f2e98c3a3499 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -194,18 +194,29 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 			 "platform data x_mm (%d) != detected x_mm: (%d)\n",
 			 sensor->x_mm, x_mm);
 
 	if (sensor->y_mm && sensor->y_mm != y_mm)
 		dev_warn(&fn->dev,
 			 "platform data y_mm (%d) != detected y_mm: (%d)\n",
 			 sensor->y_mm, y_mm);
 
-	sensor->x_mm = x_mm;
-	sensor->y_mm = y_mm;
+	if (x_mm)
+		sensor->x_mm = x_mm;
+	else
+		dev_warn(&fn->dev,
+			 "x_mm detection returned 0, keeping %d\n",
+			 sensor->x_mm);
+
+	if (y_mm)
+		sensor->y_mm = y_mm;
+	else
+		dev_warn(&fn->dev,
+			 "y_mm detection returned 0, keeping %d\n",
+			 sensor->y_mm);
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: x_mm: %d y_mm: %d\n", __func__,
 		sensor->x_mm, sensor->y_mm);
 
 	return 0;
 }
 
 static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1, u32 size)

-- 
2.53.0


