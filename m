Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254396;
	b=gRDxpNoJcZQ+fzhWPJk3qmQ0/0xX+t3Ij0Wu+zmnnH7TWLWB40lS2J7aK44ous03kdeg
	 z0JYWIVb9qxX7rMqUDJSwKSJnoGYXiUwoHTLBVB8xWBBocrpjuD2YRSvXywbdd8JWT964
	 DS0co7bLmkVsQnRniiLGpAsUku4pSF2v3ClJ66pdc/9xY43Le1C/WKWw+PSvqrV9xGup9
	 MobSsM8GR2+MH+IsAgLVeJn/xhXruPc4py5BfH24W+IcrUIDRGZQiB3uBrq+TIrCS13R3
	 ppgUhNtwaPCpgzwVpZnASRfM5GiEWE/vwxOJgsFU7aqYvcwHAB5W05bVEGx3k0Q1zEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254396;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A9yGIPf+Aoyw5oiXwa2KK5sUqghRssyWxs9xKam9uCc=;
	b=Spf41SInNQH5qFn/CGv2EVwsOOLRd3x23RhrAnUM/WM1122MBstJo47WIFqV3S6tn2cK
	 lmlHrh7VLIhDgMo7nf4bU+H5t6JRU45Zi26SeXskwNY3JkWjkczdGU1V7jpN93LZSpjKp
	 zgi00ZlEid0LMyvx/1TA9B/XYTUs8NFOL1LjBb7rfTZzK3hTpAOwOqn8Fw5b1SEV4XDiz
	 DHq2eI5Myy/rjtgBYS2ogzdtGPDJXTRqxDZakt3k61XMaqd4RWJk1c8ttX5tQvCitu8sT
	 IszYUebBPHcdRX5LMKPfAe5k2HvnqgBFV4QK0mTt71mtTT5VHN4CUzAB61PRIb6GmIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fup6WEql;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3569606A336;
	Mon,  9 Nov 2026 19:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3569606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fup6WEql
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254396; x=1825790396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FP5/RsYhahtAfZDc2I1eI+qvRqzM7YupqPpLjENq7N8=;
  b=Fup6WEql0VlU7Ha4jQpC8Bab+9TvkfvFvzV3caaC6ePjJfWPkwhp0YbD
   /kDQp/UhAsBn6lPU93iJfsYizblv84/WrQ4Ezv+5sYQHBy+YpyBDXVeyo
   zBzFIbvwUmGzmcuLDnxolI5LL9dxmAXrSUZgx+hdqHiskn3Zy0uvQ3Vi6
   Y7oqgJn33zumCGXGMtzmkuHfYHTrM1gRa/16Wa0a7vcwyUHNFhqUflRiz
   JZOTFKpVSZUrIpd+Sz88h5U+P8QjhAt8z8hsUW8FRVRos5v4abHSV+WSM
   mEU/Kyj1reNfOGnWBWEhx1E/Vewf345jiYrBTKyTjeg532vwAcZZ9XM8M
   w==;
X-CSE-ConnectionGUID: HwtW/tznQ0K83Gnv6oMXHQ==
X-CSE-MsgGUID: sC/pWsidQeCikY46GNoMOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2986562"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2986562"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:59:54 -0800
X-CSE-ConnectionGUID: gN/Ag0suS4Ssnm2BN1eJyA==
X-CSE-MsgGUID: A6nkNwa1R42UrD1Ttl7AqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8090658"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa005.fm.intel.com with ESMTP; 09 Nov 2026 11:59:54 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	simeon@maryasin.name,
	lixu.zhang@intel.com,
	crofts@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 2/7] HID: sensor: custom: Set owner for misc device
Date: Mon,  9 Nov 2026 11:59:44 -0800
Message-ID: <20261109195949.384888-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com>
References: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com>
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

Set .owner in the misc-device file operations so open file descriptors
keep the module loaded until their release callbacks have completed.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Reported-by: Semyon Maryasin <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Reviewed-by: Joshua Crofts <crofts@kernel.org>
Tested-by: Semyon Maryasin <simeon@maryasin.name>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index c12272479d82..3a65da64fd2a 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -719,6 +719,7 @@ static __poll_t hid_sensor_custom_poll(struct file *file,
 }
 
 static const struct file_operations hid_sensor_custom_fops = {
+	.owner = THIS_MODULE,
 	.open =  hid_sensor_custom_open,
 	.read =  hid_sensor_custom_read,
 	.release = hid_sensor_custom_release,
-- 
2.56.0

