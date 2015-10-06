From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: adp5589-keys: fix event count mask
Date: Mon, 5 Oct 2015 17:29:42 -0700
Message-ID: <CAKdAkRQ8mhrqiYtKXiD6dA845QHYAvDNiBFEyNdgXsd=ncNmGw@mail.gmail.com>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
	<1429626090-29022-4-git-send-email-guido@vanguardiasur.com.ar>
	<5536607C.4010404@analog.com>
	<20150506233600.GC5580@dtor-ws>
	<CAAEAJfCc_eJFunVW7oqeNsqj0FVDgGK_s9LdfS_wiEShN7nhzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34161 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbbJFA3n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Oct 2015 20:29:43 -0400
Received: by obbda8 with SMTP id da8so142398234obb.1
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2015 17:29:42 -0700 (PDT)
In-Reply-To: <CAAEAJfCc_eJFunVW7oqeNsqj0FVDgGK_s9LdfS_wiEShN7nhzQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?Q?Guido_Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, Mike Frysinger <vapier@gentoo.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, device-drivers-devel@blackfin.uclinux.org

Hi Ezequiel,

On Fri, Oct 2, 2015 at 2:28 PM, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> On 6 May 2015 at 20:36, Dmitry Torokhov <dmitry.torokhov@gmail.com> w=
rote:
>> On Tue, Apr 21, 2015 at 04:36:44PM +0200, Michael Hennerich wrote:
>>> On 04/21/2015 04:21 PM, Guido Mart=C3=ADnez wrote:
>>> >The event mask was specified as 0xF (4 bits) when in reality is 0x=
1F (5
>>> >bits) in order to be capable of representing all FIFO length value=
s from
>>> >0 to 16.
>>> >
>>> >This caused a problem: when the keypad reported 16 pending events =
the
>>> >driver took it as 0, and did nothing. This in turn caused the keyp=
ad to
>>> >re-issue the interrupt over and over again.
>>> >
>>> >Fixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad D=
ecoder and I/O Expander')
>>> >Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
>>> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>>
>
> Dmitry,
>
> Going through this patchset and noticed the "Fixes" tag got dropped w=
hen
> the last two fixes were pushed.

I believe "Fixes" tag is interesting when there was a patch that
changed behavior and broke things, not when there is a mistake that
was present since very beginning.

>
> More importantly, the patches haven't been queued for -stable, despit=
e it
> fixes a serious issue.
>
> Can you take care of sending them to -stable or should I do it?
> Upstream commits are:
> c615dcb6d13e Input: adp5589-keys - fix event count mask
> 195e610bf710 Input: adp5589-keys - fix pull mask setting

Given that there were no complaints about this issues ever since the
driver has been accepted into main line (3.0 kernel) and that the
device is not very widely used I do not believe this has to go to
stable. Affected parties can cherry-pick from mainline.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
