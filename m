From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Keyboard: omap-keypad: use matrix_keypad.h
Date: Fri, 17 Dec 2010 19:10:04 -0800
Message-ID: <20101218031003.GP5941@atomide.com>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201012172332.06480.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101217 14:33]:
> Most keypad drivers make use of the <linux/input/matrix_keypad.h> 
> defined macros, structures and inline functions.
> 
> Convert omap-keypad driver to use those as well, as suggested by a 
> compile time warning, hardcoded into the OMAP <palt/keypad.h>.
> 
> Created against linux-2.6.37-rc5.
> Tested on Amstrad Delta.
> Compile tested with omap1_defconfig and omap2plus_defconfig shrinked to 
> board-h4.

Great, good to get rid of those annoying warnings!

>  drivers/input/keyboard/omap-keypad.c     |   36 ++++----
>  include/linux/input/matrix_keypad.h      |    2

We also need Dmitry's ack for these changes.

Regards,

Tony
