From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 3/3] Input: adp5589-keys: fix event count mask
Date: Thu, 8 Oct 2015 11:21:12 -0300
Message-ID: <CAAEAJfDQKLRRKrGecPPOcYVBDgN8-Ac_44+sF7FBKXh130Oc9A@mail.gmail.com>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
	<1429626090-29022-4-git-send-email-guido@vanguardiasur.com.ar>
	<5536607C.4010404@analog.com>
	<20150506233600.GC5580@dtor-ws>
	<CAAEAJfCc_eJFunVW7oqeNsqj0FVDgGK_s9LdfS_wiEShN7nhzQ@mail.gmail.com>
	<CAKdAkRQ8mhrqiYtKXiD6dA845QHYAvDNiBFEyNdgXsd=ncNmGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33286 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758AbbJHOVN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2015 10:21:13 -0400
Received: by wiclk2 with SMTP id lk2so30874633wic.0
        for <linux-input@vger.kernel.org>; Thu, 08 Oct 2015 07:21:12 -0700 (PDT)
In-Reply-To: <CAKdAkRQ8mhrqiYtKXiD6dA845QHYAvDNiBFEyNdgXsd=ncNmGw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?Q?Guido_Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, Mike Frysinger <vapier@gentoo.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, device-drivers-devel@blackfin.uclinux.org

On 5 October 2015 at 21:29, Dmitry Torokhov <dmitry.torokhov@gmail.com>=
 wrote:
> Hi Ezequiel,
>
> On Fri, Oct 2, 2015 at 2:28 PM, Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
>> On 6 May 2015 at 20:36, Dmitry Torokhov <dmitry.torokhov@gmail.com> =
wrote:
>>> On Tue, Apr 21, 2015 at 04:36:44PM +0200, Michael Hennerich wrote:
>>>> On 04/21/2015 04:21 PM, Guido Mart=C3=ADnez wrote:
>>>> >The event mask was specified as 0xF (4 bits) when in reality is 0=
x1F (5
>>>> >bits) in order to be capable of representing all FIFO length valu=
es from
>>>> >0 to 16.
>>>> >
>>>> >This caused a problem: when the keypad reported 16 pending events=
 the
>>>> >driver took it as 0, and did nothing. This in turn caused the key=
pad to
>>>> >re-issue the interrupt over and over again.
>>>> >
>>>> >Fixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad =
Decoder and I/O Expander')
>>>> >Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
>>>> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>
>> Dmitry,
>>
>> Going through this patchset and noticed the "Fixes" tag got dropped =
when
>> the last two fixes were pushed.
>
> I believe "Fixes" tag is interesting when there was a patch that
> changed behavior and broke things, not when there is a mistake that
> was present since very beginning.
>

If anything else, the Fixes tag clearly states the commit fixes somethi=
ng
(if the commit log is not clear enough). And if the bug was there from =
the
very beginning, so be it. The tag is only clarifying that.

I'd say the more information about the commit, the better.

>>
>> More importantly, the patches haven't been queued for -stable, despi=
te it
>> fixes a serious issue.
>>
>> Can you take care of sending them to -stable or should I do it?
>> Upstream commits are:
>> c615dcb6d13e Input: adp5589-keys - fix event count mask
>> 195e610bf710 Input: adp5589-keys - fix pull mask setting
>
> Given that there were no complaints about this issues ever since the
> driver has been accepted into main line (3.0 kernel) and that the
> device is not very widely used I do not believe this has to go to
> stable. Affected parties can cherry-pick from mainline.
>

Well, the event triggering the bug was quite marginal, so it's fairly
hard to hit
it in real life.

On the other side, the bug itself was a very subtle typo
in the mask value, and took a lot of effort to catch. I thought that ef=
fort
worth a simple backport to stable.

Having a bug in mainline, and deciding not to backport it to stable,
seems wrong to me, despite lack of (known) complaints and
despite how unused a driver may appear to be.

Anyway, it's your call. I'm happy with whatever you decide.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
