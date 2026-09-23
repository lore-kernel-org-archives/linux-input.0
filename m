Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8013E639B
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200076; cv=none; b=Wv6EKlnJ1C7Qpf0+sV1IB67DzRyAWxkL47U0OmJticxYrZYVfEjniYYTN4HDNnimeP5wgR0Zb6/MIQR5X8UChNzh6zCGJGL2cG8bzr0AID8fzGXegSLuiv2/UZQQpye8B/S+fh0elT+v03DDXcVjYGU5+PiWRUu8x4xCHOJKan0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200076; c=relaxed/simple;
	bh=bx2ZDT6wM9avjFk9s3hs+2FsecCtMhGmoJkQNkCi8LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PN8fw2rAkXfCDRCE09ZENvTb6jJVJibY+G1symWGzdaDfAF5cHwWat02ePxIDIbuLvjvc7Ve3UZ+qeCp3tf0lB14aayhzd/IL90y4dRgEA8LDfVd471NTJpkhrrXeC35lc9i3PDlORvDd4qtlRyYb1Rukfhzdz2mfRb5EOgAdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/0w+y7z; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/0w+y7z"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398cb5615deso1108756a91.3
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200074; x=1790804874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TVAYOBTNEVAkzNmWopVbzpKk0XjIfuhkQ+/cS4DRbJU=;
        b=C/0w+y7zyjOt3N2iq57LY8lSZcOVEqr+vUsLAcRT4/yk2YhCCDaemLA8uc1/xmNRGm
         M5pNOmot4niN9jj0/DpeFapx+zOLn8FllGStBleBr0Ewc5aMCne2X/AMhg/JLp0df/5v
         z4VA2CyyWHqjdSJmhFI0xoj4FENoQe+CRt4DBxLY0ooNNVw9hV+/s0DGTiTc9kmGc/zs
         iFHojrOtsGCdi1WeQHW0TNelRipiyYkEPX1VOORhE/yTX2vCYHMUqXo+xI2p4lxOuu7Q
         5KeVPnDHLTRdfyvh8HnJ0pWTMsZMX+K2B08ahTlLxiaPBa6XnK5NayTJU993h/QVXRlg
         u5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200074; x=1790804874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVAYOBTNEVAkzNmWopVbzpKk0XjIfuhkQ+/cS4DRbJU=;
        b=IFANUP/K7U/0rzBXS49Uu2cMVEgtjDBXw0gPaj8/8qZjpT/R5SZHyGTl6M/+FvWa73
         dliH6j6K3T/RruNtOPOlx8dchbWqbMucEJxoZsf1jroUPxcb385XiKq0wsxUbb2n3K89
         5rrD1jRWxACTBba+Q0YYhb0W0DKoQo98WckuIeXaH4J27Hd5Wn3WVGEgdy3i6PJ0CNCq
         oKK3XnwrZ060D/Y46uotiZhuHqizxSKI/oWxDgcIk7myGvcv2hGy1zJuZ7k0YLkLbRmG
         iAbSm2zqM+/5M1ZXS21ymwzu0/Mnul41ljPDBrO6bDAfH5gWSutmnyMEUEcQJotXyLza
         0juw==
X-Forwarded-Encrypted: i=1; AKwUvByOFRwNRaxDaDnFV7TtNsEOKXAV7QQHJjuhaqv8eD3f8Y03l94KATJHQV0i9a2Wg+TIEwKsUjzsjkhOWg==@vger.kernel.org
X-Gm-Message-State: AFuF++lWiglIHkk94vavioP0mN+dsNz0l927OXsRlShl86ssMy+sPsng
	mfxY+jt1uQW9R+2D9q1Ho0WFuWjG/3gpYovggNSoPqSd2gkWDWMBIZYt
X-Gm-Gg: AYBFou3QcA8nAI6EJq+Wumn9Q4txsAUKHZuJnszsrFRWlogMC4Gx87Nx4DTZt3QLrcu
	D+jY9DIEjFMTGwSTArdYNmK2JbvF+hPGZn2xzyN2A8F7VAV+LRwsYgvrUyG2GISm5mhtluCbI7t
	9JWMhwPKybGmcMo7mI76QphmYpyHxE7bvSh4yKuJs6lN/zuQtD40I/rGjWJI+fIj9C528HaqjeK
	29XWBCgyWWs0UoFAX+vJ8++d3i0t4QkujZN9Wzb32mSJR7hY9mxK4hh31Z/O4ENwmdmDfBYwGd3
	NGyzc4+Ob0wsAZqNsaxTUeP7yIQZCXpP5FFCDEuCw/hcgoNNPMRfK4za+LImgzIKj4PCgfyMiZj
	+Z6xSyJVJOt5m+XnZSg7vs14/MPKysrb4QHOm1ixCDoHFJYFVtv2cUnYLTPLmd+44M8A7JSvyOa
	FMN/vCqsD/eYyS7yMyLk919yCXl29GYSksi/L+Luvk3HzvHW+SFjDqApu5Yrq0oJLpelYb
X-Received: by 2002:a17:90a:da88:b0:3a0:4444:ef1e with SMTP id 98e67ed59e1d1-3a098dfb13amr366559a91.29.1790200074333;
        Wed, 23 Sep 2026 14:47:54 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:b51c:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0813318c1sm2355169a91.4.2026.09.23.14.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:47:52 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 1/2 RESEND] Write shared touch initial status only once
Date: Wed, 23 Sep 2026 14:47:49 -0700
Message-ID: <20260923214749.18635-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping Cheng <ping.cheng@wacom.com>

For consistency with how the shared has_mute_touch_switch is handled during
registration, let's apply WRITE_ONCE to is_touch_on too.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
Note: no code change. Just commit comments and code comments change to the existing patchset

 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8dc7aa1c0a26..33fa491fba92 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 		 * match historic default.
 		 */
 		if (wacom_wac->is_soft_touch_switch)
-			wacom_wac->shared->is_touch_on = true;
+			WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-- 
2.55.0

