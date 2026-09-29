Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C83DCDBC
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790657899; cv=none; b=ql7uYJkRdHuEMFlHRxsJxfYB5+Pxxuy9nROj6iDO1QHC72SiC1Iru1Uo7GCIn+OYi/RkYSrvtlJj8GQqGo1q/5eDPIR6Qi7eUxwUb/ELXw3tCBiwV58nJYs5CVAOAP4hYMgb4VkoyytA2Ixbrnu9st+Fbp1BceJtGMzA4LCnPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790657899; c=relaxed/simple;
	bh=ObC0j6IsZMYYU1D2AUZuvYkMbpcbme9zLfOpsAJbP7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzdNJcCt7m6Q63ipw2eNzul0tH1NhSWUCrzTK/kRYFo3VfgOAOb43Jh5WQoFEbXVzs5kx3GcqFqmkJFiV928V3X/7DCtffJUd1ZTGGJu8MZTLgEu/3/23r00qnwyPCAXpao0K99Wv9RVRxd62sXN2gF2XYu7w9SwGzdiibCqAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=HImedsho; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="HImedsho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1790657891; bh=ObC0j6IsZMYYU1D2AUZuvYkMbpcbme9zLfOpsAJbP7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HImedshoibEYq+gBDCn42MkI919hF5wfMi0zSgOd8DsEeqpUOXMhr3VWuQS8rdGet
	 8m0M+sQ4ilCmeafSe6G9AMRl7RItA2mzrjBFGMPNl6xzAgRud28jViLcCBDm7ZvAjS
	 endCVnF2aPlobjW+LGbOHjfjpGcYgEecd7t0ymgFhkDOBnmFF4BJtW0NDjDnbjuJ6p
	 Wz+b6lOgy9SwH7qh8NS9yHHB8XmRuiWnc5yyX+ZqSzcKA/ogy7nkoZRfNVnzm08Isq
	 xCq3km7cBLXXk3ak/kOhGigCVOGSX3LAmtvRy01LqUCBmATy+XoViXOLChQi67IcXC
	 zEz2gn0UT0LvQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 06D0CA073;
	Mon, 28 Sep 2026 21:58:10 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH v14 4/4] HID: nintendo: Patch NYXI Hyperion 3 descriptor
Date: Mon, 28 Sep 2026 21:56:04 -0700
Message-ID: <20260929045607.2106149-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929045607.2106149-1-vi@endrift.com>
References: <20260929045607.2106149-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HID report descriptor for the third-party NYXI Hyperion 3's right
Joy-Con erroneously reports it as using the report ID for the left Joy-Con.
Since it does actually send the report ID for the right Joy-Con, the HID
subsystem rejects it as unknown. Here we patch it to properly report as the
right Joy-Con report ID to ensure the HID subsystem passes it through
properly.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-nintendo.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index c7e450cfb8b0..16f1860723fc 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -4500,6 +4500,21 @@ static int nintendo_hid_event(struct hid_device *hdev,
 		return joycon_event(hdev, report, raw_data, size);
 }
 
+static const __u8 *nintendo_hid_report_fixup(struct hid_device *hdev,
+			    __u8 *rdesc, unsigned int *rsize)
+{
+	if (hdev->vendor == USB_VENDOR_ID_NINTENDO &&
+		hdev->product == USB_DEVICE_ID_NINTENDO_NS2_JOYCONR &&
+		*rsize == 100 && rdesc[24] == NS2_REPORT_JCL)
+		/*
+		 * The NYXI Hyperion 3 right Joy-Con accidentally reports as the
+		 * left one. Since the HID subsystem rejects report IDs that
+		 * aren't listed in the descriptor, we need to patch it.
+		 */
+		rdesc[24] = NS2_REPORT_JCR;
+	return rdesc;
+}
+
 static int nintendo_hid_probe(struct hid_device *hdev,
 			    const struct hid_device_id *id)
 {
@@ -4528,6 +4543,7 @@ static int nintendo_hid_suspend(struct hid_device *hdev, pm_message_t message)
 static struct hid_driver nintendo_hid_driver = {
 	.name		= "nintendo",
 	.id_table	= nintendo_hid_devices,
+	.report_fixup	= nintendo_hid_report_fixup,
 	.probe		= nintendo_hid_probe,
 	.remove		= nintendo_hid_remove,
 	.raw_event	= nintendo_hid_event,
-- 
2.54.0

