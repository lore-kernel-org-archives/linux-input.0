Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8AC2772E;
	Wed, 29 Apr 2026 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777491243; cv=none; b=VMEuFwjMIaI/rpc3pFRwtZCPr9UQPQMGNYNlo5bhA/CC5T67bKC/HwsBrn1tJa84rXirJOkANZZ2GvucSMPmDPFD0GOsed7vS6bDWm9LCVDsz25G1BNor+uPu9YpVgT6OChmNK/HiwhWN51ELzdRa2wY99f82LVbutLpJ0D/yy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777491243; c=relaxed/simple;
	bh=T/Ig2gqXGBhXTpcnEZFFyotkqVFBo0yXXREHzevx3+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWFXnZUlNsQ60pLFixMVwL7nLrvwc5A6CBrAH9ojVTvcz6byUgPqR3Dj/Ypz95NgPJ4dFgKZU0tiRl937K9Bhv6RyKREWSR+9HGjpz+Q1Xdut5rXSCVulOubgMsqhO3wZJgb3D2u7+qwNWSPtdbs/3vnbtg1AJg3qWunzVgvSdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqBzytUm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqBzytUm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777491242; x=1809027242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T/Ig2gqXGBhXTpcnEZFFyotkqVFBo0yXXREHzevx3+s=;
  b=WqBzytUmO0yb3QDuybU2aVUeEU+PcESizpHQJlw5YTT+OoRFskDSZKaP
   3E9u4t+gccwcagQ+P1ih0vbWhkgGy5Sw3VfkuNXM7QSqSWU6JZufDCZVt
   iaQd+6Tfazg2IOumekCceLlasWUy/ShVcHwTps+4qGg33egsu/iC2cUCH
   ezZHbaPQABzYw8jH1IynvLCrvmviUEThGdzU3LFBJBupab4HQg7VhGOi0
   VJ3iweM8agvOe4ncc/vWnaFDtAjFEkN+lnkSz981bZyoAjTy7UldU/nJw
   XAtfhm20LpIzfRqolOPimePjKIe8jE6AqR8tW9ql2hE5N+09kDhyyl8p6
   Q==;
X-CSE-ConnectionGUID: aygTx0BpR02vNPBqBOrBDA==
X-CSE-MsgGUID: QeMcvS4hS0Oh1L8kT93OlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65962429"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="65962429"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:34:02 -0700
X-CSE-ConnectionGUID: L/y2A3OlSHWjhqTNjtiyUQ==
X-CSE-MsgGUID: N/c/7RSPQbSfW7HYMuc5Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="272487450"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:33:59 -0700
Date: Wed, 29 Apr 2026 22:33:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: humidity: drop hid_sensor_remove_trigger()
 using devm API
Message-ID: <afJdJIQS1vwOcaGT@ashevche-desk.local>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
 <20260429175918.2541914-5-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429175918.2541914-5-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:29:18PM +0530, Sanjay Chitroda wrote:

> Use devm_hid_sensor_setup_trigger() to automatically release resource
> during fail, unbind or removal of driver using devres framework.
> 
> This simplify the setup, remove goto, avoid manual resource cleanup in
> teardown path.

...

> -	ret = hid_sensor_setup_trigger(indio_dev, name,
> -				&humid_st->common_attributes);
> +	ret = devm_hid_sensor_setup_trigger(&indio_dev->dev, indio_dev, name,
> +					    &humid_st->common_attributes);

I believe the first parameter is utterly wrong here.
Or other way around, same issue but in the previous patch.

>  	if (ret)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


