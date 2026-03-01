Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625ED2727FC;
	Sun,  1 Mar 2026 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330391; cv=none; b=mYZRZsQowp8fxUoilSZ2d9FI7sm4U8YHh4coAae2p6+7Id6iMF3xWPG9lCQWt+FbzO5oDlmagTHq4Rw6I4LFG2x3/FBgfhKkxWSlh3+owlNus7rMNXroYcDJ8jHBcnd3zn7GJXVfgMojljQoRgzzdjmCwu8zrJIBSoTynUAC++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330391; c=relaxed/simple;
	bh=YjDGEw5vwwsV14ENCA8lbhSwQ/D3oZEiXwrwsQsnOMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caIfSEYzjapnv6pBSkrsDcv3K1HFJm88q0qNYXgFsv/5KQqrfRi+GMzyh6ACA28DYsa2/qAYBqwt2um4b85FIdBCJDVSILpVNGVLxup5Z4vDhztfPiFvQ8fd1e37a9KQP/xq3sHxR983N54+AkcLxplvy1YPPEPMB/LKpk/+vgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiRKQ8MC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiRKQ8MC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C417DC19421;
	Sun,  1 Mar 2026 01:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330391;
	bh=YjDGEw5vwwsV14ENCA8lbhSwQ/D3oZEiXwrwsQsnOMo=;
	h=From:To:Cc:Subject:Date:From;
	b=tiRKQ8MCaqiAfuQnQMnJCs/bZRcce32Kq/Wn/1nwgXM/5lo60YUptEt5EaxH+Z4pO
	 nSY8c0NFK8uVg3rsEkzgJ6k/mCN7I4605dXq16OcgsFmbLrY3jhIYaGnP3peAKPRxw
	 hXZkZbFgI1lrJRo537Nz5EIq1uXqbywP72JD8skYlNLzai537D4EHGxD3lxtWHdlgM
	 wfUuWhanrjwvc7Mr9w5IESSENWFNbf6GZ/GWsW9yQ+GHscSgdlLOAb4pMT8tOlIFDq
	 TlTUrLeufFj8F5ezAvQ/gE0AIhgsxOuy90POEofI4B2CBF3hrgPPNcZwMxRc6KpxE+
	 V3Xpn7P8+7y0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	oneukum@suse.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: hid-pl: handle probe errors" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 20:59:49 -0500
Message-ID: <20260301015949.1725703-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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




