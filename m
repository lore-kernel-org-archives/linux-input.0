From: Pavel Revak <palo@bielyvlk.sk>
Subject: Re: ucb1400 and mouse emulation
Date: Tue, 6 Oct 2009 15:41:17 +0200
Message-ID: <b0ba3e300910060641x47c9d24as97d1b7e3c293a6d8@mail.gmail.com>
References: <b0ba3e300910050534o75668f63y3ee0bd4c1c713fd8@mail.gmail.com>
	 <20091006050624.GE27881@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:34553 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757394AbZJFNsT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2009 09:48:19 -0400
Received: by ywh3 with SMTP id 3so3959947ywh.22
        for <linux-input@vger.kernel.org>; Tue, 06 Oct 2009 06:47:42 -0700 (PDT)
In-Reply-To: <20091006050624.GE27881@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Oct 6, 2009 at 7:06 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Pavel
>
> On Mon, Oct 05, 2009 at 02:34:09PM +0200, Pavel Revak wrote:
>> Hello, I upgraded to new kernel 2.6.31 (from 2.6.29) and I use
>> touchscreen with ucb1400 through library "tslib" which has own
>> calibration. from 2.6.30+ kernels this touchscreen emulate a mouse
>> (with out tslib) but is uncalibrated.
>
> This should not have changed, mousedev emulation was there for ages.

ah yes, but after this patch:
 http://article.gmane.org/gmane.linux.kernel.commits.head/191681
mouse emulation works in my application.

>> My application use SDL with
>> framebuffer (no X server) and read mouse and touchscreen
>> simultaneously. But now it is unusable whne I use touchscreen, because
>> I read now touch screen as generic mouse (uncalibrated) and as tslib
>> (calibrated) at same time . Exist any way to calibrate touchscreen
>> without X server or tslib for sdl applications (this is preferred to
>> me) ? or can I disable mouse emulation from touchscreen and use only
>> tslib for sdl apps ?
>>
>
> The application has to decide what interface it wishes to use (mousedev
> or evdev) and read from that interface only.

OK, thanks
Palo.
