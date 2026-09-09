Received: from outbound.st.icloud.com (st-2002g-snip4-11.eps.apple.com [57.103.78.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA2572696
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972795; cv=none; b=hSVRhGVYI1le/qLmNqIrIn+/ZwSUfLtWhB0/U61bOjP3jl6pNq4YmHKLzkaHzLtflLP1pQbtYu4kQBufHfA2Z+TWC6BAV6wZE39qlg6KJthoVS+L8Wm9klpKBgU4nlliZExMaMXY2wPN9hR8yeU40YaHbw6C4f+fNgIoxgTx89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972795; c=relaxed/simple;
	bh=uv/g6EUW5+U2gpXil3A3lf30+AJKvqs4xHE015zQNhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hE13oBhGibiewyIA0v4KwLMZgZ9LycU5afSYgKn94xPDppEmwl9dVCwL02QwPy/nkedbLo4+ZyQKOqfS7nQl4MgJnYh1sjKBt2QZ0fhoC9lygSy7pzxGdIl7+d2gnTIAuPlGGdPQzStGwaf+Mow6PSivF2yPDFPggnSPrrhmvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rf3RBYNP; arc=none smtp.client-ip=57.103.78.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rf3RBYNP"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id A9A8E180086C;
	Wed, 09 Sep 2026 16:53:10 +0000 (UTC)
X-ICL-RepId: 01a08716-7351-77d8-b53f-69730d6fbade
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQBOHVUZWQdDF0kFWRcOVk1aFV4MTRFdMFAbXwJCDxwTVhUTC1NWWxNVF0YJGQhdHRkKUFAPS1oVVRcOAkIfUB9MFldDRB8cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQC1kCQg9ICl0OWgRFC00EQwReAEUATx5fGghfHVgCSQJ3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1788972792; x=1791564792; bh=qnVrBJiY48IaSqAOtBEpASh9ORjwYDMwWTdB413PECw=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=rf3RBYNPo+0fABRVB0JjSnpKICZ0HJRL7PnlFz/trj3Jrjxovod/MYxXaQuH6f2yXssSb59h5p2tdY/g4Re6GaR26cCdikd1ZNr9+s0ptGqrgeVy7B2hJ8aKN7MTNZYi5nq2TAoTsqXqhMkAye61Vz9piSfZSa1rWiYwXoli5bXK85efKmKo7gk35ykRnRqc3GSjzZRM+bIJhlSkBFUvT4ldHN6q+augU+85AS1wyEDZmvygv/CLOAIH8MKvi6Ee7frjJP21PYvZz86sxjfdEsgn1gRA8x9bvoU5M4RGkKkA232uZhL5h7KmwfbsY2K7iQgJmzYdRE78AvV76rfGrw==
Received: from komputa (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id 0ABFE1800C34;
	Wed, 09 Sep 2026 16:53:08 +0000 (UTC)
From: Cristian Mazzotta <cmmazzo@icloud.com>
To: aer@tuxedocomputers.com
Cc: W_Armin@gmx.de,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wse@tuxedocomputers.com,
	Cristian Mazzotta <cmmazzo@icloud.com>
Subject: [PATCH 1/4] HID: lamparray: read attribute reports synchronously
Date: Wed,  9 Sep 2026 11:52:54 -0500
Message-ID: <20260909165257.352597-2-cmmazzo@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909165257.352597-1-cmmazzo@icloud.com>
References: <a62d1907-73cb-4cfd-98b1-7cdce3b37541@tuxedocomputers.com>
 <20260909165257.352597-1-cmmazzo@icloud.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Cms9kZ3q-3pIhPhEaEG0UmGQBL01n60r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4OCBTYWx0ZWRfXyVvWoY6L9+Fj
 1aeIDldB5vEwP0UMLoklI5jV2C7atb+HdqnOKv32n56aiv4vfz4EnkoO5zr3bayTT/+BfaEy7DE
 ml1uMlIf6m2OE3i4hPWS55LezkLixwRqOV+Io0ye2sip6FPT/nZvJkd9A/H+t+WCXd6bOqz4W8n
 DmG4s3eF++JF0njM8UxTutjjm3Z3oz29R4KC9+30BNNnpMqcblxxAt3h21qa0XXgrd4YuWgO7wZ
 f6Krxsmxukg8ADiKb+XJQn43yom9BFUMkS7k/6L/yuwiPAgpOyKTmI3mWD0UP9qKzE9VjoRffOZ
 1HGlBR9Ix3YHwLiqDJ9Zx3GkyU20ksHlhlu4zGluHnDtOdH1qYIUwhMXI0g+8Q=
X-Proofpoint-GUID: Cms9kZ3q-3pIhPhEaEG0UmGQBL01n60r
X-Authority-Info-Out: v=2.4 cv=Z9bh3XRA c=1 sm=1 tr=0 ts=6aa18ef7
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=zMoZyIPnO1cA:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=VAzw7L_s2ESeolZuby8A:9 a=Uh4tPsEYL5Xn7yYgV4Nn:22 a=djM25Df-3sMe0xqo8c8Q:22
X-JNJ: AAAAAAAB1ZBuRfgRtGRBNNKWrtfZ6tF6V6zkz+oqA+qc6/TymMtbkEPLwRqjAxJ5jX2vHNUlz+1t81j7hW9/zGvRITiUPuii0T79keCng2uG5BExvuwYnn1n7DAz280mvBwDuVnVJ1UiMx4hrEPyrn9xDcaHQlPwUCCpV/5hTcxEtbBL7ggFVZ76Qbu44oEEGyoBWMYypkRADLF4QWXPO/hQ58Pk3j98pX4GtB3mLCg2bU6ZYRDe//hwoadLPAo1tdz5jKxZfG+xSgO/h9Uugb0qkCbVU0xW1a+BjbiHfIEWfDgU2EBRJ58eDrxXHU79z+xDgpE5GooITJdU7nZF7dXesHWLqXuDJDDazaaR2usIvTMbeAVP8CnWiXZBAVnRGhv9v4bafjJW3h7dijaVzDo65eQMLuf5vukjsuKZrFrHFxWYMuhnIfhzNXOmm2v2ZTj1uj9gMLCOHg/DDWxi8ZHQpmfSiTh91Rxih6z1eXVi8AlxamgvPJP1r0+1kz43rtqvg/YnCPXHax39PjuuyMs3mD/Za2Q2v4BQZQ7bMNml6eBgbe3dTKZENlhFODCaxtcD24rLFPSPHo78j8QmtTKc2niohuQgyFtmfkBPtgfuLExwo1UzB1Ev7xoLeoB1ccf1Zu6DBMpeMnR/2w9IcICcaEyhBjx1/DABdscUpX3yCZAC3y5XLk9DcJGsrMHvXX5EM/0rQOe5REdJUSGuVwBgBnv28j2NFwDWBnTG1LgAcaRzAnsV7/WuDK9WZOFrpHxBLrRl5dfRbwjB8pOherYDN4MCNnWW7Q==

lamparray_read_attributes_report() and lamparray_get_lamp_attributes()
use hid_hw_request(HID_REQ_GET_REPORT) followed by hid_hw_wait(), then
read the results out of field->value[]. hid_hw_request() is asynchronous
and hid_hw_wait() only clears the output queue, so the values are still
read before the transfer has completed.

On an Acer Predator PT14-52T (USB keyboard 05AF:767A), this returns zero
for LampCount, and then zero for red, green, blue, and intensity counts.
The last one is evil: max_brightness is passed to
led_mc_calc_color_components() as a divisor during
lamparray_register_led(), resulting in a divide by zero during probe:

    Oops: divide error: 0000 [#1] SMP NOPTI
    RIP: 0010:led_mc_calc_color_components+0x58/0x70
    Call Trace:
        lamparray_register_led+0x119/0x1e0
        lamparray_register+0x502/0x820
        hid_generic_probe+0x5e/0xc0

The fault kills the kworker running hub_event() while it holds the USB
and HID device locks, which stalls further probing on that bus.

Use hid_hw_raw_request() with a hid_report_len()-sized buffer and hand
the result to hid_report_raw_event() so the HID core parses it into
field->value[] before the values are read.

Validate the level counts after reading them and fail with -EINVAL if
any is zero, so a device reporting no levels cannot reach
led_mc_calc_color_components() at all. The four level fields are also
required to share one report, since a single GET_REPORT is used to
fetch them.

Signed-off-by: Cristian Mazzotta <cmmazzo@icloud.com>
---
 drivers/hid/hid-lamparray.c | 73 ++++++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
index 9a438aa2d305..f169929aecd6 100644
--- a/drivers/hid/hid-lamparray.c
+++ b/drivers/hid/hid-lamparray.c
@@ -164,6 +164,9 @@ static int lamparray_read_attributes_report(struct lamparray_device *ldev)
 {
 	struct hid_device *hdev = ldev->hdev;
 	struct hid_report *report;
+	int ret;
+	u8 *buf;
+	size_t len;
 
 	if (!ldev->lamp_count.field) {
 		hid_dbg(hdev, "No LampCount field found\n");
@@ -182,25 +185,37 @@ static int lamparray_read_attributes_report(struct lamparray_device *ldev)
 		return -ENODEV;
 	}
 
+	len = hid_report_len(report);
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	mutex_lock(&ldev->dev_lock);
 
 	/* Update values */
-	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
-	hid_hw_wait(hdev);
+	ret = hid_hw_raw_request(hdev, report->id, buf, len,
+		HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret < 0) {
+		hid_dbg(hdev, "Failed to get LampCount value from device: %d\n", ret);
+		goto out;
+	}
 
-	ldev->lamp_count_value = get_field_value(&ldev->lamp_count);
+	hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf, len, ret, 0);
 
-	if (ldev->lamp_count_value == 0) {
-		mutex_unlock(&ldev->dev_lock);
-		hid_dbg(hdev, "LampCount is %d (invalid)\n", ldev->lamp_count_value);
-		return -EINVAL;
+	ldev->lamp_count_value = get_field_value(&ldev->lamp_count);
+	if (!ldev->lamp_count_value) {
+		hid_dbg(hdev, "LampCount is 0 (invalid)\n");
+		ret = -EINVAL;
+		goto out;
 	}
 
 	ldev->lamparray_kind_value = get_field_value(&ldev->lamparray_kind);
+	ret = 0;
 
+out:
 	mutex_unlock(&ldev->dev_lock);
-
-	return 0;
+	kfree(buf);
+	return ret;
 }
 
 static int lamparray_parse_update_report(struct lamparray_device *ldev)
@@ -371,28 +386,58 @@ static int lamparray_get_lamp_attributes(struct lamparray_device *ldev)
 {
 	struct hid_device *hdev = ldev->hdev;
 	struct hid_report *report;
+	int ret;
+	u8 *buf;
+	size_t len;
 
 	if (!lamparray_color_fields_is_complete(&ldev->color_levels))
 		return -ENODEV;
 
 	/*
-	 * Get value of any lamp.
+	 * All four fields must share the same report since the
+	 * attributes are fetched with a single GET_REPORT below.
 	 */
 	report = ldev->color_levels.red.field->report;
+	if (!report ||
+		ldev->color_levels.green.field->report != report ||
+		ldev->color_levels.blue.field->report != report ||
+		ldev->color_levels.intensity.field->report != report)
+		return -ENODEV;
+
+	len = hid_report_len(report);
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
 	mutex_lock(&ldev->dev_lock);
 
-	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
-	hid_hw_wait(hdev);
+	/* Update values */
+	ret = hid_hw_raw_request(hdev, report->id, buf, len,
+		HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret < 0) {
+		hid_dbg(hdev, "Failed to read LampAttributesResponseReport: %d\n", ret);
+		goto out;
+	}
+
+	hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf, len, ret, 0);
 
 	ldev->max_r = get_field_value_as_u8(&ldev->color_levels.red);
 	ldev->max_g = get_field_value_as_u8(&ldev->color_levels.green);
 	ldev->max_b = get_field_value_as_u8(&ldev->color_levels.blue);
 	ldev->max_brightness = get_field_value_as_u8(&ldev->color_levels.intensity);
 
-	mutex_unlock(&ldev->dev_lock);
+	if (!ldev->max_r || !ldev->max_g || !ldev->max_b || !ldev->max_brightness) {
+		hid_dbg(hdev, "LampArray device has no color levels\n");
+		ret = -EINVAL;
+		goto out;
+	}
 
-	return 0;
+	ret = 0;
+
+out:
+	mutex_unlock(&ldev->dev_lock);
+	kfree(buf);
+	return ret;
 }
 
 /* Helper functions */
-- 
2.55.0

