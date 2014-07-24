From: Borislav Petkov <bp@alien8.de>
Subject: Re: Linux 3.16-rc6
Date: Thu, 24 Jul 2014 14:25:13 +0200
Message-ID: <20140724122513.GM19239@pd.tnic>
References: <CA+55aFzJKxzw_as9iGgeM=MdQ6trUkQLDuoEr8nxj88sOqQnQA@mail.gmail.com>
 <20140723095327.GA23131@pd.tnic>
 <CA+55aFzPs4uF=eR7jCnpyBtgWNRkX-uDfXeo5u34VEvT8_yyzw@mail.gmail.com>
 <20140724064353.GW9918@twins.programming.kicks-ass.net>
 <20140724084126.GB19239@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40947 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756834AbaGXMZR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jul 2014 08:25:17 -0400
Content-Disposition: inline
In-Reply-To: <20140724084126.GB19239@pd.tnic>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Jul 24, 2014 at 10:41:27AM +0200, Borislav Petkov wrote:
> you can easily reproduce by booting a kvm guest with rc6 + tip/master.

Right, so reverting

586fefe5bbdc ("locking/selftest: Support queued rwlock")
e0645a111cb4 ("locking/lockdep: Restrict the use of recursive read_lock() with qrwlock")

from the top of tip/locking/core seems to fix the issue, with the kvm
guests at least.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
