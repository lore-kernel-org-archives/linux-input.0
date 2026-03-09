Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887B3D6CC8;
	Mon,  9 Mar 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068837; cv=none; b=ZERCzSrQ6dNYGKnyDa7MTLBMvJL8GU5DcSigoEVSDOoDzc5DjpnkxdMop88XwBfKorOsKSBnsK1goyo2RuOoe3b8PAPuj7RlRCak/92rn1HgEOujvEdq1lWh/rDYuNLW1+1X1oOFdbMJDgfh37OgPLCZaABtIX6WkQhcL36/Ro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068837; c=relaxed/simple;
	bh=S+HKxU/hjf6DLXbJXSe2bZQyzmmFgt+v5tRrw4ErU+M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eG+3Np151NAzmE/r3Zx+s3gyx92LjAg2Lh1sVpV4vZ8Pl7E7ot2+dd1yDg9XrZX463XJH6dLKDahshMS8GcDpcZKB83Ar+GQacskGSUborwd0v4FphN3pMc8PhhOGt+fEKiRGgSQUPrUap+5nRwJ4ISvaslZ36NMZE0pTBq3ekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTvmHz76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTvmHz76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9549C4CEF7;
	Mon,  9 Mar 2026 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773068837;
	bh=S+HKxU/hjf6DLXbJXSe2bZQyzmmFgt+v5tRrw4ErU+M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HTvmHz76/QxbRZlTR92j/36nVPg9Qs8rXWhgetpOnLTSpHAFb+Izkka3uDQkDo9FE
	 M/IkZYa/fMTv4oytT+J9j7RuAIZuuzkYux8NBbMCeQJ2i0K6mo1PsuylS0pN4DM+Ok
	 hGfk9MkKjExCmv9cbz76CZAOJ4IdjyyBi7zGow0Ij8K1iuradIKaszYmOIy+AxrGWN
	 YrnbrWg+l6ueBtFWiYzidzyWxmjEUKTBjPJ1tCNV/QCCHrY7WpfipF75JgQ/rorXfs
	 LhqOsMuSmwLy8ARAXkpK3mOyNFstY9XXKRuQNwZmr9MgZK3QoclT4jwLS7clKGjfEZ
	 QMVqgI3aN52NQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC v3 2/2] HID: core: Check to ensure report responses match the request
Date: Mon,  9 Mar 2026 14:59:30 +0000
Message-ID: <20260309145942.1496072-2-lee@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260309145942.1496072-1-lee@kernel.org>
References: <20260309145942.1496072-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for a malicious (or clumsy) device to respond to a
specific report's feature request using a completely different report
ID.  This can cause confusion in the HID core resulting in nasty
side-effects such as OOB writes.

Add a check to ensure that the report ID in the response, matches the
one that was requested.

Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 -> v3: Cover more bases by moving the check up a layer from MT to HID Core

RFC query: Is this always okay?
           Should the report number always match the request?
	   Are there legitimate times where the two would differ?

 drivers/hid/hid-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index da9231ca42bc..da4078554331 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2490,8 +2490,17 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
-	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
-					    rtype, reqtype);
+	ret = hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
+					   rtype, reqtype);
+	if (ret)
+		return ret;
+
+	if (reportnum != buf[0]) {
+		hid_err(hdev, "Returned feature report did not match the request\n");
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 /**
-- 
2.53.0.473.g4a7958ca14-goog

