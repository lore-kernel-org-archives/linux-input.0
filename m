From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: Re: [PATCH 6/6] Input: add IOC3 serio driver
Date: Tue, 9 Apr 2019 12:14:49 +0200
Message-ID: <20190409121449.a6f9a6452751cb61c789365f@suse.de>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
        <20190408142100.27618-7-tbogendoerfer@suse.de>
        <20190408190218.GA200740@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408190218.GA200740@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 8 Apr 2019 12:02:18 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Mon, Apr 08, 2019 at 04:20:58PM +0200, Thomas Bogendoerfer wrote:
> > This patch adds a platform driver for supporting keyboard and mouse
> > interface of SGI IOC3 chips.
> [...]

Thank you for your feedback, I've changed the code accordingly and will
send a v2 version after testing it.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
