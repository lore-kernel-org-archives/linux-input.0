From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Method to power off HID device from driver?
Date: Thu, 08 Dec 2016 04:39:08 +0100
Message-ID: <1481168348.2286.11.camel@hadess.net>
References: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
         <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com>
         <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46695 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbcLHDjZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2016 22:39:25 -0500
In-Reply-To: <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>, Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org

On Tue, 2016-12-06 at 19:20 -0800, Cameron Gutman wrote:
> Hi,
> 
> > On Dec 6, 2016, at 4:25 PM, Roderick Colenbrander <roderick@gaikai.
> > com> wrote:
> > 
> > Hi,
> > 
> > I looked a bit deeper and found EV_PWR, though it isn't clearly
> > defined, but it is used in some places for purposes like this.
> > Would
> > this be an acceptable method?
> > 
> 
> I am interested in this too. I recently implemented the ability to
> turn off wireless Xbox 360 controllers in [0], but there is no way
> to activate this functionality without suspending the whole system.
> Some folks [1] have asked for this ability in other scenarios.
> 
> [0]: Commit f712a5a05228058f6b74 ("Input: xpad - power off wireless
>                                    360 controllers on suspend")
> [1]: https://github.com/paroj/xpad/issues/52

Ditto the PS3 BD remote driver, when moving to the kernel, lost its
ability to suspend after X minutes, which drains the AA batteries
inside it.

In the original system, the remote would get disconnected after less
than a couple of minutes, and reconnect as soon as you pressed a
button, and make sure that button got sent to the device.

Would be great if we could control this from user-space.
