From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 6/7] IR: extend ir_raw_event and do refactoring
Date: Fri, 3 Sep 2010 00:32:56 +0200
Message-ID: <20100902223256.GA2492@hardeman.nu>
References: <1283158348-7429-1-git-send-email-maximlevitsky@gmail.com>
 <1283158348-7429-7-git-send-email-maximlevitsky@gmail.com>
 <20100902205607.GB3886@hardeman.nu>
 <1283462454.3306.15.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:60610 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab0IBWdB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 18:33:01 -0400
Content-Disposition: inline
In-Reply-To: <1283462454.3306.15.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>, Christoph Bartelmus <lirc@bartelmus.de>

On Fri, Sep 03, 2010 at 12:20:54AM +0300, Maxim Levitsky wrote:
> Also in the future I think I should make the
> ir_raw_event_store_with_filter the default submit function for all
> drivers, and then I could drop that silly '_with_filter" thing
> (Couldn't think for a better name for this function...)

I agree. Perhaps it would even be possible to merge=20
ir_raw_event_store_with_filter and ir_raw_event_store. The automatic=20
merger of consecutive pulse-pulse events or space-space events should=20
help simplify some drivers...

> > Wouldn't DEFINE_RAW_EVENT(ev); be more in line with the kernel=20
> > coding style? (cf. DEFINE_MUTEX, DEFINE_SPINLOCK, etc).
> Of course, nothing against that.

DEFINE_RC_RAW_EVENT() is probably better by the way...

--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
