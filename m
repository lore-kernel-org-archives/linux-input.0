From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 2/7] Input: cros_ec_keyb - Stop handling interrupts directly
Date: Fri, 1 Jul 2016 10:49:57 +0200
Message-ID: <CAFqH_52_LYL+guW-QtABWeTDBEBcLQQPu5M=z5Nfv0JFuVGpgQ@mail.gmail.com>
References: <1460464350-30414-1-git-send-email-tomeu.vizoso@collabora.com>
 <1460464350-30414-3-git-send-email-tomeu.vizoso@collabora.com>
 <20160425211735.GG26059@dtor-ws> <CAAObsKC3+Fw2QBKnur5ZYWw=Ys4yQaoEYdXV+cjNjGYyyO5McQ@mail.gmail.com>
 <20160426065755.GA19037@dell> <CAAObsKC2RrLZ4t9jPigxt4asquf1hjumWAb6h9iH8tHqU2cdPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35390 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbcGAIz7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jul 2016 04:55:59 -0400
In-Reply-To: <CAAObsKC2RrLZ4t9jPigxt4asquf1hjumWAb6h9iH8tHqU2cdPA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, linux-input@vger.kernel.org

Hi Tomeu,

2016-04-26 9:06 GMT+02:00 Tomeu Vizoso <tomeu.vizoso@collabora.com>:
> On 26 April 2016 at 08:57, Lee Jones <lee.jones@linaro.org> wrote:
>> On Tue, 26 Apr 2016, Tomeu Vizoso wrote:
>>
>>> On 25 April 2016 at 23:17, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>>> > On Tue, Apr 12, 2016 at 02:32:25PM +0200, Tomeu Vizoso wrote:
>>> >> From: Vic Yang <victoryang@google.com>
>>> >>
>>> >> Because events other that keyboard ones will be handled by now on by
>>> >> other drivers, stop directly handling interrupts and instead listen to
>>> >> the new notifier in the MFD driver.
>>> >>
>>> >
>>> > Hmm, where did Vic's sign-off go?
>>>
>>> Lee Jones asked to remove them in a previous version as he considers
>>> them superfluous. My understanding is that as I'm the first to submit
>>> them to mainline, the chain starts with me (I certify the b section of
>>> http://developercertificate.org/).
>>
>> Hmm... It seems what I said has been misconstrued a little.  You
>> *should* remove SoBs from people who were *only* part of the
>> submission path.  However, you should *not* remove SoBs from patch
>> *authors*.  Since Vic is the author (or at least one of them), their
>> SoB should remain.
>>
>> Apologies if that was not clear.
>
> I see now, will fix the tags in the next revision.
>

With your permission I'll fix this and send a new patch series with
only the patch that adds the MKBP event support and this patch. These
two patches has sense by itself and are only a dependency of cros-ec
USB PD driver and other drivers, so I think makes sense send within a
separate series to increase the possibility to get merged and don't
block other drivers that depends on these.

Thanks,

Enric


> Thanks,
>
> Tomeu
