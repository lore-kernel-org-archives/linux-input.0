Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565129E114;
	Wed, 18 Feb 2026 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444384; cv=none; b=EwoIHR5LFO6QGLrG7tMH0rHMMQgokuDOc+95Rgbd3p8v+maoN07ZchscdPZvJ6ADKfDRY+yUyNRuXjsStSXzVVcZYoK/UI5DpkHc6S5G+9RViPoW1NRJwfdf5hKGL7UNKrSQaiqhlDmkrxjVHHivmb7RGEY33yPJc/JXgf9RaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444384; c=relaxed/simple;
	bh=VjQOCxm6RRNecju6wHp8/OQCoOUvyK9kcXgtsmWR2V8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj2cljHHfr7vLBehy/86wa0tOR+bgssRy84wtBjNlKc/dWlXKEFL13afLLoJQ9gzk92OEHazNbWWvs4TMKvwdqNQXRpv7Bvqlx2r66+AD6GLP1AwtD6aDEUl/IvAWEeegx+HU/LtG07//e/fMoS4TptRruPJKboqsz1wFtBwUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMZGDIsl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMZGDIsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72480C2BCB3;
	Wed, 18 Feb 2026 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771444383;
	bh=VjQOCxm6RRNecju6wHp8/OQCoOUvyK9kcXgtsmWR2V8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hMZGDIslnsaxz12RjfURiuqS+5Nrfx/5O0XiKI9nHdvUC5D1W9WOc1nQJsXOAZkiJ
	 vpyOgv2OfJRwLkMRJK/Tu+CRkUl69fyhkRplZTERnA3UMsvTa2jsVVCSWT3Lser74B
	 OjuR8MZTTf2/gAvBArgNyBhpXgY4mF2FGR81UT1stP2tc3RwVHsRJsHctPKy0dZgyD
	 6s/cY0zdJq4LzeyJ6U0kiQY0is54Czhfdl9tMnPXve6n7XEr3KzAnewrC0jEUOThvt
	 kHOizWCyOfoJYjaC9xMjIkm+3DRbwJkk+zZTMWx1SFXIdJnXJHQeT+J3WsAXU1vpig
	 2XPyqmLUVDXrg==
Date: Wed, 18 Feb 2026 19:52:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, Lixu Zhang
 <lixu.zhang@intel.com>
Subject: Re: [PATCH 0/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
Message-ID: <20260218195254.1ec9d3de@jic23-huawei>
In-Reply-To: <aZQijRLVjzuWcU2W@smile.fi.intel.com>
References: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
	<aZLKy4l6OlPgIkZx@smile.fi.intel.com>
	<bcfc711c-a02a-4470-a2a6-de43c71e7c2e@baylibre.com>
	<aZQijRLVjzuWcU2W@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 10:10:53 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Feb 16, 2026 at 09:25:58AM -0600, David Lechner wrote:
> > On 2/16/26 1:44 AM, Andy Shevchenko wrote:  
> > > On Sat, Feb 14, 2026 at 03:00:19PM -0600, David Lechner wrote:  
> > >> The main point of this series is to fix a regression reported in
> > >> hid-sensor-rotation where the alignment of the quaternion field in the
> > >> data was inadvertently changed from 16 bytes to 8 bytes. This is an
> > >> unusually case (one of only 2 in the kernel) where the .repeat field of
> > >> struct iio_scan_type is used and we have such a requirement. (The other
> > >> case uses u16 instead of u32, so it wasn't affected.)
> > >>
> > >> To make the reason for the alignment more explicit to future readers,
> > >> we introduce a new macro, IIO_DECLARE_REPEATED_ELEMENT, to declare the
> > >> array with proper allignment. This is meant to follow the pattern of
> > >> the similar IIO_DECLARE_BUFFER_WITH_TS() macro.  
> > > 
> > > In both cases it's quaternion, maybe be more explicit and define
> > > IIO_DECLARE_QUATERNION() ?  

I like this.  It's special and this shouts that nicely.

> > 
> > It is really the fact that the scan_type has .repeat > 1 that requires
> > this, so I was trying to make a name that shows that link.
> > 
> > But right now, quaternion is the only thing that has .repeat > 1, so
> > I guess it would be OK either way. We'll see if Jonathan has an
> > opinion on the naming.  
> 
> I think we should solve the problems when they appear. Naming explicitly
> for quaternion makes it easier to get from the core reading without having
> a variable name to repeat that. Magic 4  might not always be a quaternion.
> 
> Do we have "repeat" to be used in other cases, btw?
> 
Don't think so.

Note there is a second older bug here.
The timestamp is landing at the wrong location :(  See discussion of
original bug.  I suspect that applies to the bno055 as well (that avoids
the bug we are fixing in this patch because helpfully the quaternion is
a total of 8 bytes. 

Short story - it is just another channel, so should be naturally aligned
at first valid location after the previous channel. That's bytes 32-39 not
55-63 which is where iio_push_to_buffers_with_timestamp() puts it.


Jonathan


