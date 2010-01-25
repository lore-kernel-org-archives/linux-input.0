From: Guillaume Chazarain <guichaz@gmail.com>
Subject: Re: evdev regression on macbook with 2.6.33-rc5
Date: Mon, 25 Jan 2010 23:49:20 +0100
Message-ID: <3d8471ca1001251449g6bdbdb4fn11f566b41691f870@mail.gmail.com>
References: <3d8471ca1001231053k512011dcnfab50052ce3667fa@mail.gmail.com>
	 <20100124093055.GA17607@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:34110 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab0AYWtW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jan 2010 17:49:22 -0500
In-Reply-To: <20100124093055.GA17607@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: ajax@redhat.com, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Sun, Jan 24, 2010 at 10:30 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> DOes the same behavior happens when you try using 'evtest' utility while
> in console?

Hi Dmitry,

While struggling to make evtest show keyboard events, I discovered
that the problem is an incompatibility with mouseemu
(http://packages.ubuntu.com/karmic/mouseemu) as killing it makes the
keyboard work fine.

So, with mouseemu running, evtest won't print any event at all even if
I move the mouse, and when mouseemu is off everything works fine and
evtest prints the expected events.

> Also, do you have external USB keyboard by any chance and if
> you do does it exibit the same problem?

Yup, I get the exact same behaviour with an external USB keyboard and
mouseemu running: keystrokes being delivered only when I finally move
the mouse or the trackpad.

Cheers.

-- 
Guillaume
