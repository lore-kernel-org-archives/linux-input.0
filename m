From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Wacom Intuos4 LED and OLED support
Date: Tue, 5 Apr 2011 11:28:09 -0700
Message-ID: <20110405182808.GB13086@core.coreip.homeip.net>
References: <1301817429-12782-1-git-send-email-eduard@hasenleithner.at>
 <BANLkTimvgdahQyu94Ep=C8JU_Cfra_kdjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:53907 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab1DES2R (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 14:28:17 -0400
Received: by pxi2 with SMTP id 2so378807pxi.10
        for <linux-input@vger.kernel.org>; Tue, 05 Apr 2011 11:28:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimvgdahQyu94Ep=C8JU_Cfra_kdjg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eduard Hasenleithner <ehasenle@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Eduard,

On Tue, Apr 05, 2011 at 08:12:07PM +0200, Eduard Hasenleithner wrote:
> Hi Dmitry.
> 
> I have been encouraged by Ping Cheng to submit the OLED matrix display
> patch for the Intuos4 to the linux-input mailing list. In absence of
> any comment by you on this issue, I'm a bit lost. Could you give
> something like a quick ACK (e.g. you will have a look into it later,
> when you have time) or NACK (e.g. no way for inclusion, needs major
> change, ...).

Sorry, just a bit swamped at the moment (unfortunately happens to be
quite often ;( ), that is why not responding...

The main issue for me is adding a new device-specific interface. Are
there any other suitable ways to provide access to the functionality?
Something like auxdisplay?

Thanks.

-- 
Dmitry
