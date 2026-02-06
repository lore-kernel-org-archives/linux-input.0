Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92C346795;
	Fri,  6 Feb 2026 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364552; cv=none; b=oewwPJnYgUjP44qEEmtBowTOYxidAadtWP4Xt4RRTZx4jnaATeQXqoqR1KFkhckQGeOjiBcyStmPXRLZo/9fzPLkdj+RhNqH7iJ32I9WB6hkhfUXksSZXJVH2VlB+mxcPaYJmpgUoXUA4VwrofO1C0ZMbJ1B2ZVygaHTmsz+dtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364552; c=relaxed/simple;
	bh=MOOKSOlUa/wdGXWqE3vsIYowP/2D3RUisEoy+m3Pix4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRYOSPI0FuizcctZnA6Jn5J5I+6+yAzHY2/ses80zJ74jJ7efpqR8c4rEjWkrkOvpNsSJzQbShUidFJKSNqlluBROeT+LS1wJ0Ad6abpMf5oAsszX1tb7n2APR2/lsSMWU1cwhLGCZ9YuwUjmCuEHWk8hDWFVhfnuBRbex1KAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8GmSfxi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8GmSfxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770364552; x=1801900552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MOOKSOlUa/wdGXWqE3vsIYowP/2D3RUisEoy+m3Pix4=;
  b=C8GmSfxie15SsbKLKng5Nc4jdBQUoHdWIH1U6aNz+zpy0+/TzgLfrSq7
   9QTGvzoMEoJLRWD59U3jMx0Es1OTqhrfEQPE+TBfjhvAl6GeWUtbLm4/d
   xdQscsgrbqPmcjz0aP5EOAHcT7X2KB9uuAM0H0NNICrFncGdMCE++n2O6
   T5DN3Fcr5xbzCM/w3YDjO3FflSirZ3ijT0egF3bTos1+r5YbQ4l6CnQO0
   oZhh+fhe0wXFKXmDsMVdcUkX/s0IPWYaHkQUUcQsMryn0nKw6UccsKmH3
   52gBG8YUwTH7HeNst7z7XkOpNYYmIHI93SC++3SOLuBpFnTEHiFaSJVyy
   w==;
X-CSE-ConnectionGUID: f6RmNRYDQ9qldq+KlXY5YA==
X-CSE-MsgGUID: Exbt9Tm1ST+4v1LkUg/adw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="89150783"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="89150783"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 23:55:51 -0800
X-CSE-ConnectionGUID: 6TENf+JeR4CKVrl0///noQ==
X-CSE-MsgGUID: KDPP8U5vQDOI3VyYrlsCFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="215383972"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2026 23:55:47 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 45DBE95; Fri, 06 Feb 2026 08:55:46 +0100 (CET)
Date: Fri, 6 Feb 2026 08:55:46 +0100
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Danny Kaehn <danny.kaehn@plexus.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
	Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
	Ting-Kai Chen <tingkaic@nvidia.com>
Subject: Re: [PATCH v13 1/3] dt-bindings: i2c: Add CP2112 HID USB to SMBus
 Bridge
Message-ID: <aYWegvvqsVhJdkCH@black.igk.intel.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 27, 2026 at 08:47:48AM -0600, Danny Kaehn wrote:
> This is a USB HID device which includes an I2C controller and 8 GPIO pins.
> 
> The binding allows describing the chip's gpio and i2c controller in DT,
> with the i2c controller being bound to a subnode named "i2c". This is
> intended to be used in configurations where the CP2112 is permanently
> connected in hardware.

...

> +            gpio-line-names = "CP2112_SDA", "CP2112_SCL", "TEST2",
> +                              "TEST3","TEST4", "TEST5", "TEST6";


Seems like missing space. Also I would resplit this logically, id est:

            gpio-line-names = "CP2112_SDA", "CP2112_SCL",
                              "TEST2", "TEST3", "TEST4", "TEST5", "TEST6";

-- 
With Best Regards,
Andy Shevchenko


