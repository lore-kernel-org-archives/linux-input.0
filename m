Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B34207A;
	Tue, 24 Mar 2026 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363026; cv=none; b=H76/+v02Z99ytdVBYsNJWHBggQ5dXlDWpo5xqA7qmCCawyDzDalnJlHJtzFWwgeiLub897Ov8wQ70GfgI5FjQ83Obnm4vKLJwq2EOnkPMYENcUQqd1ClHzIgJxeTgahOeV7BxQbb55Tne3GePtEvwU6tjnViVTcMMHnzVopzNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363026; c=relaxed/simple;
	bh=k0+sRC9RFye3DN2uZ/F37ej+HMwLf9FlhcBhnkPBxsY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C+mnhkUy6DL388pZjJNWRU0/fktykeS3zmU3Q7EfnORe/10k1AV3Odims0aAayN3SS2wdND3Pfz4S1QQMpWRfBfiVSvGmXrJfFNMD92hVbSUwDGlk7KN1ldg4qrSOCJN9n6LrthTwq6Bcidr3C0W1Jhw/n2t2PQ6kuG4BCEAQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZpuSYqd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZpuSYqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3811C19424;
	Tue, 24 Mar 2026 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774363026;
	bh=k0+sRC9RFye3DN2uZ/F37ej+HMwLf9FlhcBhnkPBxsY=;
	h=From:To:Subject:Date:From;
	b=SZpuSYqdp3XB+8xvk724JE6UfUo4sBOsz95fDMK5ijBhepOdQ5OX2Hu3rZqXHqGQ3
	 klgw+g8HFT2CLBOIysjDswzRkEJNIA54L++kIcnx8efMqm9HYiQLimP8ufI0eu6EqB
	 63QQVGz9KuoBxgzo68jH508c5aHDElVaZA++Yz1lh9LKt15678kyilkGOVvnu8oTOU
	 imLzyzeGfAt64dzMuto7VZ5bWw7cEuHFbvgbxc2TnYGZfu/sO5B78TbfKKMiQKscyV
	 9BGybpueL633qo/WexfTB3IHt/KD1SdzNdiZdRKGzLwfZgQKrPW2et4w4EU1g1a8JH
	 od4ppSztPpnOA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] HID: logitech-dj: Standardise hid_report_enum variable nomenclature
Date: Tue, 24 Mar 2026 14:36:43 +0000
Message-ID: <20260324143651.342273-1-lee@kernel.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we will need to differentiate between the two report_enum types
soon, let's unify the naming conventions now to save confusion and/or
unnecessary/unrelated changes in upcoming commits.

{input,output}_report_enum is used in other places to let's conform.

Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2: New patch

 drivers/hid/hid-logitech-dj.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 44b716697510..32139b2561c0 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1858,7 +1858,7 @@ static int logi_dj_raw_event(struct hid_device *hdev,
 static int logi_dj_probe(struct hid_device *hdev,
 			 const struct hid_device_id *id)
 {
-	struct hid_report_enum *rep_enum;
+	struct hid_report_enum *input_report_enum;
 	struct hid_report *rep;
 	struct dj_receiver_dev *djrcv_dev;
 	struct usb_interface *intf;
@@ -1903,10 +1903,10 @@ static int logi_dj_probe(struct hid_device *hdev,
 		}
 	}
 
-	rep_enum = &hdev->report_enum[HID_INPUT_REPORT];
+	input_report_enum = &hdev->report_enum[HID_INPUT_REPORT];
 
 	/* no input reports, bail out */
-	if (list_empty(&rep_enum->report_list))
+	if (list_empty(&input_report_enum->report_list))
 		return -ENODEV;
 
 	/*
@@ -1914,7 +1914,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 	 * Note: we should theoretically check for HID++ and DJ
 	 * collections, but this will do.
 	 */
-	list_for_each_entry(rep, &rep_enum->report_list, list) {
+	list_for_each_entry(rep, &input_report_enum->report_list, list) {
 		if (rep->application == 0xff000001)
 			has_hidpp = true;
 	}
@@ -1927,7 +1927,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 		return -ENODEV;
 
 	/* get the current application attached to the node */
-	rep = list_first_entry(&rep_enum->report_list, struct hid_report, list);
+	rep = list_first_entry(&input_report_enum->report_list, struct hid_report, list);
 	djrcv_dev = dj_get_receiver_dev(hdev, id->driver_data,
 					rep->application, has_hidpp);
 	if (!djrcv_dev) {
@@ -1935,7 +1935,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 		return -ENOMEM;
 	}
 
-	if (!rep_enum->numbered)
+	if (!input_report_enum->numbered)
 		djrcv_dev->unnumbered_application = rep->application;
 
 	/* Starts the usb device and connects to upper interfaces hiddev and
-- 
2.53.0.983.g0bb29b3bc5-goog

