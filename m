From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFT] Input: speed up suspend/shutdown for PS/2 mice and
 keyboards
Date: Sun, 27 Dec 2009 02:10:41 -0800
Message-ID: <20091227101041.GD14655@core.coreip.homeip.net>
References: <20091221070951.GA4170@core.coreip.homeip.net>
 <20091227002658.GB26593@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:57654 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbZL0KKq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Dec 2009 05:10:46 -0500
Content-Disposition: inline
In-Reply-To: <20091227002658.GB26593@khazad-dum.debian.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Linux Input <linux-input@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sat, Dec 26, 2009 at 10:26:58PM -0200, Henrique de Moraes Holschuh wrote:
> Works on my ThinkPad T43 (KBC emulated by the embedded controller firmware),
> although I don't think it made much difference in speed.
> 

Thanks. The speedup should not be that noticeable (even worst hardware
usually manages to do full reset in 0.5 sec), still 0.5 sec here and 0.5
sec there may add up.

-- 
Dmitry
