From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: Re: [PATCH] Input: gpio_keys - fix NULL pointer dereference for dt case
Date: Mon, 6 Aug 2012 23:09:46 +0530
Message-ID: <CANQgH-ayQJ3MSogJgWR1CyfiO_PjBXbMWW0XwcQTZPpxRROy8A@mail.gmail.com>
References: <1344001314-2250-1-git-send-email-fabio.estevam@freescale.com>
	<501F8553.40902@ti.com>
	<20120806082036.GB4518@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:44268 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753685Ab2HFRjy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Aug 2012 13:39:54 -0400
Received: by vbbfs19 with SMTP id fs19so5848144vbb.1
        for <linux-input@vger.kernel.org>; Mon, 06 Aug 2012 10:39:46 -0700 (PDT)
In-Reply-To: <20120806082036.GB4518@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, shawn.guo@linaro.org, kernel@pengutronix.de, aletes.xgr@gmail.com, rob.herring@calxeda.com, linux-input@vger.kernel.org

On Mon, Aug 6, 2012 at 1:50 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Aug 06, 2012 at 02:20:27PM +0530, Shubhrajyoti wrote:
>> On Friday 03 August 2012 07:11 PM, Fabio Estevam wrote:
>> > Commit 30161f6b2e7d1 (Input: gpio_keys - clean up device tree parser)
>> > introduced the following kernel crash for a dt based kernel:
>> > ..
>> > Unable to handle kernel NULL pointer dereference at virtual address 00000004
>> > pgd = 80004000
>> > [00000004] *pgd=00000000
>> > Internal error: Oops: 805 [#1] ARM
>> > Modules linked in:
>> > CPU: 0    Not tainted  (3.5.0-next-20120802+ #1366)
>> > PC is at gpio_keys_probe+0x154/0x8c0
>> > LR is at of_gpiochip_find_and_xlate+0x54/0x70
>> > pc : [<803ddbac>]    lr : [<801ed2f4>]    psr: 60000013
>> > sp : 9f851df8  ip : 00000002  fp : 9f851e5c
>> > r10: 9f873d00  r9 : 00000001  r8 : 9fa2f900
>> > r7 : 809c0920  r6 : 9f873d08  r5 : 00000000  r4 : 809c09d4
>> > r3 : 805af10c  r2 : 000000c0  r1 : 9f851db4  r0 : 000000d5
>> > Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>> > Control: 10c5387d  Table: 90004019  DAC: 00000015
>> > Process swapper (pid: 1, stack limit = 0x9f8502e8)
>> > Stack: (0x9f851df8 to 0x9f852000)
>> > ....
>> >
>> > The reason for the crash was due to 'button = &pdata->buttons[i++];'
>> > returning a NULL pointer, and then 'button' was accessed afterwards
>> > without checking for NULL.
>> >
>> > Fix this by correctly assigning 'pdata->buttons' and also add a NULL
>> > pointer check for 'button' pointer.
>> >
>> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> > Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
>> >
>> Should we cc stable?
>
> No, because it hasn't hit mainline.

ops should have checked that.
thanks,

>
> Thanks.
>
> --
> Dmitry
