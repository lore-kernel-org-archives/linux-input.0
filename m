From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] AT32AP700X PS/2 controller (PSIF): remove msleep call
	from atomic context
Date: Sun, 13 Dec 2009 20:49:37 -0800
Message-ID: <20091214044937.GD16760@core.coreip.homeip.net>
References: <4B24EB45.2020708@pajkc.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:51598 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496AbZLNEtm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2009 23:49:42 -0500
Received: by pzk1 with SMTP id 1so2013308pzk.33
        for <linux-input@vger.kernel.org>; Sun, 13 Dec 2009 20:49:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B24EB45.2020708@pajkc.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marjan Fojkar <marjan@pajkc.eu>
Cc: linux-input@vger.kernel.org, kernel@avr32linux.org, hans-christian.egtvedt@atmel.com

Hi Martin,

On Sun, Dec 13, 2009 at 02:25:25PM +0100, Marjan Fojkar wrote:
> From: Marjan Fojkar <marjan@pajkc.eu>
> 
> The patch removes msleep call from atomic context. To achieve that, the driver
> PSIF leaves atomic context before the call in order to enable interrupts to be
> performed safely. When the call is done, the driver jumps back to atomic context.
> 

Yes, msleep is not allowed in atomic context, however serio's write()
method is supposed to be callable from atomic context so msleep is not
available there period. I scanned the datasheet quickly and did not see
any restriction on the frequency of reading status register so I think
we should do what i8042 driver does - udelay(50).

Hans-Christian?

-- 
Dmitry
