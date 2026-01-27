Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABA231A23;
	Tue, 27 Jan 2026 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547611; cv=none; b=UeBfJ6IXz9J654iHF9mIIKfBYpJQBmLp7rsYKP/JLx06RX1XEXhgDwh8y3nbHJ6CLfa94DdBEV7Cf8GRXdupt7ttBL/eg0uIZ+zQ+4cTgaDFvsYp6T2KQuRGgUz5JqtMpEqDVFZO7SKMGQPcHhqwxTvKb9hx2mzC8IpTTz/sHN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547611; c=relaxed/simple;
	bh=15LikzopnR8kHz+hCxZ6bhTjumJSimQzGGKBrixcPlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDXGVnkeBLe9o6udU6lLEAuXLYP4rh4vR4aRtxWkyd13ELs80wto4JKYLN0Pv/vzM1cJVTRkjShPNPmdvfxPV9raPXYkZ8imTvGwICrAJu1+9PfTI/We+GhWQ9Z4Ko+Q51dM/dU1zY9d25tEn89o8+CN0r07Q5wLMIIgfzGRUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmxztl/I; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmxztl/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769547610; x=1801083610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=15LikzopnR8kHz+hCxZ6bhTjumJSimQzGGKBrixcPlk=;
  b=gmxztl/I2EF3LrEf8eyGnSPTAfAw8A95+NbgMgYSPxvBH3nfMZyk1SRd
   sV5Vzxv7dQ2FnNMJAbfJeZ68EaWAFrUy+9mTNHTthFx8svy5+ZfijeDgh
   PJDvpKRU2KVutdW6mczNVo8ayF2RTgdgRhi4mDtdIcbTekzXAUGPvlIIb
   bIehf/k8xkQCdmjB3EImaFazJxy6TqYiQ/cEv5vFrlBJ+lOaRxaL06Ivt
   7IU45GExB/Rc41h/fepDfBjW/1cZtvS7EIzPLLFThCH69oZRFDUIEl9Of
   u6q4BdpcHy+rAxfJwvWhmI4U4mbqs4s8N7txexreK4qanxeOWnLt6rNmr
   A==;
X-CSE-ConnectionGUID: nJnSfAlUTru+bVv469sRcQ==
X-CSE-MsgGUID: BHFsjuIhTKem8PClr0gnfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="82183461"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="82183461"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:00:10 -0800
X-CSE-ConnectionGUID: gY1JV+vCT1GAgSKQNhVjWA==
X-CSE-MsgGUID: TJfwN4TiS/Su1VcPdaiwvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212185906"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:00:04 -0800
Date: Tue, 27 Jan 2026 23:00:03 +0200
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
Message-ID: <aXknU-fxh286Nkek@smile.fi.intel.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
 <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:
> On Tue, Jan 27, 2026 at 08:47:48AM -0600, Danny Kaehn wrote:
> > This is a USB HID device which includes an I2C controller and 8 GPIO pins.
> > 
> > The binding allows describing the chip's gpio and i2c controller in DT,
> > with the i2c controller being bound to a subnode named "i2c". This is
> > intended to be used in configurations where the CP2112 is permanently
> > connected in hardware.

> Hi Folks (Intended for Rob or Krzysztof),
> 
> Wasn't sure the best way to go about this, but trying to see the best
> way to get a message in front of you regarding an ask from Andy S.
> 
> In [1], Rob H initially directed that the gpio chip share a node with
> the CP2112 itself, rather than having a subnode named 'gpio'.
> 
> Initially, I did the same thing for both DT and ACPI, but Andy S.
> directed that ACPI should not have the node be shared in that way.
> 
> With the last revision of this patch, Andy S. asked that I try to get a
> rationalle from Rob (or other DT expert presumably) on why the gpio node
> should be combined with the parent, rather than being a named subnode
> [2].
> 
> Any context you can provide would be extremely helpful. Apologies about
> the age of this patch series and the amount of historical context; some
> is due to my long delays between revisions, but other of it is due to
> attempting to get the ACPI and DT folks to talk / agree.

I think this is about markers such as "gpio-controller" or
"interrupt-controller" in DT for the device in question.
With that it might not be required to have a separate child
node for the GPIO function.

> [1]: https://lore.kernel.org/all/20240213152825.GA1223720-robh@kernel.org/
> [2]: https://lore.kernel.org/all/aSdvv3Qss5oz_o6P@smile.fi.intel.com/

-- 
With Best Regards,
Andy Shevchenko


