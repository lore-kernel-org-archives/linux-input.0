From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] input: polldev can cause crash in case of polling
	disabled
Date: Fri, 19 Feb 2010 13:15:22 +0100
Message-ID: <20100219121522.GA4107@redhat.com>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com> <20100216175047.GB15376@core.coreip.homeip.net> <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com> <20100216214309.GC15376@core.coreip.homeip.net> <62697B07E9803846BC582181BD6FB6B82661D4AA59@NOK-EUMSG-02.mgdnok.nokia.com> <20100217170315.GB10249@redhat.com> <20100217195044.GC15554@core.coreip.homeip.net> <20100217202339.GA21840@redhat.com> <128C206A-CDA0-47F8-AB9E-3FB90CFD6046@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57585 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab0BSMQO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Feb 2010 07:16:14 -0500
Content-Disposition: inline
In-Reply-To: <128C206A-CDA0-47F8-AB9E-3FB90CFD6046@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 02/17, Dmitry Torokhov wrote:
>
> I understand. I think if we just change cancel to do the right thing
> that should be enough to avoid surprises.

OK. I'll send the patch but let me re-check this code first, I already
forgot some details.

Anyway, I think in the short term the patch from Samu (which changed
input_close_polled_device to re-initialize dwork) is the best option
for now.

Oleg.

