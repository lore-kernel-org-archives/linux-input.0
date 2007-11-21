From: Herbert Valerio Riedel <hvr@gnu.org>
Subject: Re: [PATCH,RFC] Input: gpio-keys - request and configure GPIOs
Date: Wed, 21 Nov 2007 18:13:01 +0100
Message-ID: <1195665182.18471.12.camel@pbook.intra>
References: <1195212830-9137-1-git-send-email-hvr@gnu.org>
	 <d120d5000711160538u6f629e34h9465a880f09be49c@mail.gmail.com>
	 <1195222151.10848.47.camel@pbook.intra>
	 <74d0deb30711160619s2e4acd2ex31238dad34a6ae6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx02.kabsi.at ([62.40.128.130]:42985 "EHLO mx02.kabsi.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbXKUSkL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2007 13:40:11 -0500
In-Reply-To: <74d0deb30711160619s2e4acd2ex31238dad34a6ae6d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Paul Sokolovsky <pmiscml@gmail.com>, Philip Blundell <philb@gnu.org>


On Fri, 2007-11-16 at 15:19 +0100, pHilipp Zabel wrote:
> > > On Nov 16, 2007 6:33 AM, Herbert Valerio Riedel <hvr@gnu.org> wrote:
> > > > Currently, gpio_keys.c assumes the GPIOs to be already properly configured;
> > > > this patch changes gpio-keys to perform explicit calls to gpio_request() and
> > > > gpio_configure_input().
> > > >
> > > > This matches the behaviour of leds-gpio.

> > > Makes sense from where I sit but let's see what guys who actually use
> > > the module say... ;)

[..]

> We have quite a big number of users in the handhelds.org CVS kernel tree.

> Unfortunately we are traditionally slow at pushing things to mainline, and many
> of the devices depend on something like gpiolib hitting mainline for their GPIO
> extenders.

well, is there any chance this patch of mine might make it for 2.6.25?
(or maybe even 2.6.24, since it can be regarded as being an actual
fix...?) :-)

regards,
hvr

