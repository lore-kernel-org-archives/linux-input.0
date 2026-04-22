Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572752BEC43;
	Wed, 22 Apr 2026 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849388; cv=none; b=ESmAdALS31y14dpUlfLU1MrYYPNUyGqJiuiws7ndLXth4aska4KwY7sR2HLOpELU57asTRiKtc1mw0DVWS3OSJ35Q1JO/0WKJY3SQTUNhafvsAmoMPxbsR3+XwPMjHHWiVRsxwcPND3S/oxT+Ch//WTwFBDaa22KndP9b+ivdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849388; c=relaxed/simple;
	bh=JQFZ+FcsjkQagM2DPdGQk+JXMLvNW3VAC3d/wzpynNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJsrR7eh4nogbvECxeFBGUXFRb/6fpDtZwrGA+TtiKWSy9VJUV70+3pcbcmz8yyFLSoxlgP+PszxOljmFjDlyCgyw9dfN4Q1xI8S1eQS9i/mBAVSHogssb6iAc+WXprBaREgP+4i6p7ftiENFeA4narLqOBjbfR+IVDEpeQCINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZGuY1Y4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZGuY1Y4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776849386; x=1808385386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JQFZ+FcsjkQagM2DPdGQk+JXMLvNW3VAC3d/wzpynNY=;
  b=EZGuY1Y4jxLQBqZiMUqydVhAKdLQ52iV3YF59255VHmOV23XRfo5gJgH
   dfvQbbaNZmvYhsdqDjeH2jlNLOoPSi90eK1RdVgfxfIlLJAxuEP25uY9f
   PjVPSdzh9VRjQqbnsSRdkjvNgUzf7uqeYvN2F1C6M6igrnAPGYQpx8fXU
   mY9/0bOVuy8PcBg+qSLDzUkILZh7a69pi0XaP5tUlOUxmCiMeaocnG5Sm
   CDQKa8MFZa4GrUoYG9hgiYp99+jTwnzH2q/tuc8KQ2W0VHvI9PvSqf6gv
   uRsgNgLTxY+Y/QDT7v9QqV/Lwl8iXhlgrDO706Oz7tP0tomB7d5Ro7x0N
   Q==;
X-CSE-ConnectionGUID: dxccmknSSQqv4mLsPftHBQ==
X-CSE-MsgGUID: Dci4iZJeTfe8qUd9X2uUxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88408397"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88408397"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:16:25 -0700
X-CSE-ConnectionGUID: S1WYI6m8QRe2v+QUKjEIyA==
X-CSE-MsgGUID: 6Vlw6U+tSZKg54slYdysFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232603059"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:16:23 -0700
Date: Wed, 22 Apr 2026 12:16:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iio: light: HID: Replace method
 prox_adjust_channel_bit_mask()
Message-ID: <aeiR5PG08MMQfh66@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-6-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421222210.16016-6-natalia.andre@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 07:20:37PM -0300, Natália Salvino André wrote:
> Replace method prox_adjust_channel_bit_mask()
> with helper method hid_sensor_adjust_channel_bit_mask().

...

> +		hid_sensor_adjust_channel_bit_mask(channels, index,
> +			st->prox_attr[index].size);

This fits 80 when indented properly.

-- 
With Best Regards,
Andy Shevchenko


