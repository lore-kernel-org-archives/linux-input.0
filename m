Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5A25CC79;
	Sat, 12 Sep 2026 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789217144; cv=none; b=QqJpl/qGgG4MzbmSoZ4sSUxokKKghI7OAejOkp893X5BBHI2pju7+fAwTSB6ATseFxnynmiATmHaeO6oD9xvFwXJU3ioCk0hsFO5MmoaJi4L3pyDkLnVLPpUcLJ9nwVJ1QCDi3WygOPedL6xh/S9MUZEP8XmsmVV42zN7S0ut60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789217144; c=relaxed/simple;
	bh=WotrzRkJXpE+rF0m9+R3qtuwvvX5iKfQZaGNsnZGFGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzzKEuw59fVTqmam64ztgZMUOvJVkl7n88u6Zfi1YCezVcLdF1ZI5iuqQbJPthC3BRC0blXW+epyjrZ0hOLvoacVw/ZNXPfUJlQohrBgSLkned+5w4eY2xsFqXBNFEc5yNCp9mQQlXwmU5NtI6IADALF60cmx5fehFt9RWnn/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CeBcUAmb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CeBcUAmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789217143; x=1820753143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WotrzRkJXpE+rF0m9+R3qtuwvvX5iKfQZaGNsnZGFGw=;
  b=CeBcUAmbN38yV/OFq1OwVdb4vyXAP4IF8Owq6dzvZrBHrnWIHAE6u1bi
   p20lyeNPFxaLlZh48Ob/LrBn1431xxMidux81q6ZF6EurA43fgZer1caE
   3InXe7O99s3ZoHz7SefESrQq9CMEiXKmzws4qeN2W3HhxVbXzhobxJ/1I
   7BD47WVbtGJYg0X0HJHNqHyHku6ryV7/rX+xbur21qpj3dCTu9slB2/9R
   pWuGrHVISRHQTDDys6dgOoIjacKTY0KDCiw6dXQT7eTHdPR+HsfDdQ5W2
   C2el+5Hql40hr1endMw4K2crhK0bA7CgIyjvHenG9i+dhJB9wChT+YoqY
   Q==;
X-CSE-ConnectionGUID: I/L8ECthT0CpN4XpEmcxrg==
X-CSE-MsgGUID: G9NCVIzsROGDiG2thvGDpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="93481307"
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="93481307"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 05:45:42 -0700
X-CSE-ConnectionGUID: rqA7kmD7SJG0YGI53vT+yA==
X-CSE-MsgGUID: Lf9FJoIvT12Rj8F67bBZYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="310441999"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 05:45:40 -0700
Date: Sat, 12 Sep 2026 15:45:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quicki2c: Fix the return value
 in quicki2c_dev_init() kernel-doc
Message-ID: <aqVJcZ51Q4kYW6m2@ashevche-desk.local>
References: <20260912002143.35091-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912002143.35091-1-kmehltretter@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Sep 12, 2026 at 02:21:43AM +0200, Karl Mehltretter wrote:
> quicki2c_dev_init() returns an ERR_PTR() on failure, but its kernel-doc
> says that failure returns NULL. This mismatch was present in the
> original driver skeleton.
> 
> Document the error pointer returned by the initialization paths.

...

>   * Return: Pointer to the quicki2c_device structure if success
> - * or NULL on failure.
> + * or an ERR_PTR() on failure.

" * or an error pointer on failure."

>   */

...

The rule of thumb: Among options always choose the one that is less cryptic and
uses more plain English.

-- 
With Best Regards,
Andy Shevchenko


