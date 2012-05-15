From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 7/7] input/nomadik-ske: add sysfs file to enable/disble
 SKE keypad
Date: Tue, 15 May 2012 17:27:06 +0530
Message-ID: <4FB24492.3020808@ti.com>
References: <1336913065-10224-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:40161 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757851Ab2EOL5N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 May 2012 07:57:13 -0400
Received: by obqv19 with SMTP id v19so11566663obq.8
        for <linux-input@vger.kernel.org>; Tue, 15 May 2012 04:57:12 -0700 (PDT)
In-Reply-To: <1336913065-10224-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On Sunday 13 May 2012 06:14 PM, Linus Walleij wrote:
> rom: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
>
> This sysfs file can force the SKE keypad into GPIO mode (low power)
> from userspace if the device knows that it is going to go into
> a mode where the keyboard is not going to be interactive.
How about using the open and close?
