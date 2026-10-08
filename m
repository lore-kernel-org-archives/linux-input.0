Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293F13FEE;
	Thu,  8 Oct 2026 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791433044; cv=none; b=VUbTJBWtt/81baA9hKiZueBWnJUooqx+Bajlsi5nqqtngzRBY3gTYVQ9IE5KkNRYrmzTxkASAmatpgsWZLfPpqObHnFK/YxPfagT7DGjO9u1mnR7hI3vPPOjo7T4L58YxxprnsFUTtNDCRnqHjGxKlBqd6mC2cwdX7MhIwWHMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791433044; c=relaxed/simple;
	bh=ICoeoosIWbTj/bG3WY0JednzspW3OE5fElre7njVj3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZsZXXxS4j5EEa620e+AOk3E6ahL0JMTIOnFcQ/XkBtuIkiX2ZnuVcLNsF4ltYT87kZQP9gO528SNPSQLiz2ED19/D+qt2+dotFwJk/X+FJFmg5IyJjW0IeuXoKheWY8QFvv/D2J+T7M2p4jgKt0TS0sSQRLRGP5RJEFCp/jryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gd3oPJ83; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gd3oPJ83"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791433042; x=1822969042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ICoeoosIWbTj/bG3WY0JednzspW3OE5fElre7njVj3w=;
  b=gd3oPJ83XGb+YLcb9aWk7ek1lt+DYzyJXAq99wIgeLGYbODgkLV9/A9X
   GHBol4zPRy4N0yGZNpBOkrVj2gz6Dyvk4R9bOMrg6ax5QGpp1DRXurW8P
   qYlNWM2dGD1AIEWOCDRRIstqGRbN9/+opKy365LOWaPkKhWYSOjWcuvX/
   PwHm6Snd29BolIMs1CC+58WsSCBBb2vED0tsEwRZRVrFLN7Zo0/wcCkWd
   QABzKy84zEdrxWJGL3ypLj+DqNcibH3Ja8XuSAm3CBsbt2GsnXo4sV8C1
   zjI3VDETj0PC4p+Juo4GvLhpny8h4Zr1AXxRtG7yGk8hfqV1w7QvOv2DU
   Q==;
X-CSE-ConnectionGUID: 5jJqOiUuQOKQIqlceT6+Ew==
X-CSE-MsgGUID: cT5XPE/WQLGr4Blx/60z7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="93666"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="93666"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 21:17:22 -0700
X-CSE-ConnectionGUID: 1X/HIWkKQfaPub1ZSubZsA==
X-CSE-MsgGUID: 8OfYMzt+SP+/v2se8fG8kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="229129"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Oct 2026 21:17:17 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEfZC-000000003yS-1WSy;
	Thu, 08 Oct 2026 04:17:14 +0000
Date: Thu, 8 Oct 2026 12:16:16 +0800
From: kernel test robot <lkp@intel.com>
To: Karl Mehltretter <kmehltretter@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Florian Echtler <floe@butterbrot.org>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] Input: sur40 - fix DMA handling in video capture
Message-ID: <202610081252.0UqYKs2X-lkp@intel.com>
References: <20261007054430.40155-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007054430.40155-1-kmehltretter@gmail.com>

Hi Karl,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2c3418fffa9d037b2038a6db48be63f9e2291806]

url:    https://github.com/intel-lab-lkp/linux/commits/Karl-Mehltretter/Input-sur40-fix-DMA-handling-in-video-capture/20261007-074430
base:   2c3418fffa9d037b2038a6db48be63f9e2291806
patch link:    https://lore.kernel.org/r/20261007054430.40155-1-kmehltretter%40gmail.com
patch subject: [RFT PATCH] Input: sur40 - fix DMA handling in video capture
config: arm64-randconfig-1003-20261007 (https://download.01.org/0day-ci/archive/20261008/202610081252.0UqYKs2X-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261008/202610081252.0UqYKs2X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610081252.0UqYKs2X-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: drivers/input/touchscreen/sur40.ko: module uses symbol 'dma_buf_begin_cpu_access' from namespace 'DMA_BUF', but does not import it.
>> WARNING: modpost: drivers/input/touchscreen/sur40.ko: module uses symbol 'dma_buf_end_cpu_access' from namespace 'DMA_BUF', but does not import it.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
