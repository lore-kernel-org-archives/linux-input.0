From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Sat, 3 Sep 2011 13:45:25 +0100
Message-ID: <CAMLZHHQ_ErVVg0TqVuaA=R0SbYdn=htMN+2rcTEEqaF-i9LC4w@mail.gmail.com>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
	<CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
	<20110803184332.GA17880@core.coreip.homeip.net>
	<CAMLZHHTnTTbD7mn_QsjwyFZ=XU6paddrtXEVuLYossk9qBGFfw@mail.gmail.com>
	<CAMLZHHTie_u40NZ40o+LCwffk=3LbY96YTwxQt5wcVtbTc53qg@mail.gmail.com>
	<20110817070351.GE29361@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49674 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab1ICMpZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Sep 2011 08:45:25 -0400
Received: by gya6 with SMTP id 6so2518758gya.19
        for <linux-input@vger.kernel.org>; Sat, 03 Sep 2011 05:45:25 -0700 (PDT)
In-Reply-To: <20110817070351.GE29361@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net, pgf@laptop.org

Hi,

Sorry for the delay in replying to this - I took sime time off.


On Wed, Aug 17, 2011 at 8:03 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> OK, so we have the following scenario:
>
> - we do not need to worry about SND and LED on OLPC;
>
> - we do not need to worry about releasing the key that was pressed
> =A0when we went to sleep because they system would not go to sleep wh=
ile
> =A0there is a key pressed. So the code in input_dev_resume() won't
> =A0actually release any keys unless a key was held pressed and we for=
ced
> =A0system to sleep somehow.
>
> - we need to make sure we do not loose key press (and following event=
s)
> =A0when we are waking up.

Yes, that seems accurate, with one more addition:

- we need to make sure we do not loose mouse button press or mouse
movement (and following events) when we are waking up.

> Can atkbd driver stash away serio byte data (when not in command mode=
)
> and replay it when pm notifier signals us that resume process is done=
?

I'm having trouble understanding this suggestion or relating it to the
problems in question and the previous patches posted. Are you
suggesting stashing of data that is sent from the host  to the
keyboard, or from the keyboard to the host? How does this solve our
issues? What about the mouse?

How is it going to avoid the input-level issues?

Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
