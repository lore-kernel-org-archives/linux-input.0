Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AC33557B;
	Mon, 16 Mar 2026 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684722; cv=none; b=U25PPF05COeE+qNPfPhq4xs/Xxu4Ae4oiQeUQD1rsSVxe69Nq9okW/PshgvEaVtHmzDlGn34sloxwOIBjMQ1mlK4+S8ALeDa+I0UtfbvmNi/S8F8YyfhAEn6okEpYeRr1T7XoQo+G80pFAjdGbkCP/j1LmeGK8KwVzFpj8VNLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684722; c=relaxed/simple;
	bh=uuHtxwMK92FAeGlqaRP+FAD+ZSVh3DZAEiYD1F+E7Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfOCYT4YNspM1jyZZPsSz+zDM++hcfcwu9z2EOQCpYEcG72E8LdV3OaKo+oNZU0EWAz38vONV+WsRBGk08ff00EhFsiCmVMvLwTPh5KuQLpDSndbybUJSSfaCtOL11BCFUylxIpZZjGbBCohkXShj81N6ajoIEnxDpXVcxYzksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C87C19421;
	Mon, 16 Mar 2026 18:12:01 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: sentelic: fix comment typo
Date: Mon, 16 Mar 2026 14:12:00 -0400
Message-ID: <20260316181200.146681-1-joseph.salisbury@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file contains a spelling error in a source comment (formating).

Typos in comments reduce readability and make text searches less reliable
for developers and maintainers.

Replace 'formating' with 'formatting' in the affected comment. This is a
comment-only cleanup and does not change behavior.

Fixes: fc69f4a6af49 ("Input: add new driver for Sentelic Finger Sensing Pad")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
---
 drivers/input/mouse/sentelic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
index 02cac0e7ad63..9ba3631e3d0f 100644
--- a/drivers/input/mouse/sentelic.h
+++ b/drivers/input/mouse/sentelic.h
@@ -60,7 +60,7 @@
 #define	FSP_REG_SN1		(0x41)
 #define	FSP_REG_SN2		(0x42)
 
-/* Finger-sensing Pad packet formating related definitions */
+/* Finger-sensing Pad packet formatting related definitions */
 
 /* absolute packet type */
 #define	FSP_PKT_TYPE_NORMAL	(0x00)
-- 
2.47.3

