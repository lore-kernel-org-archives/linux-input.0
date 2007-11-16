From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH,RFC] Input: gpio-keys - request and configure GPIOs
Date: Fri, 16 Nov 2007 08:38:11 -0500
Message-ID: <d120d5000711160538u6f629e34h9465a880f09be49c@mail.gmail.com>
References: <1195212830-9137-1-git-send-email-hvr@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:38696 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbXKPNiO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2007 08:38:14 -0500
Received: by nf-out-0910.google.com with SMTP id g13so820556nfb
        for <linux-input@vger.kernel.org>; Fri, 16 Nov 2007 05:38:12 -0800 (PST)
In-Reply-To: <1195212830-9137-1-git-send-email-hvr@gnu.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Herbert Valerio Riedel <hvr@gnu.org>
Cc: linux-input@vger.kernel.org, Paul Sokolovsky <pmiscml@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Philip Blundell <philb@gnu.org>

Hi,

On Nov 16, 2007 6:33 AM, Herbert Valerio Riedel <hvr@gnu.org> wrote:
> Currently, gpio_keys.c assumes the GPIOs to be already properly configured;
> this patch changes gpio-keys to perform explicit calls to gpio_request() and
> gpio_configure_input().
>
> This matches the behaviour of leds-gpio.
>

Makes sense from where I sit but let's see what guys who actually use
the module say... ;)

-- 
Dmitry
