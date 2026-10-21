Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604590;
	b=VQxyoE7HzQCQckFMc1C2ByAXEoI540xEUjQVLNBKLo7vpSUYL3BFUfxkdXBO/xoNUX6i
	 hFbmwboIisorQhxKoVAwbxiDZWSBRMVp59xtLz+6mO6YWAl54EUoOJtr8P1LvL2EZPsA2
	 pf7vXRdCWKSQL3oUDTACWWVKgIVr4D+ksW3UU17ruo9wWZ5EY5P+XDAiFr76NMOeIYcR9
	 UEyX9/6ERsA6z2ARlNhQKNdIPUGFSaR4yktcjliq9Ny8iDAb0PENUcqFuKME9lZ2y+gl0
	 WhhSKeH4FaU03jvhI8YkFOxsdhfoHqNW5QipYqPQbmJH8Rgx/NYl2qgC7fmICLRLk2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604590;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=cyRMrmRtZUX95PQBJk9L0GNJdPfXf4VJ96b7e9nHs3M=;
	b=4O9sk4dosy0sEqM2Lh72a7itHdbhvTbpVLIFu6OPiCIz/wN3rHFwUdBHgKebaf2d6a/U
	 +24il6l4LM0vrQKwgFtJK1V+MFGhyq+0J1srq2DjmXDsBcj5kvS+jYfAD5yPuc3b+fYGV
	 /g0pZUvH+HAXn9iT+plsyP2xkziOJ02njFatR/wgYuRYt76i2PpxfoHehVHFGWyYmjzVJ
	 dnD8oMBFh82D6E5wbOxniR1/q17U91FQe2hVvhZgUAGbfPpfG/ntzGGWnNZVUMhS//b4t
	 oGnnlc1YaUU0xEaLodNW8h2lTFFOCwkBbKY5oYYPdEtN9UAXp06Oy5tbjmgRE9S7jhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PgUGK8xC;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D411606A31A;
	Wed, 21 Oct 2026 17:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D411606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PgUGK8xC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792604589; x=1824140589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CQG09qhOxI4i96OkwFhNPL4Y4F67tDoq4cUXnX3YA1M=;
  b=PgUGK8xCXunf4AQlMqRS4poBY6wCtXrKg+gqd5u0bGaiNgHlvks8COQr
   Wwwerr/+VdFrx6ia8Yw1XKA1jMDMp5YsnC1DHu6S7P4/uSFMLOlGEzCRC
   cF7x8TfC9l3uyUWj49LNYZdwFP6IcAAjtpMMN1H7ANq+vs3h9kH8gVaRu
   iRvDcrASFOnzaRFyoLoHE5cpsJb/rPW/Cbi7kElPb24/jXLgPbkHM7s7D
   WIIMT6atMukFAuuFh0NAHKfvHL/Hh5G+j3nlKlzhYvqozl/UJ5hGGzl+s
   3jYJJ73yqe5L6JrTY/JmKa1yT5+oMI88GWrq30U+VJeGVE0QvlJ0ZCzYg
   Q==;
X-CSE-ConnectionGUID: ALTmD+pLSSeKqIXv7swDgg==
X-CSE-MsgGUID: LTpJE3dsSAqfJYE11Ledfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1354565"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1354565"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:43:08 -0700
X-CSE-ConnectionGUID: N/dkcIvDRPOYCuaWfOaaRQ==
X-CSE-MsgGUID: im1wKVecRCq+XQwo1TeFpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3485606"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:43:05 -0700
Date: Wed, 21 Oct 2026 20:43:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: soc_button_array - use __free() cleanup
 facilities to free memory
Message-ID: <atj5pgIU0VCcrHHX@ashevche-desk.local>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
 <20261021015004.1537738-2-dmitry.torokhov@gmail.com>
 <atjw4b-ICVGH3-2a@ashevche-desk.local>
 <atjyyqxnlqEvwNxh@google.com>
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
In-Reply-To: <atjyyqxnlqEvwNxh@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 10:15:43AM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 21, 2026 at 08:05:37PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 20, 2026 at 06:50:00PM -0700, Dmitry Torokhov wrote:

...

> > > +	const union acpi_object *desc __free(kfree) = buf.pointer;
> > 
> > Rafael added 'acpi_object_free' for __free() (pun wasn't intended :-).
> 
> Not sure why it is better... It goes through ACPI_FREE() ->
> acpi_os_free() wrappers which might be nice for ACPICA code, but has
> limited utility in the rest of the kernel code...

Today it might be similar, tomorrow it might be different. ACPI objects should
be freed with their proper APIs at least for the sake of consistency, no?

-- 
With Best Regards,
Andy Shevchenko


