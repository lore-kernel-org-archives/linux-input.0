Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793098733;
	b=fFs81wCMN8ipPqzQ2St5CvJD5OmI5/N1fqWz9smwI5cixduTBNH7c4XEbxiqcsJAEBiK
	 3+g+GrdNoy9coxNefsOIq8kCZVBY30ClRrnalbo89LvM8h3A8L+Zyzkzdlaw3Dk0EOOGY
	 jfFWvtV9H3sj65EShUoQK/zobCsmaDzkkVGeywZAtB0vn3hZKpGhJwwqJOWMBg10Nvrd5
	 LuCgmLKygp6w12lhj3PbWcDB1lBc8DvRP/cZgAeiTyAXuxbEip4Vq9o8DCQgVX8MXhS3+
	 FurRSp2UfHd6BgZDwLpnbk5DyCaaVwEUjxWukAuuxtLRWN4eHpM5Q7waGsxmftSEPLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098733;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jRVGSqGb3x/iswrEHVzAMghiqhU4ka2ocVNlaJSUIlo=;
	b=2unhh6eAGQVh01BCGI2MW1CE9MTpTBe9MBfgqDST0P9WHD09GrEMukOqyL7ZGQbSM59T
	 wllPDE1+uhkWUTg/959AtN1Re6aYfKNNVRrrqX6Vcl8/49HhWa3GlO57e9MgvhANKYkln
	 k6yXMLWuMuJnOFL73FcdLycJx1usO+Ru+u7xaIodm24H9VeonoSpaQ31hM3p/N/RM8zQ8
	 KFRGocVPAuNQXVCBQqYccXt18LNW/mdoLl4gF158eMq3RALwzw5XnYe1GApD/aNZLunDx
	 ihLLgI9UZmn7ceA1ZJrEy7ERPfhPdFxZIu6KVHFT0g3Zqhkpa+d5bYDj5sK+Nh7281Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajljmEdH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE9606A31B;
	Tue, 27 Oct 2026 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajljmEdH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793098733;
	b=XhWekbwv/qD3PeP2dWAYUO2+NMC76MG+CvbGqDyrwH6D9iAo5HkE+Sn0c/GriiQjFrcc
	 Cea3YdKipyDMCfjTIf2YqZ6BWIKlaneEQ0BXUESj9KvykZ/kLi8i96dgukrgmL0oB2ktW
	 dTHmm3t2MqqyCIta8SE629wrgfEfDTrmnOYE9GRPqju6+VVabgR2lm+criqYgKtE6CH3l
	 wmwC4YDeZXRA2P7XSn/Y9Ew+/EDyVk94nawlBUE9+k52e7NPWSPzRZTzMbmKOBFmNIvKh
	 IKtAGts6ikTyaHihOdnBrkZ7Z6enq46TLD2dy57knE+IOs8M+gH7mYstWXi2A6fRiJg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793098733;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jRVGSqGb3x/iswrEHVzAMghiqhU4ka2ocVNlaJSUIlo=;
	b=oymBU4CuUQvHlemp2Lv92Z1A7dNk6tRyQ/bNIa39MBnY6lcvL4cS1a6ts4zRMlRDX4pQ
	 PJZBab7UkLhrmlUikuse21RXDzlxo8MqbP+eYdUziJ1+VdwnqtXfbP2+IK9FV1srW1XdU
	 K75Qk+QQuaPkqTFvGXYNCrS+8nWf7FiiWGsmNfutroshJK11zINqv/sR3Ifm+DLKWiz5l
	 w8vEeHkDpEIc4uBgXB0fE23I4KQGashgKK/t2obE7qbpcUX3rLeOYqF8dhFtfbzubPHV9
	 QGC4tqjNR7SC9t5gXlRHuKm5rMkWAXxMRaBc0kpKWMH0rNhTDuIwwiqUmi0RCWfcETA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7570B1F01825;
	Tue, 27 Oct 2026 10:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098732;
	bh=jRVGSqGb3x/iswrEHVzAMghiqhU4ka2ocVNlaJSUIlo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ajljmEdHmyMGq01Jw9j6/obLNAiTRumm/M9Lg/OiDTa9YVeQSgjOGKc8NRU7wzC97
	 Of/wIvnwo/iSP0Vb6QuNyYr1I010QYCxrUimzvOvorffOoxTkaKF+FQ42S+LLxIMK1
	 tiAWzrJ4i4OQonLPV3T7QRljQm7pU0QYVmZzZ/5TPBsjNA6j/v64P7vX6vllH3DlPd
	 qe8UtAfQ/E9oTyTy1KSYgWr1yIF0mmhez1EAQzMTBqo1fO0qPJDJFPtLH/vaKwdaId
	 n/g/z3ULY5tgOM3QQlhOKIZrnqdlIXsnRU/pf2H7946AdbBnzN2xjG3CM5qSbl7pSZ
	 EswBvNT2vuuUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CC1264509F;
	Tue, 27 Oct 2026 10:58:51 +0000 (UTC)
From: Daniel Schaefer via B4 Relay <devnull+dhs.frame.work@kernel.org>
Date: Tue, 27 Oct 2026 18:58:39 +0800
Subject: [PATCH] iio: light: hid-sensor-als: Don't read past the end of
 short fields
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-iio-als-overread-v1-1-e47e2706368b@frame.work>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gZsxe9VxEWoqQaklRREkN7d4
 vItZl5IrMIJ5uoF5VuSxFBg6grcQWFnlK0YbGN709gBRSLSmTDerMq0oZu4a0dPvfEEJbuUvTz
 /cllz/gAIkYvKYgAAAA==
X-Change-ID: 20261027-iio-als-overread-c9e538fa61fa
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Schaefer <dhs@frame.work>, 
 =?utf-8?q?Sven_Vaink=C3=BCla?= <sven@xn--vainkla-r2a.ee>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793098731; l=1879;
 i=dhs@frame.work; s=20260705; h=from:subject:message-id;
 bh=HbHuBMAJPm4/X1qXGCMYOxlRvxnQ4Q+ym/c/16zMV7Y=;
 b=hNWK6KU9FNsC+SmMsb+DoSpOCyteg/p4oNS7Z6kAHJRdxscCJyuLk7DJM3oE/Xsd/yq3H+sbb
 VNQqTddW9FYDRCIKWlZ+Xut5xDwHppXVKYz0tyVIqs32kOpEi5+06sy
X-Developer-Key: i=dhs@frame.work; a=ed25519;
 pk=O1zF7VDnmz6EZNc7sEiawR+KK650uRg1XteQ8jHwScw=
X-Endpoint-Received: by B4 Relay for dhs@frame.work/20260705 with
 auth_id=852
X-Original-From: Daniel Schaefer <dhs@frame.work>
Reply-To: dhs@frame.work
Content-Transfer-Encoding: 8bit

From: Daniel Schaefer <dhs@frame.work>

Reports are not guaranteed to be 4 bytes.
On color ALS sensors there are fields that can be shorter than 4 bytes:
16-bit illuminance, color temperature and chromaticity x/y.

I don't have such a sensor right now, but I have emulated one in
firmware. With this patch, no garbage data is read from the next report:

  before: 05dc02bc 05dc02bc 190005dc 0ce41900 00000ce4
  after:  000002bc 000002bc 000005dc 00001900 00000ce4

Same fix as commit ad02ca57e44e ("iio: hid-sensor-prox: Add support for
16-bit report size").

Fixes: ed5514c925a0 ("iio: hid-sensors: Added ALS")
Signed-off-by: Daniel Schaefer <dhs@frame.work>
---
Tested on an emulated sensor with 2 byte reports that is correctly recognized
by Windows.

Cc: Sven Vainküla <sven@xn--vainkla-r2a.ee>
---
 drivers/iio/light/hid-sensor-als.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 929343e42d83..00dfc2037c19 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -267,7 +267,21 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct als_state *als_state = iio_priv(indio_dev);
 	int ret = -EINVAL;
-	u32 sample_data = *(u32 *)raw_data;
+	u32 sample_data;
+
+	switch (raw_len) {
+	case 1:
+		sample_data = *(u8 *)raw_data;
+		break;
+	case 2:
+		sample_data = *(u16 *)raw_data;
+		break;
+	default:
+		if (raw_len < sizeof(u32))
+			return -EINVAL;
+		sample_data = *(u32 *)raw_data;
+		break;
+	}
 
 	switch (usage_id) {
 	case HID_USAGE_SENSOR_LIGHT_ILLUM:

---
base-commit: 09f742b49cb2728086d78be2b0b35e4d1d71fc85
change-id: 20261027-iio-als-overread-c9e538fa61fa

Best regards,
-- 
Daniel Schaefer <dhs@frame.work>


