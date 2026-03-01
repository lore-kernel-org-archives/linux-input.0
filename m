Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809D29B793;
	Sun,  1 Mar 2026 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328693; cv=none; b=ffpkrY6nNN/VJBrQIO+yHI65+tSOjACJNBGYkBO4x9yDsdDoIVz258BTRzRXe5LHnQBfTvdLi+31SPf8zKg2sTKf7XdwSWwUc6xxqlx9oauKkxSu5JWOh5OJ+Gl6WaB8ONCn9TfF2VkK29c4/1zjlFKwZGYI3LOLmdk61nNV0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328693; c=relaxed/simple;
	bh=eO7NyUPjZFuTsLzac0Y0wH1saGYMyQk+JYXxnGJCae0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLmKClvwTPMiXTnK74t4DN0ON4so5b0+M0tc1Nc8d0pmmddfxI9JTCwJ2KSs00dhzfbh1Jy7PJNErrKIF8nM6u4vlEU6w33Dl7D6zmfxIDNL1iLGgZfQ0qzvpBe4v0cLVXKJTizxP6KnuBPNyo9rOv8kVG/erNB5s6XTqRfIO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGbnaq3/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGbnaq3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AEFC19421;
	Sun,  1 Mar 2026 01:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328693;
	bh=eO7NyUPjZFuTsLzac0Y0wH1saGYMyQk+JYXxnGJCae0=;
	h=From:To:Cc:Subject:Date:From;
	b=AGbnaq3/Xt1Hr+PWMOg6rgD/gEwLvGeUnX0rjPwEPklM7EbPAc5SC0NmfE5GkWAHI
	 kfy5RjQZ1G71jN135QGeQh5wbtSgwsiVf/VCQLLkK1YqdkNni8H1l1/VLapNUBXUpT
	 E5CK8NtISGcHgKPvmB3zwyUNvEYUZWa0oo2ZxqSiNpk1+m0wajNmAmKTNoPvUZcwxO
	 x7Ktri9ibjND45tklB71f92MUh9ggnJoQy9sSone4LvRsEOd/k8jucdljD4l1SbtKY
	 gtyn3JOGO3Q5T86sJ/1o2xTYShjY8sHf3jgMRIaNB6jTad/7HTgLursyZc+uvyDtlW
	 6H+2lke5Fc7Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	oneukum@suse.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: hid-pl: handle probe errors" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:31:31 -0500
Message-ID: <20260301013131.1690059-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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




