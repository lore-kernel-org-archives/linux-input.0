From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH,RFC] Input: gpio-keys - request and configure GPIOs
Date: Wed, 21 Nov 2007 14:44:07 -0500
Message-ID: <d120d5000711211144tdba04acq7c1100c6f2921b87@mail.gmail.com>
References: <1195212830-9137-1-git-send-email-hvr@gnu.org>
	 <d120d5000711160538u6f629e34h9465a880f09be49c@mail.gmail.com>
	 <1195222151.10848.47.camel@pbook.intra>
	 <74d0deb30711160619s2e4acd2ex31238dad34a6ae6d@mail.gmail.com>
	 <1195665182.18471.12.camel@pbook.intra>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:29072 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbXKUToK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2007 14:44:10 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1510741wra
        for <linux-input@vger.kernel.org>; Wed, 21 Nov 2007 11:44:09 -0800 (PST)
In-Reply-To: <1195665182.18471.12.camel@pbook.intra>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Herbert Valerio Riedel <hvr@gnu.org>
Cc: pHilipp Zabel <philipp.zabel@gmail.com>, linux-input@vger.kernel.org, Paul Sokolovsky <pmiscml@gmail.com>, Philip Blundell <philb@gnu.org>

On Nov 21, 2007 12:13 PM, Herbert Valerio Riedel <hvr@gnu.org> wrote:
>
> On Fri, 2007-11-16 at 15:19 +0100, pHilipp Zabel wrote:
> > > > On Nov 16, 2007 6:33 AM, Herbert Valerio Riedel <hvr@gnu.org> wrote:
> > > > > Currently, gpio_keys.c assumes the GPIOs to be already properly configured;
> > > > > this patch changes gpio-keys to perform explicit calls to gpio_request() and
> > > > > gpio_configure_input().
> > > > >
> > > > > This matches the behaviour of leds-gpio.
>
> > > > Makes sense from where I sit but let's see what guys who actually use
> > > > the module say... ;)
>
> [..]
>
> > We have quite a big number of users in the handhelds.org CVS kernel tree.
>
> > Unfortunately we are traditionally slow at pushing things to mainline, and many
> > of the devices depend on something like gpiolib hitting mainline for their GPIO
> > extenders.
>
> well, is there any chance this patch of mine might make it for 2.6.25?
> (or maybe even 2.6.24, since it can be regarded as being an actual
> fix...?) :-)
>

There is a slight one ;)

Applied to the "for-linus" branch of my tree. Thank you.

-- 
Dmitry
