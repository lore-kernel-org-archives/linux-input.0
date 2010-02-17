From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] input: polldev can cause crash in case of polling
	disabled
Date: Wed, 17 Feb 2010 21:23:39 +0100
Message-ID: <20100217202339.GA21840@redhat.com>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com> <20100216175047.GB15376@core.coreip.homeip.net> <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com> <20100216214309.GC15376@core.coreip.homeip.net> <62697B07E9803846BC582181BD6FB6B82661D4AA59@NOK-EUMSG-02.mgdnok.nokia.com> <20100217170315.GB10249@redhat.com> <20100217195044.GC15554@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58642 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755019Ab0BQUY3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 15:24:29 -0500
Content-Disposition: inline
In-Reply-To: <20100217195044.GC15554@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: samu.p.onkalo@nokia.com, linux-input@vger.kernel.org

On 02/17, Dmitry Torokhov wrote:
>
> It apppears that it is allowed to try to cancel work that has never been
> queued

Yes,

> and I believe that canceled or completed work should be exactly
> the same as never been queued work (which is apparently not the case
> currently).

And yes, currently this is not the case.

As I said, I agree that cancel() could clear ->data. Will this change
help? (in any case this change is not for 2.6.33)

But I don't see how "completed" can do this, please see my previous
email. Note that flush() can't do this too.

> Yes, it is certainly possible to work around the issue in every driver
> that may happen to shut down and re-create workqueue as needed. The
> question is whether it is the right thing to do.

I'd say, the question is whether we can improve this ;) Well, see above.

Oleg.

