Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A632BEC4E;
	Thu, 20 Aug 2026 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787189601; cv=none; b=rOUYyMBsRZwJ9ZN5hTT/dIHa3IFLAXXxBHUGRmxkF3kYrjmrJ0u1S25REEpxQU/o9BVjTq/SsZYTfBp+9sXwmG6GFkMH2Dkh0Pld1nQkcCWMnKIiKdhPKWgJ37vhfMxy1IFVconZ5cT15gOANDwPvubUTA+VAY5cqRKnoaXT5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787189601; c=relaxed/simple;
	bh=g13Pv4JuVFo6OIfiEShx0uOdZljN7fu1ANxm5ucmvs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9F+6dWLCz313tD6bhWI2qAFUQ02+c0obMD7FNnp9o3iCqvXW/7PhUHSEnOQinLPz0maJ3kVOvMiV0Eqipje9TR1gr12b3fvub4cC/Tz5JluByJAkxmCiM4J5OVINXps50fluAgLtNhLWtKLcXcN8P2k4i5cRWcLFb1jmQAXOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7rq4XAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7rq4XAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878191F000E9;
	Thu, 20 Aug 2026 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787189589;
	bh=sMzDwovQvldXxHOKbiznYPcMxYYp3lo0IVrPbgNNuN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N7rq4XAA09++WypTpLDTMDRyg2JjslntIEKUUwz9X3UN1uTlf4Kb7RQDOg1FeEwe+
	 JNj3jC/UyloK51S5v2Ylxvr0M59bXiVJ0v/IxlOoFKSsLah0DMy55eCjrcByRcWwnI
	 eqQBhivA8CqM2pfrig2ekX0Sj2ugBvznDlS2oPOUArx4SkQlw17cITDfd+pp3nqgR6
	 w1CXyvcMWwr6EFwRcpr4UCpZh2lGVvC7z518sCIRrma4SQ7slSufXeo6RPIkf0k+OI
	 5jjudBe540TqHdCwXzCmmviNwwsSth218F4eRX+LWU9E4K1bQ90Sc3F8R72o1Zxv17
	 PGYHDvTHquANQ==
Date: Thu, 20 Aug 2026 02:33:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: sanjayembeddedse@gmail.com, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Maxwell Doose
 <m32285159@gmail.com>
Subject: Re: [PATCH v3 0/2] HID: iio: warning clean up and prefer kernel
 coding style
Message-ID: <20260820023305.19a9085e@jic23-huawei>
In-Reply-To: <20260712014733.3f5ed10a@jic23-huawei>
References: <20260707-15-jun-hid-iio-alignment-v3-0-8791574ad0fe@gmail.com>
	<akwbOnnEuQ4wA-OE@ashevche-desk.local>
	<20260712014733.3f5ed10a@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 01:47:33 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 7 Jul 2026 00:16:42 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Tue, Jul 07, 2026 at 12:29:42AM +0530, Sanjay Chitroda via B4 Relay wrote:
> >   
> > > This series updates HID sensor IIO drivers to address checkpatch
> > > warnings, improves readability and compliance with kernel coding style.
> > > 
> > > The changes are:
> > >   - replacing explicit NULL comparisons with implicit pointer checks;
> > >   - adjusting indentation and alignment;
> > >   - reformatting multi-line function declarations for improved
> > >     readability and consistency.
> > > 
> > > While updating alignment and line wrapping, function parameters are
> > > grouped more logically and common callback signatures are formatted
> > > consistently across HID sensor IIO drivers.
> > > 
> > > Testing:
> > >   - Compiled with W=1 for each patch in the series    
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >   
> Given the set of fixes working their way upstream for HID, it
> might be a little while before I apply this one.
> 
Seems my tracking went astray.

Long applied.

> Jonathan
> 
> 

