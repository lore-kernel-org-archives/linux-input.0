Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61127345741;
	Wed, 22 Apr 2026 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848834; cv=none; b=ZcNvhT93JWRfqP0x9IOr7J+wpzBFtLACsrjfsD9tqBodewgajiFfRF//rNq8rCfGbWvqKdAgt8rmIgIVLyed1OT2UZmiGhbqS+NLpghbRW+AKHM/hT0cWZkLxJjZF3xX2HrKCBwA4lkvxCQNLeO1dfSV4pJKZ5vWOA2uZLsJ2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848834; c=relaxed/simple;
	bh=A4b/59ZvGaHt5z2sMqtYaccXG/KaIk8hGSJTR4NhZjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf21HcL6Ccq3jbXN3Y0hGvLipdPIPrifhZcWkGDXuHiVD29cs6dmIOWLZG8YYRmolvAKTbCx9jLtZuCQFFMrKEC8cCx8CG4yJ9vixpwiKJQ+9rya+2vuUdF1y91TkDaLgad31u5nhrAer9JvifBZ3/o9qNcJk5f7YkSGswxc/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=au35Xdqa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="au35Xdqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776848833; x=1808384833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A4b/59ZvGaHt5z2sMqtYaccXG/KaIk8hGSJTR4NhZjY=;
  b=au35Xdqameh2DXA3rXKLyReOp38OQ09v1+jBdVzikFoew9nGmXKFpGrU
   8benSVrbdlJ/rP8R3y1UM4Nm3mKwHOWFyvg2on+v7zoawvM7DqyZuYCOu
   I3ihgCd6aJ09OCXSlVPoo49MbCir9Cjb3aZkntVbRhiUVCc5/MVIzTodc
   42zc9ELIN8chP9qCEujgp8tlLIFh6bgzG6EWzeCUIhCQ4Dutv7+iz5fx+
   LtsscmFku5hVWoK9L93AxTkZrbjJYKGkXprq0XyM8WCp4+KeNVxj7hgFZ
   TvNiuw217eJa2P6dvpHuIzU2O+TQpvMaNsF2RBElqK7wkmudaoH3UkcvB
   A==;
X-CSE-ConnectionGUID: qkC58e5MSFOV/VyaVVntwQ==
X-CSE-MsgGUID: wJYqWfItQlag2NVJL7ML/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77779763"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77779763"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:07:12 -0700
X-CSE-ConnectionGUID: 3ATMT4J2TzysSzSPoGKufg==
X-CSE-MsgGUID: PEZj9sgwQCOi9T/MGM1KkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232600147"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:07:10 -0700
Date: Wed, 22 Apr 2026 12:07:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: accel: HID: Replace method
 accel_3d_adjust_channel_bit_mask()
Message-ID: <aeiPuxj2TRLNRbv1@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-3-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421222210.16016-3-natalia.andre@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 07:20:34PM -0300, Natália Salvino André wrote:
> Replace method accel_3d_adjust_channel_bit_mask()
> with helper method hid_sensor_adjust_channel_bit_mask().

...

> -		accel_3d_adjust_channel_bit_mask(channels,
> -				CHANNEL_SCAN_INDEX_X + i,
> -				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> +		hid_sensor_adjust_channel_bit_mask(channels,
> +			CHANNEL_SCAN_INDEX_X + i,
> +			st->accel[CHANNEL_SCAN_INDEX_X + i].size);

Indentation is broken. Taking into account that the last line is too long when
properly indented, perhaps

		hid_sensor_adjust_channel_bit_mask(channels,
				CHANNEL_SCAN_INDEX_X + i,
				st->accel[CHANNEL_SCAN_INDEX_X + i].size);

Which makes it most right and under 80 limit.

-- 
With Best Regards,
Andy Shevchenko


