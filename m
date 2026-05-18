Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BD3E0C42;
	Mon, 18 May 2026 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089458; cv=none; b=iTJbNVDPOBY6tEJ15+AwumeSqRDYZcfc1otL8uwOkfQhqciaIag2hiJxDi8wU2oLjQsMVLIPkXXOBc6Ga6ws8DfadpP09cyA7ltMjiI930+PftZvnJMJhKAPcVWkQ/Cd5hFnfwlftNwqXKFXue3R/JeS+j7nJfekVHKv5glLYqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089458; c=relaxed/simple;
	bh=UaRHwV1chvJbIFiNEZ7+ON4XkcfWZY443RzNN8Aa5wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNbYMqpQvXS1WOsI8g4dCrkvjpVV5e1FobiVNsryDgMPUfuIsRVVVzmhzCVR2wXKC3G4YziBJBIvmd26Z116cCJRHguWZx3fEyRZ1M/OZjnhtr0yOy1IqHx1P+6WlpnuLICoGCKxX3Isd2CeIWvEnwew/xt2yu13WIC2HuRB6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwDPS1N9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwDPS1N9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779089452; x=1810625452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UaRHwV1chvJbIFiNEZ7+ON4XkcfWZY443RzNN8Aa5wk=;
  b=TwDPS1N90siKQt3usj5SRfn5wt9UU1MKAlASPvEeDzKDY8GsK6+ek6IY
   KNYiCxfLDZfEvr5/VIlCdk5UO61QzrKfKCc4J/RrDaeDtIKUP4kycp1QV
   7B/5SVmS9Tm1KYxgbUt6kWpGSaDSi5t5GLEwp3TTGdyeRvCtzuqj8+Zbc
   iSq9ko4NlpTpeG6NQzPaFYEM07Ab8yVB7LwcHp1n3whe8u4yUdbSYxKtu
   wa/3CLoSM/Bfv/IQnnW7LnSw+jTlscOr/ZYIjS3n+fPkbJ5Mu41B0GmRH
   /inGCXmf7BS2yIkHDaXOUoHEOonIdizpYvW+Nm4vunNif5yYxbAJBztNT
   A==;
X-CSE-ConnectionGUID: JGp50jVSTWCH6BG/IBl7NQ==
X-CSE-MsgGUID: AhLZ7ZbuTw29FOPoAn4kJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79984136"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79984136"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:30:47 -0700
X-CSE-ConnectionGUID: 9J+sJRDISnCHuXZHDNRNVg==
X-CSE-MsgGUID: vMqIh9JcQPuKrJHTNcXvBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="277446492"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:30:38 -0700
Date: Mon, 18 May 2026 10:30:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Anshul Dalal <anshulusr@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Support Opensource <support.opensource@diasemi.com>,
	Nick Dyer <nick@shmanahar.org>, Hans de Goede <hansg@kernel.org>,
	Job Noorman <job@noorman.info>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Kees Cook <kees@kernel.org>, bui duc phuc <phucduc.bui@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yauhen Kharuzhy <jekhor@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Minseong Kim <ii4gsp@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Josua Mayer <josua@solid-run.com>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	David Heidelberg <david@ixit.cz>,
	Petr Hodina <petr.hodina@protonmail.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Xichao Zhao <zhao.xichao@vivo.com>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v1] Input: Use named initializers for arrays of
 i2c_device_data
Message-ID: <agrAG3cLjEAPV90B@ashevche-desk.local>
References: <20260515164848.497608-2-u.kleine-koenig@baylibre.com>
 <CAMuHMdWGSBbQtKaoFej1Qm-SUgDenLMDF0psD9o07wyHKu8A+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWGSBbQtKaoFej1Qm-SUgDenLMDF0psD9o07wyHKu8A+w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 18, 2026 at 09:24:35AM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
> 
> On Fri, 15 May 2026 at 18:48, Uwe Kleine-König (The Capable Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> > My additional motivation for this effort is CHERI[1]. This is a hardware
> 
> Nice!
> 
> > extension that uses 128 bit pointers but unsigned long is still 64 bit.
> > So with CHERI you cannot store pointers in unsigned long variables.
> 
> Good luck fixing all implicit assumptions about this in the kernel!
> Also, good luck convincing people to use uintptr_t instead ;-)
> 
> https://lore.kernel.org/all/CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com

Yeah, I believe Linus will have a strong opinion about all this CHERI stuff :-)
But let see, it might be surprising turn around.

-- 
With Best Regards,
Andy Shevchenko


