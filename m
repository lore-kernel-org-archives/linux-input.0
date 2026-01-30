Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311802F8BD0;
	Fri, 30 Jan 2026 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759594; cv=none; b=Db+GxLsPIN/xl/n+d1W/rj8f45Ii8K5j3EveAJAXMsFlWvbyGvfV+Pa3hl4qKSy6BbHvWOkpX/UOgOjlhvROelD+sREQJxY6wfT4IUjaExLXInKN6b0p4ICWw5pC0HSf0tOBcDg7AgOsByFC00v/q81UfLxcgBBmP/FsDH2KCss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759594; c=relaxed/simple;
	bh=N+XzgfavOWTt7osrny+ea51lBffcN2kQA5aqYOJwhhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnMlZMBCT8WBXPk4+xeU0/aBcY03Z7w7HAVO4/B+d2ccc8qEizaQHUzDB8RwwA7Qs/2c/saa7Gi6xwpePKQ2GUqkJwkIHwzB/b9TlG+fzyE2PyTwxBT76dVdWsaLKQhebF17z7WvgcSADw92lgmtZPM+Gk3wvCcOXOVPRtWG8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0IgF1zm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0IgF1zm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769759593; x=1801295593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N+XzgfavOWTt7osrny+ea51lBffcN2kQA5aqYOJwhhg=;
  b=e0IgF1zm451RjgDhf2hsQzhPYjv7/hT3wSD4srTRae7sDRWKy5pYd3aM
   KelCvCDcFno5dpmvvF9OFQXIMYHcLWgTNFgYAv5LtE4LTlu+B1rJU5FQc
   E8Ank6uG6Za/E06ePPz+bmVh0U9YmrNFaBiTMINWh2jfD3gE38oVx2OeR
   72WRSWtY69O+Vm9zkph/FuUVF26WhQTp9H9sjrpY/xbE8R/uznJ7r9a/I
   U+OIR/Q807wZ+/w4Z5QF0uignRP6qmf4f7KQ1bmhG6/Alg2Y0w5a3ro1D
   AwMmFw9UJm7SZpi7vFaYd6VsULNDSnqmmZlqbfIPxXy2u+h4Rewl89SRF
   A==;
X-CSE-ConnectionGUID: dr1LMaVxQmaHCfHGl13jPA==
X-CSE-MsgGUID: zOmMK3WyRQuSsPnDZn7i3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="81642347"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="81642347"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:53:12 -0800
X-CSE-ConnectionGUID: aLY2uB+aRhi8535KZgPeyw==
X-CSE-MsgGUID: t67pp0MMQ4+qux+BXtDumg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="208391437"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.227])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:53:08 -0800
Date: Fri, 30 Jan 2026 09:53:06 +0200
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
Subject: Re: [PATCH v13 2/3] HID: cp2112: Fwnode Support
Message-ID: <aXxjYtiZnSX-wEUh@smile.fi.intel.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-2-6448ddd4bf22@plexus.com>
 <aXkawwpmLW7m4Fu8@smile.fi.intel.com>
 <20260129183650.GA1419235@LNDCL34533.neenah.na.plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129183650.GA1419235@LNDCL34533.neenah.na.plexus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 12:36:50PM -0600, Danny Kaehn wrote:
> On Tue, Jan 27, 2026 at 10:06:27PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 27, 2026 at 08:47:49AM -0600, Danny Kaehn wrote:

...

> > I'm wondering if we can avoid this (additional) check and use the result of one
> > of the branches.
> 
> Meaning something like using the result of acpi_get_local_address() to
> determine whether the node is ACPI vs. not? That is what it used to do,
> before I needed to switch to different schemas for DT vs. ACPI. Now, it
> doesn't really make sense to use the child node types to determine
> whether the GPIO node is shared, but still possible if we store a bool
> result from the *_for_each_child_node() loop, but needs more complex
> logic to store that based on each child's type (and the loop is fully
> unnecessary for the non-ACPI case anyways).
> 
> Following the discussion on the DT binding thread, do you still want
> ACPI to follow this different schema with the separate GPIO child node,
> or would you prefer to unify them?

Wouldn't it be a bit messy if we combine main Device object with the GPIO
and leave I²C as a separate node? Besides that it seems already established
practice to have GPIO + I²C controllers separated based on _ADR (see Intel
Galileo case, drivers/mfd/intel_quark_i2c_gpio.c). Even if we can combine
I prefer to use the existing schema to have less animals in the zoo, for
the consistency's sake.

...

> > > +		device_for_each_child_node(&hdev->dev, child) {
> > 
> > If we are still use the above check it will be dev_fwnode() duplication call,
> > so perhaps a temporary variable to collect the device's fwnode and use it
> > there, below (see below), and here as for
> > 
> > 		fwnode_for_each_child_node()
> 
> 
> Makes sense, will update. I initially assumed we wanted to use the
> "device_*" API wherever possible.

Yes, but use a common sense. If we have fwnode already available, why should we
still use device_*()?

> > > +			ret = acpi_get_local_address(ACPI_HANDLE_FWNODE(child), &addr);
> > > +			if (ret)
> > > +				continue;
> > > +
> > > +			switch (addr) {
> > > +			case CP2112_I2C_ADR:
> > > +				device_set_node(&dev->adap.dev, child);
> > > +				break;
> > > +			case CP2112_GPIO_ADR:
> > > +				dev->gc.fwnode = child;
> > > +				break;
> > > +			}
> > > +		}
> > > +	} else {
> > 
> > I would still check if this is a proper (OF) node, in case we stick with the
> > ACPI check above. Because we might have swnode and if it triggers, it will be
> > really something unexpected.
> >
> > 	} else if (is_of_node(fwnode)) {
> 
> Wouldn't it be valid to use software nodes to describe the
> CP2112's functions? Is there any reason to intentionally prevent that?

swnode:s are for quirks. I hope in this case we won't see them IRL.
In any case, let's enable them when we will have the case.

> > > +		child = device_get_named_child_node(&hdev->dev, "i2c");
> > > +		device_set_node(&dev->adap.dev, child);
> > > +		fwnode_handle_put(child);
> > > +	}

-- 
With Best Regards,
Andy Shevchenko


