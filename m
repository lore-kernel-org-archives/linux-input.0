Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10842749DC;
	Mon, 21 Sep 2026 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956505; cv=none; b=Sz8RuoSYa1oR3a4WazywDPmW0XftqFzPW5JwAfXmVrkB7f2e5fOADSzM0AqVe6Ef/8GZLpyHfN3OBTjmUkwhL3L3Nv23pV1fyP3Ipb6Tl/0j6thEMa6J3K6CNRakM4P1Udf1wvlmgqcWQEMx5UlVM7svuPs4xJ3O3zZQp95HJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956505; c=relaxed/simple;
	bh=FaQMT0rE37baVWJSJ0dRe4PqLBIHpn+9HdLmHtyFE5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDLbG9ZMRKhPgbaL1Si6LCm376dPZivQNGZ8qw/+0jxJCtA+Yj8Mn6VfOxd9/dfvM3Ktgz+Zgw5BXQ0G01xKagxHpaZOnUjejrVqLpO2XlrOpmmDqO6Cb8sYiRpO0Qzcpo6ROekCQJEzmXHvDHCKN6XKMm+09BmwI83tkkt/HXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZkPaFQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZkPaFQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8DB1F000FF;
	Mon, 21 Sep 2026 02:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789956503;
	bh=NpIRnFxqUUD3tCptCr10Wb+X9uJvASSGEA6JSURbCr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XZkPaFQHJ/onb/hbeK+wuQOu8zy2YVScKURFRY04c0BF7yrtvTNfT5xQQMjbFC9M2
	 z41m/Jzg3z/cU03Z8EdS/9Oxwq8lbNg5ME8M/wSyYdvPQlZ/G1WdawhYS5u9yYrDGl
	 OpQ6ZcXXdgftyVBhQz8FcIyjCqfJeWPMBiwdiH3CDt8zTXRl70j9YQBBIaQBt3cwcR
	 gx0sXh/Rga0P2/CAqPPVVs3k2Du83t8NSQS0VJ0l/IIQEpxkpLLJqBemsLCA2LLVgs
	 Lh+BZds9HPaFDB52fH85RmjbWcQaygKJqAqdKyJ1ql+8hjZDuwp5/NRsqbrZNuwIse
	 JXYb1aQihgltQ==
Date: Mon, 21 Sep 2026 03:08:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Zhang, Lixu" <lixu.zhang@intel.com>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Yibo Tan
 <lhfff@tju.edu.cn>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] HID: sensor-hub: synchronize multi-value read
 cancellation
Message-ID: <20260921030820.3ef1a6bd@jic23-hlaptop>
In-Reply-To: <SJ0PR11MB56133EB59F6A661ECE3820D593B82@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260910112338.4171983-1-lhfff@tju.edu.cn>
	<9ae8e6b44ffaf5affb7324f802a3626c581ac461.camel@linux.intel.com>
	<SJ0PR11MB56133EB59F6A661ECE3820D593B82@SJ0PR11MB5613.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 01:16:09 +0000
"Zhang, Lixu" <lixu.zhang@intel.com> wrote:

> >-----Original Message-----
> >From: Zhang, Lixu
> >Sent: Friday, September 11, 2026 1:17 PM
> >To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>; Yibo Tan
> ><lhfff@tju.edu.cn>; Jiri Kosina <jikos@kernel.org>; Jonathan Cameron
> ><jic23@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> >Cc: Shevchenko, Andriy <andriy.shevchenko@intel.com>; linux-
> >input@vger.kernel.org; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> >Subject: RE: [PATCH v1] HID: sensor-hub: synchronize multi-value read
> >cancellation
> >  
> >>-----Original Message-----
> >>From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
> >>Sent: Friday, September 11, 2026 2:29 AM
> >>To: Yibo Tan <lhfff@tju.edu.cn>; Jiri Kosina <jikos@kernel.org>;
> >>Jonathan Cameron <jic23@kernel.org>; Benjamin Tissoires
> >><bentiss@kernel.org>
> >>Cc: Zhang, Lixu <lixu.zhang@intel.com>; Shevchenko, Andriy
> >><andriy.shevchenko@intel.com>; linux-input@vger.kernel.org; linux-
> >>iio@vger.kernel.org; linux-kernel@vger.kernel.org
> >>Subject: Re: [PATCH v1] HID: sensor-hub: synchronize multi-value read
> >>cancellation
> >>
> >>On Thu, 2026-09-10 at 19:23 +0800, Yibo Tan wrote:  
> >>> sensor_hub_input_attr_read_values() publishes a caller-owned buffer
> >>> to the raw-event path. If its interruptible wait times out or is
> >>> interrupted, it clears pending.status without taking data->lock and
> >>> returns.
> >>>  
> >>
> >>Hi Lixu,
> >>
> >>Please give me quick test. Change itself looks good, not sure if we
> >>need something more.  
> >Hi Srinivas,
> >
> >The machine is currently running other tests. Once they are done next week, I
> >will run a quick test on this change and get back to you with feedback.  
> 
> Tested-by: Zhang Lixu <lixu.zhang@intel.com>
> 
> I did some basic validation on a real HID sensor hub / rotation sensor system and did not see a regression from this patch.
> 
Great. Thanks!

Yibo Tan, please can you spin a v2 addressing the other feedback.

thanks,

Jonathan

> Thanks,
> Lixu
> 
> >
> >Thanks,
> >Lixu
> >  
> >>
> >>Thanks,
> >>Srinivas  
> >  
> 

