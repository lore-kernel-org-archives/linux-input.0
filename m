Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602793;
	b=wPo97eAWLHchx+sk8rMpOpkVBcX7G0se4IN7tEhshqo0kmlHzyh18lbDpc7wriIE0ykd
	 cL1Vcr0RQ0/SCP25MWnQU4OGPaMUd4WmvZ8uccZaPxxquBZPMj0zAH03psehn+AQNjXX4
	 lQiZR1u9/UXwWXrZeKyvMC+5T/f1sj0Br2zevo1xsRqxK7RpwtDOmeXcY6nEmsbDe1swF
	 4YEQwZVCki0rgpocEbVdu6uA/cF5BT220tWRGdWon9Gc+3UFJ+/4tuLvTOUfHYRYYwuXJ
	 sfySU9+0YDD7CDrZ1T4kwWaZZ305ajt0u37EtCDtBTN+OrQEeTRgKb0fHgW8r9s9x1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602793;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=rkKvJMcNlYtK4WgVFyqLjlbKR7Ee577Xp+OAr33Prtw=;
	b=oZnN5KiU/keu8/RJ36yvloZjW9n5UQBXZ4ZBxHYnp4VqtpezT+YWm+SasY078uPFZ7sJ
	 lCsEVvp3JtGXxNvCxNM+Suyq5z64BXqmFtpjsc56tNCfUJgjQyxTCThEBtORNcQi/nNWn
	 RE7Brp6FuT20gDb4uLmYDZwK8ekxzdMQEdXt9foGHRUKnVQivDdYRMnpq+9lsNXOAmykD
	 EDrNVeH+wNC7EtpzGYTEZir9qI6ZFQhQNmztoO/+SfvDCq5/raUuwNtA3Otk96MFFEHWT
	 1Pqv4FMo4OW/w0L08/r/fTp3KPDxuqm4sAGjgfYWDjD7mRENE0kLIHRvVmiCpYKkd2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DEsxE467;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14D606A31A;
	Wed, 21 Oct 2026 17:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE14D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DEsxE467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792602793; x=1824138793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hoR1fALggNIJg7ge3SbfZZWzt3TtjBehebEjM7ZQRUA=;
  b=DEsxE467UvLKTS4M5cPysxwqU/CK5V+A+K/314k59tU0t8Sk9RifOW7z
   q83MeWnt1jiw2Jq0smzj2MAezEF6wKseigBXunUz/vQ5aw1G3taP8zO9l
   N3OTRvtQnHszM2GqVoboh8UzY/LczMicep8GI1+qleZLkBfaNz7r9THXy
   EMgIqKO2c8iIdLIGrCGxtIKNGhZyOcNRdQReR/ir/NgmDW/0xXNTMkzJz
   TGBjxGu2Oea1wUYCnpznPRb1SAiJN04tSThWtHIPfEL/WsRTFComPNA2H
   DXwefbMCJuTXMv6djdRme7r20l6xJ5R9DWGQLwyD7KPELIdpIsfq5jnxX
   A==;
X-CSE-ConnectionGUID: vtSJ4R2zShO/rIs+6Tl0og==
X-CSE-MsgGUID: slAXG2ifQE6Jf769ncnKrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1211229"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1211229"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:13:12 -0700
X-CSE-ConnectionGUID: C5utkEkyRKWpEVmugHT44Q==
X-CSE-MsgGUID: k1Fvf6UJTjyGNUPT7isgPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3196404"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:13:10 -0700
Date: Wed, 21 Oct 2026 20:13:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: soc_button_array - convert to software nodes
Message-ID: <atjypFBUGPzWv083@ashevche-desk.local>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
 <20261021015004.1537738-3-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021015004.1537738-3-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 06:50:01PM -0700, Dmitry Torokhov wrote:
> Convert the driver from using legacy platform data to using software
> nodes for registering 'gpio-keys' devices. This allows us to
> transition away from platform data and use generic device properties.

...

> +static void soc_button_remove_swnodes(struct fwnode_handle *parent)
> +{
> +	struct fwnode_handle *child;

> +	if (IS_ERR_OR_NULL(parent))
> +		return;

Isn't this redundant? Because the following has it inside already.

> +	fwnode_for_each_child_node(parent, child)
> +		fwnode_remove_software_node(child);
> +
> +	fwnode_remove_software_node(parent);
> +}

...

>  	const struct soc_button_info *info;
>  	struct platform_device *pd;
> -	struct gpio_keys_button *gpio_keys;
> -	struct gpio_keys_platform_data *gpio_keys_pdata;
> +	struct fwnode_handle *parent_node;

Can it be one line down, so we keep reversed xmas tree order?

>  	const struct dmi_system_id *dmi_id;
>  	int invalid_acpi_index = -1;
> -	int error, gpio, irq = 0;
> +	int error, irq = 0;
>  	int n_buttons = 0;

...

> +		child_props[prop_idx++] = PROPERTY_ENTRY_U32("linux,code", info->event_code);
> +		child_props[prop_idx++] = PROPERTY_ENTRY_STRING("label", info->name);
> +
> +		if (info->event_type != EV_KEY)
> +			child_props[prop_idx++] =

> +				PROPERTY_ENTRY_U32("linux,input-type",
> +						   info->event_type);

Make it a single line, you seem use 100 limit anyway.

> +
> +		if (info->wakeup)
> +			child_props[prop_idx++] = PROPERTY_ENTRY_BOOL("wakeup-source");
> +
> +		/* These devices often use cheap buttons, use 50 ms debounce */
> +		child_props[prop_idx++] = PROPERTY_ENTRY_U32("debounce-interval", 50);

...

>  static void soc_button_remove(struct platform_device *pdev)
>  {
>  	struct soc_button_data *priv = platform_get_drvdata(pdev);
> -
> +	struct platform_device *pd;
> +	struct fwnode_handle *fwnode;
>  	int i;
>  
> -	for (i = 0; i < BUTTON_TYPES; i++)
> -		if (priv->children[i])
> -			platform_device_unregister(priv->children[i]);
> +	for (i = 0; i < BUTTON_TYPES; i++) {

At the same time this can be transformed to

	for (int i = 0; i < BUTTON_TYPES; i++) {

> +		pd = priv->children[i];
> +		if (pd) {

		if (!pd)
			continue;

?

> +			fwnode = dev_fwnode(&pd->dev);
> +			platform_device_unregister(pd);
> +			soc_button_remove_swnodes(fwnode);
> +		}
> +	}
>  }

-- 
With Best Regards,
Andy Shevchenko


