Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC122A7E6;
	Mon, 16 Feb 2026 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771227858; cv=none; b=qrh1jZa/piQriM0dskdkuLA+vzM3omqNKGFqE/BI+UH28EcC96WrMt2LDC46MOPTchnJPrqZWANVE2wC1/kqfnff+ExPcg5jvFDCDgmwTcRb8uxHp5VZ5b/75qtvtKMFHcDFl/pmoL4SWgh544PSqmFnjkPcaVgPe+9qv37WStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771227858; c=relaxed/simple;
	bh=0t9gvbIpRZ92LD7qBBl+WRzwbncyyV+lAa8pHWlF0JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxBz5JE9zGiReffEuDUFzS2DG/i3lQXtCRX4J2r/EKstisrB5SPHwVszuuJSdJdR0IGp4+gtctPW9hOb04RCyF0BccogAiV2RDsCVi3YPjr1PXO4iDY4PnUXXF1f3RoTkp6dJpzZf12SnxYIExDGLrzV4z60XXgZQFHrLmIA9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyqxWhFl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyqxWhFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771227857; x=1802763857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0t9gvbIpRZ92LD7qBBl+WRzwbncyyV+lAa8pHWlF0JM=;
  b=MyqxWhFl7tInYg0/l6P4QqbTcIADWV+LFWUudMw85jTZ0A1qk+9LJt1g
   xOD2ZALlRa9GU2Au/0AnlfVqUUTr//+UKltJuocF8lpkLUy1am0OdTl1y
   6LNLXLI5RL/LNYCnGSBVjyjR7+zhflnb6DFMqtvaIODJ0oRuAKI7C8Dpa
   ILhK6ie0vqn5+lsgPGGTL7kSNoAJrRO/y5fgihekbYySvzzjmoSJPABPh
   +SNcOTteRaPewRQ4zGK6CtoU1MOWYmQo+ObfTE5/RBpnxy5/QBaSusvQ3
   0Q/c2DaZ8YlTvLdu0Z1mAKTdFSyxcvHqBIZN6gfvGj8wc34jO/ONGtIRl
   A==;
X-CSE-ConnectionGUID: YPWynBn6R7eLrjVPF9xaMw==
X-CSE-MsgGUID: xeMDHwF0TUaBv2NxsAq2JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="76149052"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="76149052"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:44:17 -0800
X-CSE-ConnectionGUID: 8PHq4HufQXmVYzpJK+fjfQ==
X-CSE-MsgGUID: D5jaA3i6SM6cg+I33zDWSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="218061740"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:44:14 -0800
Date: Mon, 16 Feb 2026 09:44:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>
Subject: Re: [PATCH 0/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
Message-ID: <aZLKy4l6OlPgIkZx@smile.fi.intel.com>
References: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 03:00:19PM -0600, David Lechner wrote:
> The main point of this series is to fix a regression reported in
> hid-sensor-rotation where the alignment of the quaternion field in the
> data was inadvertently changed from 16 bytes to 8 bytes. This is an
> unusually case (one of only 2 in the kernel) where the .repeat field of
> struct iio_scan_type is used and we have such a requirement. (The other
> case uses u16 instead of u32, so it wasn't affected.)
> 
> To make the reason for the alignment more explicit to future readers,
> we introduce a new macro, IIO_DECLARE_REPEATED_ELEMENT, to declare the
> array with proper allignment. This is meant to follow the pattern of
> the similar IIO_DECLARE_BUFFER_WITH_TS() macro.

In both cases it's quaternion, maybe be more explicit and define
IIO_DECLARE_QUATERNION() ?

-- 
With Best Regards,
Andy Shevchenko


