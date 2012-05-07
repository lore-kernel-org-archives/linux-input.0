From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] QT1070: change the trigger mode of QT1070
Date: Mon, 7 May 2012 00:04:24 -0700
Message-ID: <20120507070424.GC22074@core.coreip.homeip.net>
References: <1336357653-18663-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33008 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab2EGHEa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 May 2012 03:04:30 -0400
Received: by pbbrp8 with SMTP id rp8so6313985pbb.19
        for <linux-input@vger.kernel.org>; Mon, 07 May 2012 00:04:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336357653-18663-1-git-send-email-voice.shen@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: javier.martin@vista-silicon.com, khali@linux-fr.org, w.sang@pengutronix.de, josh.wu@atmel.com, jm.lin@atmel.com, linux-input@vger.kernel.org

Hi Bo,

On Mon, May 07, 2012 at 10:27:33AM +0800, Bo Shen wrote:
> The default trigger mode of QT1070 is IRQF_TRIGGER_LOW,
> Using TRQF_TRIGGER_FALLING to replace IRQF_TRIGGER_LOW | IRQF_ONESHOT.

Why don't you set up IRQ the way you want in board code instead of
implementing workarounds in the driver?

Thanks.

-- 
Dmitry
