Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7D92264C0;
	Tue, 27 Jan 2026 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544395; cv=none; b=US0kY93KG63Uaq1M9d+zyIygNP/C8iDBVsSpo7CDUOtwP3HFtaC/KzE2MDPTeSiV3YzHMHTqJ+Nrz46aezGoebYDdf0hJ9nBTHcDDsYg8Xtx62g2LmN0+MOiADYXBC+VfF+xAxRCELx4HgkZaVIOJtvW+nX22T0U+LgjJxYuOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544395; c=relaxed/simple;
	bh=zPrhT921AFGu3dIsD1Q7R6O352BGOwx6qd5NHjVoMBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eD5lkaqT2p0mGpRagE8Yg+Zhpi69sA/qx5fLyK4oe0hfmZkDhYYJK5GiDRjmUUGUskWQqkaguWedQK+FzOAM/2uYaQlsE8tj5/Bjc7xdDKK020VDlsISP08/fgHRcZHTscjtO7EEs0LcEYm2mpPFIrK7REn2SpVKo2uKOJr3qXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOR0DXEt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOR0DXEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769544394; x=1801080394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zPrhT921AFGu3dIsD1Q7R6O352BGOwx6qd5NHjVoMBY=;
  b=nOR0DXEtB4FXa1A5JqowSeh4v8WjzX8o8zY6P+joNp6dYRpfsQNV3a/h
   zg78zBRYYDZ8p4aSfW93P6H2a9ZuMS1pHm67hwT2zr4yfkrsKjXcRta2x
   egiPWHnmue1C9aRhVlYENn4HjUluBLncI1Csnsx1g2aBX7bCM1ymmnUln
   jvoDvvQmeYMKQjGNTOWKSFkj0+ZWaozdIxvhyj+OK4K7cadQtSbpMWOzF
   74UeeGoFbZvUHYsXyatqqHe1FoJx5Qk3lYqeG5HfWBWvNHKfavt1TwyU4
   8dNGDZ6zA3wyX58G/NzVv9vhvhFCfdTgpH9+GAkiJyxclQsv5Wkf/+N2p
   A==;
X-CSE-ConnectionGUID: PLFSX4Y9RAuW9o/eu5d0kA==
X-CSE-MsgGUID: joBU5bGyT+OrTZTi5kRzWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70467668"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70467668"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 12:06:34 -0800
X-CSE-ConnectionGUID: eag8VKKLRjqPYaP9mwrn1A==
X-CSE-MsgGUID: 0AhMw0f/Rdiio5l9NvNScw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208424553"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 12:06:29 -0800
Date: Tue, 27 Jan 2026 22:06:27 +0200
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
Message-ID: <aXkawwpmLW7m4Fu8@smile.fi.intel.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-2-6448ddd4bf22@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-cp2112-dt-v13-2-6448ddd4bf22@plexus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 08:47:49AM -0600, Danny Kaehn wrote:
> Support describing the CP2112's I2C and GPIO interfaces in firmware.
> 
> Bindings between the firmware nodes and the functions of the device
> are distinct between ACPI and DeviceTree.
> 
> For ACPI, the i2c_adapter will use the child with _ADR Zero and the

_ADR equals to Zero

> gpio_chip will use the child with _ADR One. For DeviceTree, the

_ADR equals to One

> i2c_adapter will use the child with name "i2c", but the gpio_chip
> will share a firmware node with the CP2112.

...

Also it's interesting choice of capital letters in the Subject.

I would expect "...: Add fwnode support"

...

> +/**
> + * enum cp2112_child_acpi_cell_addrs - Child ACPI addresses for CP2112 sub-functions
> + * @CP2112_I2C_ADR: Address for I2C node
> + * @CP2112_GPIO_ADR: Address for GPIO node

Probably you want to mention in the description of the enum (here) that
the assigned values are explicit since this is basically a protocol between
FW and OS. That's why we may not change this values without breaking
older firmware descriptions.

> + */
> +enum cp2112_child_acpi_cell_addrs {
> +	CP2112_I2C_ADR = 0,
> +	CP2112_GPIO_ADR = 1,
> +};

...

> +	if (is_acpi_device_node(dev_fwnode(&hdev->dev))) {

I'm wondering if we can avoid this (additional) check and use the result of one
of the branches.

> +		device_for_each_child_node(&hdev->dev, child) {

If we are still use the above check it will be dev_fwnode() duplication call,
so perhaps a temporary variable to collect the device's fwnode and use it
there, below (see below), and here as for

		fwnode_for_each_child_node()

> +			ret = acpi_get_local_address(ACPI_HANDLE_FWNODE(child), &addr);
> +			if (ret)
> +				continue;
> +
> +			switch (addr) {
> +			case CP2112_I2C_ADR:
> +				device_set_node(&dev->adap.dev, child);
> +				break;
> +			case CP2112_GPIO_ADR:
> +				dev->gc.fwnode = child;
> +				break;
> +			}
> +		}
> +	} else {

I would still check if this is a proper (OF) node, in case we stick with the
ACPI check above. Because we might have swnode and if it triggers, it will be
really something unexpected.

	} else if (is_of_node(fwnode)) {


> +		child = device_get_named_child_node(&hdev->dev, "i2c");
> +		device_set_node(&dev->adap.dev, child);
> +		fwnode_handle_put(child);
> +	}

-- 
With Best Regards,
Andy Shevchenko


