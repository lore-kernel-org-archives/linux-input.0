Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED013BB682
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101845; cv=none; b=eMIldcr2pVwsWdf44S4Dcu/GV7/wH18Zhhr9XFSdwsbnuwZIIsinEIvTn1DMK1u4hZROj1Aezw/Se4YsA492cF6ieVCs3wvAy+3vFZ8Tv410wSl+Vw1kjUobRb+ozsVqs5+3m1G4YnAkn9tuO8b3fR7v8MD2DconPFDEzxo9sTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101845; c=relaxed/simple;
	bh=0zLjl9mkMBOOhDmSCV77z2Ywd7ode1Ah9a1MkAcZ/OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxCkrcPvZJGg21XEp/L9Uoix9/A6RDEBTjl0sKFaRZWe1N9DuxtwodWrBgJQPN+Z3Hqnj1IIWJWRyYamyTig7zG0JSL08sK/Hi2NaQ7LbJ1/bMJ0SmNlg7HmFawTXjLvUUujobw5+eveeKrKj1BMpF/QU552fa3d9fK6Q1URC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVhvKLDN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVhvKLDN"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-85590c5aeabso1912987b3a.3
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788101844; x=1788706644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FijoARYQvxvOMp0D7nTD2Ip0kQ4rcp88ZBCNLuIH6S8=;
        b=hVhvKLDNRy/VjcsHchtrd6t0TtSQdeZPHA4DSF0cA9jmskQpjky6jIupP9L1P6XqpL
         nrEsAKgsru+Um9y25X0Npox2+WKsOWzRbF11VUpXaBS7VN+UjwziY2M27zL7WkQYCXWQ
         Vzf7DNO/brQ7wC152WjOnRTaFW3C3AtwEpScJUlPdvQAoYN9w95h831XrjmhdKodgAdM
         k1+KwkdD63ngxaViccSzhWnhF6GUp0yMbWwzN9VzHAqFlir7omzPvJfFz50bdEYvNXyp
         2hR4YO5BSTsoy5f4oAI8Pni9C4aoCWrMSt+wZo49iQpOvRN81SKzPOrkLkiTizPDoINK
         q7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788101844; x=1788706644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FijoARYQvxvOMp0D7nTD2Ip0kQ4rcp88ZBCNLuIH6S8=;
        b=ZgEba/cmQLrjkMD1Vm+Bgr/XVy4BBdKe65T1gu1401Y+eZZA05Yi502OYXTvqOH/w0
         8+/uTDfOObUZXQKl7gfa67QLpTV/gR9pSDZzn/XA5SFa/+Em0H03L62wpKcQ4PRcHqGn
         4bwIJf5mPGA3y9dlGBTK9vITA1TMcfr9IDjHMA6fetRmD9qIDuV0vPLVHoEMLouurQyh
         w6VfvOLlm4i9+vyPl1TW3/wyVzJiNuhfE69P14zjH2gQDMXsSAdCOR9q+11lTyoierqs
         OnWauD5m8Jjbw32IuvPEosh3h1E9yQaNhgFjDB4w91IWI8gS+8Z0wZbHfpSER8GHXA8F
         KnDQ==
X-Gm-Message-State: AFuF++lLW5DDFWlQi25+DZbA32Phpq2JAChkNIB2wZnsJOOvjDPVGMAY
	bqqbuwvQOR1IFBlA+ZP7orkOxw36zauyNoaoTFZ7OGPjGXwducZLEMqX
X-Gm-Gg: AR+sD11UPBWAbnfP4IZy/HOanUaUHsBbB+2/5SXB7I3UPTEpHFr9ypnqWz/zUcRqu4A
	6To8Yqqr3fAow+olzqGPbV+gqxGfrTRCsx1/di6qyKlBdYgfDswGBr8RxpdKYRMzOqqJP4dCAQm
	1fuSVly7FlRKYPQlzccIbjg3WefJpE8lSo8g/c7sV1MA0VkwXvBEp++GlTaUoNS9FDdvvQ3BTgC
	VwEjLAMaFEiwwqkR0LsE/PE37GeS8R68GIvWGMTvSJSzbZhJHenIO17qT5lD+xrqVu0kgb0XvFS
	ThkE/rfBWSZhYVDjZksorZq1WGvL+Rd71a2Vp6KYdNCZeQHHYjXJSDNLSqcdoqjU7qykyJBNeD7
	1jjZgk373gd1o+v1DaFsfXk8RvbngCSN7WQVOTq5ySocrF8G4FnQm7BFlqh4aPsLhSjnamjgb/n
	Fc8egwwXDstXL+GYajZHSJxfzrgzsFQ8XSFVP9NURkJmKGomxiEy2XZG1ehdEbJ/uBESHzeVjzN
	aQJDY3LKiGVbPDYscY=
X-Received: by 2002:a05:6300:6d84:10b0:3d5:3420:8d73 with SMTP id adf61e73a8af0-3d53420a6f4mr4844618637.17.1788101843292;
        Sun, 30 Aug 2026 07:57:23 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f959575sm23198024eec.15.2026.08.30.07.57.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 07:57:22 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] HID: hid-lenovo-go: reject unknown calibration action
Date: Sun, 30 Aug 2026 20:26:57 +0530
Message-ID: <c9b58da2e4247e179647c5eb902b93a33a37488a.1788096668.git.mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788096666.git.mradityadash@gmail.com>
References: <cover.1788096666.git.mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calibration action table includes 'unknown' at index zero. The options
attribute skips that entry and lists only 'start' and 'stop', but the
store searches the full table. Writing 'unknown' therefore sends a request
without an action byte.

Reject CAL_UNKNOWN before building the request. Leave Start and Stop
unchanged.

Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index c7a2e621a4ad..a4231d188b7a 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -1419,6 +1419,8 @@ static ssize_t calibrate_config_store(struct device *dev,
 	ret = sysfs_match_string(cal_enabled_text, buf);
 	if (ret < 0)
 		return ret;
+	if (ret == CAL_UNKNOWN)
+		return -EINVAL;
 
 	val = ret;
 	if (!val)
-- 
2.55.0

