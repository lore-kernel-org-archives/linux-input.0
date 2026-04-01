Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753933F36D;
	Wed,  1 Apr 2026 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028213; cv=none; b=q69es3RnhFXSG1nyRSI2lQXKOrkl/FO25nGTOPwaz+lbCGo4bldUVCrBQ1RPbmCBGvBTDM3Tx9XBzJxHU5r/i3qcj8DUhWhOqLc5vmnGkC1FpiLyptrMcophOFh215/irJpOgcqVrvH2OeNNrnc+eH+8rLXk0QU4e5xbvvhkUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028213; c=relaxed/simple;
	bh=sTTxU0r5oAfkXSFho3yKIsWmWia6/oV2ArumN8jjoQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYqc3DsJ6q+z6ACxEUDvsZQE0fmNVH2lBQVUlU9dNGXTqzBME3PV3+9otJlthgO0Jkjr7EQBhejzep4ShP1jUDv4dwj8hnlo9+V6Luwws8jICRqNEJqwdRwMZNjEXKMsFF3wGdtge8jlPlL8Fy4Xk4u4c4QDw6xIqT6/HuPdFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQaqqDkL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQaqqDkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D364C4CEF7;
	Wed,  1 Apr 2026 07:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775028213;
	bh=sTTxU0r5oAfkXSFho3yKIsWmWia6/oV2ArumN8jjoQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQaqqDkLFw1B5CH6vsmkNCuJrLrNRVx3hEDSt2okJ5KtmFZd9pXHubtaYc3/8WQWS
	 s7pdAHy01k31rVYk8Cg/ckxl2B/PSan7IXuvqOOhzD+IP44nromIkGYsZRWc3UZGw8
	 0/ykBjMAkCj3GBqd8CX0CDrybJAt2GXFA9zIhscw/hrztE4ADZAfHypXnpZOEW7Fpw
	 MoMbUEPZbkaJXuyY6f5BJybX0VCaw0+KNdj38wdCYQmX2tNzTiHIkdFJhADuEABkxr
	 2msDei8qeQ83oibIXFe9Szoa3dA5RxTVO5pW8hooFfanCtjLOyEcdn2sBMp+1ES+vX
	 dvs3nkW0/6mFQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w7pvG-000000095m5-3YKa;
	Wed, 01 Apr 2026 09:23:30 +0200
Date: Wed, 1 Apr 2026 09:23:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Input: refactor USB endpoint lookups
Message-ID: <aczH8sLWWYkn9JOr@hovoldconsulting.com>
References: <20260330095948.1663141-1-johan@kernel.org>
 <acsNayeGbU6cRw3P@google.com>
 <acwskOMBhv9yWkD7@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acwskOMBhv9yWkD7@google.com>

On Tue, Mar 31, 2026 at 01:21:05PM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 30, 2026 at 04:55:35PM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 30, 2026 at 11:59:44AM +0200, Johan Hovold wrote:
> > > Use the common USB helpers for looking up bulk and interrupt endpoints
> > > instead of open coding.
> > 
> > Applied the lot, thank you.
> 
> Actually, dropped patch #4:
> 
> https://sashiko.dev/#/patchset/20260330095948.1663141-1-johan%40kernel.org

Thanks, I saw this one last night as well (after reading the LWN
article). 

I'll send a v2.

Johan
