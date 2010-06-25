From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v5 3/3] input: samsung-keypad - Add samsung keypad driver
Date: Fri, 25 Jun 2010 19:25:16 +0900
Message-ID: <4C24840C.1000701@samsung.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
 <1277101605-2435-3-git-send-email-jy0922.shim@samsung.com>
 <20100625083019.GD8546@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100625083019.GD8546@core.coreip.homeip.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kgene.kim@samsung.com, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 6/25/2010 5:30 PM, Dmitry Torokhov wrote:
> Hi Joonyoung,
> 
> On Mon, Jun 21, 2010 at 03:26:45PM +0900, Joonyoung Shim wrote:
>> This patch adds support for keypad driver running on Samsung cpus. This
>> driver is tested on GONI and Aquila board using S5PC110 cpu.
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Following my conversation with Thomas Gleixner reagrding "long playing"
> threaded interrupt handlers I tried to convert your driver to use this
> concept. The idea is to keep polling within IRQ thread context instead
> of using additional work/timer structures to simplify code and ensure
> race-free shutdown/unbind.
> 
> I think it was based on v4 of your driver and I'd appreciate if you could
> give it a try.
> 

Your patch gives me below patch errors.

$ patch -p1 --dry-run < 2.patch
(Stripping trailing CRs from patch.)
patching file drivers/input/keyboard/samsung-keypad.c
Hunk #3 FAILED at 68.
Hunk #4 FAILED at 116.
Hunk #5 FAILED at 158.
Hunk #6 succeeded at 196 (offset -7 lines).
Hunk #7 succeeded at 212 (offset -7 lines).
Hunk #8 FAILED at 230.
Hunk #9 FAILED at 365.
Hunk #10 FAILED at 418.
6 out of 10 hunks FAILED -- saving rejects to file
drivers/input/keyboard/samsung-keypad.c.rej

Can you give me your patch based on my v5 patches? If not, i should try
manual merge.

Thanks.
