Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201330E830;
	Sun,  1 Mar 2026 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329769; cv=none; b=ibE71U+UUp8q64Llzx0sxcARBRgQ0VUzoUEQWCrD/7WDi08BxvliNGpuvoHtKmbpcSaGNWO7Hg+KGDvL31YncbwdRUTHWs8rSZqg2KIQCFC6rP1H7Ev2tziiC1Su00ggmbuOofWLrkC4n3TCneVk4fv6AkY23pMmCkOkal3H57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329769; c=relaxed/simple;
	bh=dDXSLP8cYSa7q3bAaiuJEXBoTU9AS++TRpSrD48zZBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToykIr7OBKPL6X2sC+F33O7Buh63/PcQdeV+7KJ0d325M4hF1ESrlu50tRqtG+g5eI+71ww7i/mmjobirZoat39mOUs+gNNa6mEDbcca0IfJe9FuTLkefBl1fHaa7JvOyqntzYAW+uQ0y2GgdruriwcIfwuZxgxElU/zpePfWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4ej8cky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4ej8cky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F2BC2BC87;
	Sun,  1 Mar 2026 01:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329769;
	bh=dDXSLP8cYSa7q3bAaiuJEXBoTU9AS++TRpSrD48zZBg=;
	h=From:To:Cc:Subject:Date:From;
	b=Y4ej8ckybPO2jVb2mQetQu9x5+4VDMFhI+pisnvKLAfwVBAeq+L5ilYgN57RDEwDq
	 feUo3CBhiuqfu1GgxKSWs8qfFN5xEJxGT4MWr296xaZNiX/b7cGZIbnCRDHYeeru8C
	 mdpHx/mHDd3DCqmTC8tpjKgWqqUmLXvX7Nsdqk3htLhmMm341G9ltDR1BHrsDgoNhE
	 DX4RqP9/0t1fcOeQo6EvNPYfgCZAGi0g4M3NNZgKfN6gPAEJ+LpUpMfi0DwR5hkq+Y
	 e5bP/eUYg2oJVfhACms3d7pRGiZRmTWg0YoZONOdfvgYV8NHuQKRM2KzVK2b8RqzAM
	 paP742LXY6jjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	oneukum@suse.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: hid-pl: handle probe errors" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:49:27 -0500
Message-ID: <20260301014927.1713957-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3756a272d2cf356d2203da8474d173257f5f8521 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Wed, 19 Nov 2025 10:09:57 +0100
Subject: [PATCH] HID: hid-pl: handle probe errors

Errors in init must be reported back or we'll
follow a NULL pointer the first time FF is used.

Fixes: 20eb127906709 ("hid: force feedback driver for PantherLord USB/PS2 2in1 Adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-pl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index 3c8827081deae..dc11d5322fc0f 100644
--- a/drivers/hid/hid-pl.c
+++ b/drivers/hid/hid-pl.c
@@ -194,9 +194,14 @@ static int pl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err;
 	}
 
-	plff_init(hdev);
+	ret = plff_init(hdev);
+	if (ret)
+		goto stop;
 
 	return 0;
+
+stop:
+	hid_hw_stop(hdev);
 err:
 	return ret;
 }
-- 
2.51.0




