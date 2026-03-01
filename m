Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7FA2F39B8;
	Sun,  1 Mar 2026 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329262; cv=none; b=i1HtEuBxeRZSxVeTnY8EI0oQF/GeNhdAyoB5u45yXUl+7x3jsadfzsbjIhuVH6CAOcYEhtdy7h9u4s05qmrDZ2svKkB4j1ddl5JGs/pH6A8KL4Nu6vabAmfr+3c3siVGq1ky/XddmnmK0bDFd5XY8J/5s+HjFpXFbLargUtGl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329262; c=relaxed/simple;
	bh=Jp3xrx6O6Tc5hBGyNEwDmw6vSIID8FxLKlp2Kn7Sr5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohmccRWNd2jU2tJyg+7x+1eIhu4PqQZ6bxTPSw0cneGE/1PuoM6LT8Nxia3Oc2hTmt0fARFmrg3F4Krb7Dz5au+kV9JwRGltTUdzk0YX0Y+OXR+GkP5JbS7eq0UNOPD1SIERqZ3qe3+F3D2j/cl5L+UdxYg/w1BPN/BkeLr3Eh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJmbWrhj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJmbWrhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041C1C19421;
	Sun,  1 Mar 2026 01:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329262;
	bh=Jp3xrx6O6Tc5hBGyNEwDmw6vSIID8FxLKlp2Kn7Sr5E=;
	h=From:To:Cc:Subject:Date:From;
	b=IJmbWrhjtbyyjU75MAXIjoO5195fi6I9i4/S4cwW0vilEUZhppkN1wt3KZFl1sL5D
	 XQUOHQrgD+Vbp9uxuEZZqRYlUhp6YBwq/tMcj2TEC6gQg8sScz1J7+BdQ4AunniJu4
	 3xJKVI2zAfkFIdkUyz4k3A3eM7zzyNco0ajRpXX9gvXwvuOZfvS2Ob+5FPQOlHUT+E
	 0IbgJlUqEW8t/QFDu481CmWgoXJkcMME89mBACF5LutXthqIjFxA/6TM++TOC3/qKQ
	 0COU2OBr1sPKSkuCB3bSXDJDNMl8dnXeTeA0Y4/iMtvQkdNsCDkCD7k9gB7s/eQ0/R
	 vCeF2WlBNQE2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	oneukum@suse.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: hid-pl: handle probe errors" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:41:00 -0500
Message-ID: <20260301014100.1702470-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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




