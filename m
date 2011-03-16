From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: generic driver for slide switches
Date: Tue, 15 Mar 2011 23:36:18 -0700
Message-ID: <20110316063617.GG14604@core.coreip.homeip.net>
References: <1298640558-3030-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
 <201103151413.50042.alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37722 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab1CPGgX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 02:36:23 -0400
Received: by iyb26 with SMTP id 26so1356653iyb.19
        for <linux-input@vger.kernel.org>; Tue, 15 Mar 2011 23:36:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201103151413.50042.alexander.stein@informatik.tu-chemnitz.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Cc: linux-input@vger.kernel.org

On Tue, Mar 15, 2011 at 02:13:49PM +0100, Alexander Stein wrote:
> On Friday 25 February 2011, 14:29:18 Alexander Stein wrote:
> > This patch adds a generic driver for slide switches connected to GPIO
> > pins of a system. It requires gpiolib and generic hardware irqs.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
> > ---
> >  drivers/input/misc/Kconfig         |    9 ++
> >  drivers/input/misc/Makefile        |    1 +
> >  drivers/input/misc/slide_switch.c  |  268
> > ++++++++++++++++++++++++++++++++++++ include/linux/input/slide_switch.h | 
> >  16 ++
> >  4 files changed, 294 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/input/misc/slide_switch.c
> >  create mode 100644 include/linux/input/slide_switch.h
> 
> Did this get overlooked accidentaly?
> 

Hi Alexander,

Hm, can't it be merged with gpio_keys? Just add the 'value' to the
gpio_keys_button structure that would be valid for EV_ABS (or even
EV_REL) types. Debouncing should filter out jittery events...

Thanks.

-- 
Dmitry
