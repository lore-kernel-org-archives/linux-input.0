From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
	specify exact irq flags
Date: Mon, 30 Nov 2009 16:37:24 -0800
Message-ID: <20091201003724.GC3906@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org> <87hbsd2b17.fsf@tac.ki.iif.hu> <20091130082737.GA27979@gw.healthdatacare.com> <87638rlof9.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:51462 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbZLAAhX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 19:37:23 -0500
Received: by pxi26 with SMTP id 26so3326965pxi.21
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2009 16:37:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87638rlof9.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Nov 30, 2009 at 09:59:06PM +0100, Ferenc Wagner wrote:
> Mika Westerberg <mika.westerberg@iki.fi> writes:
> 
> > If it suits you, I would go with the "can_disable" -field in the
> > struct gpio_keys_button. This way it should be possible to extend
> > gpio-keys in future to support multiple buttons sharing the single IRQ
> > and it also works for us.
> 
> Why not simply release the corresponding IRQ?  No new fields are needed
> in the platform data, you don't even have to change the IRQ flags.  Or
> do I miss something again?

It would work but with one unpleasant possibility - of you release IRQ
some other device might "steal" it. I don't think it is a good style for
a device to fail due to resources conflict if it was working to begin
with.

-- 
Dmitry
