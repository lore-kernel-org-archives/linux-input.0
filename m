Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0D36EA82
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477552; cv=none; b=aXANSKwvGpQrBRE0ByNOqGXSb52bV37u3fFGRv8oYweuh7nuc3orL8cOPR+29Zv5nhjuEBJE842AtZ8KaROnBK2say1iAZbvUjXmrcQE8qr03l/BucaLuE726Ro5eCgLsGIYgNVDk9FKl9ZYdyW44TUlsSWmkXeJkuCW7XOCIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477552; c=relaxed/simple;
	bh=XMrKqPPL6EnxrPNqt7DnB6/q9v2v5jYjq00A27CAQF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJtX8kCyl976mEByw1OCuWNYfPELToKk21LrFTDRURE2axQTPFeY/X7T5+9myEgjsDGSZst6dc2jQNoOjTvbrIjfNf1FhtAV8DT2L458KgGlxokf+6uIxAe14jwW+5PEKxvPqAOlzgQaZhPSAeF8+ErwP3itYPqIY8HSD4Op7a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvW7PMCE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvW7PMCE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780477551; x=1812013551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XMrKqPPL6EnxrPNqt7DnB6/q9v2v5jYjq00A27CAQF0=;
  b=CvW7PMCEYKEDkuE/xaCF4V65sCbrwvjYx8AjD9cGSb31jdzIXXJI5RBg
   cAJtkAlIGC9ES3Pa2CpaNfrGX5oeOUZ5ZPSr82uDkrUPBUjf+NIZMZxmo
   bzy8y9gHkJOZa5ok3mAqyalGHmHnaOtS0gQ8lHdV1ullcXCiVAonfKbpv
   XAABnSVC6qs/n9LbixyJ5ihEyePlrgJa4Qlgp/U7vAzz5o4DOfs3fTmTo
   bHVW5Lgm2n0Klx5SU/8laOo+ND6r0kEm01PEiMZq2h479YTmjPvby86BO
   Ah+fEBYShu72T4fAdhXCHdXoRLNKrmX8ap8ICe2/aLC/g36PMZxgW9DfG
   g==;
X-CSE-ConnectionGUID: GZda01leTdm7OqNAx8Q+UQ==
X-CSE-MsgGUID: lFu6QWGjTVSQJfTI5A9L8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81309713"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81309713"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:05:50 -0700
X-CSE-ConnectionGUID: 15YMYGhSTd6uyx89p/I/lQ==
X-CSE-MsgGUID: VKzSLoGVRTWuSf4KRX9IHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="239998597"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:05:49 -0700
Date: Wed, 3 Jun 2026 12:05:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v1 1/1] HID: nintendo: Use %pM format specifier for MAC
 addresses
Message-ID: <ah_uajaqNy5urdFC@ashevche-desk.local>
References: <20260603082808.119958-1-andriy.shevchenko@linux.intel.com>
 <20260603083946.923AD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603083946.923AD1F00893@smtp.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 08:39:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] ABI Breakage: The patch changes the MAC address exposed via sysfs from uppercase to lowercase, breaking userspace tools that rely on exact string matching.
> --
> 
> commit 6c8c4e53eb547a4381d6f8dabe9201540c4f0168
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> HID: nintendo: Use %pM format specifier for MAC addresses
> 
> This commit refactors the MAC address string generation in the nintendo HID
> driver. It replaces a custom sprintf format string with the standard %pM
> format specifier.
> 
> > diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> > index 29008c2cc5304..77b14dfdae867 100644
> > --- a/drivers/hid/hid-nintendo.c
> > +++ b/drivers/hid/hid-nintendo.c
> > @@ -2431,14 +2431,8 @@ static int joycon_read_info(struct joycon_ctlr *ctlr)
> >  	for (i = 4, j = 0; j < 6; i++, j++)
> >  		ctlr->mac_addr[j] = report->subcmd_reply.data[i];
> >  
> > -	ctlr->mac_addr_str = devm_kasprintf(&ctlr->hdev->dev, GFP_KERNEL,
> > -					    "%02X:%02X:%02X:%02X:%02X:%02X",
> > -					    ctlr->mac_addr[0],
> > -					    ctlr->mac_addr[1],
> > -					    ctlr->mac_addr[2],
> > -					    ctlr->mac_addr[3],
> > -					    ctlr->mac_addr[4],
> > -					    ctlr->mac_addr[5]);
> > +	ctlr->mac_addr_str = devm_kasprintf(&ctlr->hdev->dev, GFP_KERNEL, "%pM",
> > +					    ctlr->mac_addr);
> 
> [Severity: Critical]
> Does this change the sysfs output from uppercase to lowercase?

I think yes, it does.

> The original format string %02X explicitly generated an uppercase MAC
> address string, while %pM delegates to hex_byte_pack() and generates a
> lowercase string.
> 
> Since ctlr->mac_addr_str is exposed to userspace via the uniq attribute,
> could this cause an ABI regression?

This is a good question. This is MAC address string and conceptually the
user space should be prepared to parse it as a mac address and not an arbitrary
string. OTOH, the field is named something like uniq, which means the
driver just supplies MAC as an arbitrary (unique) string.

> Userspace utilities and gaming libraries (like SDL and the joycond daemon)
> often map USB controllers to their Bluetooth pairings by performing
> case-sensitive matching against the uppercase Bluetooth MAC addresses
> exposed by BlueZ.

Hmm... Interesting. Okay, perhaps we need to have %pMU first.

-- 
With Best Regards,
Andy Shevchenko


