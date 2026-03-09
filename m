Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D023D75BA;
	Mon,  9 Mar 2026 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068831; cv=none; b=JtbpLEELY+REbWQisWeI0nX69a/IKLa5DxoH31yNDHs5L1ak/IdD0c4+R/hTqnNIbl96lzzam4M0RUoCLjgiBpS+C4bAmVi0VEEnX0jdoC8e7Vh4RoDC9ZITkDspNgoczZtNnBudMNjJwhJ3HvFbFRQWulNEtgmt/OEN9q/mK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068831; c=relaxed/simple;
	bh=8nmU1jGFyFRy7QLyer6K+iyNw+3jcpVxO5/C5I37K4k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QK9C2jr5JwxXU/faS9IDSvjnyvxrzsdBl/NsqDhUIswAd0xOoVejvguEM9dK0lMgWR3GfKuXztPYb6Y8YWljpubTHMTLlZ5KMtmE0Y9MOop863BGml+2ogWvR3BjaT0pGuHUu47BLI2dbqaCAk3voAyN9wiO3XfT4DDhSO3Wx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCF0SzL7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCF0SzL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07604C4CEF7;
	Mon,  9 Mar 2026 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773068831;
	bh=8nmU1jGFyFRy7QLyer6K+iyNw+3jcpVxO5/C5I37K4k=;
	h=From:To:Subject:Date:From;
	b=GCF0SzL7ouGihFPHjz6hxVpm8I7RX7cUxcpCiFSwBBl20+ooXX5JG0Sm4nTvYTKR6
	 ZtlVJX2EU2ef8WQ9l+GhwYc+TfnHiPPJ7Xn99kf8quAoRsJ8K09QrC/9GuBw9EaUBV
	 KJIYw2xouZMBZN6MlTX/soohhX+u2ma1WyW4H6jONn4YeI8T9wtucc9sL0cE1qvHoa
	 I9DcqilFUr8z1miu1Z4uRFpUJ+BHNjSn/xh2V9SiaAwlVSaVp9NmuOuc+T3M7X9XG6
	 vE8lmyA93a9fjLZTGMgcLf3xN3WL+F2jig/FztUcq92k5ThbM94WNU+Dus4ZVNbUsS
	 QlSOv4/C/At+A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC v3 1/2] HID: core: Mitigate potential OOB by removing bogus memset()
Date: Mon,  9 Mar 2026 14:59:29 +0000
Message-ID: <20260309145942.1496072-1-lee@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memset() in hid_report_raw_event() has the good intention of
clearing out bogus data by zeroing the area from the end of the incoming
data string to the assumed end of the buffer.  However, as we have
previously seen, doing so can easily result in OOB reads and writes in
the subsequent thread of execution.

The current suggestion from one of the HID maintainers is to remove the
memset() and simply return if the incoming event buffer size is not
large enough to fill the associated report.

Suggested-by Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 -> v3: Instead of removing the check entirely, show a warning and return early

RFC query: Is it better to return SUCCESS or -EINVAL?

 drivers/hid/hid-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5b3a8ca2fcb..da9231ca42bc 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2057,9 +2057,9 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (csize < rsize) {
-		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
-				csize, rsize);
-		memset(cdata + csize, 0, rsize - csize);
+		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
+				     report->id, rsize, csize);
+		goto out;
 	}
 
 	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
-- 
2.53.0.473.g4a7958ca14-goog

