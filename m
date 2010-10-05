From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH 1/3] Input: hgpk - enable advanced mode through module parameter
Date: Tue, 5 Oct 2010 17:59:35 +0100
Message-ID: <AANLkTinHiCWBb+wZT9niBfGWd3Q-X448CdtMC8yD0NtF@mail.gmail.com>
References: <20101002204235.052959D401B@zog.reactivated.net>
	<20101004174533.GC8321@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65434 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab0JEQ7h (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 12:59:37 -0400
Received: by eyb6 with SMTP id 6so2566286eyb.19
        for <linux-input@vger.kernel.org>; Tue, 05 Oct 2010 09:59:36 -0700 (PDT)
In-Reply-To: <20101004174533.GC8321@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

On 4 October 2010 18:45, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Why do you use abs->rel conversion in driver and not rely on the
> standard userspace component handling thouchpads in absolute mode?

Thanks for your feedback.

The justification mainly revolves around a patch that I saved for
later - one that enables pentablet mode for use with a stylus, which
relies on advanced mode. I'll include that patch when I come to
resending them all after this review, so that everything is clear.

But we don't actually want to use it as a tablet, we want to use it as
a mouse pointer (since the touchpad way of using the mouse is not very
reliable) - i.e. we want it to be relative.

I experimented and enabled it in absolute mode, but I couldn't find
any way of making X treat it as relative. It still "behaves absolute"
even with this command:
 xinput set-mode "OLPC HGPK ALPS HGPK" relative

We want it to behave relatively, i.e. if I finish my stylus movement
in one place and continue from another, the mouse cursor should not
jump.

Does this act as justification for doing the relative calculations in
the driver, or is there an option that I'm missing?

Thanks,
Daniel
