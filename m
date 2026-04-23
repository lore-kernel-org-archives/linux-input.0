Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF135B631;
	Thu, 23 Apr 2026 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776914443; cv=none; b=ufpXHjqje8eglModRQm4V6C1RzKVkEOPjg0x4I+aVOx3gxsRt1FaMeZF22Vpgg+jK2/PdX3dme1FzC/C7WRy76SDjgIoJ9ajVpmiQuEQF0kw1esGH80ksFm89x/olzPNPlFcIUg5ksjJdCqmQk35r8SSa3B5oEG5WMj4N70o34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776914443; c=relaxed/simple;
	bh=5CgyhDbPhy8LbimSoltjci/VydBXslygGu6M6EA1kqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=AVpt+hTsaX9hp8hx6U3hVSy5IJWmbC1ab8yyW7NjItY4rSMgee+V0gFw/cebwJ+yGatg43W+hO+Pika85fFT15/SvMVn8//bB9BItCRRgPEWxEunEmiBBdHgtjn1a5MrBCKvPLuy+FAuStvhxlNnUlcrjXB2thaESwOk4+bPd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auF3cUAS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auF3cUAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776914442; x=1808450442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5CgyhDbPhy8LbimSoltjci/VydBXslygGu6M6EA1kqc=;
  b=auF3cUASH6JgMq8aDE6fZSNY3+jBHzO1+oQMWKv9HfizldN++a/ShsVn
   +5/Zaspkw9XdcnB4/eIALLexUsliaN/3XtY/UFLEkFX3o/rZ31kzsTmKE
   CAYmnVaZE+K25Y7nWZnZbpx91IHTyyWsojIcehE99cdlVy8OomfUdpqVE
   41+WzjCVI2PDhD1Yt6ujcxTHK2tS35Ka0YTOW1F55De8wvl1JEZJfvbMo
   4LEXfLrCx61dpFY+4isllpvYBbi2f5PLxQYDztmH2Q5R0wjHlqNCvSDQR
   e0bwlH523+xlG8RthcwJFgil5/a+Ls5GLkEGHq6wQ4aNU81b8ZosZv35O
   w==;
X-CSE-ConnectionGUID: +T1nWLCHQMaA5KLIy24B/g==
X-CSE-MsgGUID: dYR0/ZFHScKnUeQhYuMj6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77858075"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77858075"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 20:20:41 -0700
X-CSE-ConnectionGUID: glNzgitGSZO8vNkh4WmruA==
X-CSE-MsgGUID: zLINBKiyRnevnQFI5Ne+NQ==
X-ExtLoop1: 1
Received: from lixuzha-desk.sh.intel.com ([10.239.146.213])
  by fmviesa003.fm.intel.com with ESMTP; 22 Apr 2026 20:20:39 -0700
From: Zhang Lixu <lixu.zhang@intel.com>
To: natalia.andre@ime.usp.br
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v2 1/7] iio: HID: Add helper method hid_sensor_adjust_channel_bit_mask()
Date: Thu, 23 Apr 2026 11:20:38 +0800
Message-ID: <20260423032038.233475-1-lixu.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421222210.16016-2-natalia.andre@ime.usp.br>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br> <20260421222210.16016-2-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 21, 2026 at 07:20:33PM -0300, Natália Salvino André wrote:
> Add helper method to deduplicate code in HID sensors.
> 
> Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
> Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> ---
>  .../iio/common/hid-sensors/hid-sensor-attributes.c   | 12 ++++++++++++
>  include/linux/hid-sensor-hub.h                       |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index c115a72832b2..3ee6e83c6cac 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -3,6 +3,7 @@
>   * HID Sensors Driver
>   * Copyright (c) 2012, Intel Corporation.
>   */
> +#include <linux/bits.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/time.h>
> @@ -589,6 +590,17 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  }
>  EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
>  
> +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> +					int channel, int size)
> +{
> +	channels[channel].scan_type.format = 's';

There is no 'format' field in struct iio_scan_type. This should be:
        channels[channel].scan_type.sign = 's';

Thanks,
Lixu

> +	/* Real storage bits will change based on the report desc. */
> +	channels[channel].scan_type.realbits = size * BITS_PER_BYTE;
> +	/* Maximum size of a sample to capture is u32 */
> +	channels[channel].scan_type.storagebits = sizeof(u32) * BITS_PER_BYTE;
> +}
> +EXPORT_SYMBOL_NS(hid_sensor_adjust_channel_bit_mask, "IIO_HID");
> +
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>  MODULE_DESCRIPTION("HID Sensor common attribute processing");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index e71056553108..6523d46c63e0 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -281,4 +281,7 @@ bool hid_sensor_batch_mode_supported(struct hid_sensor_common *st);
>  int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency);
>  int hid_sensor_get_report_latency(struct hid_sensor_common *st);
>  
> +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> +					int channel, int size);
> +
>  #endif

