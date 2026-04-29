Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F85175A81;
	Wed, 29 Apr 2026 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777491093; cv=none; b=F6J+uC4bWZnn6mwNnpFTbqRHATqTH8HGONdAxdorWP65k+qYNi8I5gfALLvPvllhNaLZc19tRm6IN7ihENvhZ3Ns5C8szHgoJlh+p2YbJ6qSMVknrU0v2MM85XoSq78kOWAs43ynN5QdHnHdnTow9vOXY16nZVTy04xvQz4BU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777491093; c=relaxed/simple;
	bh=+LQhbcAgW3ewVCWmY7VLHYmTyq4G9Fc7ntXY7yWyRyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTL5I83DbVxkGCRfprY+8wsaN15C0904VxVt3zlu7oBoI5KBiGKATu+5Orjf3kxTRiMMNi/SLzbcOcVSZOlh72fP4az4d/xwR4tDRcAISqXg6QOWJ0Mw0EmNpKWNmdfa3OudphncsoeCkvxnIf8JJeQ6AEJPYP1hOvMJbSheIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ht8drbHF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ht8drbHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777491093; x=1809027093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+LQhbcAgW3ewVCWmY7VLHYmTyq4G9Fc7ntXY7yWyRyY=;
  b=Ht8drbHFx/+OoN6gUqisP0/yg2ZRF2J88yIeJ+3e6yy8dVk0PGmKjIdi
   KbXo7p4izPsSIVyuyzupEIO/kCsITcMdLsIbkyXoyBqB97XT8k8Yj2VMu
   gT/pdQ2e/Jk6J2ULqP1ere41sM4DWbLhgWIbFOl4ZXZtwdTQdGi3+EhSl
   YTxct06MDO/3M5M5wm0IbscuVNZugiw8mxO512tUyyqQaHCkZKyuxKXjY
   cKktXUHkddcrFITjHfjJJhFvkqojZE+j0DKc0bDwOJxm0dxqpILVz6H0J
   3+kv+xNQPmCpkr+otZs0N4NTHp3ptOs96H28idgOyvx81BJ0jIY3RwCud
   Q==;
X-CSE-ConnectionGUID: k31J6NvjR9mAZCcjkcHk0A==
X-CSE-MsgGUID: IPUYTkjLQLCAmWLQTuF9EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78539244"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78539244"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:31:32 -0700
X-CSE-ConnectionGUID: +uiXokeTRuqGBpQp4Gcjqg==
X-CSE-MsgGUID: x9wi+QFoQlCA+0Jjwuucfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="231222186"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:31:29 -0700
Date: Wed, 29 Apr 2026 22:31:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: hid-sensors: introduce device managed API
Message-ID: <afJcj34Fc_aUMVhe@ashevche-desk.local>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
 <20260429175918.2541914-3-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429175918.2541914-3-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:29:16PM +0530, Sanjay Chitroda wrote:

> hid_sensor_setup_trigger() is common API used for the HID IIO drivers,
> prepare devm API devm_hid_sensor_setup_trigger() to acquire resource
> during setup and release using device managed framework during drivers
> fail, unbind or remove path.
> 
> Register action with devm_add_action_or_reset() to release resource with
> devres framework.

...

> +static void hid_sensor_remove_trigger_action(void *ptr)
> +{
> +	struct hid_sensor_common *attrb = ptr;
> +
> +	hid_sensor_remove_trigger(attrb);
> +}

Casting is not needed here.

static void hid_sensor_remove_trigger_action(void *attrb)
{
	hid_sensor_remove_trigger(attrb);
}

...

> +int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
> +				  const char *name, struct hid_sensor_common *attrb)
> +{
> +	int ret;
> +
> +	ret = hid_sensor_setup_trigger(indio_dev, name, attrb);
> +	if (ret)
> +		return ret;

> +	ret = devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, attrb);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, attrb);

> +}

-- 
With Best Regards,
Andy Shevchenko


