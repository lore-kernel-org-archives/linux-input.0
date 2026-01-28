Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78369191F98;
	Wed, 28 Jan 2026 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604587; cv=none; b=Q4MIBHkopGRpZuc6uugpxii4sYe4jN0qWrtcRoRc8jYBfxl/XdpwiKRCvZHFAD+HGdcaGkdk8wCp73IhT3lbsdlseBwyorOSWwJhURHhsDJRfaMjfpP9Xh/3TMhrpImFlLQOEN7wpAbvBAG6IMOighW1v6eWmYw5b/C3cRs9Lpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604587; c=relaxed/simple;
	bh=KmjdpuWSlmGRPloRpd2Hx6yaXSeiIiqP/jIxfSxWb6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSjnclmUuYKg5A69YZpT/YnA94Lp6sdw1G7f0HGsm4tBDGrJIQHBr3HXlEiTTZQ7ZwN8E55j2NJVt4SL5/fCp0jEqSqWN9Cmyqu0KyAm3iO0g8Zm1kG1P/gyDS3If6DzqT1mkEELFlTFQ7I9Adly5qHnjkYolE93nBPjCGOxDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEUnJSQw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEUnJSQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769604587; x=1801140587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KmjdpuWSlmGRPloRpd2Hx6yaXSeiIiqP/jIxfSxWb6s=;
  b=WEUnJSQwbkBBwq19uzdj7gGSkkTOtvKhgY51h0HZvDb9yVHCArTGHQ0u
   NhZc4/WZzzZhG2l6jLLFo+fi+bNzZEpZKnW2XLjJkO3CuJVGDc+9MoYTO
   w8HkFhZPWrbovV1JFSBpzt/2J0pBJPjgmwvtwLB6/5HHDYbJKtz3FhPfz
   PMku6WErij+n/w7V+n0oOIoI4IROjjeu0dpa6wCi4NeU/cmg/Q+eQeFo2
   5BFJm1b7mPOa4mWsjckqgPnyFsFS/RlSuuK1ZLkx80uuY26shGwi6L3F7
   mqQCTClgazJ5wUtAHh3kKYM22AvZZNlukr0V+qvXiooKz7i3o6e79h6Nq
   A==;
X-CSE-ConnectionGUID: +pkohkgjQGe0EKhXMoh/iw==
X-CSE-MsgGUID: go94jGEpT5Gg+C8AO+WcvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81537942"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81537942"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:49:46 -0800
X-CSE-ConnectionGUID: a2PVRto2Qdyxt04flRADMw==
X-CSE-MsgGUID: qk2UHxACR/a81rcNcGkVDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="245865958"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:49:41 -0800
Date: Wed, 28 Jan 2026 14:49:39 +0200
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
Message-ID: <aXoF4zi4SZrXaku5@smile.fi.intel.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
 <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
 <20260128-magnificent-faithful-otter-c4f900@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128-magnificent-faithful-otter-c4f900@quoll>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 11:35:25AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:
> > On Tue, Jan 27, 2026 at 08:47:48AM -0600, Danny Kaehn wrote:
> > > This is a USB HID device which includes an I2C controller and 8 GPIO pins.
> > > 
> > > The binding allows describing the chip's gpio and i2c controller in DT,
> > > with the i2c controller being bound to a subnode named "i2c". This is
> > > intended to be used in configurations where the CP2112 is permanently
> > > connected in hardware.
> > > 
> > > Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
> > > ---
> > 
> > Hi Folks (Intended for Rob or Krzysztof),
> > 
> > Wasn't sure the best way to go about this, but trying to see the best
> > way to get a message in front of you regarding an ask from Andy S.
> > 
> > In [1], Rob H initially directed that the gpio chip share a node with
> > the CP2112 itself, rather than having a subnode named 'gpio'.
> > 
> > Initially, I did the same thing for both DT and ACPI, but Andy S.
> > directed that ACPI should not have the node be shared in that way.
> > 
> > With the last revision of this patch, Andy S. asked that I try to get a
> > rationalle from Rob (or other DT expert presumably) on why the gpio node
> > should be combined with the parent, rather than being a named subnode
> > [2].
> 
> Because it is explicitly asked in writing bindings. Please read it.
> 
> Because we do not want Linux driver model affecting design of bindings
> and DTS, by subnodes present only to instantiate Linux drivers. I do not
> care about driver model in this review and I do not see any reason it
> should make DTS less obvious or readable.
> 
> That's actually rule communicated many times, also documented in writing
> bindings and in recent talks.

Does DT represents HW in this case? Shouldn't I²C controller be the same node?
Why not? This is inconsistent for the device that is multi-functional. And from
my understanding the firmware description (DT, ACPI, you-name-it) must follow
the HW. I don't see how it's done in this case.

-- 
With Best Regards,
Andy Shevchenko


