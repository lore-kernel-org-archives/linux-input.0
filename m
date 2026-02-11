Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A01534EC;
	Wed, 11 Feb 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828041; cv=none; b=HAKHYqsPc9Wf57jMSnB6pATnc4gWpmyi/w8g8o21T2HcrleLz9ZXXUuMWO7/Gv2L7DwcRkZrE1rKqr5mt3zFf+I0gl/NRhEku5HxHohMCvxEJMuxz92Sl4JGag9NBFMLPSPktKTl0kgR6YNP9UKuZtI3iZw+cXe6pjpy85eA3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828041; c=relaxed/simple;
	bh=lXF7lb5Tcc9RIDtlkfYug7BxS/76Zgj+VgkT3dy+gmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XA3zmABr817Oth1pFnZwK3+toVThlygWN/arGEVXe+grdObLuDTxhIKuBHH63wAuPp6iZWIoqwaIbyh19s3YmGy0I151pgYvk8cNNSFiglv31U7TcekSaYRePA16BNEzmZdPTaUc3PHtRcoeCP9X5ulFW+mSVhzKDz5neL9xkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR9DOoMT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR9DOoMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A667C4CEF7;
	Wed, 11 Feb 2026 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770828041;
	bh=lXF7lb5Tcc9RIDtlkfYug7BxS/76Zgj+VgkT3dy+gmw=;
	h=From:To:Cc:Subject:Date:From;
	b=VR9DOoMT7h8wNgyCeB32ZHMkd+cdgQ98kvk8eo0Tzqbdyn1UHsS78FSCoG20JEQmf
	 TdyQIP2P/vV/teaIAd6UqCFLu8kcaoaEbx0XyEUmvxmqlAEfpDurvj90mxQ0saDrvD
	 4PBY3fl1nbSpUTihHnTHqhfv/R/xRrOZs8SPmf4SIXKAzf+KevFH8zxu0/mHTrgLrq
	 0ADzNqY55AsoE6wvrpAn4bw9ct5i8gPtLV9uNGD1KvvOC6QXT5PZgHicOsHepsW0eI
	 cE6FhEulekgU6ZCGb3UAE6YcY+pULnxfoAOOrDIekqMs46HT42num5HXyNL1ERQ38g
	 VJkZnhb/7IjIg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	David Rheinsberg <david@readahead.eu>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw events mismanagement
Date: Wed, 11 Feb 2026 16:40:24 +0000
Message-ID: <20260211164025.171242-1-lee@kernel.org>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the report ID is located within the data buffer, overwriting it
would mean that any subsequent matching could cause a disparity in
assumed allocated buffer size.  This in turn could trivially result in
an out-of-bounds condition.  To mitigate this issue, let's refuse to
overwrite a given report's data area if the ID in get_report_reply
doesn't match.

Cc: stable@vger.kernel.org
Fixes: fcfcf0deb89ec ("HID: uhid: implement feature requests")
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/uhid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 21a70420151e..a0ee4e86656f 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -262,6 +262,10 @@ static int uhid_hid_get_report(struct hid_device *hid, unsigned char rnum,
 	req = &uhid->report_buf.u.get_report_reply;
 	if (req->err) {
 		ret = -EIO;
+	} else if (rnum != req->data[0]) {
+		hid_err(hid, "Report ID mismatch - refusing to overwrite the data buffer\n");
+		ret = -EINVAL;
+		goto unlock;
 	} else {
 		ret = min3(count, (size_t)req->size, (size_t)UHID_DATA_MAX);
 		memcpy(buf, req->data, ret);
-- 
2.53.0.273.g2a3d683680-goog

