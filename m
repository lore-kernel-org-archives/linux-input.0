Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A23370EA;
	Wed, 28 Jan 2026 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633006; cv=none; b=FAVYKcvtrAzVTrBpa/xb0y/eovDETLuJnhJ6o9AQbqYFtTNxkSdgQhrdekdCDV8WHQyQymvmguuAZXiXwMgOJ1n1rK4cErf3e7GOR3yoSblM8SVBE/2baCzlnWRPLntLeJUE+RO1UVO/SCuzCz+UkSY8ODMGQMbAZfrUa/18iNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633006; c=relaxed/simple;
	bh=vGc8cR7Hsv0b9Y5Y7vkiU7vmGCNGRQSF1U7JEcTLui0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnzmOKmWVbMEOj4IgOyrqHMx/so8FZ/LWgzut+P7VyugeVUHlUlBRs5oH1HifgX1JdNyZoVglcILXBfeFRgueqZVL2KJ+5MWuBPkB2Q1sid7ntuUDpfI1GyjbIS10IAlYwenbKMElA+7/78huTg/0g96b2SGiU27jQAglkMmkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A36+BQnN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A36+BQnN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769633005; x=1801169005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vGc8cR7Hsv0b9Y5Y7vkiU7vmGCNGRQSF1U7JEcTLui0=;
  b=A36+BQnNCKqGfzZJRaZ2uaBLkaPLdXTgoqhog3BnLYFwY7Mrl8Nnct8r
   +/1ibydDSQ9FiM30at8U9ktUJdCWQD0//ER9gUEe55fQr83ZOZ5g/Zh1+
   g/SQxd2nBK99d+JexrN68DRfa5zByBxAjH1YgIGnBFYuoSozL2D6nr5Jd
   MuurbAPlFYC+zUZu9gedrbhb6vuF4vTmzlN3EUwYd550NReTiRJWI5GK1
   nEYvdsFzm0RbfwhBMNLmOayleQLaoNHtnCZmjllPZFMLQbP2spoiVZCu+
   Esp092H16WQAzXKSHGYRC1KVdX9G2hONcu8RrXhEBwJ4Zk2VZo1kcY9JL
   A==;
X-CSE-ConnectionGUID: mrfBT7MSRJi0o83RNvqU3w==
X-CSE-MsgGUID: Aib8HyELSWyrRA/qSjYEyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="82284779"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="82284779"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 12:43:24 -0800
X-CSE-ConnectionGUID: uqnc2ccEQlK8inqhJkHSiw==
X-CSE-MsgGUID: lXH8l913SnKXl1t+QwdtsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208458023"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 12:43:20 -0800
Date: Wed, 28 Jan 2026 22:43:16 +0200
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
Message-ID: <aXp05Dk7gGc5DkPt@smile.fi.intel.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
 <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
 <20260128-magnificent-faithful-otter-c4f900@quoll>
 <aXoF4zi4SZrXaku5@smile.fi.intel.com>
 <3db84b61-e463-4362-b142-59d3ca6eae90@kernel.org>
 <aXoz4Xs8csdxXeZU@smile.fi.intel.com>
 <bb448595-ae60-4497-98ad-040f148af2e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb448595-ae60-4497-98ad-040f148af2e5@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 08:52:50PM +0100, Krzysztof Kozlowski wrote:
> On 28/01/2026 17:05, Andy Shevchenko wrote:
> > On Wed, Jan 28, 2026 at 04:48:18PM +0100, Krzysztof Kozlowski wrote:
> >> On 28/01/2026 13:49, Andy Shevchenko wrote:
> >>> On Wed, Jan 28, 2026 at 11:35:25AM +0100, Krzysztof Kozlowski wrote:
> >>>> On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:

...

> >>>> That's actually rule communicated many times, also documented in writing
> >>>> bindings and in recent talks.
> >>>
> >>> Does DT represents HW in this case? Shouldn't I²C controller be the same node?
> >>> Why not? This is inconsistent for the device that is multi-functional. And from
> >>> my understanding the firmware description (DT, ACPI, you-name-it) must follow
> >>> the HW. I don't see how it's done in this case.
> >>
> >> What is inconsistent exactly? What sort of rule tells that every little
> >> function needs a device node? It's first time I hear about any of such
> >> rule and for all this time we already NAKed it so many times (node per
> >> GPIO, node per clock, node per every little pin).
> > 
> > That we should represent the HW as is. There is no "rule", there is a common
> > sense. Of course, it's possible to have all-in-one node, but this may lead
> > to a disaster when there are tons of devices in the Multi Functional HW
> > and some of them use the same properties. How would you distinguish HW
> > with two GPIO banks, two I²C controllers, et cetera? That's what my common
> 
> I do not see problems in these examples. GPIO banks have gpio-cells for
> that. i2c controllers are busses, so as I explained in other email, must
> have their own node whenever any other node is expected.
> 
> And for everything which is more complex, e.g. regulators, we do expect
> child nodes.
> 
> Still the "MFD" is not a reason itself, we consistently give such review
> and we also documented it.
> 
> > sense tells to me, putting all eggs into one bucket is just a mine field
> > for the future.
> 
> Some years passed and I do not remember any mine happening here.
> Actually mines appeared when people DID create fake nodes, because then
> when the actual true bus node was needed it was violating the rule we
> have - not mixing bus and non-bus nodes on the same level.

Okay, thanks for elaboration. I definitely learnt something new about DT.

-- 
With Best Regards,
Andy Shevchenko


