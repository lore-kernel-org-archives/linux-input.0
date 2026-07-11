Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FD2D1913
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783779800; cv=none; b=hMsKgGTebhN9TcVb//5ccfPNWO2Da1nWcMYonXLc8bKqTaAOQXunvIIChmTBGtxyE4ni3s329BL0Y/300NNv4jluAO15z0L5FSJeHMlNraUePDAOpKF+PYe05TnrtnUAw39uPqZNUbRpt1L7T6ff94wdKVAoqwDmHGBZ69nCIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783779800; c=relaxed/simple;
	bh=Z3ysDAcu64wjIDQodnhoYELVCW9ak1YdOLc0SwLlWpQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Nxym6WUQkhPwKtw+iZATrR7F2m99iIaBmf69I7cqQ8dTsu9+oQlHZ+xGNv5wCEVUEAioSMmzr8X9kOUD7KxyWvedcoRakXiMURhw8l1yI8SuTGYL2uX8Hi6/Hnu+i6QMdhV08pxOmHC2JL/9kG3S7MeVaJqFS9aI16gJhwe1j4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BfzVkcsG; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BfzVkcsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783779786; bh=GOXnMCmSmoM1nGz3VQIj7fW9ZNHNn5zrPA5YeWIsyTk=;
	h=From:To:Cc:Subject:Date;
	b=BfzVkcsGAn3iwo6Mrj1RW8PZ6pLDNJ9p7st5uF3828ModoLUeUgT5ydj29sLZsqav
	 eZY5iZ6L5UbGy9ddrEvyUHDmKXdI+aISSRBmMAAu/L1GlT9CIvXcHQxvewpfiwdUa0
	 Y73akS0VYtPkwf14C3+sD66ZiaTCRGdjcLdv2/UY=
Received: from xein-revoarch ([2409:8970:110a:3b78:e88b:a1f9:882c:88d6])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 5B92CE30; Sat, 11 Jul 2026 22:22:57 +0800
X-QQ-mid: xmsmtpt1783779777t0qojfy43
Message-ID: <tencent_AC29AFBFF3AF614C95F0E2E59A721D595C0A@qq.com>
X-QQ-XMAILINFO: Mzcurg9uYAemhnUk//fn6lsAY+ANQCdz7KiBBWuvULNcV5gov9ArU7HogQsNfe
	 kYAg2Tcy8c2DRASriv0ysrC5GAjSngHgQsW9W6QUs6lDL+jC2LGoiUa5Wi7NcPIMxLjJXY1abHcz
	 E2aRqWnsgG33TtnCqR+0LQy3CTBrlRKTWVw8xwqbDh1QAsTf+47bkSU/5Zo1+KjUEdr+8ZU/iPhY
	 hs3cTk/gK7PTvCJKXCN8MsCR7jSCmmGwl8BJwY40M9mRpMR0MZicBJEkmlCeK7wTsBqx1tM6hDMR
	 iMUw4EYAPzt+FaGa3+M8BHQzXS6cQbmejhNGvKCfjPPBcxIl7X5fH8UieOr+S5NzxPyPgSMZcugV
	 nveA7UhoSmMIpS+6Bw2QUQfapuVpQHHKzfScWrZPubYf9tFD48+ArsbRYDpD4Uyt7wC7cmBYMF8a
	 7TclLTFcVIeLmrRzX0eolqXlRuxSZCy57vEYuSJrG8Mwk7ruuoFzQTcabJGET++7kD+WxKZjC70U
	 PPGzurvSWxLwfrTgLtWmSM9Suw7OVVlpXc0NluFY7Xdmz6TIWGoV7c3DR5Df87JSCjgFJaSHILX4
	 adEyIpXesfAlwxRwIUHDl29MO8yzU1MkNC5R02iZT+bYa7fobwVqq/JamyX7vd0FNOItNNDyie2G
	 jY4aqMEEhYajAzHyxrPKYRLnMa+KYu1Yq9dhl5FG+OGuJffe11U3UreAOJIlUy3y34Ihw4WSkNAs
	 RWEpjitSXwiubxBHKCOErBUkg0ZXA5pmPSlKdSwtc877ftm/WpWSe4IcdK1sM0/RT5T1/Pm3CsoV
	 aIexW/Fvy2zMKgUHz2KVpxu2LBJES5HHeEmQcbx40tC7ZV7c7ncwVzlgoeTGOBgltK8Tc/BNlOZB
	 GU9p8SxJzxDBiNoWVuzg83W+lJW8kmoP0jjb0h4JcJ7tvyH0g9nWRJUOaA/dJGnJDhbYdDlihoG8
	 mXpUC4b0DLSEHRWGu1uU/tiqI0MPeoATAajj7bqg6MgG+Io+WsXty7h1q42BjGkdmzMiMJZksV3d
	 caz/eaHLv2VpSRyw1eBfaU+au1cCs0muWACk6jRcn/ZLGAn8qs
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Xianglin Lin <1021538027@qq.com>
To: Jiri Kosina <jkosina@suse.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Xianglin Lin <1021538027@qq.com>
Subject: [PATCH] HID: multitouch: reclassify HTIX5288 to WIN_8_FORCE_MULTI_INPUT_NSMU
Date: Sat, 11 Jul 2026 22:22:55 +0800
X-OQ-MSGID: <20260711142255.10193-1-1021538027@qq.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b5e65ae557da ("HID: multitouch: Add quirk for Hantick 5288
touchpad") assigned MT_CLS_NSMU to the HTIX5288 (0911:5288).  This was
necessary because the device sometimes fails to send touch release
signals when transitioning from >=2 fingers to <2 fingers, and
MT_QUIRK_NOT_SEEN_MEANS_UP fixes stuck touches by treating missing
contacts as released.

However, MT_CLS_NSMU only carries MT_QUIRK_NOT_SEEN_MEANS_UP.  It
lacks MT_QUIRK_CONTACT_CNT_ACCURATE and MT_QUIRK_IGNORE_DUPLICATES.
As a result, after a two-finger scroll finger lift, the device still
reports stale coordinates from the released contact in subsequent
frames, and the driver overwrites the remaining active slot with
those frozen coordinates.  The remaining finger appears stuck at the
lift position until all fingers are lifted.

This was confirmed via evtest on Arch Linux 7.1.3: after
TRACKING_ID=-1 for the released slot, every subsequent frame contained
duplicate position pairs -- the real moving finger's coordinates
followed by the lifted finger's frozen position, both attributed to
the active slot.

Reclassify the device to MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU
(0x0018), which preserves the original MT_QUIRK_NOT_SEEN_MEANS_UP
fix while adding the necessary Win8 quirks (CONTACT_CNT_ACCURATE,
IGNORE_DUPLICATES), preventing stale coordinate contamination.

The additional FORCE_MULTI_INPUT flag is harmless here: it separates
the mouse and touchpad collections into distinct input devices,
which is the standard behavior libinput already expects.

Fixes: b5e65ae557da ("HID: multitouch: Add quirk for Hantick 5288 touchpad")
Signed-off-by: Xianglin Lin <1021538027@qq.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2722,7 +2722,7 @@ static const struct hid_device_id mt_devices[] = {
 			HID_ANY_ID) },
 
 	/* Hantick */
-	{ .driver_data = MT_CLS_NSMU,
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			   I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288) },
 
-- 
2.55.0

