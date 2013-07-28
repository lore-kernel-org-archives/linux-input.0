From: Rolf Morel <rolfmorel@gmail.com>
Subject: Re: [BUG?] EV_LED events not seperated from other events by SYN_REPORT
Date: Sun, 28 Jul 2013 14:35:12 +0200
Message-ID: <CAFRyfCyWkBYRaBkpd9f2DQuzXhjEDoegpfpgy=FKvkVP+NahzA@mail.gmail.com>
References: <CAFRyfCzE2_SE2YJuApUF35+s_Kt-P_tH1dwDwucJL3J_73w8=Q@mail.gmail.com>
	<20130728052608.GB23567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:43426 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab3G1MfN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 08:35:13 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so7352405obb.39
        for <linux-input@vger.kernel.org>; Sun, 28 Jul 2013 05:35:12 -0700 (PDT)
In-Reply-To: <20130728052608.GB23567@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

2013/7/28 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> - require application writing events into /dev/eventX write EV_SYN as
>   well.
>
> At the moment I am inclined to say that applications shoudl do this.

Yes, this is what I was missing/doing incorrectly.
Clients who write to the stream must add there own EV_SYN (SYN_REPORT).
And this would be most correct indeed, as when the writing client, if
there ever where the need, sends events happening at the same moment
in time.

Thanks for replying, it has helped a lot.
