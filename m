Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBA3B895D
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030986; cv=none; b=e9ZNiOOnTnUmiBB8D/wKn2uxzWE+ANWiD/AzY/jnnMxf6+cUgQQlbGJW4DNTkXleq4AeJFw2A6HsCnt7BRvpukkBdkELeqnxU1EejIn2H1PqtEBeimSs+BbIqHjECQdw8UUq5tXw2wYGz0DVzL5t5U5UQJ2Cwm3AbUVFxHaqPm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030986; c=relaxed/simple;
	bh=MmjSefjqqE8Ddc9vpSec4Qbn1Vi6ljlz/x0ma6qyBmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkWRDVUg2I04J66kr1VgY4t2txR7GgcE/NCDuqfN8YzQ5VR05J5GvsKpzDYEQn3a6zI9ENzjUtgTHJz/oJqKRf6PtSfqjKwZCguMdwgBSiWCwShOB8KeZPYNqTg9YDQBZ2VU6IykSjGDcwE/h1JZG2m04pZU5NbreGqLlKNGxjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=JmIRDvY/; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="JmIRDvY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783030984; bh=MmjSefjqqE8Ddc9vpSec4Qbn1Vi6ljlz/x0ma6qyBmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmIRDvY/Mua0mFw/Aj1zT/n561ZVvXNkclf0wGes8q/IK9uwaZXHAMdVGLR9KwAGB
	 ZWkfP47SECehjSQBV5G8m2UJ5iYcINqL7FADv1QaFW2cOXlbrMeBAAEr3WtUlD3+am
	 aCF+JoWob2BwOkHJTa+9ujIf14Y2AppDUqAwh8qWonftVj0A+K7hVDpN8j2g0H9znV
	 l2y5t/MkVtSprSx0LNgJ7m2xa0MjQsh6y0j1Gab6+mF0CTkEtNLhluMxxnXIssUrfv
	 //D32wLFQTpoBLjiTQaVJId0Ius2dB5MMaJui1TH9A89vE/MxbCxvnIi6iCgufbzWV
	 0A+1Po3P3TQOA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 7320BA0F9;
	Thu, 02 Jul 2026 15:23:04 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>,
	syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Subject: [PATCH 09/10] HID: steam: Reject short reads
Date: Thu,  2 Jul 2026 15:21:42 -0700
Message-ID: <20260702222145.1863104-9-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702222145.1863104-1-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Steam Controller FEATURE reports encode the size of the message in the
message itself. Previously we were trusting that the size reported matched
the size we actually read, leading to a potential issue with short reads.
Instead, we should actually verify the length of the read.

Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=75f3f9bff8c510602d36

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 593151709cf1..e97431bc2828 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -389,6 +389,12 @@ static int steam_recv_report(struct steam_device *steam,
 		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
 	else
 		hid_dbg(steam->hdev, "Received report %*ph\n", ret, data);
+
+	if (ret >= 2 && data[1] > ret + 2) {
+		hid_err(steam->hdev, "%s: expected %u bytes, read %i\n",
+				__func__, data[1] + 2, ret);
+		return -EPROTO;
+	}
 	return ret;
 }
 
-- 
2.54.0

