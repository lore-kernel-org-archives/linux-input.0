Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812584207A;
	Tue, 24 Mar 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363029; cv=none; b=Po3+s0VhuhBGytH7D3h1MBYiCwzmnOdtsh/v05j8ZKSMEm4b1QVCK7mvbGfunBy3/VdO+w1dg7spNviwy9ID/5kxF0t+c/gg/TbdaEX2nYbNK2KWEQe2UFPaZf0Bvv6/MFdoh4mLAMzo93N3k+zmQnwvZNkSvUgEJlEud1B79XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363029; c=relaxed/simple;
	bh=j0QFlw9eZCNnNrEs0MwrtvX9YJ7Om51Ez8rXcd+pyGE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psQIr0gRcXfWy/36bqWJKlzBophq9l4luS7yd70JOCl1+HfwypvEVW2aE8LwKL7A0WGs+/A1zS0zAR1wCSRMbC20PEtBVdMFxF2rKubsYc3AmLNBOg4AbcUIzFbvTcv8TeCSNnu9MFWDwTceFHJJ9hBgePkDeqsP745XEA0OICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl0So5en; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl0So5en"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FC1C19424;
	Tue, 24 Mar 2026 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774363029;
	bh=j0QFlw9eZCNnNrEs0MwrtvX9YJ7Om51Ez8rXcd+pyGE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Vl0So5enOhwKkaTc/6q0VngSCXBQcc9giDEiOm0iDZTtnDbV6luZbNH9IKBVnDPxi
	 18AORvCn7j6pYNEdT7BVClP81gwWUpCYhiA0Bvm7qHtD1eSFp7OLRFrveUWeFQMm8s
	 /Gz29+hlkc4Mr/zS+i86F+zCPmFCIl5Kxz2QwBkEnfkEz4WAPQ0j+XxTf6jPZp2thL
	 WtpRvzJ8AWm9eOO56RlPSZ/Yj7tLAOXl8IovBQOfVWrVPENbuIrbBJRApdLpshxeoK
	 lMwaNoHZG5frUIjl8Gw/eslc7WA3Qb8IyVVpKP1HtWU65iFVNM7gASat1sj1xaTudo
	 d6YzsqKbXkRrA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related user initiated OOB write
Date: Tue, 24 Mar 2026 14:36:44 +0000
Message-ID: <20260324143651.342273-2-lee@kernel.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
In-Reply-To: <20260324143651.342273-1-lee@kernel.org>
References: <20260324143651.342273-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

logi_dj_recv_send_report() assumes that all incoming REPORT_ID_DJ_SHORT
reports are 14 Bytes (DJREPORT_SHORT_LENGTH - 1) long.  It uses that
assumption to load the associated field's 'value' array with 14 Bytes of
data.  However, if a malicious user only sends say 1 Byte of data,
'report_count' will be 1 and only 1 Byte of memory will be allocated to
the 'value' Byte array.  When we come to populate 'value[1-13]' we will
experience an OOB write.

Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2: Move handling to .probe()

 drivers/hid/hid-logitech-dj.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 32139b2561c0..a8082199d13d 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1859,6 +1859,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 			 const struct hid_device_id *id)
 {
 	struct hid_report_enum *input_report_enum;
+	struct hid_report_enum *output_report_enum;
 	struct hid_report *rep;
 	struct dj_receiver_dev *djrcv_dev;
 	struct usb_interface *intf;
@@ -1903,6 +1904,15 @@ static int logi_dj_probe(struct hid_device *hdev,
 		}
 	}
 
+	output_report_enum = &hdev->report_enum[HID_OUTPUT_REPORT];
+	rep = output_report_enum->report_id_hash[REPORT_ID_DJ_SHORT];
+
+	if (rep->maxfield < 1 || rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
+		hid_err(hdev, "Expected size of DJ short report is %d, but got %d",
+			DJREPORT_SHORT_LENGTH - 1, rep->field[0]->report_count);
+		return -EINVAL;
+	}
+
 	input_report_enum = &hdev->report_enum[HID_INPUT_REPORT];
 
 	/* no input reports, bail out */
-- 
2.53.0.983.g0bb29b3bc5-goog

