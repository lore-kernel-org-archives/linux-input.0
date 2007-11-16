From: "pHilipp Zabel" <philipp.zabel@gmail.com>
Subject: Re: [PATCH,RFC] Input: gpio-keys - request and configure GPIOs
Date: Fri, 16 Nov 2007 15:02:17 +0100
Message-ID: <74d0deb30711160602k3e19a660td5698b395f817a85@mail.gmail.com>
References: <1195212830-9137-1-git-send-email-hvr@gnu.org>
	 <d120d5000711160538u6f629e34h9465a880f09be49c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:26602 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbXKPOCT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2007 09:02:19 -0500
Received: by fk-out-0910.google.com with SMTP id z23so885696fkz
        for <linux-input@vger.kernel.org>; Fri, 16 Nov 2007 06:02:18 -0800 (PST)
In-Reply-To: <d120d5000711160538u6f629e34h9465a880f09be49c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Herbert Valerio Riedel <hvr@gnu.org>, linux-input@vger.kernel.org, Paul Sokolovsky <pmiscml@gmail.com>, Philip Blundell <philb@gnu.org>

On Nov 16, 2007 2:38 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi,
>
> On Nov 16, 2007 6:33 AM, Herbert Valerio Riedel <hvr@gnu.org> wrote:
> > Currently, gpio_keys.c assumes the GPIOs to be already properly configured;
> > this patch changes gpio-keys to perform explicit calls to gpio_request() and
> > gpio_configure_input().
> >
> > This matches the behaviour of leds-gpio.
> >
>
> Makes sense from where I sit but let's see what guys who actually use
> the module say... ;)

Looks good to me, too. I have yet to test, but at least the gpio_direction call
is mandatory as per gpio api docs, so this fixes an actual bug.
gpio_request is optional and claims the GPIO for this driver's use
only (on architectures where
this is supported), so I'm not sure if this is really needed, but it
shouldn't harm any of the current users of gpio-keys.

regards
Philipp
