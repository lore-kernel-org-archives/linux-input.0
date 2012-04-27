From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH V3 1/4] Input: pxa27x_keypad keep clock on as wakeup source
Date: Fri, 27 Apr 2012 17:04:53 +0800
Message-ID: <CAN1soZxTfp9p-JoTmXRDFYLKt0mmgcSwc5F9Tk8b+E0fQRW6AQ@mail.gmail.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
	<CAN1soZyBPE3YExELmu5yHeMTWQf9Zs07v26F6Qz3ocKO+cXGFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49102 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759677Ab2D0JEy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Apr 2012 05:04:54 -0400
Received: by vbbff1 with SMTP id ff1so359245vbb.19
        for <linux-input@vger.kernel.org>; Fri, 27 Apr 2012 02:04:53 -0700 (PDT)
In-Reply-To: <CAN1soZyBPE3YExELmu5yHeMTWQf9Zs07v26F6Qz3ocKO+cXGFw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <chao.xie@marvell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, haojian.zhuang@marvell.com

On Mon, Apr 2, 2012 at 5:37 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> On Sun, Apr 1, 2012 at 10:08 AM, Chao Xie <chao.xie@marvell.com> wrote:
>> When the keypad is used as wake up source, the clock can not
>> be disabled. Or it can not detect key pressing.
>> If the keypad is used as wake up source, when resume back,
>> do not enable the clock and configure it again because the
>> register content is retained.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> ---
>
> Hi Dmitry,
>
> I just found that you're not looped in this mail thread. Could I merge
> them into arch-pxa tree?
>
> Best Regards
> Haojian

Applied

Regards
Haojian
