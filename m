Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C057184540
	for <linux-input@vger.kernel.org>; Tue,  8 Jul 2025 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962556; cv=none; b=gH50KjdQ9YzVp2GZCb4aT/EItUznEJ9auVZIROJ9Ac03tBsgTqgS2SR2VuIxAdap267BMKWqDJYi+NOYA4t1nmB5RMpxoo5E60Xzb4GcozqSmqLgla44FLVw6/8YK/KBt995dWImP3V8jMVXhBjdFDcSvaTjpf/u570DQk1Z63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962556; c=relaxed/simple;
	bh=2mQg7U9a4UX+aN5nea6lh1dtv/beTgXS7/Si+gU6lD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFkAgNH4vKL1gVkPuUgn9mY+rH/RIO5kzxT1VOxE8PdCQsU+v2ImnUXyoO5YfL7SlIurbTia9ZGXcwWEXdYyuOUTp7UAkrCeGZ31QCBx8TPHZhFEblMvgXu6JumA4IEnPdGFnZ0b+z30fMJBdiAi8mnrrdV0CDRdLMDBHpfqL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AXvLpLKA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AXvLpLKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295ECC4CEF0;
	Tue,  8 Jul 2025 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751962555;
	bh=2mQg7U9a4UX+aN5nea6lh1dtv/beTgXS7/Si+gU6lD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXvLpLKAiDu3eM04SAid/DB+VaX+E7eXuoYYMp2IdpDdorz3Tc+x4xsei/p4ORoyA
	 iRD3DnOX+urXJtOHtPdh9aipWmjP7aHiOGZ+JDYvDL8yyUDgDDXVH7TCkTbZur4NvQ
	 69W7+I1jeW0SyFsLqDsaJgf2RQe7b7ccwMGD9Me8=
Date: Tue, 8 Jul 2025 10:15:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nilton Perim Neto <niltonperimneto@gmail.com>
Cc: vi@endrift.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH] Changed Acer NGR200 to XTYPE_XBOX360 fixed the table
 because
Message-ID: <2025070840-marauding-popular-517f@gregkh>
References: <92a568ca-e08f-423a-9de0-3f5b2946e721@endrift.com>
 <20250708033126.26216-2-niltonperimneto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708033126.26216-2-niltonperimneto@gmail.com>

On Tue, Jul 08, 2025 at 12:31:27AM -0300, Nilton Perim Neto wrote:
> You're correct Vicki
> I wrote the wrong xtype in the device tree,
> But now it is fine.

Very odd changelog text :(

