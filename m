From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] OMAP3: RX-51: complete tsc2005 controller support
Date: Wed, 14 Dec 2011 17:45:22 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1112141742530.28200@kernel.research.nokia.com>
References: <1323867676-15956-1-git-send-email-vladimir.zapolskiy@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1323867676-15956-1-git-send-email-vladimir.zapolskiy@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Vladimir Zapolskiy <vladimir.zapolskiy@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-input@vger.kernel.org

Hi,

On Wed, 14 Dec 2011, Vladimir Zapolskiy wrote:
> This change adds initialization of TSC2005 touchscreen controller
> found on Nokia RX-51 board.
>
> The change is taken from MeeGo kernel adaptation for Nokia N900,
> it repeats the work of Aaro Koskinen and Mika Laitio, the original
> discussion is at
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26749.html

I think Tony applied this already:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=3dad5356aa47097cf67027cf0a07298b4f5baef6

And that patch was from Maemo, not MeeGo kernel...

A.
