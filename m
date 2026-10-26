Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004736;
	b=NAQMRNmKPnI5lgtcd6GubG+KEVKRvV7y9wM6d3IZ3DG6R8fWoApnzHz4/0pT8L9+fhSt
	 4lwqFtomh+CWPyyinzfcKW8eZK/clzVSxLoVjvcnhRxSvvRcPddczY2hVVcG0+zVQ+djD
	 y58oEJ35mAGwmB2zmdVFDGzp07NS45jPKxWZEJBnOk6eJWeQEYSMTMnriZ268N6Iv4tYU
	 JoSeEMXnW9Wuok9tMaiYt3L4wEnADSLJPweFTIIe0J5BNN0VqTSn5N+8JRt5Co1H0Qm1p
	 LeuG0vt6nYyD7gFytM+cxXbRVlLnWYTClS75Z4DCDGB9bTyxHR+WF01yD6PU5o/3Weg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004736;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=pi1B7J06pQAlF24N/BvX+wC7pBbB0wGuY462/UBZEik=;
	b=J7hOYuWjIKcgyW1W2QY05miOHOumrFB3d8mt3gazeihk36EiU8BScTVB6muTcK7msulF
	 WxP97yuEG1AliKZ3F+fnovc72ziLixooaL4ZyHGQXaQlHQcUhiXizfLkpC5coYJThF2r/
	 LEoX5wgMGmEJ/fIuc3p+YkrDCr6jfqWvrtvfus9x5wv0C3Vy04cp2vKC0VVFtHMeQWI9j
	 M8wd0D4FfvLg91UoSWGwULSpCtwjctq5AwDfbBFFJsWT1ZQivQwJzHrYpw2XczJQm56/4
	 AhhUYXc+dwMrUCPcgkiJXxxc9FGxC5mWSVABBGQkn8qvdv/WRyrUjJijxO+DDpOJQ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DO2rrnBA;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF0606A31A;
	Mon, 26 Oct 2026 08:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00DF0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DO2rrnBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793004735; x=1824540735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kjuI/w5QNmHvgwphrr7C9WT/IGfhnOeCTYfvv/oClDo=;
  b=DO2rrnBAvZE3aAlPveekYRDEfvhuPmJzSakIzAQBQ2nuq9bQEqEebZIn
   jdrbXJmpR87QauGMiC7gbO8Oyc8Pyca7WQzPZQm/eORkveAfeJcBljSOo
   xFC4zB1cRSXoQKxTl8B5cMguyD21BQA0jJC1Qe9C8d9ZY80W4RGqFsTPs
   mKmKjqTtDGcV0R9aIIEU50BGDxgI0RQo1I/Pk/lgluHAOmhTmhOhMuNdv
   gqsO7atVsTWAV5l2m6tX/ogoBR+RjK+eCuRN13s5FXBw+RBbew3g9++OW
   gEWagknszPsoRqi+I9QtIXYPFN2V00mllaiLYUKb1lSX1E5/xwewuYMEV
   A==;
X-CSE-ConnectionGUID: QLA+SbalQEaNJpv1gn93dg==
X-CSE-MsgGUID: lNxwds/wRga/GcN8+EZx3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1553970"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1553970"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 01:52:15 -0700
X-CSE-ConnectionGUID: covuXGiARweDOFTHO1yh/w==
X-CSE-MsgGUID: SMQ7VNwmRmqKCzwqqqF04A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4111876"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 26 Oct 2026 01:52:11 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B115D99; Mon, 26 Oct 2026 09:52:10 +0100 (CET)
Date: Mon, 26 Oct 2026 09:52:10 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Corey Minyard <corey@minyard.net>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/8] i2c: acpi: use 4-argument i2c_smbus_read_block_data()
Message-ID: <20261026085210.GD158991@black.igk.intel.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
 <20261024-i2c-smbus-read-block-data-v1-1-19bb97467982@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-1-19bb97467982@gmail.com>

On Sat, Oct 24, 2026 at 07:48:41PM -0700, Dmitry Torokhov wrote:
> Pass I2C_SMBUS_BLOCK_MAX to i2c_smbus_read_block_data() in
> i2c_acpi_space_handler().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>
