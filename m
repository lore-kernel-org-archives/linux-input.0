From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/5] input: add driver for tnetv107x on-chip keypad
 controller
Date: Mon, 20 Sep 2010 08:29:35 -0700
Message-ID: <20100920152935.GA698@core.coreip.homeip.net>
References: <1284995252-23337-1-git-send-email-cyril@ti.com>
 <1284995252-23337-2-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33372 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab0ITP3p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 11:29:45 -0400
Received: by pwi3 with SMTP id 3so1242790pwi.19
        for <linux-input@vger.kernel.org>; Mon, 20 Sep 2010 08:29:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1284995252-23337-2-git-send-email-cyril@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cyril Chemparathy <cyril@ti.com>
Cc: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, shubhrajyoti@ti.com, khilman@deeprootsystems.com

Hi Cyril,

On Mon, Sep 20, 2010 at 11:07:28AM -0400, Cyril Chemparathy wrote:
> This patch adds support for tnetv107x's on-chip keypad controller.
> 

There is one thing that I missed - since you have 2 separate irqs they
may execute at the same time on 2 different CPUs (theoretically, if
platform will ever have multiple CPUs) so you need to take a spinlock
inside the interrupt handler to protect from simultaneous access to
shared data.

Once you add it please add

	Acked-by: Dmitry Torokhov <dtor@mail.ru>

and forward it to Kevin so it is merged through his tree.

Thanks.

-- 
Dmitry
