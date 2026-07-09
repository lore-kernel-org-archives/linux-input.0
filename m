Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA739182E
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567428; cv=none; b=VKepbW4vbY+ojLkfXsgP4WIHMQl1KhRNmJbQwon7/HAVadZ+NGOtj0RBZShKgCQId7KvQLK/9Yqabfky1TNbQTlg8cYRwHq3oDGQIZ92gOHa1rI9wNV4fxhnUIBVVzzWzr7IwZac8P41zj2pznPpekay8NJup5FcL3dYaEMxzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567428; c=relaxed/simple;
	bh=ipMzd2Q9rTLbjHk4rCTSs+Y83KRqU+HbVYm4y2CylKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toDkO1CeZGsiPc0L3hdtbzdAUFbZCvy8jbqIJedt+1qxhg5yWTvwPZuBEFDRg/Cj+zLU65QFRMQXRbPH6M5w/qNMl26VMPUyppFDR1a8YaC2lE7xaRzRudFkH+T+1918EnxygSz8psSENgnPBnmAq5VgEW6hGGR4HSOAGuFmvdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZIam4kd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZIam4kd"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e6c4a867cso75644385a.0
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 20:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783567426; x=1784172226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxuTQ6FNrwZNnL47C7xvjgXyQjEyIq7herBQaioqzY4=;
        b=LZIam4kdk/e8i+gy6MVHYPMrZ9Ft+4wvzqTDYUdCuNEJvq9oGKzideA86WDQ8JVfhc
         WJL7MWxujdowV4XVqoSAudqJJzGSP0SxHz4/SN3HyCvrGodS8g9G0ihyAkNLgykzoPQt
         Ovm9tCTKNqEzyVbHfgy/r7fpECNeSgW5xGkUCkkApfMUxc7l3lT9IuN6t9xz/kMLAa0W
         qQda6PZh393musMY08fxjdoorOFgP18LIKCq5OosPnvlvGjxwpepkiuA9iWLuELEF3vG
         iR2nEXSaoUCehJN3WuO6QfIRxCJ37vR6XE/1j31wZD+MPwX9bjAqUlwlHGa8ah21Srod
         Wsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783567426; x=1784172226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dxuTQ6FNrwZNnL47C7xvjgXyQjEyIq7herBQaioqzY4=;
        b=HX8xUnTkwT+o/TlS7yqUWQzQ7vw6zLj2Z23alykTXERhIoSOpRZsS4N+NVJhlpHzSp
         jRJ/2+EM3gSzmA628yd/+VYLOR1bmbmzFVtxaabBEnxoIT9+IDh64GwohvdbNTuIUEvX
         s4ktJkxcBRomZAHfmjY129eXCURo+khwa3QpcjCGbGyjXtheY6F6tNmL60bnaWHo5n61
         g6VDiUBvPitVIwFRmuNlNklohFr2ZK0xS0ZqI5F5kl3IMZfV3R+5kULd99z8xsyy//if
         Ldw0RkV0b3tA1diPFt+rlaUjiXM4wsyC7tDqr1KoKQKjcKzqEj5ArUwmODMEN8cELuRe
         Nzog==
X-Gm-Message-State: AOJu0YyybM4p15nQETP8/x4pQYqgk1bNqeRIRI+6udQHYeFmLqUfEYUR
	9NvTUEqhx/UC+mPYubrWpg578H9e3Fy1DeV1hrtmfNBUr6vUOhKERlSm
X-Gm-Gg: AfdE7cnPenk71FShQTv/Dxx7zNd7CYF619zNRe3LVhwb9ZoGthPkE2/6vs2vgDf2nUq
	B2sQmdNRqxLdyg5/ndEb0FAnWFvzv4y+32mYvrGHgSvBBJmPdwCbkCOuvtenzDnOaUrUc0GTX97
	fnBfNrxrW+Ku6qtLZxQplJL8wBDKWXw6pOzM9/oS/4M0MUMHklii29aZCoKZAS78wZA0RLB4/VS
	VxCBUTNEsjPg+K7KuZ2v8eL4s3O2dZN3MqpGbYyjadPpx1d/HvWY9xud0UqHwyjDkXTBAYWVLIZ
	7j/jduwrs7DSg7B+sbMn6qI4Mdn4pBml/15oCl/u03LT0ZumXPY/xUUsGBIqovuAtuIAIhCcexc
	DDbpM7Uu2CaV4+ZhS1ZEWOr8QX2dl6pUsPTpXbQDA1FrF0mBR0yn4cpT8TCjwPrla15QSS0e0Se
	2iXngD1JXxG6SY/6L8GwDB1Cg7HOnOTNVCAOhL9X4hqiW60Dk9Yltxbmxfz3VRTGSkOaYCdcqZO
	vJfNMBa
X-Received: by 2002:a05:620a:294a:b0:92e:72cd:325a with SMTP id af79cd13be357-92ecf5b4798mr503161885a.15.1783567426029;
        Wed, 08 Jul 2026 20:23:46 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e9c0f7de9sm1336872185a.26.2026.07.08.20.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:23:45 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
X-Google-Original-From: Sriman Achanta <68172138+srimanachanta@users.noreply.github.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v6 6/9] HID: steelseries: Correct Arctis 9 battery calibration range
Date: Wed,  8 Jul 2026 23:23:13 -0400
Message-ID: <20260709032316.1908460-7-68172138+srimanachanta@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriman Achanta <srimanachanta@gmail.com>

Map the Arctis 9 raw battery value over 0x64 (empty) to 0x9a (full)
instead of 0x68 to 0x9d. These values match the HeadsetControl project
[1] and fit the calibration points from an independent reverse
engineering of the battery tray (about 25% at raw 112, 50% at raw 125)
[2].

I do not have this headset. The values come from those references and
were not measured directly.

[1] https://github.com/Sapd/HeadsetControl/blob/master/lib/devices/steelseries_arctis_9.hpp
[2] https://magnier.io/reverse-engineering-arctis-9-battery-tray/

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries-arctis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index 7b8f5f2623b0..b54f20f081a2 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -141,7 +141,7 @@ static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
 	if (data[0] == 0xaa && data[1] == 0x01) {
 		sd->headset_connected = true;
 		sd->battery_charging = (data[4] == 0x01);
-		sd->battery_capacity = steelseries_map_capacity(data[3], 0x68, 0x9d);
+		sd->battery_capacity = steelseries_map_capacity(data[3], 0x64, 0x9a);
 	} else {
 		/* Device off: 0x55 (no status) or 0x03 (stale status). */
 		sd->headset_connected = false;
-- 
2.55.0

