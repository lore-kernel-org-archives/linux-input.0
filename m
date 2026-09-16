Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242D36165E
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524218; cv=none; b=RSRs6/zjBm79yKOK6Twmahv3mRt+PWeZn1FWVURNLFjhCWGS3R+6WZ5v+epaOzveMf7GMZEjhZQqF/M8pH/wscseS5xEGM8fE/iVrqYqf2859h80PR6NU/Lkmv79bPlFK32JmdsdKa7F69muuawfF8CWTXVWUBzDB9Kh+KBti04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524218; c=relaxed/simple;
	bh=vzEInW3AILDtlCuTp6PU+V5lfdFdMa8AXK+R69RJOuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tB2SWIPhlFJpjUiDvOCPWi65FZMeNlJj4NCkEOeZNVau7e/vquz57UcNDyxjmNJtaXoB40RFDagM5jiEy93R1ohAy4s4vG31pJu/ElcBEi3HODQ2vGM6TklK1hvmEYAMGuGWP/a+Vpz8C1Bo4Pp50Hl1HNciGkQXoVNTapwgT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkp2oKW0; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkp2oKW0"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea48edcso304320a12.2
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 19:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789524202; x=1790129002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2boQb5kVerPgWQfFRWhmiEpNAxPJICHNL8sN5LeSsMw=;
        b=dkp2oKW0igKNZ4jxqOti1XEs3CjRTJxnxLYZZfYFMQd9WEiZHAOVUhw2MafMnur0/V
         Ur+sIj3kNH9CiHoyEWnYFF1viiQNX8g7l7+j8j2/iFqAM7SIvBbwG9NRTkvY9I/E1VjH
         qGZEVVZPYnGU26v3dtn5Nvtrpd0rq78dd9ku6KT3mFGUqKkauwu2R1ApmMEGANWtzDB6
         ssr15dfDm38Sr9q0GDkOFiQTSULPUksH+fn/XmP2aGuDRDTknoj7qWnSfQE6JgMw4k06
         SaOuMUh0veHj101UiAn+Y2ko32JCzk63xSB2XNYTdAjMwGLx34mIbePN6w+86m3mrzZ/
         K15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789524202; x=1790129002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2boQb5kVerPgWQfFRWhmiEpNAxPJICHNL8sN5LeSsMw=;
        b=UwkIqRwSSN8OToPEgzjbRUFN+J2uraET0+ToPg1PAPp+DGAZrkd6BUolJ957bxUSNI
         T2Q2Luys9cM4ytnHwNcahpoReVCA1L39sfvINBJQn/4YZj7klQ+2fpxHkcoXmmhJ2LAi
         85TwGS53AlzbCqsfZUNtdXbKuPDelCs8k7p0NJQVCaY6DYah7IGvW+bWz+3CMX21ynm2
         wd2whOkkKxsL4d8JmUbcpmlpjhLzLZrEt5987iejSk/2tappOzNEtK6gn07SXqy1lLa4
         X3MTUK8Jkbq5AUfjIpkth2nq2/5mwsxdXMpA5qGX8NI/diQEvjDfL0cP4mgPgXbjFKrI
         4xcw==
X-Forwarded-Encrypted: i=1; AKwUvBypia2vBjLOFb74lODLjFxJCdSQj0trtnJbfC/T5521DGbB2rIwI+1pk4fSPTjNVQV/+NZfLltgONcdMw==@vger.kernel.org
X-Gm-Message-State: AFuF++k5gP1PsrlQogQA3JaU88xXIOV6nxx5+GzSdSbZ3SrJn1D9ooOF
	06pNBEr2nDtvL8tjbnbOVeBO13gIx3g4GBBoKBL6TuhN1QZigF1WYP4s
X-Gm-Gg: AYBFou2xWibPK9fkabcbxmktrxIMsNKWReBYnd7eFEVRE263WPtwjtHTCbl1AEIbSWj
	Pk0zVHxilm+x/4YCbtvctyp68k8Qnv4nfbOtqJpivkZotFK/oej1Lv4uVXc8uXg3+Jp8mfZDPIZ
	FvjhvnyVeOhT2DbYVtM6ydfjihq9rdXT+XFPH6ioj95YwGlDOZn7gdWFnPHohvJjQ3R6xtAlwkk
	GMWUO0TQOiHevmIA+WeZ7Ix18iysxT7PYI0ornwV/lIKyOpHuEyge6u5Lt0TTtZHFrAUOcOsV7D
	/2//2C8IyfCn2bE9i+Z9bthWDJjnexzwAZdn+dR5mBvO4epvvNDNwNhyC2pZPd8vnYK4phfLO8c
	UM2DoQDvfchBin4bXj5UCDeYHptY9WIZutQ0afp2eT40+pzChOaca852yTnNVT+5CwRhzoET6h2
	ZvQkeWgmaBaAuuG5BX2zXsBTsDZ25+G3++irgARnrcKr9eVnYFQMP7nD0Arw1Bw2vBllej
X-Received: by 2002:a17:90a:d650:b0:39d:f7dd:4e4f with SMTP id 98e67ed59e1d1-39e1e300ab8mr1990954a91.10.1789524202169;
        Tue, 15 Sep 2026 19:03:22 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:83e3:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b3dcf6dsm1505898a91.1.2026.09.15.19.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:03:21 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 1/2] Write shared touch initial status only once
Date: Tue, 15 Sep 2026 19:03:01 -0700
Message-ID: <20260916020301.24188-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping Cheng <ping.cheng@wacom.com>

To match the same logic as with other shared data during registeration,
use WRITE_ONCE for is_touch_on too.

Cc: stable@vger.kernel.org
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8dc7aa1c0a26..33fa491fba92 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 		 * match historic default.
 		 */
 		if (wacom_wac->is_soft_touch_switch)
-			wacom_wac->shared->is_touch_on = true;
+			WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-- 
2.55.0

