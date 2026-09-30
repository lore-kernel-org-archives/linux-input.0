Received: from outbound.ci.icloud.com (ci-2005k-snip4-11.eps.apple.com [57.103.89.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA5144A708
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798187; cv=none; b=E6iMnuqL8/nxYuZD/9f4KMiwDrBOkoDC+LKIv2m/pY2UikNdkxIInD5MUfiA7geMKKW32UEULugW6HJZmVtfvoJUbXAC/BCQupVlysM/jLgPC3NfLDKItIgk8nikYklBPsmGzOVBMw3xJ50xzZ04Nzmnsbx5TcNJ/aKtyHEGqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798187; c=relaxed/simple;
	bh=O2A4H6Pu8HokgZldss/bPwxeyavMmKJMdUMBnMemgjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cL53KIHgrVxKhwQBfwc9aMpalyTJvchDxeAqOCkq5yGQsU7oYh4n8SpkxwuIpZWCE3vP7Y47T/Kw1Bp3432TqSQFdvFysHLS4NgGqYuLDXY14ikg3RD8hXUi99baXq2ZRGjSAyqg6LTrpkrQ2Un4OyI0tQtqXvs9lAP+n7pkt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=UP8gsUSZ; arc=none smtp.client-ip=57.103.89.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="UP8gsUSZ"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id 4012118000BD;
	Wed, 30 Sep 2026 19:56:23 +0000 (UTC)
X-ICL-RepId: 01a0f3e3-bb10-7c41-8aee-bc938b0ca488
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQVNXw5eHwQXRhlVBEceXVZQBBkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg4SDhkGWVNbARZdTAdeDlIDQA0cVllWWQVFAUsFWQNYBkUMHgULUQ4FXghPCl0AUgdHC04dCl4fHBYKFkFcWytfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790798185; x=1793390185; bh=pokyHhBR6X0gbDC7x63a1yzY/tTPFsNMFjxmqKxT2Xs=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=UP8gsUSZqVznjZabkhIX8xGv/2AVfnNi0U9Oc9iTv/9xqjVcN5Cg/GE7VJLrn2NbqWExw327dk5Q/4UcLJaHoAVOhUX7QqxZyEMxRMqsY6I2kyYB5ihft0KyQ/1fu4NVtzn4MNq+6pGuCeqApPzaUgKpyVbFypRtLPtnGnLkTnDovool6OTNN9HkMOScPNBBJjjl+fQ9IeuloGeSyrg2LNt9FCaccvuVIp6GQTa76irqgz2ob7utNyoPh97bcfyy3CWp64SBqwJiwFcx6Ytm2+NpPvT6M+pN5ErmBRLKsTlM6tvsEinNQehlkL7egpl6HiZpz8wVxqSH7ADD9aSarg==
Received: from fedora.vpn.altanet.fr (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id 938D018000B4;
	Wed, 30 Sep 2026 19:56:21 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] HID: winwing: drive the URSA MINOR rumble motor
Date: Wed, 30 Sep 2026 15:56:00 -0400
Message-ID: <b7a54d03fd44399104de4a275836443455f6ffe7.1790795726.git.f3nr1l@me.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790795726.git.f3nr1l@me.com>
References: <cover.1790795726.git.f3nr1l@me.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MSBTYWx0ZWRfX2aHb7mOmmpBB
 m8vc4jBQZbELD2P1sgEV7yd7Y44eMXf3PihHqpqaMu8uOGqs3+3BexIEfp1BAru/2O5l0HUKA+R
 sbtE52N8FHdoYeloyTb0/00HWSXti/wCjKbBn2PEvSJXqj8CM0d1v0xfZPFvVn9lXTXODTOTFWS
 epfft2Uj+GziWw7kBciSe3uoPm0LoV/WOxjIVPPmyX9Ywr3RyNf7PzJrSBahhKFEOQyu+41TARI
 1y7ulw9NnVKaKRjwgFLhfAshaGlKquj4ngP4LPslQxFJQ5eKR3bAtlfdx5CjWSVIDR+IK67xQJ0
 pLAikYxCf7Oxk1TwT++gfl5av7WlPVISfqCE36/2UP5uZv628DChYk2QKUDAYE=
X-Proofpoint-ORIG-GUID: CNhK9tc8ex5AN1fq4a1n9qqCmWcWnTPr
X-Proofpoint-GUID: CNhK9tc8ex5AN1fq4a1n9qqCmWcWnTPr
X-Authority-Info-Out: v=2.4 cv=OK4qHCaB c=1 sm=1 tr=0 ts=6abd6967
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=pvo7c7CdJwnF_bxRcHMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAAB027aMPDaIL4GsnGYfUnsU7Odc98xG43uKVopPWNbCGWQw55b/POeDQQJRGiTd2efZcmvot48gTkJhz7P8SGEDOD/eLdwX53sCPA0G9ZkBPXlzE8o5It60c+Q1EKWPKYmJ6qwwOPpDK8nKlbJh/NpxsPUSi2LcNT9PIQeHKh1wiNEFmBY0MBQj2ve+HRlcXZ+4cVTOgydtaCnLJVX9XU5sq3AvqJVnLUSZSIjIJelEymf1Av+wplxCp+nTkgf0FlM7NOWNoOas4cUjSQJrgzMYKhhmc+aK+kdJFCG+TKeseOxh+5oto8g3EDlyCaXG/0XJEoek0YJU2tbYgRlrrH7rKT8Bzy1unJ6brgpC7nSX5QB2btZWJqJOGqsgsG5MtCmdhSPESq98AosXZp65en6tDE+sDN1Lp7qvnQHk8yKKbVqwkJcpW3vzWmKG6qHMuV0UJC6hz4NpdDtQSO4LFlh59XoxWNR5/8HO/p3WtXftbesNIFL/R70fd6mgwH46OY3Y4NFdf7Qge7AAtmwvxHjYWyDOAPU8XR4PwXmkXqbcWIPY3ynNqo7t3aT4SvOFQ77UxzCuZBVikOgqOQAgRGonKNLhfUrWEM4FabEP5DABJ4AwgVo2gR+B3tNbAAFuTDFCOftiBDzriWV6kVHR9i4lDI0FX2pn1L20iiAyalE1LGR5/OXGwuby58w7xFHXjJjpXQUiQ4aM8auFEYkkFQ3bPjM8kBW5ByMfI8Ut6iSB1+6skXLJX2Br4IAlUJ2c+sJzcjDD96NZ00wZUm7/CQyFDEphy5IkbZ5ZyS7Nlmnpqbumok=
X-Apple-Category-Label: MjczODQ1OTkzOiRjYXRlZ29yeSRfUGVyc29uYWws

An URSA MINOR stick has a single rumble motor, carried by the grip rather
than by the base and addressed by its own device number, derived from the
product id. The two-motor throttle path sends to device 0x01 and 0x03,
which a stick ignores, so give it its own path.

Both magnitudes feed the one motor and the stronger one wins, which is
what the memoryless force-feedback core expects of a device that cannot
drive them separately.

The Orion 2 keeps its two motors.

Signed-off-by: René Onier <f3nr1l@me.com>
---
 drivers/hid/hid-winwing.c | 50 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index a52e7efece..86caff9183 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -4,6 +4,7 @@
  * HID driver for WinWing Orion 2 throttle and URSA MINOR sticks
  *
  * Copyright (c) 2023 Ivan Gorinov
+ * Copyright (c) 2026 René Onier
  */
 
 #include <linux/device.h>
@@ -45,8 +46,10 @@
 #define URSA_LIGHT_DEVICE	0x20
 #define URSA_LIGHT_FAMILY	0xbb
 
-/* Rumble motors of the TGRIP-15 grips, one report each */
+/* Rumble motors answer on the grip, not on the base */
 #define WINWING_STICK_FAMILY		0xbf
+
+/* The TGRIP-15 grips have two motors, each taking its own report */
 #define WINWING_RUMBLE_LEFT_DEVICE	0x01
 #define WINWING_RUMBLE_RIGHT_DEVICE	0x03
 
@@ -95,6 +98,10 @@ struct winwing_drv_data {
 	int rumble_right;
 	unsigned long quirks;
 
+	/* URSA MINOR: single motor, on the grip */
+	__u8 rumble_device;
+	int rumble_sent;
+
 	/* Lighting controller and LED set of this model */
 	unsigned int num_leds;
 	__u8 led_device;
@@ -296,6 +303,40 @@ static inline int convert_magnitude(int x)
 	return ((x * 255) >> 16) + 1;
 }
 
+/* Device number of the grip, 0x09 for the left stick and 0x0a for the right */
+static inline __u8 winwing_ursa_device(__u32 product)
+{
+	return (product & 0xff) - 0x20;
+}
+
+/*
+ * An URSA MINOR stick has a single motor, driven by the same opcode as the
+ * lights but addressed to the grip instead of the base. Both magnitudes feed
+ * it and the stronger one wins.
+ */
+static int winwing_ursa_rumble(struct winwing_drv_data *data, __u8 *buf)
+{
+	int ret;
+	__u8 m;
+
+	m = convert_magnitude(max(data->rumble.strong_magnitude,
+				data->rumble.weak_magnitude));
+
+	if (m == data->rumble_sent)
+		return 0;
+
+	ret = winwing_send_set_ledx(data->hdev, buf, data->rumble_device,
+			WINWING_STICK_FAMILY, 0, m);
+	if (ret < 0) {
+		hid_err(data->hdev, "error %d (%*ph)\n", ret,
+				WINWING_REPORT_LEN, buf);
+		return ret;
+	}
+	data->rumble_sent = m;
+
+	return 0;
+}
+
 static int winwing_haptic_rumble(struct winwing_drv_data *data)
 {
 	__u8 *buf;
@@ -312,6 +353,9 @@ static int winwing_haptic_rumble(struct winwing_drv_data *data)
 	if (!buf)
 		return -EINVAL;
 
+	if (data->quirks & WINWING_URSA_MINOR)
+		return winwing_ursa_rumble(data, buf);
+
 	m = convert_magnitude(data->rumble.strong_magnitude);
 	if (m != data->rumble_left) {
 		int ret;
@@ -382,6 +426,10 @@ static int winwing_init_ff(struct hid_device *hdev, struct hid_input *hidinput)
 	data->report_rumble = devm_kzalloc(&hdev->dev, MAX_REPORT, GFP_KERNEL);
 	data->rumble_left = -1;
 	data->rumble_right = -1;
+	data->rumble_sent = -1;
+
+	if (data->quirks & WINWING_URSA_MINOR)
+		data->rumble_device = winwing_ursa_device(hdev->product);
 
 	input_set_capability(hidinput->input, EV_FF, FF_RUMBLE);
 
-- 
2.55.0

