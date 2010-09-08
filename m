From: Jarod Wilson <jarod@wilsonet.com>
Subject: Re: [PATCH 4/8] IR: fix keys beeing stuck down forever.
Date: Wed, 8 Sep 2010 10:47:09 -0400
Message-ID: <AANLkTikoT0MEQFBAPcZtVccbMa5106wipxdhmzVoacyZ@mail.gmail.com>
References: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com>
	<1283808373-27876-5-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1283808373-27876-5-git-send-email-maximlevitsky@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: lirc-list@lists.sourceforge.net, =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>, mchehab@infradead.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Sep 6, 2010 at 5:26 PM, Maxim Levitsky <maximlevitsky@gmail.com=
> wrote:
> The logic in ir_timer_keyup was inverted.
>
> In case that values aren't equal,
> the meaning of the time_is_after_eq_jiffies(ir->keyup_jiffies) is tha=
t
> ir->keyup_jiffies is after the the jiffies or equally that
> that jiffies are before the the ir->keyup_jiffies which is
> exactly the situation we want to avoid (that the timeout is in the fu=
ture)
> Confusing Eh?

Yeah, seen time_is_{before,after}_jiffies use accidentally inverted a
couple of times... Kinda hints that we could use better names and/or
descriptions of the functions, but maybe people just need to read more
carefully (dunno, haven't looked to see what's there for usage
descriptions already)... Anyway.

> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> ---
> =A0drivers/media/IR/ir-keytable.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Jarod Wilson <jarod@redhat.com>

--=20
Jarod Wilson
jarod@wilsonet.com
