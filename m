Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6D359A8B;
	Tue, 23 Jun 2026 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210635; cv=none; b=ccf9AFuk7po61CHz8qgNrFSuNE5u34XBhlaHZROyu86+B6khZBOj8f8V2zRgiVVwYJvgD1541IqqzDEw8/FTtiEPKDDj1M3umAouc0Fav4QjqB4ipJsT53q8S6JlT/T/1AR7BrrKG3o2wKnegKfrKjG6p7IpPSMjMMuzBjeMe2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210635; c=relaxed/simple;
	bh=Dm4j/mvNVt9S5t1qetrhTySaQB3CVULjgBATeoR3e6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK1TGcayvI4jQFf6SJEPYAnvRGEzxp+1KCRItqoFmtkdxZPTmhh3nWqb1F1nqoCp9EU1PgH9POgE7Si80Y34wuA3O58cfCE+lbNN/gOK6U2mqHj4zSJTw/EPgFp+toOz5tFx8Xy+/HNHWGho9u073mEQzqlO33M5NCJ55thkjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCgxU1nu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCgxU1nu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782210633; x=1813746633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dm4j/mvNVt9S5t1qetrhTySaQB3CVULjgBATeoR3e6s=;
  b=mCgxU1nuxlWXhUJjUCb2/nVZLYeVt4dRQVpscJWXI57etl72SO+s+yaW
   Svpg1ItmGc7DCYfA9m9UsKoCXLC/eBbP8DIEc8ZoTVxQIPP50yrpYZBMW
   GoHvQNvj44d6Xt4Ztt2fBE5OuK89fkcs5mwe9DbLD/ymxtLNxZAVz4Sru
   ZBBoLY60ljYT1XJIaK5T5uZbCf43gqOdOAi+EREQzPi9fU1IGwlvUfphw
   iupqyU4gzu5u2fS4sVPB/ZkBKMaWOwXczWmo7FxUr1zL7ff/DicFVJ2Kv
   ncc05/zpKS32c8nIR7FDwGVoH3+IAtCI3wNhRAmukdLHsghPldw9+s9TO
   Q==;
X-CSE-ConnectionGUID: ZSmwICo2TSipoBWsUJo8vQ==
X-CSE-MsgGUID: Z51mpjLDTtivTGmeavcPWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="100377668"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="100377668"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:30:33 -0700
X-CSE-ConnectionGUID: 2wrNwMBpSQizc3b1aQwtHA==
X-CSE-MsgGUID: Hz5IlPhdStmaeyXKtGDKMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="251415531"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:30:29 -0700
Date: Tue, 23 Jun 2026 13:30:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Archana Patni <archana.patni@linux.intel.com>,
	Song Hongyan <hongyan.song@intel.com>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v2 0/8] HID: iio: Avoid race between callback setup and
 device exposure
Message-ID: <ajpgQ8vCHacv_klG@ashevche-desk.local>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 22, 2026 at 10:59:56AM +0530, Sanjay Chitroda wrote:
> 
> This series avoid a race condition in HID IIO drivers related to the
> ordering between callback registration and device exposure.
> 
> Currently, several HID IIO drivers register the IIO device (making it
> visible to userspace and other kernel consumers) before all required
> callbacks and resources are fully initialized, or rely on devm-based
> cleanup in a way that does not guarantee correct teardown ordering.
> This creates a window where the device can be accessed while it is

There is a difference between "this creates" and "this might create".
I believe Srinivas and others were asking for the proof. So, what path
in the code makes this happen or possible to happen?

> not fully initialized or is being torn down, potentially leading to
> sample drop or stale/no data.
> 
> To handle this, the series ensures that:
>   - All required callbacks and resources are set up before the device
>     is registered with the IIO core
>   - Resource cleanup is performed explicitly where ordering matters
> 
> PS: This is prepratory series to convert all HID IIO driver to devm.
> 
> Testing:
>   - Compiled with W=1 for each patch in series
> 
> ---
> Changes in v2:
> - Drop fixes tag and rectify commit message with reference to that

You also dropped my tag. Why?

> - Link to v1: https://patch.msgid.link/20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com

-- 
With Best Regards,
Andy Shevchenko


