Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F0333442
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770623970; cv=none; b=MSwZTnUr5KHXCr3oJs8w9U4SnMUE7UY+j6J3Pi/+inGNPb9G2ZKuOiCivymhznF6JIlTCbB6e+GHJdkPZCpqbIrPgrVrKcONWeFCWM7UkjDwGOumZqrvcJnK/i2Zew+hf4zW0r/zflRBAXaOi6bvFQlICMqkPI0FIf6IKZ/Y7l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770623970; c=relaxed/simple;
	bh=G1nim9onrQ/nUeS5cFTr1BlVKvOKJMZ+KulEAtZLZ7Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GSeQVNc6mUWHjiselRzJw9tlIIznufandhWeP4AfB/rbnbDm0S6toxGzPGWIuKXLS53YVwFnewvzV5IU+iRd3zkrOa+Q1aP0m4I7zZEUyI4RlAZsds5ka19BpnycgaUXlEilm8YCUe2aXGfy0xIm5T73fp8oZXxVfDspCuC3hSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7ZIKmTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7ZIKmTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42009C116C6;
	Mon,  9 Feb 2026 07:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770623969;
	bh=G1nim9onrQ/nUeS5cFTr1BlVKvOKJMZ+KulEAtZLZ7Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=N7ZIKmTTOm31gYri10tITDiJtbu0qoN6Kt8d3BOI0FH1VRwX4iRFtS5K4/n/jcrjx
	 9pWnqLjKY1cx3/mCDiBHQKONH3zN0GBHeWek+OtUImRta4YVLArbmxXK1ewE8dDaeZ
	 vn1AnL/9STVL6gMaC+e46SIDVbTLG8GfS5PghUQSVpnMPVYGzXngOuUcMhOnGR24Aj
	 BhOt6NMqn6YCg0WlEVeKTs9JIjvv5j0nPhCYd90rAIdpt4uAyBO0gPFBSkcNCSgvvm
	 Q+2uPg95Vcl+vThfiZW8TTGZJXqI5C3NqPPh2QG9Go9uG7ePHTz746rnUnnx+6xddz
	 cqTOX6Ujtp72A==
Date: Mon, 9 Feb 2026 08:59:27 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Vicki Pfau <vi@endrift.com>
cc: lyude@redhat.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
    Bastien Nocera <hadess@hadess.net>
Subject: Re: [Poke?] Re: [PATCH v2 0/1] HID: switch2: Add preliminary Switch
 2 controller driver
In-Reply-To: <2fb48bd0-55ce-4467-9310-ef914e362a55@endrift.com>
Message-ID: <88or5277-s642-pr37-5917-r194o7015p0s@xreary.bet>
References: <20260109034034.565630-1-vi@endrift.com> <e66735b6e1b0ac4db3dfd2aaddadcc9ff052beb0.camel@redhat.com> <721a51815d1cc21aa22e255ce31598035b687592.camel@redhat.com> <or594565-p59s-784r-494s-82o6qrn9p496@xreary.bet>
 <2fb48bd0-55ce-4467-9310-ef914e362a55@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Feb 2026, Vicki Pfau wrote:

> I was not aware of such a convention. There were plenty of drivers that 
> seem to defy this, like hid-wiimote, so I figured I'd just name it 
> something shorter. 

Yeah, unfortunately we haven't been really super-consistent with this over 
the past years, but I try not to get this completely out of hand.

> I didn't want to fold it directly into hid-nintendo since there's no 
> real opportunity for shared code between the two of them, so it'd just 
> mean (effectively) dead code getting loaded along with the rest of the 
> module if you're only using a Switch 1 controller. That said, 
> hid-playstation doesn't seem to care about this, so I can fold it into 
> hid-nintendo if that's not a concern.

As the amount of code (and even more so the resulting binary) is not 
super-huge, I don't think that's a concern. Most of the drivers for other 
all sorts of devices we have in the kernel are shared by many different 
device variations (think ethernet drivers), and it's ok.

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs

