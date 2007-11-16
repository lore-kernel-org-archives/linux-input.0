From: Herbert Valerio Riedel <hvr@gnu.org>
Subject: Re: [PATCH,RFC] Input: gpio-keys - request and configure GPIOs
Date: Fri, 16 Nov 2007 15:09:11 +0100
Message-ID: <1195222151.10848.47.camel@pbook.intra>
References: <1195212830-9137-1-git-send-email-hvr@gnu.org>
	 <d120d5000711160538u6f629e34h9465a880f09be49c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx03.kabsi.at ([195.202.128.130]:43552 "EHLO mx03.kabsi.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbXKPPas (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2007 10:30:48 -0500
In-Reply-To: <d120d5000711160538u6f629e34h9465a880f09be49c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Paul Sokolovsky <pmiscml@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Philip Blundell <philb@gnu.org>


On Fri, 2007-11-16 at 08:38 -0500, Dmitry Torokhov wrote:
> On Nov 16, 2007 6:33 AM, Herbert Valerio Riedel <hvr@gnu.org> wrote:
> > Currently, gpio_keys.c assumes the GPIOs to be already properly configured;
> > this patch changes gpio-keys to perform explicit calls to gpio_request() and
> > gpio_configure_input().
> >
> > This matches the behaviour of leds-gpio.

> Makes sense from where I sit but let's see what guys who actually use
> the module say... ;)

I grepped through my 2.6.24-git source tre, and the only places I found
gpio_keys.h included was

drivers/input/keyboard/gpio_keys.c:#include <linux/gpio_keys.h>
arch/arm/mach-orion/dns323-setup.c:#include <linux/gpio_keys.h>
arch/arm/mach-at91/board-sam9261ek.c:#include <linux/gpio_keys.h>

with dn323-setup.c being maintained by myself, and board-sam9261ek.c
having seemingly non-compilable code wrt to gpio_keys (for instance, it
uses ".keycode" gpio_keys_button  struct members which should have been
".code"), there don't seem to exist many users of that module...? :-)

cheers,
hvr

