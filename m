Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6CC280335;
	Sun, 14 Jun 2026 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781415371; cv=none; b=tdF5VhIC1iTiGvY+bFnR+A4gmrXoknNZm+PhH04787HphOUVasKnPEYqZNFLCtYDkMy53M5OJx4GTNClT+Ry1lbmzakJUya2bWgbsmEqqJ5JQlj+redXabEXHVYtgmJr7x8InFLsKMLeBn5fj5Wyy7yleRHKEsYXeJq+0uHLzQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781415371; c=relaxed/simple;
	bh=L9Q/cVEYoi9hU3/OOYHTg1MTSjKB4O4+uylfJIbKrQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lisI4BJA54eAorhu7GPoUxLxQhNJ3AJtFJD3CorqQHUr4T14No6l7i3wQLJ7ayb7oVpPq/R1UMDpX9f8zUgsMg2GQZl6Ryys7ZVJHV8pcpaacSNN07GpnbTZJ9YNDG8bmLEg2k7Z+MxKU+EKWXAZ+HGkYwO5ngU77e4gwxSAuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgibFWUd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgibFWUd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F11DC2BCB9;
	Sun, 14 Jun 2026 05:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781415371;
	bh=L9Q/cVEYoi9hU3/OOYHTg1MTSjKB4O4+uylfJIbKrQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EgibFWUdWZsobkzCWtPiVZJ0vYCC4iTnKbriQt4O2tM0hjsVT0OkDoKnrecEUs9Li
	 V7ncIsv0p0xgZ6BPh+arDxsQoY1Md82Ot7/orlaDwnwRndq/tWrHQXdjwg0xon2zuL
	 u6O3RfQ21ncV3To3CKC7VTi74iBhZ48TrrgCZr+zO2tBQrqABO9+nKdrihw4KAN8Dz
	 fOcga57yT8vuWvwmrl8+E+oMyJ7Ar78jI7TiAPHk+hEUiQfnbYrK6VbGLeca0qmHXi
	 BzFcKlnt8Tkpoucp8jjA1EMfo8OCbwTb91nvnMNEJXqCNqL4/XVS8fpYmzZj1PmgDH
	 Xcxk0mqFbzY5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE67CD98D8;
	Sun, 14 Jun 2026 05:36:11 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sun, 14 Jun 2026 00:36:12 -0500
Subject: [PATCH 2/2] Input: synaptics-rmi4 - bound the F30 keymap to the
 GPIO/LED count
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-b4-disp-818d6bda-v1-2-cf39a3615085@proton.me>
References: <20260614-b4-disp-818d6bda-v1-0-cf39a3615085@proton.me>
In-Reply-To: <20260614-b4-disp-818d6bda-v1-0-cf39a3615085@proton.me>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, linux-input@vger.kernel.org, 
 Andrew Duggan <aduggan@synaptics.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781415370; l=1673;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=qeGYmDQV4/varPHdBXmYNMaMCeZqzNjTiG7YT4l+RVU=;
 b=nMwMJdDCpdLABBi8XPZy7jhOOjVibgWW+ZbHJIb4P+d5n2bTFYGaDi1DqbJk2ZXPEONnCe/rK
 oljTyEbu4m9ClWO3Y13eN5V1Hp7QViLj/3px8RqBkfjW/pKVecBKeKh
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

rmi_f30_map_gpios() allocates gpioled_key_map with
min(gpioled_count, TRACKSTICK_RANGE_END) == at most 6 entries, but
rmi_f30_attention() iterates the full f30->gpioled_count (device query
register, range 0..31) and dereferences gpioled_key_map[i], and
input->keycodemax is set to the full gpioled_count while input->keycode
points at the 6-entry allocation.

A device that reports gpioled_count > 6 with GPIO support enabled
therefore causes an out-of-bounds read on the attention interrupt and
out-of-bounds read/write through the EVIOCGKEYCODE/EVIOCSKEYCODE ioctls,
which bound the index only against keycodemax. This is the same defect
as the F3A handler, which was copied from F30.

Size the keymap for the full gpioled_count; the mapping loop still
assigns only the first min(gpioled_count, TRACKSTICK_RANGE_END) entries.

Fixes: 3e64fcbdbd10 ("Input: synaptics-rmi4 - limit the range of what GPIOs are buttons")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 drivers/input/rmi4/rmi_f30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
index 35045f161dc2..b2155c8e20e7 100644
--- a/drivers/input/rmi4/rmi_f30.c
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -233,7 +233,7 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
 	int button_count = min_t(u8, f30->gpioled_count, TRACKSTICK_RANGE_END);
 
 	f30->gpioled_key_map = devm_kcalloc(&fn->dev,
-					    button_count,
+					    f30->gpioled_count,
 					    sizeof(f30->gpioled_key_map[0]),
 					    GFP_KERNEL);
 	if (!f30->gpioled_key_map) {

-- 
2.43.0


