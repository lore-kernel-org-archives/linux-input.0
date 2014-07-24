From: Borislav Petkov <bp@alien8.de>
Subject: Re: Linux 3.16-rc6
Date: Thu, 24 Jul 2014 18:34:03 +0200
Message-ID: <20140724163403.GP19239@pd.tnic>
References: <CA+55aFzJKxzw_as9iGgeM=MdQ6trUkQLDuoEr8nxj88sOqQnQA@mail.gmail.com>
 <20140723095327.GA23131@pd.tnic>
 <CA+55aFzPs4uF=eR7jCnpyBtgWNRkX-uDfXeo5u34VEvT8_yyzw@mail.gmail.com>
 <20140724064353.GW9918@twins.programming.kicks-ass.net>
 <20140724084126.GB19239@pd.tnic>
 <20140724122513.GM19239@pd.tnic>
 <20140724125814.GX6758@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140724125814.GX6758@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <Waiman.Long@hp.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 24, 2014 at 02:58:14PM +0200, Peter Zijlstra wrote:
> Of course we should have made the lockdep change before merging qrwlock,
> and that's entirely my fail, but with qrwlock in these new semantics are
> already a reality.
> 
> We could of course disable qrwlock until all such issues are cleared up
> (its the safe option)...

So we leave in the lockdep change and disable qrwlock ontop of
tip/locking/core. Nothing's hurt yet as this whole pile is queued for
3.17 anyway.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
