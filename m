From: Sundar <sunder.svit@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 23:12:26 +0530
Message-ID: <AANLkTikqNNY=gNC96ZEo5ar+Adw80h=M3_XGe3A--unu@mail.gmail.com>
References: <AANLkTi=ouKDuPgUgLOwfBPhWKM=RCoh8hb0tY3h53i2r@mail.gmail.com>
	<Pine.LNX.4.44L0.1010131335580.2311-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37909 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab0JMRm2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 13:42:28 -0400
Received: by iwn9 with SMTP id 9so59993iwn.19
        for <linux-input@vger.kernel.org>; Wed, 13 Oct 2010 10:42:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1010131335580.2311-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>

On Wed, Oct 13, 2010 at 11:07 PM, Alan Stern <stern@rowland.harvard.edu=
> wrote:
>
> Sorry, I don't quite understand your question. =A0I think it would be
> okay to add an interface for userspace to cut short a runtime-suspend
> delay, but I don't think anything more is needed.
>

I was just confirming that it is agreed by all that we can definitely w=
rap
this up via the standard PM helpers; through the accelerated suspend
if no one has any other reservations.

Cheers!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
