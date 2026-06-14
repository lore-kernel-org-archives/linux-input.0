Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2D3043C8;
	Sun, 14 Jun 2026 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781461492; cv=none; b=Va9mwz8uAvEeg9d2XZ/c7scBnOmvMYMu6G0mJAVat/YdsN2vhZPw1cf0bHVX1I5QaXegWQFPGK2c2wLTHq2lmEbNYtZ0PnMiaGyf8nNxMs1YxDzA5CnUr5dtS7Dkbw/JT90wVUgJc5N5YO/8WemsxbA5ZTf/vvbPgdE+NLqT8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781461492; c=relaxed/simple;
	bh=LaVC8EWdQMbzvPr409OsIuajM1urxotlCKA+hJqv/0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZnh5Dgk3oeBPD1DGUkSaLF++0h0wSFDSOccqtrJ7RW+Phr0AZnNbpjrpLiQg0W5BBVFtgDMcyHFN7HCTa1sdnDj6eXEJarbztHHTZGhq+I5zO8LeN/y0/eljQcp9LNKRYJnmBPi+tA5W3FgoJjy9SVoAqjOt1zeBpV/Tx3Fmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdDZo7iZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdDZo7iZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA241F000E9;
	Sun, 14 Jun 2026 18:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781461491;
	bh=ryQU/PtG2uuHwpiHqji7sZh3i3jOaJ94HLQzN0BZrA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BdDZo7iZ8dEVFQcorLUitx8eFkFK8+I7GmcXXndlf6MK8a726lGk/DboXw8rye+fU
	 Gqx2uvfAkSs+ZlBmuePMPkSR9qotltjKo02GDpvl+FjfQiAvw9ZYozcl/lyRHtHgxE
	 sQlCyuSxRdO7B/74w8z6jBOrWu41SSw3JvKwx6WHEAb7SJDi2fU1BwfKxVmtKmfvXr
	 YMe3oCIyfJHeyRpAZ/5VQEnNv2zjDMElo9cShAUj7Mozn+sVX0Ww2/5a3mi6gli2km
	 uorpNpi34FCdVGUjQvYXyB62Kd8lpJkRcJC0V+MA1KII047OoinoQSCKgc3h0A7w3U
	 y5FICxWIsr0aw==
Date: Sun, 14 Jun 2026 19:24:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "dlechner@baylibre.com" <dlechner@baylibre.com>,
 "archana.patni@linux.intel.com" <archana.patni@linux.intel.com>,
 "hongyan.song@intel.com" <hongyan.song@intel.com>, "nuno.sa@analog.com"
 <nuno.sa@analog.com>, "jikos@kernel.org" <jikos@kernel.org>,
 "andy@kernel.org" <andy@kernel.org>, "sanjayembeddedse@gmail.com"
 <sanjayembeddedse@gmail.com>, "linux-input@vger.kernel.org"
 <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/9] iio: orientation: hid-sensor-incl-3d: Fix race
 between callback registration and device exposure
Message-ID: <20260614192442.6eaa1a54@jic23-huawei>
In-Reply-To: <b3c449ee646fc3bff89dbbdfaf04f731fea87b2b.camel@intel.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
	<20260606-5-june-hid-iio-race-fixes-v1-2-27a848c5758f@gmail.com>
	<b3c449ee646fc3bff89dbbdfaf04f731fea87b2b.camel@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 15:34:05 +0000
"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> wrote:

> On Sat, 2026-06-06 at 17:07 +0530, Sanjay Chitroda wrote:
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > 
> > The driver registers the IIO device before completing sensor hub
> > callback registration and unregisters callbacks while the IIO device
> > is still exposed during teardown.
> > 
> > This creates race windows in both probe and remove paths, which can
> > lead to NULL pointer dereferences or use-after-free.  
> 
> Reordering is fine, but can you show how this use after free is
> possible?
Agreed - I'm not seeing a definite issue so more info needed.
For now I'm going to mark this changes-requested in patchwork.

It might be a touch slow if someone manages to get buffered capture
up before the callbacks are available, but I think that just means
dropping a few samples?

Jonathan

> 
> Thanks,
> Srinivas


