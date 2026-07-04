Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A0208D0;
	Sat,  4 Jul 2026 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783127383; cv=none; b=lFJRWnHRlqOxrrCVQa+EBRwT6lEMa1VejAB3VIWbwLeFyMiPhRxg/DCjjKhFajoAqLEnuxgGJahvt5Nx4eW0y9mS4edrMi4ZCKCAOsPTAeURM6I67CIN9oiZUKvqdogB6Ewb2Rlf4BIrVRH4EsxldosHiqj67C+d8/MTgrmWcEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783127383; c=relaxed/simple;
	bh=6/s/SwMlmyhRBB42jG173yqgXRvHwLIoepyCkpyNLY4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3DxI/qs1WiqH+aBZTpMkn+M8P9MymYPWm5rB7+wWh3DDe/i5kaDKvAw4mRrIr3zPmCOUQBySIibwVlBkjXDi5whLbL39EU6l7Cgzk5Hukc359loEG+d063c1ui30JpKTEeA9HaKc3w/pEWv08t9hgVD8DvUYAsq5ArFxFvMNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2Z+ZeCM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2Z+ZeCM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783127381; x=1814663381;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6/s/SwMlmyhRBB42jG173yqgXRvHwLIoepyCkpyNLY4=;
  b=T2Z+ZeCMT2R1td91Oiw/hUmnI3aWKAJHb0eCU/DA6+Y3BKZN3sB7TjmO
   MKEsklRtjr3X9Cn8RgQI1x7+8nvPjw9PuM3Iu3k7EtYpJ/UHSbMF556EW
   iLjMYA97ZQHZfZCr9svK5HsIt8c2KhK9iLi5h/7/zO66A5VUeeSjGEUo4
   8Le4/KizbRvhKhLKAP7QyjgqTS05uDvqpymp78djsSaF3CBWn4zEGz4XF
   endY8hhExZPXBHNGlDfblrpDYah1ECCDEYSxsMbC/Kj6ByNxIIJ8TmZGh
   pf4j+gr3FKhaniWvoReahDNRg/YR30cbGShk3w9rOImQJxc+yyprj8guG
   Q==;
X-CSE-ConnectionGUID: RuSXj6eiQuu3bsz/bR/wlw==
X-CSE-MsgGUID: q1BgYuThSqSM/1AMp5uNnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="82972934"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="82972934"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 18:09:40 -0700
X-CSE-ConnectionGUID: TePZ+2OaSuWMMLLKSf0FAg==
X-CSE-MsgGUID: /Z9TwGBcT8iealIOTbWNHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252751275"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.110.148]) ([10.125.110.148])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 18:09:40 -0700
Message-ID: <e753606a89dbed26389d8c5ee8b2e4f0dafcd2f3.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/6] iio: hid-sensors: align function parenthesis for
 readability
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Sanjay Chitroda via B4 Relay	
 <devnull+sanjayembeddedse.gmail.com@kernel.org>,
 sanjayembeddedse@gmail.com,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko	
 <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Date: Fri, 03 Jul 2026 18:09:39 -0700
In-Reply-To: <akewhE9wEpU6UW0u@ashevche-desk.local>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
	 <20260702-15-jun-hid-iio-alignment-v2-2-b87f01f5efbc@gmail.com>
	 <20260702182015.303db93c@jic23-huawei>
	 <akewhE9wEpU6UW0u@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-03 at 15:52 +0300, Andy Shevchenko wrote:
> On Thu, Jul 02, 2026 at 06:20:15PM +0100, Jonathan Cameron wrote:
> > On Thu, 02 Jul 2026 21:47:59 +0530
> > Sanjay Chitroda via B4 Relay
> > <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:
> >=20
> > > Adjust alignment of parentheses across HID sensor IIO drivers to
> > > improve readability and maintain consistency with kernel coding
> > > style.
> > >=20
> > > While updating the formatting, group related arguments
> > > consistently in
> > > multi-line function signatures where appropriate.
> > >=20
> > > No functional change intended.
> >=20
> > Whilst I appreciate this code isn't quite in line with standards
> > and usually like that stuff to be fixed up, in this particular case
> > this is a massive amount of churn.=C2=A0 That churn will make
> > backporting
> > fixes etc messier, so I'd like input on whether others consider
> > this
> > one worthwhile.=C2=A0 Jiri, Srinivas, Andy etc. What do you think?
>=20
> I am fine as long as Srinivas is. I understand pros and cons of this,
> but from
> time to time we have patches =C3=A0 la this one that messes up with
> backporting but
> were accepted as a good part of some bigger series.

I am fine. I guess we will deal with backporting issues as they appear.

Thanks,
Srinivas=20

