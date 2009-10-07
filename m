From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ucb1400 and mouse emulation
Date: Tue, 6 Oct 2009 21:35:55 -0700
Message-ID: <20091007043554.GB10204@core.coreip.homeip.net>
References: <b0ba3e300910050534o75668f63y3ee0bd4c1c713fd8@mail.gmail.com> <20091006050624.GE27881@core.coreip.homeip.net> <b0ba3e300910060641x47c9d24as97d1b7e3c293a6d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f217.google.com ([209.85.219.217]:36247 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZJGEgi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2009 00:36:38 -0400
Received: by ewy17 with SMTP id 17so217597ewy.39
        for <linux-input@vger.kernel.org>; Tue, 06 Oct 2009 21:36:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b0ba3e300910060641x47c9d24as97d1b7e3c293a6d8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Revak <palo@bielyvlk.sk>
Cc: linux-input@vger.kernel.org

On Tue, Oct 06, 2009 at 03:41:17PM +0200, Pavel Revak wrote:
> On Tue, Oct 6, 2009 at 7:06 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Pavel
> >
> > On Mon, Oct 05, 2009 at 02:34:09PM +0200, Pavel Revak wrote:
> >> Hello, I upgraded to new kernel 2.6.31 (from 2.6.29) and I use
> >> touchscreen with ucb1400 through library "tslib" which has own
> >> calibration. from 2.6.30+ kernels this touchscreen emulate a mouse
> >> (with out tslib) but is uncalibrated.
> >
> > This should not have changed, mousedev emulation was there for ages.
> 
> ah yes, but after this patch:
>  http://article.gmane.org/gmane.linux.kernel.commits.head/191681
> mouse emulation works in my application.

Ah, I see. 

-- 
Dmitry
