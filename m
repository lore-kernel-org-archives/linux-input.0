Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F13F8ED3
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145115; cv=none; b=b5kQSZ4F9WUr2hp8xSSt3J40EO5H8zFane9r9kKuI1IoZXu8avDrIMc8/+ImJngx9fP9pE4K+9JiwmbViUwRKy/YE0GUuMFMKMFzmaXkkB6Lug28rujOo53QUmLxPEempIJMiOB7u0IbTpCNESpLIDy+MSOkSXe/cMVP1DZ0Fac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145115; c=relaxed/simple;
	bh=Mk1UEW/0OyJaZjPAehnfBWZnUbujy4bagICuF5X2fMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaZ8FW1w6hXS88f7NXLVgeC7tUh3/X2zu4jQxnrAMe4XJZ63P/+mexf8fP0AtEO6BZ/TYm+SPWDJEHFpILoH19pHxyVp7oIMPJGxHG1LFF+v96qwnO6AC16sDAhsQwWu18eIvm3kDXpMT6kFAul5L05PB6zF9cr8yrYyLePar0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=uo/RVK+T; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="uo/RVK+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786145107; bh=Mk1UEW/0OyJaZjPAehnfBWZnUbujy4bagICuF5X2fMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uo/RVK+TSDNxEmoObEqR8V5s6FYUFeDAGcmG4E2uIJbGQIVRXErKrCBEY8NLoz75H
	 5Rr/3DrGjek1wlYb+i8EOFHj8SRicJidbwWb+JWRK6xk7z9kAiqTOz/G9PycsBz0hA
	 JjjAhv7AeoREhwPtv7SZu/GLXa5Xut4ywU1CUjkTkgFXyUr5TXt4O8oIjiwUa56ILk
	 wW7ad9rKwRqgkwiCHsSfu9u9iCuyjQrbArHj1D9G/dYn3jEgJ05MurUInko4z+Fy5v
	 XX6eDFLY8LCC0xwyipBgD7hE7QytRVRFF+DsWRRQaywwUHgSExU9hFv2UiQxDdrTmF
	 AgsjFDjEQv9fg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id B4196132033;
	Fri, 07 Aug 2026 16:25:06 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 4/6] HID: steam: Don't set feature reports when disconnecting
Date: Fri,  7 Aug 2026 16:23:35 -0700
Message-ID: <20260807232339.2799205-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807232339.2799205-1-vi@endrift.com>
References: <20260807232339.2799205-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an input device is closed, we set a feature report to reset lizard
mode and IMU mode. However, if the input device is closed because it was
removed, then we will necessarily error out when sending this, resulting in
logged errors. Since an error here is expected, we should just fail
silently.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 8d3ef523682b..d95296b28f92 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -490,9 +490,13 @@ static int steam_recv_report_id(struct steam_device *steam,
 	}
 
 	kfree(buf);
-	if (ret < 0)
+	/*
+	 * Don't log if the failure is -ENODEV, as this
+	 * can happen normally on disconnect.
+	 */
+	if (ret < 0 && ret != -ENODEV)
 		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
-	else
+	else if (ret > 0)
 		hid_dbg(steam->hdev, "Received report %*ph\n", size, data);
 	if (ret < 0)
 		return ret;
@@ -570,7 +574,11 @@ static int steam_send_report_id(struct steam_device *steam,
 	} while (--retries);
 
 	kfree(buf);
-	if (ret < 0)
+	/*
+	 * Don't log if the failure is -ENODEV, as this
+	 * can happen normally on disconnect.
+	 */
+	if (ret < 0 && ret != -ENODEV)
 		hid_err(steam->hdev, "%s: error %d (%*ph)\n", __func__,
 				ret, size, cmd);
 	return ret;
-- 
2.54.0

