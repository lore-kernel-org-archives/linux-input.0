From: Sundar <sunder.svit@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 23:30:22 +0530
Message-ID: <AANLkTin0cLmmCyWuQS=OyrOVp-wTEmW65PRqR7S_ez4b@mail.gmail.com>
References: <AANLkTi=ouKDuPgUgLOwfBPhWKM=RCoh8hb0tY3h53i2r@mail.gmail.com>
	<Pine.LNX.4.44L0.1010131335580.2311-100000@iolanthe.rowland.org>
	<AANLkTikqNNY=gNC96ZEo5ar+Adw80h=M3_XGe3A--unu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50854 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab0JMSAX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 14:00:23 -0400
Received: by yxm8 with SMTP id 8so1217670yxm.19
        for <linux-input@vger.kernel.org>; Wed, 13 Oct 2010 11:00:23 -0700 (PDT)
In-Reply-To: <AANLkTikqNNY=gNC96ZEo5ar+Adw80h=M3_XGe3A--unu@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>

On Wed, Oct 13, 2010 at 11:12 PM, Sundar <sunder.svit@gmail.com> wrote:
> On Wed, Oct 13, 2010 at 11:07 PM, Alan Stern <stern@rowland.harvard.e=
du> wrote:
>>
>> Sorry, I don't quite understand your question. =A0I think it would b=
e
>> okay to add an interface for userspace to cut short a runtime-suspen=
d
>> delay, but I don't think anything more is needed.
>>
>
> I was just confirming that it is agreed by all that we can definitely=
 wrap
> this up via the standard PM helpers; through the accelerated suspend
> if no one has any other reservations.
>

And I forgot one more point. Since this switch feature was one of the
requirements for the Meego framework, wouldnt it be nice if the Meego
people also put out their opinions on this newer solution?

Cheers!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
