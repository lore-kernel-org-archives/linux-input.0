Received: from outbound.st.icloud.com (st-2002i-snip4-2.eps.apple.com [57.103.78.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433A56B866
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972795; cv=none; b=I15UHymNz5tmNgI28fP/yE8UOCAxlvS2r7Zos5WmWI125Q1k8mGSFRdnaOUv8n1/OtUaPbkcBXfUMD2A/g0YNPnk9eD2ogCBovZjSDm2G34nid3UgDRZnN2vmSDC59j/t8lzUVUwWLs3cC4+12WiK3zoTN7/Gdkbi6ChvVLrqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972795; c=relaxed/simple;
	bh=0ITZ1ASi0mvOfyjVjAVE4u6M8L3rvcDLINGU1i/Fjbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVltlQ1BBFcnDYNHsSbYslhojlmpbziGl1xp5ntfTyWyJpE21yj9iE81OeYEBnlib3PV8OTHAzY1OrHqD8C5d22C/WspTDmIKPhoUNVhSFgeCwa6Z72WnB+p7GcDh55zo/2ZayqoHiPNsvcM1xlXfFOr1WgL1J/sRd8MYa3rSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PLT2LSbJ; arc=none smtp.client-ip=57.103.78.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PLT2LSbJ"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id 797AF1800865;
	Wed, 09 Sep 2026 16:53:11 +0000 (UTC)
X-ICL-RepId: 01a08716-76b4-7790-bec6-8bdbba58e1da
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQBOHVUZWQdDF0kFWRcOVk1aFV4MTRFdMFAbXwJCDxwTVhUTC1NWWxNVF0YJGQhdHRkKUFAPS1oVVRcOAkIfUB9MFldDRB8cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQC1kCQg9ICl0OWgRFC00EQwReAEUATx5eGghfHVgCSQJ3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1788972792; x=1791564792; bh=LlfAGzzk1PxPEr+/sSo/yReT1GRA92Hn+vVgdwb6p+Q=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=PLT2LSbJ2PqHs49WVYZ4GDIN5/AM1w54tscGBH1nntoQI6olsPa37OTnDlJD94yBpWw7NxhwpCOwluGklRUVzL4IB9QqOM8eUMmxDXN9xOL5+krkEbg0HkwnUjReYKJK9gmW87iLh7lBvRr61BvX7DrLzkMvNPodROHgnnKorifaC+MzWnJ7wU9MUvlFtVOnn+zg9PkZqT/H3sypZA86Kvnl6HzdbAdkgA04gEGIfy3D7Xzn3yc4OhdFm7FNFKKyGeqeYhQ5oQFwZIghhAMQflr/3XCyZaFpNA6gc3fQlhY41Mp+z2avd36UC7TWRviHo9D6cka6ZTcgswCb0qZAEA==
Received: from komputa (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id 428121801E94;
	Wed, 09 Sep 2026 16:53:10 +0000 (UTC)
From: Cristian Mazzotta <cmmazzo@icloud.com>
To: aer@tuxedocomputers.com
Cc: W_Armin@gmx.de,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wse@tuxedocomputers.com,
	Cristian Mazzotta <cmmazzo@icloud.com>
Subject: [PATCH 2/4] HID: lamparray: raise log level of fatal probe errors
Date: Wed,  9 Sep 2026 11:52:55 -0500
Message-ID: <20260909165257.352597-3-cmmazzo@icloud.com>
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
X-Proofpoint-ORIG-GUID: me6n274eeFFweZhdYNSQD1N5c8C_LQqW
X-Authority-Info-Out: v=2.4 cv=d5P4CBjE c=1 sm=1 tr=0 ts=6aa18ef7
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=zMoZyIPnO1cA:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=MPtH9Rw9gXh03n2V8fYA:9 a=Uh4tPsEYL5Xn7yYgV4Nn:22 a=djM25Df-3sMe0xqo8c8Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4OCBTYWx0ZWRfX2j+f8e6pRj63
 q6+HCFXZcFr+HkWm+j01Ky7Nk4LO1L120uexgXONsK774jXiIAu4eVPhLMPzSc9Oko1Ye/XdzUj
 z7K/keaiB0FlRH3tpzPrKqe2QsaHa+u0QK6IgQRiX4vKpkqmqc0MLo4WNjRZW42rB1pafaeBVP0
 Ninicl1JGxTYMLixYSoscHuzEaFq1yqCo6lp0Be3M+rWWOJdxworATjtfM2031myQSaXG3dl41r
 Tr3YSjAqY5jp3kHHt6cVGYpteq3zFCc3MSXX73xLOCpqiBClg3eMShdTd6XWjCZxwPTKPHgg6Vm
 8vngycZ2WxAtFdGMiHxON8vy+q/fSyTVa+pzO1nDuVoVj6Y49rGlMs9ssQymw4=
X-Proofpoint-GUID: me6n274eeFFweZhdYNSQD1N5c8C_LQqW
X-JNJ: AAAAAAAB+4QizMdxTcw3tnHa5YqdAJinsHMPeDRO/MfVgmXWMDIBjwuiQHp2LIFzpIinDTSUBPAJbX/ZiWqtJzfp4yEO5iXBwOyFuiyncODrvhXxO9jityrV1M2mfkk316UBnfslK2s2wiA2iqaJT+fStvd4jTYjwDDGBde+ZrxsXd5G+p2r/krybax9zaxK1OnpvMkddo6FVFCO+DoF//5RRTNsrtCTvgxAuSUGTDvo0jOtuYNuF42nbGHJWcwZlv7/QAadaKE9DQiXPa3Gi/+sMKgUIBWdcRdErJckIB1eBkRbz5Be406kFUnVN1RO9H9vmm8/1fTY5OsY8vsSbYah3mckYoBieRBYOH0dy1nORGhf59vXPw8nRAxqoERXGgp6bueMlgEFYz73XxPmwWzP67WPAm8Uei1qEgMfToOCMFWsomSylwD+3RazZfYij5Xr28lGzbc6E5Ijvt+ZBaCk4zXgM3rZMALeWhx7FKHlRqKGV13+utsD1AKhiJnuuQ1a8NNRSGhNWFqENXpnSxG4BT7/HoJqaWGr4i1CAZfSU0IK18l/lYbmXwz7H1rohPSxwjU7rYWdt88jxLV+dkFXC2o4w7Bwh0W8cPlzzjyDbK6ZVYjDds1UI7wVKYaICQXL2LGV7/sFmsund3S5HSnD3efGebNjAn+NPMdnwNcv28/31NU8Z8T0FAlJZ+jwAh7t6UpL5xLwJjPkZ7n17a64bUVuW4ASWrOsuzQ12R9lhbMangoIpdzrHc5Rdyqgf96fXhSyVO1TtZizYDzlIZMn89V/X0aslMJuOA==

The failure paths in lamparray_read_attributes_report() and
lamparray_get_lamp_attributes() use hid_dbg(), so on a device that
cannot be driven the driver declines to register with no output unless
dynamic debug is enabled for the module.

Use hid_warn() for these, since they leave the device without LED
support and the reason is useful to anyone diagnosing why a LampArray
device did not appear under /sys/class/leds.

Signed-off-by: Cristian Mazzotta <cmmazzo@icloud.com>
---
 drivers/hid/hid-lamparray.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
index f169929aecd6..70c596f292a2 100644
--- a/drivers/hid/hid-lamparray.c
+++ b/drivers/hid/hid-lamparray.c
@@ -169,19 +169,19 @@ static int lamparray_read_attributes_report(struct lamparray_device *ldev)
 	size_t len;
 
 	if (!ldev->lamp_count.field) {
-		hid_dbg(hdev, "No LampCount field found\n");
+		hid_warn(hdev, "No LampCount field found\n");
 		return -ENODEV;
 	}
 
 	if (!ldev->lamparray_kind.field) {
-		hid_dbg(hdev, "No LampArrayKind field found\n");
+		hid_warn(hdev, "No LampArrayKind field found\n");
 		return -ENODEV;
 	}
 
 	report = ldev->lamp_count.field->report;
 
 	if (!report) {
-		hid_dbg(hdev, "LampCount field has no report\n");
+		hid_warn(hdev, "LampCount field has no report\n");
 		return -ENODEV;
 	}
 
@@ -196,7 +196,7 @@ static int lamparray_read_attributes_report(struct lamparray_device *ldev)
 	ret = hid_hw_raw_request(hdev, report->id, buf, len,
 		HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 	if (ret < 0) {
-		hid_dbg(hdev, "Failed to get LampCount value from device: %d\n", ret);
+		hid_warn(hdev, "Failed to get LampCount value from device: %d\n", ret);
 		goto out;
 	}
 
@@ -204,7 +204,7 @@ static int lamparray_read_attributes_report(struct lamparray_device *ldev)
 
 	ldev->lamp_count_value = get_field_value(&ldev->lamp_count);
 	if (!ldev->lamp_count_value) {
-		hid_dbg(hdev, "LampCount is 0 (invalid)\n");
+		hid_warn(hdev, "LampCount is 0 (invalid)\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -415,7 +415,7 @@ static int lamparray_get_lamp_attributes(struct lamparray_device *ldev)
 	ret = hid_hw_raw_request(hdev, report->id, buf, len,
 		HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 	if (ret < 0) {
-		hid_dbg(hdev, "Failed to read LampAttributesResponseReport: %d\n", ret);
+		hid_warn(hdev, "Failed to read LampAttributesResponseReport: %d\n", ret);
 		goto out;
 	}
 
@@ -427,7 +427,7 @@ static int lamparray_get_lamp_attributes(struct lamparray_device *ldev)
 	ldev->max_brightness = get_field_value_as_u8(&ldev->color_levels.intensity);
 
 	if (!ldev->max_r || !ldev->max_g || !ldev->max_b || !ldev->max_brightness) {
-		hid_dbg(hdev, "LampArray device has no color levels\n");
+		hid_warn(hdev, "LampArray device has no color levels\n");
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.55.0

