Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566A28CF77;
	Wed, 29 Apr 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492500; cv=none; b=HFoIJyfMxjqIMX4zEQg6AzIbn3U69yU1CEAvEd2g2L8OixxG5EbRq8S59TVDIgN5SaZUu1syDplTsv7jfwalSYQ5NEkVXUt8M/pLwVFSh9hU01UTyrxd1UtemR+eTKAEINqB+Fz4+guihAiK4H7YD/00zEEi+EvI71hu43wdY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492500; c=relaxed/simple;
	bh=pmAzQAVQCStUE+VV4MqMdSPR/Xvj9wQV7X1h/44Yzh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCkxL/TO8Iome9D76RrC+0iMpSXfeUsa4V37JYf4U1FsYymM1dF0F2+M1/o00bdsfsqf0iFcH3DdM3mIxsRLa8TJeQyBCuqPpELZ94FQuaTLaDPyk6Hj96PiJLALrQygx+t4GpR4DpkxiFzzYSjkQ8hTbj9CVV/TPIqVvO8i/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtpHMcFo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtpHMcFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777492500; x=1809028500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pmAzQAVQCStUE+VV4MqMdSPR/Xvj9wQV7X1h/44Yzh0=;
  b=NtpHMcFoSwX54qPTJ+xlFbS/9i5I1LZIH7+OuQVDXqcA7oJUAvHRxU+I
   7u09djQH+okK0nqmuURxBHhjS352GpzkhGFbT0gKCfWhFjlUd3m9gUhib
   86egqHkVk9IhrEGtcoiP7G1+S/J00FbsPP+FlHbNOtdanMUNtxUl1has8
   cPJXMUmdOOjKKdbeYP8oZdVrD7dsXS6naJpejdvaHgnM0bZzD6gVOatTC
   CCDQ1KJ1HLSBbi6O+33JJe3NrgvBciA9uidk/4t5Io6F3wHXCVOIqtEg+
   +tDG8wlfmc/7zEw9sT+Eb6Lz6fjcrokqEzu2Mq8xCi7EDvrOMDDNzNKSu
   A==;
X-CSE-ConnectionGUID: MUxGrwVuTL65LwZyFJON/A==
X-CSE-MsgGUID: KZ/omD7ySkq6Rkp4mT/Xug==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78622350"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78622350"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:54:59 -0700
X-CSE-ConnectionGUID: F8LI1en1TseWX+MXIn003Q==
X-CSE-MsgGUID: Ia6ryg3NREilKcLYOPysZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234391917"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:54:56 -0700
Date: Wed, 29 Apr 2026 22:54:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>,
	andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: accel: HID: Replace method
 accel_3d_adjust_channel_bit_mask()
Message-ID: <afJiDeoCdH0egapV@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-3-natalia.andre@ime.usp.br>
 <aeiPuxj2TRLNRbv1@ashevche-desk.local>
 <20260424200847.78494f27@jic23-huawei>
 <ae8upGN9ILmtCzeA@ashevche-desk.local>
 <20260428191246.152c2972@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428191246.152c2972@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 07:12:46PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Apr 2026 12:38:44 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Fri, Apr 24, 2026 at 08:08:47PM +0100, Jonathan Cameron wrote:
> > > On Wed, 22 Apr 2026 12:07:07 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > On Tue, Apr 21, 2026 at 07:20:34PM -0300, Natália Salvino André wrote:  

...

> > > > > -		accel_3d_adjust_channel_bit_mask(channels,
> > > > > -				CHANNEL_SCAN_INDEX_X + i,
> > > > > -				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> > > > > +		hid_sensor_adjust_channel_bit_mask(channels,
> > > > > +			CHANNEL_SCAN_INDEX_X + i,
> > > > > +			st->accel[CHANNEL_SCAN_INDEX_X + i].size);    
> > > > 
> > > > Indentation is broken. Taking into account that the last line is too long when
> > > > properly indented, perhaps
> > > > 
> > > > 		hid_sensor_adjust_channel_bit_mask(channels,
> > > > 				CHANNEL_SCAN_INDEX_X + i,
> > > > 				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> > > > 
> > > > Which makes it most right and under 80 limit.  
> > 
> > > Why the double tab? Maybe just go long on this one and align after the (  
> > 
> > I never know when you are strict about 80 limit :-)
> > 
> I was meaning vs single tab really.

Ah, my point if the line is too long and maintainer is too strict about
the limit the indentation I would like to use is to occupy as much room as
possible. I.o.w. to indent right as much as possible to fit the limit.

> You are slowly wearing me down on the 80 limit by pointing out lots of
> cases where going beyond it really helps! ;)

Ha-ha :-)

-- 
With Best Regards,
Andy Shevchenko


