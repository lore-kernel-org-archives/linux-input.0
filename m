From: Jarod Wilson <jarod@wilsonet.com>
Subject: Re: [PATCH 7/8] IR: extend ir_raw_event and do refactoring
Date: Wed, 8 Sep 2010 11:26:48 -0400
Message-ID: <AANLkTinr6mN=t=vNnR3pSBxXb0ud=Ymrqn_WyDNkUJTz@mail.gmail.com>
References: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com>
	<1283808373-27876-8-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36278 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab0IHP0u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 11:26:50 -0400
In-Reply-To: <1283808373-27876-8-git-send-email-maximlevitsky@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: lirc-list@lists.sourceforge.net, =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>, mchehab@infradead.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Mon, Sep 6, 2010 at 5:26 PM, Maxim Levitsky <maximlevitsky@gmail.com=
> wrote:
> Add new event types for timeout & carrier report
> Move timeout handling from ir_raw_event_store_with_filter to
> ir-lirc-codec, where it is really needed.
> Now lirc bridge ensures proper gap handling.
> Extend lirc bridge for carrier & timeout reports
>
> Note: all new ir_raw_event variables now should be initialized
> like that: DEFINE_IR_RAW_EVENT(ev);
>
> To clean an existing event, use init_ir_raw_event(&ev);
>
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> ---
> =A0drivers/media/IR/ene_ir.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 +-
> =A0drivers/media/IR/ir-core-priv.h =A0 =A0| =A0 13 ++++++-
> =A0drivers/media/IR/ir-jvc-decoder.c =A0| =A0 =A05 +-
> =A0drivers/media/IR/ir-lirc-codec.c =A0 | =A0 78 ++++++++++++++++++++=
+++++++++++-----
> =A0drivers/media/IR/ir-nec-decoder.c =A0| =A0 =A05 +-
> =A0drivers/media/IR/ir-raw-event.c =A0 =A0| =A0 45 +++++++-----------=
--
> =A0drivers/media/IR/ir-rc5-decoder.c =A0| =A0 =A05 +-
> =A0drivers/media/IR/ir-rc6-decoder.c =A0| =A0 =A05 +-
> =A0drivers/media/IR/ir-sony-decoder.c | =A0 =A05 +-
> =A0drivers/media/IR/mceusb.c =A0 =A0 =A0 =A0 =A0| =A0 =A03 +-
> =A0drivers/media/IR/streamzap.c =A0 =A0 =A0 | =A0 =A08 ++-
> =A0include/media/ir-core.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 40 ++++++++++=
++++++---
> =A012 files changed, 153 insertions(+), 63 deletions(-)
=2E..
> @@ -162,22 +164,48 @@ u32 ir_g_keycode_from_table(struct input_dev *i=
nput_dev, u32 scancode);
> =A0/* From ir-raw-event.c */
>
> =A0struct ir_raw_event {
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
pulse:1;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
duration:31;
> + =A0 =A0 =A0 union {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 duration;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 =A0 =A0 carrier;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 =A0 =A0 =A0duty_cycl=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pulse:1;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reset:1;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout:1;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0carrier_report:=
1;
> =A0};

I'm generally good with this entire patch, but the union usage looks a
bit odd, as the members aren't of the same size, which is generally
what I've come to expect looking at other code. I'd be inclined to
simply move duty_cycle out of the union and leave just duration and
carrier in it. However, as discussed on irc and upon looking at the
code, we don't actually do anything useful with duty_cycle yet, so
perhaps just cut it out entirely for the moment, and add it later when
its of use.

--=20
Jarod Wilson
jarod@wilsonet.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
