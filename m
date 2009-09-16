From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2] input/keyboard: add ADP5588
	QWERTY I2C Keyboard Input device driver
Date: Wed, 16 Sep 2009 08:55:13 -0400
Message-ID: <8bd0f97a0909160555n390ad48dhf19c7eac5c3783fe@mail.gmail.com>
References: <20090915062050.GB10232@core.coreip.homeip.net>
	<1253062178-18196-1-git-send-email-vapier@gentoo.org> <20090916050236.GF2756@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:63091 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758413AbZIPMzb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 08:55:31 -0400
In-Reply-To: <20090916050236.GF2756@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Wed, Sep 16, 2009 at 01:02, Dmitry Torokhov wrote:
> On Tue, Sep 15, 2009 at 08:49:38PM -0400, Mike Frysinger wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Signed-off-by: Bryan Wu <cooloney@kernel.org>
>> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> ---
>> v2
>> =C2=A0 =C2=A0 =C2=A0 - merge my and Dmitry's clean up fixes
>>
>
> Looks good, I'd also like to add this instead of recalcularing delay
> every time:

makes sense to me.  you going to merge that, or should i merge & repost=
 as v3 ?
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
