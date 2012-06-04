From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC PATCH] Wiimote joystick reports no axes
Date: Mon, 4 Jun 2012 17:08:34 +0200
Message-ID: <CAOxFTcze+r2Qa26iRZg0Mw66T2Yoyuwm_5Z39idRUZ_JZfK+ew@mail.gmail.com>
References: <CAOxFTcwsVFpN0KcKSbCjCHJ0=0Q+CcSd0UxanWzue0pv5ZSoXA@mail.gmail.com>
 <1338800098-5643-1-git-send-email-giuseppe.bilotta@gmail.com> <CANq1E4TWf24_U5PdZ7mc2WXEO+wnGgVsU=LC_PcDvBf+0Wg+RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:65477 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760739Ab2FDPIz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jun 2012 11:08:55 -0400
Received: by vcbf11 with SMTP id f11so2501853vcb.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jun 2012 08:08:54 -0700 (PDT)
In-Reply-To: <CANq1E4TWf24_U5PdZ7mc2WXEO+wnGgVsU=LC_PcDvBf+0Wg+RQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

Hello David

On Mon, Jun 4, 2012 at 4:48 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Giuseppe
>
> The changes look good to me. They still allow us to disable the
> accelerometer on the device, if no-one uses the accelerometer-input so
> power-management still works. However, we are now duplicating the
> events which I wanted to avoid in the beginning.

Yes, I must say that I'm not crazy about this fact either. A possible
solution could be to not report the keys on the Remote device when
they are reported on the Accel device, or to have some kind of switch
to determine on which device(s) they should be reported (defaulting to
both). But maybe this is overengineering it?

> I have never used the joydev interface. In fact, I don't even know why
> it exists and what it does different compared to evdev. Therefore, I
> recommend CC'ing Dmitry or Jiri to let them comment on your ideas. But
> I guess they recommend using uinput to get the same result. That is,
> creating a fake input device from userspace that collects data from
> all the Wii Remote input devices and only sends the requested ones.
> This would also allow applications that are _not_ aware of Wii Remotes
> to use them. It would also provide much more configurability and
> extensibility. There is also a xf86-input-xwiimote XInput2 driver that
> can provide the same functionality to programs/games using XInput2.

The nice thing about the joydev interfaces is that it allows using the
device (possibly with some limitations) with games that already
support this interface, without needing specific wiimote support or
awareness, and without requiring additional drivers. As long as it
doesn't conflict with other usages, I think it's all value-add 8-)

> Anyway, feel free to send this patch to linux-input as proper git
> patch and CC Jiri and Dmitry. I have nothing to object here but I also
> don't see the reason to support joydev with Wii Remotes.

Ok, I'll prepare the patch, thanks.

-- 
Giuseppe "Oblomov" Bilotta
