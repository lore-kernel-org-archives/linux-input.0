Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898085;
	b=Rz+tCizqXyq+9C6cQWU2xu7DD75ujbiWLc8CT4Xo46gFXo4C16ZpeeDnxSWZO+1Vrxbm
	 6A4zykqny2X6ui8fdIZX7QIFNo82/VqVtdnC97hD58vDCxaTOE8743kZj/w81hETGR8fo
	 RQ/1WYxX9rkxNLV6HAFvHrwg059oJsfFQv9kazWZOxcF6Y3dTm1PD2v/a/Q9TEZIKtfk4
	 NQ6DaJJ+iTsiHFR8tlMdpwfUf38jMKx+e6uQmGWWI++YDCWsdmPFoEa5+XjR3+Dx6wwX5
	 yGfaZlHwnMO6Maaor4aGQ0hclIUfHtDgSWpYadZQsrVieypvk9eUUcIOXQTtqI6pzGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1Bj0+K8jV5yl/+WlXVdM+whsRRuk81dsUqfDRXtanZc=;
	b=ObIuMdg3+9fsARUCpuABX9HIsyUdsXBgves04eyxWA+WpPGos9GG5vUjtC5Kg4g98Apq
	 oEdiuiFABypVyjSRefuEF6agh9+kEQ7X+ZfzSgYPDFPyWDWwmeyVUwv+clFtjvA3UvG2K
	 u1zBSZFwOq7iEHhh0pPbOkjdZVNNRJ8QRtdpjZH/VYmL7EPU2+Fc8MBkNEB1J0LEg11Gu
	 aZO8UJ585KztD2L+wwW8m9t802zmQjjWVpSwLsfp9EFMxoCmIputZOmRT1mH96qRUrjIX
	 JXTgSqIjDl3Ibv7X9ZWAfTGdoBcQKhJEm8bFU3nN0ZYv/pWQCOE3dLJ4GO7+gcifZlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=grsecurity.net;
	spf=pass smtp.mailfrom=opensrcsec.com;
	dkim=pass header.d=grsecurity.net header.i=@grsecurity.net header.a=rsa-sha256 header.s=grsec header.b=lu7Fu7ru;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05610606D82C
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 17:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05610606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=grsecurity.net header.i=@grsecurity.net header.a=rsa-sha256 header.s=grsec header.b=lu7Fu7ru
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490c1d337d8so1129218f8f.2
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1793898083; x=1794502883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Bj0+K8jV5yl/+WlXVdM+whsRRuk81dsUqfDRXtanZc=;
        b=lu7Fu7ruhWk17tVwfHYq+9Cf6MZ+ltAqQ1RSTydkOwv3SypLfT5YWqU9zFrisGAA+i
         OfMDYAd8/AB8TcQ86vZpeTqs4/HmTYNLfULPSIK6KBD2RwvcR+HpwQ957XxcWgkPO0Pj
         7eCpjcNBTxpmFxmcplaLHFrS1dOLi4aowGrydTFin7RbBrS3SPECyvqfVwJcgBBi3chm
         6SnnE/LADV4UziNg3T9+3jOhHTcJSzEowOSyLYQwhP5Y94JvpypyRiLVthpLL6pAanxB
         ra0vhxSivqKBO33DCa3jSTMRvZxLfpMLqrg7AQUfSdrHleLLmmgqqhukfYDn2Mq8fF53
         sTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898083; x=1794502883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Bj0+K8jV5yl/+WlXVdM+whsRRuk81dsUqfDRXtanZc=;
        b=hXBy4XujJzQ3SXNe+vOMOUJ4ArYJoDTeCTbDcqcngY1bdD4Dpbx9jE5CYs43TDfbsB
         +NS1BJKBMTKm41iPDsm37Tlv9wdQlyLz3F6e+icbNChpw8G3HwHJUifiG+s7hueF4NBX
         YqLBZc16JDbnxHg1j7aDlA8YGe/+a2ttWA+JeCWkzQrSmXehzU4WHsoiw3KRtArenMiC
         JJ536IQhGqRceLS2TsgKIDvdjkBEKf3mlND2V5Hdmj7QcmgAdp9kJtsGi6qgDDeRtB/M
         /DypERpB6pW8y/lBLt90sXE8FtMcmbMvTmPhp9VzJMsE1JwGwBTdOUbW1XNC1dtjMZab
         C7Pw==
X-Gm-Message-State: APuU4Z9H9hI3YKZMGsh6AUHBXvVZg4UUPD/K/BlaMYryqoUQmwlAcrNp
	9DoQNKVxWIuHH20z7hg2bG5SlODLRiuDHaycBPrkkXG3yjVOaXT5vU1x3iWOVuodCQs=
X-Gm-Gg: AYBFou0J2Wkbxn6AZhcrVh/RtAzoGuS3Eev1lbdorqp7nLWddP2Qxvogd7LBq8PjrPp
	PAmrH9F7OnQS90jJ1HMDOFTTzMPly9eokUeu5LMvSjRd2zJVd/e+W359I+LxStZlWhDEPvUd2X9
	xlE2GQChDCxlUcOwOwT61PnTvE8N/UHocH35pEy1eTavkU7c9ngHaELCc701Uro5CF1BZer7xc9
	QqkBLCCBJE1tdp2zw6gTn5t6x5bJImwMxAeKmAKKrWJaPG76c6Fah7Xn680dikGkvw/uTKTopHM
	NYm2aR5yDkOc23XlRPrVQeDzfQ585MwwKQdZO4SZWdlcpZMZxoe3w5WPnrSDNd1cJt9ZOo5IQiQ
	X62zxWkkZeqIMjGNEx5EJUzUDKuxxPwQQKTiqTVeeOGNFSorKK1y1CzmTdkP5jAkPiBa2B2oo6E
	tCKlZBnc4Aaiw/IRjrr361jgIKOCQIoZy/WOY4BO6zkvMHcVCwNxad7FFIoL1LzQLJ1dQGE27d+
	XJ4LH2Ut195etmoUI14pF8cqnoWxknu2O4CU1nUwKpRHGjrD40UopCNDKri5yWRuMz37wNePSyz
	Z/9+4EhSllgbnEaWVLWYIrF+WExZLdoUKiFWgwWCf9tJ/J7F5fNd2O90GYC0kLmYuO9VKzhdNsv
	/W8YbRUpabhzsdBnuz+guTpp6
X-Received: by 2002:a05:6000:26cb:b0:491:e062:383d with SMTP id ffacd0b85a97d-4928030bd26mr175146f8f.57.1793898083236;
        Thu, 05 Nov 2026 09:01:23 -0800 (PST)
Received: from bell.fritz.box (p200300faaf11b90088550f04e79781cf.dip0.t-ipconnect.de. [2003:fa:af11:b900:8855:f04:e797:81cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d88e1sm11033465f8f.15.2026.11.05.09.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:01:21 -0800 (PST)
From: Mathias Krause <minipli@grsecurity.net>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH] HID: Intel-thc-hid: Fix REGMAP dependency
Date: Thu,  5 Nov 2026 18:01:16 +0100
Message-ID: <20261105170116.3193223-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel-thc-{dev,dma}.c make use of the regmap API and related data
structures, breaking the build if CONFIG_REGMAP isn't set.

Fix that by forcibly enabling REGMAP when this driver gets build.

Fixes: 1b2d05384c29 ("HID: intel-thc-hid: Add basic THC driver skeleton")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 drivers/hid/intel-thc-hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-thc-hid/Kconfig b/drivers/hid/intel-thc-hid/Kconfig
index 9d74e53b8c62..57a1e51cb512 100644
--- a/drivers/hid/intel-thc-hid/Kconfig
+++ b/drivers/hid/intel-thc-hid/Kconfig
@@ -8,6 +8,7 @@ config INTEL_THC_HID
 	tristate "Intel Touch Host Controller"
 	depends on ACPI
 	select SGL_ALLOC
+	select REGMAP
 	help
 	  THC (Touch Host Controller) is the name of the IP block in PCH that
 	  interfaces with Touch Devices (ex: touchscreen, touchpad etc.). It
-- 
2.47.3

