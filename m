Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFC29E0F8;
	Wed, 28 Jan 2026 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616381; cv=none; b=m+YTAGEOWy8Z0MUglN0o3gRDktuRlvPzghXz6oQWHNHUKDEGEI+VMhyI+fx8y+dsgyyXMNB/BZ12jPwj5+6sTgtq5N6Gqo4cfo4SEDLJU8p7k/07f1Cvlp9ffKdiJu28vFDKuUmszBONYqmeGC1P9SVL0dyCbuAWrhXH0VN8LqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616381; c=relaxed/simple;
	bh=a5f/qHahHVMqvq2j3+g/5RwSWC+rr/ywSbBxNTGrVLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyuV5p/ErLexSeMdXqkrLkqAaSKAIJ0iwhu92DtLBnBEMvHvdQ+0axUEELOR/tPBcVxCU0JzaSJL1f61fuMY2daykAGtkyBYPwWKXkVRa5ugNJB3mDpixJ06fyx/mfGt7PPrL3JAX72vfPj1ahbEmWP9IfNj8WAKGsTe7Bch7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPs051z4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPs051z4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769616380; x=1801152380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=a5f/qHahHVMqvq2j3+g/5RwSWC+rr/ywSbBxNTGrVLw=;
  b=WPs051z4bJ0Rs/EPHLZCMGuv1jLzU7s9mPGRflg8GpR7XjigCc6rItqn
   WEuw1qQ+Aee+8N26KlNWEePkryT6IUkgECYHkOiBpDd8IvH3/2a5wjG4o
   9j6yvDvpj2NcxP/3zqZDQhO+D1Xw7JRzouDtdTPuZZP0zGYFkoB7rK5gv
   Kg5r7v7E9CmibxlLlmSoBdLp7FHFBgpzwerQ1bSY/3We1tOeHFN4X4mV9
   hAXphHKiSf2V62cVzvwI/HQJZIvgvxFKtVQ0+r6NHevPBv9581ff3Iw1G
   4phSwLHHx3mDWeRjSKQcD0SDyjsd6au9WdKQtAZe79G1GwA3/HV6fCg1Y
   g==;
X-CSE-ConnectionGUID: OXRxH4CxQ+umkW9y2hYoGA==
X-CSE-MsgGUID: 7MdkGrI7QZWyPecA5IMcdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70033046"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70033046"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 08:05:59 -0800
X-CSE-ConnectionGUID: vWdRqZNqRf+sY/vtIUrilQ==
X-CSE-MsgGUID: 4WmMqs1JTneERcvMolESMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208741809"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 08:05:55 -0800
Date: Wed, 28 Jan 2026 18:05:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Danny Kaehn <danny.kaehn@plexus.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Message-ID: <aXoz4Xs8csdxXeZU@smile.fi.intel.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
 <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
 <20260128-magnificent-faithful-otter-c4f900@quoll>
 <aXoF4zi4SZrXaku5@smile.fi.intel.com>
 <3db84b61-e463-4362-b142-59d3ca6eae90@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3db84b61-e463-4362-b142-59d3ca6eae90@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 04:48:18PM +0100, Krzysztof Kozlowski wrote:
> On 28/01/2026 13:49, Andy Shevchenko wrote:
> > On Wed, Jan 28, 2026 at 11:35:25AM +0100, Krzysztof Kozlowski wrote:
> >> On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:

...

> >> That's actually rule communicated many times, also documented in writing
> >> bindings and in recent talks.
> > 
> > Does DT represents HW in this case? Shouldn't I²C controller be the same node?
> > Why not? This is inconsistent for the device that is multi-functional. And from
> > my understanding the firmware description (DT, ACPI, you-name-it) must follow
> > the HW. I don't see how it's done in this case.
> 
> What is inconsistent exactly? What sort of rule tells that every little
> function needs a device node? It's first time I hear about any of such
> rule and for all this time we already NAKed it so many times (node per
> GPIO, node per clock, node per every little pin).

That we should represent the HW as is. There is no "rule", there is a common
sense. Of course, it's possible to have all-in-one node, but this may lead
to a disaster when there are tons of devices in the Multi Functional HW
and some of them use the same properties. How would you distinguish HW
with two GPIO banks, two I²C controllers, et cetera? That's what my common
sense tells to me, putting all eggs into one bucket is just a mine field
for the future.

-- 
With Best Regards,
Andy Shevchenko


