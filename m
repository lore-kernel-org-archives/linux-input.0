From: Pavel Revak <palo@bielyvlk.sk>
Subject: ucb1400 and mouse emulation
Date: Mon, 5 Oct 2009 14:34:09 +0200
Message-ID: <b0ba3e300910050534o75668f63y3ee0bd4c1c713fd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:49236 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbZJEMfW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Oct 2009 08:35:22 -0400
Received: by gxk4 with SMTP id 4so3741283gxk.8
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2009 05:34:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello, I upgraded to new kernel 2.6.31 (from 2.6.29) and I use
touchscreen with ucb1400 through library "tslib" which has own
calibration. from 2.6.30+ kernels this touchscreen emulate a mouse
(with out tslib) but is uncalibrated. My application use SDL with
framebuffer (no X server) and read mouse and touchscreen
simultaneously. But now it is unusable whne I use touchscreen, because
I read now touch screen as generic mouse (uncalibrated) and as tslib
(calibrated) at same time . Exist any way to calibrate touchscreen
without X server or tslib for sdl applications (this is preferred to
me) ? or can I disable mouse emulation from touchscreen and use only
tslib for sdl apps ?

Thanks, Palo.
