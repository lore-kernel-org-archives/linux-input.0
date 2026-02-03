Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223D3D3497;
	Tue,  3 Feb 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137925; cv=none; b=NS/0QjHHXJzW+MNiGWD/S0KkO7XsVaogyliDodgI4AYaq4SBAcEujPShLNRxa/ryjXAYY4SFW2Y656NPTKUsSmxPa2Hz8+WNDUUPnaFVMiwE3+2y/k1kZ5vJfW2dX23AGttYjWlGIRiiqErNVrYmc/MXZkgqaNLxN90EuNZ71+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137925; c=relaxed/simple;
	bh=AUsFA+Sb2+W06GKLkOjSvEgqjMflS321Gm7pHcuGYUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETdCJ+LRhf002avHDC4cqboxpGmUSqrppRhp5kNe9WdypfSZv8adGe8hornJAEghAV7cPFgnBZXlW+cOSMnpeH3xPalD3WHQN4WwYoylKwxhSmu8O7R4KNdQIDW3CrGaUWx1OeCJJO2gTM95f10j9S+5evg5i2ktBl3/1WrbvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rYl1AoQa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rYl1AoQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C46DC116D0;
	Tue,  3 Feb 2026 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770137925;
	bh=AUsFA+Sb2+W06GKLkOjSvEgqjMflS321Gm7pHcuGYUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYl1AoQaEsSRdwQQRbNPgP+W62Z0FpsKIjvhawQ1ABhBcV3vrcS9ZJrgrm6NSFNIO
	 jdt8V8XWarMXDJtDefbDyWuIHSEkOYGnO0eiPQJHLxexv8vLshrvug7p6ewGWfLFqx
	 kTsOGSp9I91+nQebK3gKPaRnjDM6yFull1cFpxck=
Date: Tue, 3 Feb 2026 17:58:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sebastian Reichel <sre@kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/9] misc: Support Asus Transformer's EC access device
Message-ID: <2026020347-mushy-lunar-d12d@gregkh>
References: <20260201104343.79231-1-clamor95@gmail.com>
 <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh>
 <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
 <2026020346-ashamed-campfire-b483@gregkh>
 <CAPVz0n2HmLwdif5ry+y56LB8Gpwh2o9_gJ7K2jhcZVR=rPgfPA@mail.gmail.com>
 <2026020314-humbling-mobility-c24a@gregkh>
 <CAPVz0n0TMOCYnMiVUZ7xx-1SqrXuaVCOY-o4-x9L=f-xSMDj8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPVz0n0TMOCYnMiVUZ7xx-1SqrXuaVCOY-o4-x9L=f-xSMDj8g@mail.gmail.com>

On Tue, Feb 03, 2026 at 06:50:01PM +0200, Svyatoslav Ryhel wrote:
> > debugfs allows you to do much much more than simple stuff like
> > BIN_ATTR_RW().  Go wild there, but don't put debugging stuff in sysfs,
> > that is NOT what it is there for at all, but rather, that is exactly
> > what debugfs is for.
> >
> 
> I am removing said stuff from sysfs, that is not what I am asking.
> Debugs does not allow to upload register values in a form of binary
> block. It allows only dumping via debugfs_create_blob or
> debugfs_create_regset32 but not writing. If you know examples of
> reading and writing register sets as binary data, please point me to
> it.

You can easily write your own given that debugfs allows you to use what
ever file operations you want to use for a file.  Why not just use that?

> I am asking if it is possible only to preserve dockram_read/write
> functions in the code, without exposing it to sysfs.

Why would you want to do that?

confused,

greg k-h
