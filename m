Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163B37C11B
	for <linux-input@vger.kernel.org>; Mon,  2 Feb 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048575; cv=none; b=uwF5MKGRyR9Jv5DX+K0S+qbxeHmAWtO1cBV+AFWTJauyX438komvbd/b3Tnja5USCSvA+VHJUr+NGvIJhzXt5rs9og1KwOT81X0aGoyEPaeqEqZewFHsFh5pAcrCpfvSVhWUZWVDRWKIcNG5ylbMM44LcjKjr8G8iQmFCwnF76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048575; c=relaxed/simple;
	bh=HAu4DKcmCn9jRLj+0mwc8/nFGBytGpJStHcpa6gpDB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4dApKe3ULbCZ83EOyuVpyKESnaSOHdc4NWLfYwx3i53l13ny2sRLgV34BOIGyuiDDc6NHJFPcREzoSjavXxkmLjhVMAAxOlqGKHhoaggR7mNeah63YhrxLZz/TaWlQD53XkEKDiNofVXUuCZ+SCcnCnMwZCXUljiuXzK3uR1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=T/aF7pW4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="T/aF7pW4"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5029aa94f28so41854751cf.1
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 08:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1770048572; x=1770653372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+NROkACJhEmkOXCU3jerkpj3wRhMMHpRt2F5TFK3GA=;
        b=T/aF7pW4sCXpmiC+JSZEj181I01WGd9DdwvMa/biourGoJwoxYiTejaAe0PrAE0crc
         DKkkwS8IHycF1FqUp9ucbeTe7lMPTVOy0Q2AqmJN8ZCqxrgxFVvErhAmRKJzYDpkaTS8
         /eepTS8JJVYx48oKrjG1w5vvjs9kH35RhEqFbD6F2OFfyrwSr5K+w0ts4S8ukLuQ1Q4n
         DU0iNtp8gjMHnlcuBhVkL3IdyrfPRy0EMp+cbVI47Wx60foddVISLXJwJ5bhMD/sa166
         xG/UWzFawsQ6qosapkTYWb2ta992J+V8ADuCpJBlVgCJdfpi7z9guiGWeUsAjyfYb94A
         O4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770048572; x=1770653372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+NROkACJhEmkOXCU3jerkpj3wRhMMHpRt2F5TFK3GA=;
        b=DPGvqGNPoTqe9qxl6Mp+JMEQavEzeL3/+M6FdfnQSBXRVtaIsO8O7V8Nx8+/xPU9FI
         3IGuU7Lsazuwlkf8dDl5xcdZJqDAlJw8OMZA6oJwpJX6cAOVVrlsUaQCqwXsQDkud2ZZ
         UAn7+LWnHlnM0BFgNlmAin6Qh8m495KjnWl+X4o2v+TYsfJeI0x71etmdxNcrR78X+M4
         wccI+ZLXT3BTJ+VgPbwvlUtx0JReequS2EJv13zg9rQYkfE4OXFTBdvV2Ufr7q36TDXo
         qLVcpA0foWotZE0CaSYNV77aIeR3W3nuPKcLLvaX1dReyII+eu5jioTzZOoMvYk8CHmU
         EkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8aR2iGJHOAjieHeb7/3cDg6PmHySnvSSgoX0XAXISJlI1LgKzBjKBXTxgzVb+a1RvIVwFdS7RAGPuBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVFwvxI/Z8k2sgiPKcP6Pi1w0F/IcRTQVotbNjZ6/ptmzaoi/
	i4AwBxbMK8CSJ6fetFTcKIOPf6CaMnLdfvWfTolCZ1CMoWxarQoLbve3w6Qay/gbBw==
X-Gm-Gg: AZuq6aJtFBfKPYuqWlGDTZyiMZdNrmmWGYsXsNt+F9gxIK4mb2nV5ed+wpdEke/cCB2
	IajPyUQqMZ/3scxXplRcYpS4KAZJkq6UI1Gt0d34nvwM/KS8IOczOKJsjyWlfvwMAVf0VqFYC8x
	Z6aio2a6v0A3VFYbFELi3NPfzrJpfJC0WKLltem+U/JbkW7oAELv1ONC9H0D9D22N9ahts36wSk
	dFiuiM+IVnFUzykFyR0qDI2/CxiailSTEcS4vY2Q9ivcFr9D+4WK/ZCUGwqU11D3P9MGqn9mMPM
	cbyB3x9/uj2toNg8DD2tDKv7QR0L8mLZvZGrszfFgvgCb5IsPRLUPKDt4yP4ULORsiHUf4i/IeA
	vizaTFclU/UMSjX03OtEssGDw9rl/q8UgnKAmIl0Mzqy8l/9qkWytVOpdxQLH50KfwwNyaIDZoP
	sXjo7hKR//46fG
X-Received: by 2002:a05:622a:14cb:b0:501:40b2:453d with SMTP id d75a77b69052e-505d296ba35mr134758821cf.23.1770048572253;
        Mon, 02 Feb 2026 08:09:32 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::7a0a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bbb66dsm107921011cf.29.2026.02.02.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:09:31 -0800 (PST)
Date: Mon, 2 Feb 2026 11:09:28 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Liam Mitchell <mitchell.liam@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: usbhid: Intermittent EPROTO errors trigger USB reset and
 interrupt user input
Message-ID: <43c9b46c-344a-434e-8581-c6374a6e8430@rowland.harvard.edu>
References: <CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com>
 <1ebf9d19-7293-4902-857b-164fd4d21f25@rowland.harvard.edu>
 <1c317994-2932-4e2e-8e80-1c90606e63c9@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c317994-2932-4e2e-8e80-1c90606e63c9@suse.com>

On Mon, Feb 02, 2026 at 04:48:49PM +0100, Oliver Neukum wrote:
> 
> 
> On 01.02.26 21:40, Alan Stern wrote:
> > On Sun, Feb 01, 2026 at 06:57:06PM +0100, Liam Mitchell wrote:
> > > Hi,
> > > 
> > > I'm trying to understand and fix intermittent keyboard/trackpad issues
> > > on my 2013 MacBook Pro running Linux v6.18.4:
> > > - missed/repeated/sticky keys while typing (this thread)
> 
> Alan,
> 
> this raises a question. What happens to KEY_UP events generated in
> between the last EPROTO and the reset? It seems to me like we need
> to assume that a reset implies that all keys have been released.

That question is specialized to keyboards.  You could ask a similar 
question about mouse buttons, or other input (or output!) devices.

But it's a good point.  There should be some sort of callback to inform 
HID drivers that their device has been reset, so they could reset 
whatever internal state they are maintaining.

This sounds like something going way beyond usbhid, though.  And it 
probably would not crop up very often, so it wouldn't get much testing.  
Liam's computer seems to be pretty unusual.

Alan Stern
