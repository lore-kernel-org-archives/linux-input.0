From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] wistron_btns DMI info to recognize Maxdata Pro
	7000 notebooks
Date: Sun, 12 Jul 2009 21:03:47 -0700
Message-ID: <20090713040347.GG10819@dtor-d630.eng.vmware.com>
References: <4A50E086.5090206@iragan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:2590 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbZGMEDw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 00:03:52 -0400
Content-Disposition: inline
In-Reply-To: <4A50E086.5090206@iragan.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Giuseppe <g.mazzotta@iragan.com>
Cc: mitr@volny.cz, stable@kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Jul 05, 2009 at 07:19:02PM +0200, Giuseppe wrote:
> This patch adds DMI recognition information to automatically load the  
> correct layout for the Maxdata Pro 7000X/DX notebook models. Such  
> notebooks are clones of Fujitsu Amilo V2000, the hook for the v2000 is  
> being used and I have tested that perfectly works.
>
> The immediate result of integrating this patch is that the five special  
> buttons will work on these specific notebook models and that the RF  
> killswitch will not be activated after suspend. This patch definitively  
> obsoletes the fsam7400 module which I was still needing to enable wifi  
> and to fix the RF killswitch suspend problem; in the current 2.6.30  
> kernel it is necessary to load the wistron_btns module with options  
> 'force=1 keymap=1557/MS2141', which was not anyway a complete workaround.
>
> Signed-off-by: Giuseppe Mazzotta <g.mazzotta@iragan.com>
>

Applied, thank you Giuseppe. BTW, your mailer converts tabs to spaces
and line-wraps the mails, you might want to look into fixing that,

Thanks!

-- 
Dmitry
