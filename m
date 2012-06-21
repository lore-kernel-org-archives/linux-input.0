From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: gpio_keys_polled.c and DT
Date: Thu, 21 Jun 2012 01:53:40 -0700
Message-ID: <20120621085340.GE2193@core.coreip.homeip.net>
References: <4FE0946B.8030201@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FE0946B.8030201@antcom.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: dgdunix@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Roland,

On Tue, Jun 19, 2012 at 05:02:03PM +0200, Roland Stigge wrote:
> Hi,
> 
> as far as I can see, gpio_keys_polled.c currently doesn't support DT
> initialization. Is there a plan in this regard?
> 
> Rather than duplicating the respective code from gpio_keys.c, maybe
> gpio_keys.c could be changed to support a polled mode also? This way,
> gpio_keys_polled.c could be removed.

We had several attempts at gpio_keys and adding a polled mode and we
ended up with the driver getting too complex and having unwanted
dependencies. At the moment I believe that the split between gpio_keys.c
and gpio_keys_polled.c is justified even it it may lead to certain code
duplication.

However, if DT bindings are really the same we could split them off into
a separate library module used by both drivers.

Thanks.

-- 
Dmitry
