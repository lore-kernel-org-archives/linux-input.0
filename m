Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A84368D43;
	Sat, 13 Jun 2026 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781316634; cv=none; b=gu18DcUmbxIKwhEtOdWXuJXVbxcQ8XdTSY1ArhMjrN53zFFuYfvJs2pxu32B6wStKedfcMleDJ9NCBpNVRuqfiNSreuUdFOxqEvH80cSPO2jQyHEJMwM/72wf0Nf9HstjBUPW+C5ZfuQaAybvZT2MjE0v3to7V3Wj0wQrc+lWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781316634; c=relaxed/simple;
	bh=7eYOcTRgyIl+0jhUh96jwzHWZ1wO5DwpjrhpP87G/NE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=De/OA/aQUSsZ1ix6UnaoVRG9DC3zRWAmBQxIIEd7Koo7/3KmutJO5FAguAhv9cn/OLiElJuM0+ijtu4iPsXjG87+uiOpirsmBxf0gkxz6Vkd8dArNGam41kheFUGWqctLREn5qam918IjxeJzF8hAnZxmk5FzqmtScAcnTC/DXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8HAxWlM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8HAxWlM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F36BAC2BCB4;
	Sat, 13 Jun 2026 02:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781316634;
	bh=7eYOcTRgyIl+0jhUh96jwzHWZ1wO5DwpjrhpP87G/NE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=u8HAxWlMDmShLtgnvfdQNYOKVYgjJxZbO+t0RM9erFVlj5iW12zusacXwfgEVuNIG
	 MvMjJIMe1sfIUMr4FHcSdA617EI9Kybr6knI7EQzX4NtJU+okrl9RAcIzb14Rlp/tq
	 tyP6W7T88GblbD0C3S1Za0VF1kACzl5EhXxNkXV/oOwGr2zjikYtaEqL7dG+3C+Vuh
	 XACplJrcI076qBigrUcuTIfTjQ4/dLbGTemSZmGe4oOmXD6lZ6sGTXU+F9nRF77qeW
	 w5vbfSE0gmkRRUE/bf4itB2YNoJlfsAbrcKIv2ZdC2xFjV9o5obfgxmWheqGbs3LBB
	 qiWLWxtlPmO+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B1ECD98CE;
	Sat, 13 Jun 2026 02:10:33 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 12 Jun 2026 21:10:33 -0500
Subject: [PATCH] Input: goodix - clamp the device-reported contact count
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-b4-disp-6844625d-v1-1-df0aed080c9d@proton.me>
X-B4-Tracking: v=1; b=H4sIABi8LGoC/x3MPQqAMAxA4atIZgP2xyheRRy0TTWLlhZEKN7d4
 vgN7xXInIQzTE2BxLdkuc4K1TbgjvXcGcVXg+40daQ0bha95Ig0Wku692jJhFGpwXhHULOYOMj
 zL+flfT8IznHBYgAAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781316632; l=2188;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=8Qj7c/zb9l+DCDhqBZQh8IHkrnwoVRmOpltbzUeTh9w=;
 b=inOWvX4CMyP+Ep+Qnn4+GrGd5mVgMpKH3p+6iWXdPmMrSvQjTr9oNI/CgNeh97LY9KqGCUKur
 kbULJ1LuAaVB+4OEWnc20OB4mBnQeAgntflkGwO5cK1DZHcBX3M6gcO
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

goodix_ts_read_input_report() copies the number of touch points reported
by the device into an on-stack buffer

	u8 point_data[2 + GOODIX_MAX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];

which is sized for at most GOODIX_MAX_CONTACTS (10) contacts. The only
runtime check bounds the per-interrupt count against ts->max_touch_num,
but that value is taken verbatim from a 4-bit field of the device
configuration block and is never clamped:

	ts->max_touch_num = ts->config[MAX_CONTACTS_LOC] & 0x0f;

The nibble can be 0..15, so a malfunctioning, malicious or counterfeit
controller (or an attacker tampering with the I2C bus) can advertise up
to 15 contacts. goodix_ts_read_input_report() then accepts a touch_num
of up to 15 and the second goodix_i2c_read() writes
ts->contact_size * (touch_num - 1) bytes past the one-contact header into
point_data - up to 30 bytes (45 with the 9-byte report format) beyond the
92-byte buffer: a stack out-of-bounds write.

Clamp max_touch_num to GOODIX_MAX_CONTACTS, the number of contacts
point_data[] is sized for, when reading it from the configuration.

Fixes: a7ac7c95d468 ("Input: goodix - use max touch number from device config")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 drivers/input/touchscreen/goodix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f8798d11ec03..17fcfe45988c 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -1057,7 +1057,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 	}
 
 	ts->int_trigger_type = ts->config[TRIGGER_LOC] & 0x03;
-	ts->max_touch_num = ts->config[MAX_CONTACTS_LOC] & 0x0f;
+	ts->max_touch_num = min(ts->config[MAX_CONTACTS_LOC] & 0x0f,
+				GOODIX_MAX_CONTACTS);
 
 	x_max = get_unaligned_le16(&ts->config[RESOLUTION_LOC]);
 	y_max = get_unaligned_le16(&ts->config[RESOLUTION_LOC + 2]);

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260612-b4-disp-6844625d-463f81173dc6

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


