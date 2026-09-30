Received: from outbound.st.icloud.com (st-2001h-snip4-11.eps.apple.com [57.103.76.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D754DE72B
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799268; cv=none; b=mE7TEJtw1fCKZ9ZIFt2gszhjktOrQqFK+ImjFwMbuqoNZMiotUmxdW2fivW9Q9/+Uw6rn2fZHLVfF53wIBguCKceryQEnF7k1W9XYxyacTUcz2Lw+Ej744lqgfbWkHjR/SADjJAEWKmte0o3WlWs0esABVoJe4ToUxHbrdW7+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799268; c=relaxed/simple;
	bh=O2A4H6Pu8HokgZldss/bPwxeyavMmKJMdUMBnMemgjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzGTjNzkVjchS2ft2zE7zHt4FYd6dtqAsB+OHz8y/+P2j9WZ+L5Nfww1ATxg5vxQLdJqA+lIGFLQ2x7qF4gl0lxbPah3YGfK786CpkSsAExO78YB+JiqoxxptrDG5y+7n2ppLR9DX5aJWlfoolKOkKgNn5yM45E0W0sncD9DDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=ZvnXmqnH; arc=none smtp.client-ip=57.103.76.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="ZvnXmqnH"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id 6932A18000B1;
	Wed, 30 Sep 2026 20:14:23 +0000 (UTC)
X-ICL-RepId: 01a0f3f4-3676-7121-9904-cc388fea9256
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg4SDhkGWVNbARZdTAdeDlIDQA0cVllWWQVFAUsFWQNYBkUMHgULUQ4FXghPCl0AUgtAC0AdCl4fHBYKFkFcWytfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790799266; x=1793391266; bh=pokyHhBR6X0gbDC7x63a1yzY/tTPFsNMFjxmqKxT2Xs=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=ZvnXmqnH7xwq00F09yHtCDxYnQ4JaHmrKSXVXYzgaafbaz2kjtHV4NqMzWvaUmdkOERjZHdRAH1a1Z2zQOV8Wp9c28LUq+osDg/BK0o2FB9sFmn+B4snniJPzKO3BvVyFbx6EWSDE18f+zE5J3EGXeZUPnGMM+eET/c9GBw9vVMfOfsxhQ1mJIMG+PLCEmvt4EOEz5UPBNV6Rfijgoep/ix81MTyJjFxKRqUsF4ZIiqrg7YRUfL2sXttHbuMuulUiI/hpiE37/NSXW9pk/3AU9qYZvrxr/paDGcLxc9lucXoIVaVjdWnFKnErGjEIWA750LMSorWN9aydzfXBhafVg==
Received: from fedora.vpn.altanet.fr (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id BB5791802FC9;
	Wed, 30 Sep 2026 20:14:21 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 4/4] HID: winwing: drive the URSA MINOR rumble motor
Date: Wed, 30 Sep 2026 16:13:58 -0400
Message-ID: <b7a54d03fd44399104de4a275836443455f6ffe7.1790799028.git.f3nr1l@me.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790799028.git.f3nr1l@me.com>
References: <cover.1790799028.git.f3nr1l@me.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PrqutGEfc5Uetta5lY8jGWMjwiQSRMCu
X-Authority-Info-Out: v=2.4 cv=PsOergM3 c=1 sm=1 tr=0 ts=6abd6d9f
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=pvo7c7CdJwnF_bxRcHMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MiBTYWx0ZWRfX7NJxsKJA/vzl
 xXk2T7UkfQlhVjucmrHZ/gf+UhQyhGhGOmJyuL+snqjAqN3KGXx5JthoUdHFcuCaIP3HuuZ9y+4
 fLZx2aO6IYVXD3qmL0QhvVb9Oz96gL+OrYHjE7S0J5pr0bcwnAo71+xuri9+DpOD+MoBHJlk+mB
 L0wzbeDbcClZyucVxNqnkdGnTQiVWj9Kvtdb59exmcuKY9mMNAupz0TM4gVVHChdn6mJ0WEPDGh
 iz3JN6NvjHAkY2bdC2QLl7VOD47xugp8l/8iNoZpNKmBdHEzowrflLvnjGSYXcY4awUgi9aTjPk
 FeRwJFP5TsKU/hNqu8yfz14n9EXpdrBtAWOh8sQNK8H3phvoaaZK9YzW/wsKTY=
X-Proofpoint-ORIG-GUID: PrqutGEfc5Uetta5lY8jGWMjwiQSRMCu
X-JNJ: AAAAAAABf7k8Y264OdiG/MTjOfVf/biWeB/bz414vJjp89JQy/Gshv1OlSs2l0gbPkNDB6fws33qIfQHXs+tV2Gm3sltXBhOXnvPKfwfbp/aKvS50IJ5MNThOhc64qiepCy2QStlOuau40slSsfjCiOoHBTjraKzFfyhqzCC5YT+8sAPzyj8MKZMqyydcI7AnyNaQYLOrCAJJZO5K4J75ZUJTnkKz/Ij2CrlXJuOR+ujQT10TquqyxLVmU1ZiqzoKY4ozxhACafZLMNMz6U8/AbqD182Igk3Ks3Tu49Ds5E6zUh0G3QwWx5pMbQT2yc2ECAH6CGWNTiTQ64UAD9AN8YkNsVted4iAqDAgPZfecOGai302ZS8xwtQ4gWjHu9R0PrizAxvil2Nid0Z0XdPUMq+9496dOnRxa72GO8UjhMCqxuPTi0yLNRNmYSFC84dPY49+1huepXq5QEluwDWEJ2XatVSNu2l4jcLu1ijNTxb0Ck+Sicnx4QTOoqjJnh+fQW9l1GQlXEGimAfLpmzGpTjEuN6zNfUjOpqTn5nk29wDXePL/P1sM2HKqajVn0GZ8bqsqp7lYAmpKA1g25SsmCZ4L61apWm0uwCBfObLJq4N28gh4lHaCf23hzNm8a0iNv+6CDyGhEVnWEOq1Jb4Sm11pFDJCgXpikLjXAQsTvFYuk9SBUVue30DBSYpMZzPtipHhOFLsoG7ibYm/P05muv7Gec8dZkGg/wPXouTgoBPAUERen8CgFWRWhGfF6GpNPZiw3UXuhdvMwanFUs3+v2zpjtRoUoF4/ia5ruwq2uxEvXUpupNYxeC4w=
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

