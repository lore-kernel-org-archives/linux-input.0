From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ucb1400 and mouse emulation
Date: Mon, 5 Oct 2009 22:06:25 -0700
Message-ID: <20091006050624.GE27881@core.coreip.homeip.net>
References: <b0ba3e300910050534o75668f63y3ee0bd4c1c713fd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f217.google.com ([209.85.219.217]:57948 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbZJFFHH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2009 01:07:07 -0400
Received: by ewy17 with SMTP id 17so3529420ewy.39
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2009 22:06:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b0ba3e300910050534o75668f63y3ee0bd4c1c713fd8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Revak <palo@bielyvlk.sk>
Cc: linux-input@vger.kernel.org

Hi Pavel

On Mon, Oct 05, 2009 at 02:34:09PM +0200, Pavel Revak wrote:
> Hello, I upgraded to new kernel 2.6.31 (from 2.6.29) and I use
> touchscreen with ucb1400 through library "tslib" which has own
> calibration. from 2.6.30+ kernels this touchscreen emulate a mouse
> (with out tslib) but is uncalibrated.

This should not have changed, mousedev emulation was there for ages.

> My application use SDL with
> framebuffer (no X server) and read mouse and touchscreen
> simultaneously. But now it is unusable whne I use touchscreen, because
> I read now touch screen as generic mouse (uncalibrated) and as tslib
> (calibrated) at same time . Exist any way to calibrate touchscreen
> without X server or tslib for sdl applications (this is preferred to
> me) ? or can I disable mouse emulation from touchscreen and use only
> tslib for sdl apps ?
>

The application has to decide what interface it wishes to use (mousedev
or evdev) and read from that interface only.

-- 
Dmitry
