From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
Date: Mon, 17 Feb 2014 11:16:58 -0800
Message-ID: <20140217191658.GA19223@core.coreip.homeip.net>
References: <1392348001-4950-1-git-send-email-21cnbao@gmail.com>
 <20140214075717.GA14682@core.coreip.homeip.net>
 <CAGsJ_4xqnZAO6vpkgTEHmfp9+nbWa1qwQ4pda6B2sSrEtbV3ZA@mail.gmail.com>
 <847BC5012124A94BB5CA1B26E022CCA3012BAFDC27@SHAASIEXM01.ASIA.ROOT.PRI>
 <CAGsJ_4zjtWV3Z1AJ2bqekXn54rm=k8d4iOi_zzainCEnNGefCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:50252 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbaBQTRG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 14:17:06 -0500
Received: by mail-pb0-f42.google.com with SMTP id jt11so15755045pbb.29
        for <linux-input@vger.kernel.org>; Mon, 17 Feb 2014 11:17:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zjtWV3Z1AJ2bqekXn54rm=k8d4iOi_zzainCEnNGefCw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Xianglong Du <Xianglong.Du@csr.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Barry.Song@csr.com>

On Fri, Feb 14, 2014 at 09:41:06PM +0800, Barry Song wrote:
> >> Input: sirfsoc-onkey - implement open and close methods
> >>
> >> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>
> >> We can control whetehr device generates interrupts or not so let's
> >> implement open and close methods of input device so that we do not do any
> >> processing until there are users.
> >>
> >> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Tested-by: Xianglong Du <Xianglong.Du@csr.com>
> 
> Dmitry, will you push this one to your tree so that i can rebase others?

I rebased and pushed everything out, please take a look to make sure it
all looks good.

Thanks.

-- 
Dmitry
