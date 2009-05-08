From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ff-memless: fix signed to unsigned bit overflow
	in?ml_combile_effects()
Date: Thu, 7 May 2009 19:10:45 -0700
Message-ID: <20090508021045.GA30616@dtor-d630.eng.vmware.com>
References: <20090507193206.9342.15843.stgit@fate.lan> <4A03748E.3060709@gmail.com>
Mime-Version: 1.0
Content-Type: text/Plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:62536 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753AbZEHCKv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 22:10:51 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1038614wfd.4
        for <linux-input@vger.kernel.org>; Thu, 07 May 2009 19:10:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A03748E.3060709@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>

On Thursday 07 May 2009 16:53:50 Anssi Hannula wrote:
> Jussi Kivilinna wrote:
> > When userspace sets effect->u.rumble.strong_magnitude to 0x8001 or
> > larger, ml_combine_effects() would always return strong_magnitude 0xffff.
> >
> > Problem is that 'gain' is passed in as signed integer. Multiplying
> > magnitude (__u16) with gain (int) causes magnitude read as signed and
> > results negative value (with magnitude > 0x8000). This signed integer is
> > then divided and value, still negative, converted to 32bit unsigned
> > integer. Finally checking combine overflow min(new+old, 0xffff) gives out
> > 0xffff.
> >
> > Fix is to simply change 'gain' to unsigned int.
> >
> > Signed-off-by: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
>
> Acked-by: Anssi Hannula <anssi.hannula@gmail.com>
>

Applied, thank you.

-- 
Dmitry
