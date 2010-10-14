From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [1/8] IR: plug races in IR raw thread.
Date: Thu, 14 Oct 2010 15:29:37 -0400
Message-ID: <20101014192937.GA4224@redhat.com>
References: <1283808373-27876-2-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1283808373-27876-2-git-send-email-maximlevitsky@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>, mchehab@infradead.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Sep 06, 2010 at 09:26:06PM -0000, Maxim Levitsky wrote:
> Unfortunelly (my fault) the kernel thread that now handles IR processing
> has classical races in regard to wakeup and stop.
> This patch hopefully closes them all.
> Tested with module reload running in a loop, while receiver is blasted
> with IR data for 10 minutes.
> 
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>

Carrying over ack from earlier(?) version of the patch:

Took a while to unwind everything in ir_raw_event_thread() in my head,
but now that I think I have it sorted out, yeah, that looks like the
processing logic all remains the same, with the addition of locking
that should prevent the race (also heavily supported by your testing).

Acked-by: Jarod Wilson <jarod@redhat.com>

-- 
Jarod Wilson
jarod@redhat.com
