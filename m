From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 3/3] Input: adp5589-keys: fix event count mask
Date: Fri, 2 Oct 2015 18:28:48 -0300
Message-ID: <CAAEAJfCc_eJFunVW7oqeNsqj0FVDgGK_s9LdfS_wiEShN7nhzQ@mail.gmail.com>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
	<1429626090-29022-4-git-send-email-guido@vanguardiasur.com.ar>
	<5536607C.4010404@analog.com>
	<20150506233600.GC5580@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37847 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbJBV2u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 17:28:50 -0400
Received: by wicfx3 with SMTP id fx3so46786546wic.0
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2015 14:28:49 -0700 (PDT)
In-Reply-To: <20150506233600.GC5580@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?Q?Guido_Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, Mike Frysinger <vapier@gentoo.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, device-drivers-devel@blackfin.uclinux.org

On 6 May 2015 at 20:36, Dmitry Torokhov <dmitry.torokhov@gmail.com> wro=
te:
> On Tue, Apr 21, 2015 at 04:36:44PM +0200, Michael Hennerich wrote:
>> On 04/21/2015 04:21 PM, Guido Mart=C3=ADnez wrote:
>> >The event mask was specified as 0xF (4 bits) when in reality is 0x1=
=46 (5
>> >bits) in order to be capable of representing all FIFO length values=
 from
>> >0 to 16.
>> >
>> >This caused a problem: when the keypad reported 16 pending events t=
he
>> >driver took it as 0, and did nothing. This in turn caused the keypa=
d to
>> >re-issue the interrupt over and over again.
>> >
>> >Fixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad De=
coder and I/O Expander')
>> >Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
>> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>

Dmitry,

Going through this patchset and noticed the "Fixes" tag got dropped whe=
n
the last two fixes were pushed.

More importantly, the patches haven't been queued for -stable, despite =
it
fixes a serious issue.

Can you take care of sending them to -stable or should I do it?
Upstream commits are:
c615dcb6d13e Input: adp5589-keys - fix event count mask
195e610bf710 Input: adp5589-keys - fix pull mask setting

Thanks!
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
