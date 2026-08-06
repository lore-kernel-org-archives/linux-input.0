Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929EB47F784;
	Thu,  6 Aug 2026 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048999; cv=none; b=N+V1fEjkBOV5270nsUVmn4/k7hby4x2Dvh/UTqYGIqmluQVDaKki+WfQlZO6mCpuOfkg09sfraBHzQEsA+s7HDBJ4K/aYxL9XYNfTMX6IOpQ1ORjV80tTMdfdbUc9FZTY2f3bYllldTilWKItJWEf6WEeVehvDumU42PuCh5/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048999; c=relaxed/simple;
	bh=XYQ9ph7SkY99P2wiTffNIVODeXKg9zc/r2YlJXW/V38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRVq8+P3u8QPL6csbU0pAAosrtOVvaZekAkPyoQvlyBz78g0GIHYfghYUl9/qkFbtJJK0s4k1bv2gYvB4bVcTWUYmgB2ZcmZJhaeXNzLJOTHilwQ2FdnpHP09HtaLd/zQgQUWKUlqG8mvAS5P4qPXldsJXhuy6H2HYrhMqgql3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtZmjvIA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtZmjvIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786048998; x=1817584998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XYQ9ph7SkY99P2wiTffNIVODeXKg9zc/r2YlJXW/V38=;
  b=EtZmjvIAQ5g+j2cVWg1olvoAxOP8k2IaLICXDIfHwAzogtfVqkmIKp6I
   U3CceOfcyLje0exg/oTRR0qmk7GcFi/kav1cKuuAw5nLZbE2E+d86W4c4
   nda9cP4uJ4ngsunuDWR30LLagWie60mOeglNXkuwhURTLWrtbefb+hfZF
   yJU4ms65Sc5SpQCQNs7da7no9g1kdkKAZR/yTEW8BCcCz4V9Vqent1IfN
   q6wXqvLjCP0LpmQSpsbsa7JY2mL+3uuGzPPQ7EgKw7Y1MFC7c20vNkuWE
   SDhbf0N8u2KWJVznyR/pCFd9mvgXMjOAoJ65pLo+rQqelc/fBxCtqaD7n
   Q==;
X-CSE-ConnectionGUID: b+C0gNgQSWuk639teA+DeA==
X-CSE-MsgGUID: fs14AFdVQXWchdiO4bgEuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74196166"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="74196166"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:43:17 -0700
X-CSE-ConnectionGUID: htgOAVvLRcKSncnclFgLkw==
X-CSE-MsgGUID: 5CYS6t07T7uX3QBlQJtdtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="286886747"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:43:13 -0700
Date: Thu, 6 Aug 2026 23:43:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] i2c: of-prober: Defer regulator_disable() on
 successful probe in simple helper
Message-ID: <anTx3y3kZNDEKRFW@ashevche-desk.local>
References: <20260721075226.2347933-1-wenst@chromium.org>
 <20260721075226.2347933-7-wenst@chromium.org>
 <al9IwVR7Whw2DiXU@ashevche-desk.local>
 <CAGXv+5EkcASZ__Cyp4PnwemPd2xAe+WL-ics9jqHLuxWjWyT7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EkcASZ__Cyp4PnwemPd2xAe+WL-ics9jqHLuxWjWyT7w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 22, 2026 at 04:34:15PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jul 21, 2026 at 6:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Jul 21, 2026 at 03:52:20PM +0800, Chen-Yu Tsai wrote:

...

> > > +     /*
> > > +      * Wait a bit of time for async drivers to probe and increase the
> > > +      * regulator enable count. This allows the drivers to check and
> > > +      * skip waiting for re-initialization.
> > > +      */
> > > +     if (defer_disable) {
> > > +             dev_dbg(dev, "Deferring regulator disable\n");
> > > +             msleep(100);
> >
> > How was this value chosen?
> 
> I just chose an arbitrary round value.
> 
> If both the prober and the driver for the probed device (trackpad in
> this example) are builtin, the time between enabling the node and the
> driver asynchronously probing is between 5 ms and 30 ms, but could
> also see outliers exceeding 100 ms.
> 
> If you're worried the value won't suit every user, I could make it a
> parameter of the simple helpers? And the user itself could be made to
> probe asynchronously to not block the main code path.

I think the comment above should be updated to summarize the above instead of
"a bit of time".

-- 
With Best Regards,
Andy Shevchenko


