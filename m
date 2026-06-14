Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C924A078;
	Sun, 14 Jun 2026 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781415371; cv=none; b=QQxJHxxumIiHE1+PxR594zN/r8dbkTlSw5AsUx4MfBCEAqF1zFPgmZkbMgZE4XgxnocG/Hw2dmJgcp9YaxurqAh0v8gWzMvXUoJh+MmDROwLSUq26zooPxXn/TPYWwZ/qlkn/dnQXWtWikyIqj85kvm9atbIvGrbJE2DQdI2SHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781415371; c=relaxed/simple;
	bh=YQArd/wmurkGZmLzuAl5Z/my7237EOVzn2BG98Fqh1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdZSAvcLylbksjgjDrPk+JuMlLQZhZHkQPGCI4hqemYK/H5yYfkGa+DVeg1k3347C211q766HHa9ieEXXyZN/XPnBV2wzi1WlBXwL1sezUu6DfYh+Iu3RoOyqFWxtAeIrVZBJEuu9wC9rsPjqdeIc2BL1FzMwIRmng2vVKpmkr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEDj1+wS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEDj1+wS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52A1CC2BCC7;
	Sun, 14 Jun 2026 05:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781415371;
	bh=YQArd/wmurkGZmLzuAl5Z/my7237EOVzn2BG98Fqh1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nEDj1+wSW+qOfKD/KIeRKTWZ2+R29NMVdt7L+I4x8iVZyZQoUrshaUx1EgvxurzDh
	 f6EeiUcBalsVwJSPZI+PJNV5RstoMVFiEivW9vGwG5+FQOOVYMSJQ0TbCdh5Od3TvO
	 GcwmCoVbvctWA5Fi460dUT70SV3yYXNdKpNXjvK37JYFtQZPd86jU4tGpNYQe6+/Kw
	 HiUsKxNYm5R5Btsm5/TXqjEBHxxSoUDm3PjWrn/96xivRsT1FGCvioCzMKsBdsXAQZ
	 75qECta4SZorrG1RCGO1qrflM1Dv2/pnVZ1PWUHmPCxUU5EBNynfnnA6BlvlmylQeh
	 e/ag7xatyeVLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B58ACD8CA8;
	Sun, 14 Jun 2026 05:36:11 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sun, 14 Jun 2026 00:36:11 -0500
Subject: [PATCH 1/2] Input: synaptics-rmi4 - bound the F3A keymap to the
 GPIO count
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-b4-disp-818d6bda-v1-1-cf39a3615085@proton.me>
References: <20260614-b4-disp-818d6bda-v1-0-cf39a3615085@proton.me>
In-Reply-To: <20260614-b4-disp-818d6bda-v1-0-cf39a3615085@proton.me>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, linux-input@vger.kernel.org, 
 Andrew Duggan <aduggan@synaptics.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781415370; l=2002;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=HUtj0HNyZgocnIFgieSuzeFM3t9J2shY44s+u4vDzys=;
 b=t1yaV/l8rhVGvHjfd6Vng6pxotM+bWnVF1EbrQNEyaBCLQ4gqNzMxR5+txCzwO03EKfiimLLd
 1hBUe0sganrBHB7ssninZ2cM3ULdgTKQn5VMSrrCj7fanekmJs6AuxS
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

rmi_f3a_initialize() takes the GPIO count from the device query register
(f3a->gpio_count = buf & RMI_F3A_GPIO_COUNT, range 0..127).
rmi_f3a_map_gpios() then allocates gpio_key_map with
min(gpio_count, TRACKSTICK_RANGE_END) == at most 6 entries, but
rmi_f3a_attention() iterates the full gpio_count and dereferences
gpio_key_map[i], and input->keycodemax is set to the full gpio_count
while input->keycode points at the 6-entry allocation.

A device that reports gpio_count > 6 therefore causes an out-of-bounds
read of gpio_key_map[] on every attention interrupt, and out-of-bounds
accesses through the input core's default keymap ioctls: EVIOCGKEYCODE
reads past the buffer (leaking adjacent slab memory to user space) and
EVIOCSKEYCODE writes a caller-controlled value past it, for any process
able to open the evdev node, since input_default_getkeycode() and
input_default_setkeycode() only bound the index against keycodemax.

Size the keymap for the full gpio_count. The mapping loop is unchanged:
it still assigns only the first min(gpio_count, TRACKSTICK_RANGE_END)
entries; the remaining slots stay KEY_RESERVED (devm_kcalloc zero-fills)
and are skipped when reporting.

Fixes: 9e4c596bfd00 ("Input: synaptics-rmi4 - add support for F3A")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 drivers/input/rmi4/rmi_f3a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f3a.c b/drivers/input/rmi4/rmi_f3a.c
index 0e8baed84dbb..a0777644eef0 100644
--- a/drivers/input/rmi4/rmi_f3a.c
+++ b/drivers/input/rmi4/rmi_f3a.c
@@ -132,7 +132,7 @@ static int rmi_f3a_map_gpios(struct rmi_function *fn, struct f3a_data *f3a,
 	int button_count = min_t(u8, f3a->gpio_count, TRACKSTICK_RANGE_END);
 
 	f3a->gpio_key_map = devm_kcalloc(&fn->dev,
-						button_count,
+						f3a->gpio_count,
 						sizeof(f3a->gpio_key_map[0]),
 						GFP_KERNEL);
 	if (!f3a->gpio_key_map) {

-- 
2.43.0


