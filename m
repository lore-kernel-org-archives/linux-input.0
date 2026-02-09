Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08B37B409
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648453; cv=none; b=aDGhFHWVPx9Va4Wa6mGWO1eO97iPJXmLuB5DaYCGRY7Jh5RXBWGSYjkrvXhmEuwfmhr46LByElyLdZ4+vUAfcOdmz4XJ2pD8ngrKBUxiy9xr9G6EOP/cG0irRdJi2AszAGujUDkoqQJ99cDxulINkjJl8gHqNrY5Je1BMMDJuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648453; c=relaxed/simple;
	bh=p38Pt61WWnI/446NW3EDs/FqTgapnD4fxQmalZjM5hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhT5SCaJ8mEPNE+7gkY23vALVTlQKw1BPnsfVlYtr2q4aXqq+rJ3F5jRKQd9/CJke0RJhL4FSp2FyECZs4jrB8e9SW7NMKYk8H55H7XHtlf4k/LjmSEc8vDMn4sMM4wjPcmFeapDU0+T1i1TBnIK7WtPCTyDfSgvc5nsyYnF+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=HcWQTxr4; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="HcWQTxr4"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-896f6d4b6c1so19119066d6.2
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1770648452; x=1771253252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ho//V7xLOKZYyWUOboKGJN9nZXZMUfKAgO5c4WVrjL8=;
        b=HcWQTxr4Fkat5ASfsOohELjnjBlqeasHLEgH0Syc7/l4VZFpO7aRpHL9sw8JxunpsF
         MCwguM4LAnRlZ+VzX3HRcpjVc5o1+8YJ5Us67T6vRvq0cNlANtr3SKD/k3kn8dNSOric
         hEFWyeY9DK1auSt3V0hPCY77kY4shHED9Io+No53mVxHE48t+SoRi/HhBnChao2Tw/GG
         diPUWbftbqdQtkqztQJTo29Mtw1Hv3Vi5i/6+P7611ngI7U1mWMOP0TrITrlBaANzZtN
         lf/ZvHel65UL670TDF2+vuNyKiERcIwHKdoNmmt4Sz9FIUedWT6lAEPdu5lpAMtBS4E1
         ULCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770648452; x=1771253252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ho//V7xLOKZYyWUOboKGJN9nZXZMUfKAgO5c4WVrjL8=;
        b=lPguo5S5O7nYAUg6z0izXsrkq6iNo+Ew38JEvt0wmS9AxSUyZ4LQcW6ft1xlRjjLMz
         9cUywaQfxXdQuDfnZF6jp7N+Uo/MGhyI1z1XUVLkpU4ekMp10G/EsrAQpKKPE4xKNPIB
         uSI88P+FaFrWnwALBxQOjKswj5dHpjNA0lXSFiYqGiZrPMDGTo7YfaKhBnubfI+W9OiB
         TJSbswLDMfcST1HgU0vysYOBQS0hIcg8+tCv2kjAzt9maTfpahGc7Um7sDNqAiow8ZuL
         SVgGEoK/zLTL2iIyH3pDDeIyjd8Geb7VrYmwejoR6DXnOysEsAteh4FQLUeQeh/g25ey
         B2gw==
X-Forwarded-Encrypted: i=1; AJvYcCUBFuCyy1K+1+ygT4Y1HTIIUEpYVwTJrZ5RaMTUGweN0Nqknk+oe2NXlcA4+lrwqo2l94lzFRdoR2mf1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWdFP6mU+Fh1h2JKC4SF5DlwWQnGxU3W/dHMqplGN0+w/7ier
	LXTrOLL9Goo8LYBSaJJ4iUavnxHcG/LZ8qqoqYKRB6FFGJjG5Vix75kuc8sD262pbA==
X-Gm-Gg: AZuq6aLLYeeedjnsjYRrwlP9EeDVg2KrnVG9IBK+LyxR4Y1NNatYOIi3ino+toVG/2D
	0QhhFE+vFkn6RYba7I+gYJTVIRfEJuxzbMw6qvnF4hyrMhqffZlbElFG0ma2s4kP2onoSI6KTJp
	NjrplXSsU6WvnuoGj3H3PKrXLatwT52FbKlxGbe90ikikJM0FztoaiMuNDjcoPDlaQk2uebvGUQ
	hYo/LEaOk0OkeJS8oQHI5G0XdCLRfT7xLkDk5ZT3t7gVPT03V4WCCUYkFH6RI1bwRzqkofG6Bjx
	NmuZaVZ4r94XuJFz9qgv8uXwMGMIVF5NxGrrUDy6oV/0VRJIL6VINXtLQlhN17Y00JeBfMBx//K
	pW/7fdp4SGDBBF251i0vpybT0Sy57qKC7j0jQ2h0Oogt6QVgna0GVYFqiz0fn4zOGt8W4TZt3mx
	uw5b/tHL48mig4+mqpL30D88O34FA3aQ==
X-Received: by 2002:a05:6214:1bce:b0:894:835d:b112 with SMTP id 6a1803df08f44-8953c86c112mr172690676d6.40.1770648452057;
        Mon, 09 Feb 2026 06:47:32 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7be4366sm821652985a.16.2026.02.09.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:47:31 -0800 (PST)
Date: Mon, 9 Feb 2026 09:47:29 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Liam Mitchell <mitchell.liam@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbhid: tolerate intermittent errors
Message-ID: <d1cbfe87-5097-4630-b848-4575ebcf3b09@rowland.harvard.edu>
References: <20260208-usbhid-eproto-v1-1-5872c10d90bb@gmail.com>
 <a31763aa-77af-4e13-8708-b007ed53277c@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a31763aa-77af-4e13-8708-b007ed53277c@suse.com>

On Mon, Feb 09, 2026 at 11:06:03AM +0100, Oliver Neukum wrote:
> On 08.02.26 18:10, Liam Mitchell wrote:
> > Modifies the usbhid error handling logic to better handle intermittent
> > errors like EPROTO, which should only need resubmission of URBs and not
> > full device reset.
> > 
> > Reduces initial retry delay from 13ms to 1ms. The faster the URB is
> > resubmitted, the lower the chance that user events will be missed.
> 
> Hi,
> 
> in this case I have to ask the obvious question: Why wait at all?

Because of the possibility that the error was caused by transient 
interference that might not go away immediately.

> It would seem to me that if you have spurious or intermittent errors
> the right time to retry is immediately.

It depends on the cause of the errors.  In any case, a short delay, such 
as 1 ms, should not make much difference.

Alan Stern
