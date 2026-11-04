Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823253;
	b=OHw2rHBaqYl9KS/XnoF25vGd8AM1HNdYFFXlJ/XFmxA5buSH6rjNUWofTsHX3DZoeFPE
	 CDZAdHuZ9AvSz3gCmqZ3yym6dBPnMUxQwYqNq4NvEfq8PZW4Bsi3byEokfdFFbfOJkZyy
	 8/Qtht+lBwvUfbpIXjb+4VVB9P1Khs0r1qQHD+kbtHT1o90wZU52FmjUm+l4MI0LJXF19
	 jtl5G5iK/Oe67fHhqWiifCCJFSYPjkMNOyyvtWgCvsWwjCRx8fXpx3/YRHcqJWo2iqOGT
	 mCQTcJd+OYYgSu1VJiRQ1ejQ3lI78jH5eCA9t2HodqCfMK9SF2fyS9qOm2eQdt/JfPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823253;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=C9K6AlwxvZkRAhvXK7JDreQoWQ/mL7LoB19bzXeoukw=;
	b=4holMV6EERD0g7GfIt09zIRzo16Ky7PPS3WF5Scy6HKdrcrUxEhUt8ktX444vgG6zNoZ
	 upy7ilC6bPYEHl8iv7tja3aBdGXBBTKCXtB9dSttTfBreW1ruFCVckKiKHWZK58VI/Uqu
	 YxAG4uXlVYR2XmPJU211BRhYd5dxanK6Kl6lnsKCYza7C2iOWYUSOzkhvlgXdR8vY/3Q6
	 mZM9wcWMW/aZTsxniKMHgbfgUPoi+4ebJYhtWsx0fMgU6Q6d8jFmPOF49o1S+lwQ9P6Hd
	 Zf1aQ9POiJSGVBKkuekfQSkmahefmKh7kb1Y3kknd4oxF1M2YqR5hssd3rKTGWSFuZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kEMKso78;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366436081763;
	Wed,  4 Nov 2026 20:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 366436081763
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kEMKso78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793823253; x=1825359253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=liY6DSpUkOf2amiuHUrMfaWnLp1daeWOd7Iqh1oIb04=;
  b=kEMKso78uWI7yn69UG1FxcviBGx0jxiklAiFBVqndlHdQ7b2MT19jdnF
   zjNRXYNJgKZZhfmR+rOKbOy+B/rE4RYGeLEGeyGsha7/eWWtAu4c2YGGY
   XbRm6B/dY32g0hG1o0rwX08wf84Jn1uLoOwfsM/b0Cz11ffgJGPMQktQ4
   vh+FuqtJYgmGGoLspx1AloCJaAPVwMPPkkDNufjgSAtM1ME6JMYHI9k4N
   Nkj/Bhdeoi3FngUpllK5rUMAtraX0mVX/wFUj2yAf1pCU5+z9sRfSIk6K
   vbVSD6YKKUIABfqinPWQ0B5olSA41bEqDOVVYhTfJ0cHSfuhjlIRwVrtn
   A==;
X-CSE-ConnectionGUID: nz8viL6BQMehm6pPQbUteQ==
X-CSE-MsgGUID: j/hUzGQNQQC01bdfo5uX1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589114"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589114"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:14:12 -0800
X-CSE-ConnectionGUID: qPEV7GeTRO2Lvudgv4u0yw==
X-CSE-MsgGUID: RzVpgF8CSkCf912jyHe0qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6925630"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa009.jf.intel.com with ESMTP; 04 Nov 2026 12:14:09 -0800
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
Subject: [PATCH v2 2/7] HID: sensor: custom: Set owner for misc device
Date: Wed,  4 Nov 2026 12:13:58 -0800
Message-ID: <20261104201403.2039921-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Set .owner in the misc-device file operations so open file descriptors
keep the module loaded until their release callbacks have completed.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Reported-by: Семён Марьясин <simeon@maryasin.name>
Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com/
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-custom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index c2b425afd951..72e5639cb1d9 100644
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

