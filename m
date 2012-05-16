From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/7] input/nomadik-ske: move key scanning to delayed work
Date: Wed, 16 May 2012 11:33:27 -0700
Message-ID: <20120516183327.GB14471@core.coreip.homeip.net>
References: <1336913049-10153-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35602 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab2EPSdd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 May 2012 14:33:33 -0400
Received: by pbbrp8 with SMTP id rp8so1450090pbb.19
        for <linux-input@vger.kernel.org>; Wed, 16 May 2012 11:33:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336913049-10153-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-input@vger.kernel.org, Karl-Johan Perntz <karl-johan.perntz@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Linus,

On Sun, May 13, 2012 at 02:44:09PM +0200, Linus Walleij wrote:
> From: Karl-Johan Perntz <karl-johan.perntz@stericsson.com>
> 
> Move the key scanning to a delayed work thread, drop the threaded
> IRQ since all the IRQ work can now be done quickly.

Justification for the change is missing. What are the benefits of doing
such move, why threaded IRQ does not work for you.

Thanks.

-- 
Dmitry
