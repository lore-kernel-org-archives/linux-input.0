From: Luotao Fu <l.fu@pengutronix.de>
Subject: mfd: STMPExxxx fixes and touch screen support
Date: Thu, 24 Jun 2010 13:13:35 +0200
Message-ID: <1277378021-16802-1-git-send-email-l.fu@pengutronix.de>
References: <20100622135635.GA30720@bnru02.bnr.st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100622135635.GA30720@bnru02.bnr.st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rabin VINCENT <rabin.vincent@stericsson.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-input@vger.kernel.org

Hi Rabin,

I merged your stmpexxx patches and tested them on my board with a stmpe811 chip
(gpio + touchscreen).

In the following are few fixes for the gpio driver. In the serie is also the V4
of my stmpe touchscreen driver, which is now converted to the stmpexxx core.
There appears to be two stmpe variants with a touchscreen controller: stmpe811
and stmpe610. I checked briefly the datasheet of stmpe610. It appears to be, as
far as I can see, identical with stmpe811. Hence I think that the stmpe-ts should
work for the stmpe610 too. Since I don't have a stmpe610 here, I didn't add the
stmpe610 support to the core. Maybe someone out there has possiblities to test
stmpe610, should not be too hard to add support for the chip to the core.

cheers
Luotao Fu
