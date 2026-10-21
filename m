Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606919;
	b=jM+CLmnNm0zYjcZIHXg00FTJ9g3zvZhF6EM8Hrp/RO603AVlQQKvDTQ5J0ihV55I+Mb5
	 8cHFd9oVrsMt4TOL/+RSYndRPNxgfOh2HMqb79otqcg4mtpclFW+ZI4L/5NiDwG7nJrCy
	 CPkHQ2TEv6FpKFpFrO/vj+czOdfwZXhZVzT5ZVVZi4ZEPwyZ1LisTnhEoMrXFuPmoz/ci
	 6bJskR4Kd8zQuRHLM5IRF0XsG3dYF8GMWyJzUscGdTlTpl6C1kDF03omxEuMoYPST4fus
	 ZdlXHbgcZOEHFPFQTHdfXFcQ4KDteBCEx1L9P6XZfMIs2CnGKARJIlaS6Z4u875GbcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606919;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0Xi0GKbMN2Oqdu7m+YBVdZb5sclpnnu0dtiqv8V8WVI=;
	b=tHHbKmAKDeA9pKsL5HmZ18LvbRuaqHZqjqjqWMGtsGW0+yuT5S5SFimlErZzuIC51I+5
	 xGLW3Y32kYX10imaYw0dqIHRbpQVBeZFTn7O61X7Wc2xzbKOYmxNHWk8KrHaE5mvvBfTs
	 D2S9lsXhbrXDCSP4rKvmixn0kp299oCZ2woSmkqR2m39YSMPgIMrzNa84B0mHvZD3UbAH
	 gCpCkWMPPfg4nrFdqT5UjF+HWk7GvxlFsR6P+NyJa/czeaEb3h5QvdY7o/v2zWJKJuFdj
	 xHA0ObJyh34Npm1q5HL7P6eEnW07wE1vwD6qlm/WfmETIJa8H3XlLqfbSpufOLGxKXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CnzU1iGG;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89540606A319;
	Wed, 21 Oct 2026 18:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89540606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CnzU1iGG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792606918; x=1824142918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YqEW9tVezdaoJ8G/XXWCUZ3u3M0v5a2gt+v3QGHcdkM=;
  b=CnzU1iGGfBCFldp2qcxkxhg7MsgPFzTdHtfaaL9RJiXMKyD+v3x6eGlD
   bzN+XvePYX652/CTX9JiAtzA7YPxc/0jXyPmP7tugQh+yRdduxM4QSDpj
   gqO6iyRKxNZF38tFHml/bveGQgwutT6sKFta2D5CG52Jh9fogwWgcQRoj
   8eghIGgexky9u95sYlerdz8idKu3XmHCxY7F1Y8BGvsp1u22UMgxBcsPw
   XMhO0EC7BS0kPDZDfWuOq3ikvHZIR2+VxFHDyJb//VZswEJ+xT4n1+YHI
   ZBQxx9AO+18kGxs8kiMPDL4F07pmEfy6DXbblby0WQQZw/XPvWi23V47J
   A==;
X-CSE-ConnectionGUID: PPDsYtnRSyCqKYs6EmtTSw==
X-CSE-MsgGUID: rcGzBuCKTRa04W8DEvKsDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1437979"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1437979"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 11:21:58 -0700
X-CSE-ConnectionGUID: gj6my4CVQ+i+jFfC0jgiHw==
X-CSE-MsgGUID: Zk07A7/XRMyswhzHp96dQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3225895"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 11:21:54 -0700
Date: Wed, 21 Oct 2026 21:21:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: soc_button_array - use __free() cleanup
 facilities to free memory
Message-ID: <atkCwCXRcobOI9J2@ashevche-desk.local>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
 <20261021015004.1537738-2-dmitry.torokhov@gmail.com>
 <atjw4b-ICVGH3-2a@ashevche-desk.local>
 <atjyyqxnlqEvwNxh@google.com>
 <atj5pgIU0VCcrHHX@ashevche-desk.local>
 <atj71VUZdpHO4aBT@google.com>
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
In-Reply-To: <atj71VUZdpHO4aBT@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 10:53:06AM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 21, 2026 at 08:43:02PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 21, 2026 at 10:15:43AM -0700, Dmitry Torokhov wrote:
> > > On Wed, Oct 21, 2026 at 08:05:37PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 20, 2026 at 06:50:00PM -0700, Dmitry Torokhov wrote:

...

> > > > > +	const union acpi_object *desc __free(kfree) = buf.pointer;
> > > > 
> > > > Rafael added 'acpi_object_free' for __free() (pun wasn't intended :-).
> > > 
> > > Not sure why it is better... It goes through ACPI_FREE() ->
> > > acpi_os_free() wrappers which might be nice for ACPICA code, but has
> > > limited utility in the rest of the kernel code...
> > 
> > Today it might be similar, tomorrow it might be different. ACPI objects should
> > be freed with their proper APIs at least for the sake of consistency, no?
> 
> Fair enough. I'll add a todo to switch once it hits mainline.

I believe it's pending for v7.4-rc1. Are you planning to push this series
to upstream before that one is out?

-- 
With Best Regards,
Andy Shevchenko


