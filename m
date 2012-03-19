From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH V1] input: keyboard: gpio: Support for interrupt only
 key
Date: Mon, 19 Mar 2012 12:54:21 +0530
Message-ID: <4F66DF25.9000909@nvidia.com>
References: <1331715123-15099-1-git-send-email-ldewangan@nvidia.com> <20120314160011.GA12987@core.coreip.homeip.net> <20120319060610.GA8835@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:18111 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab2CSH3v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 03:29:51 -0400
In-Reply-To: <20120319060610.GA8835@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linus.walleij@stericsson.com" <linus.walleij@stericsson.com>, "david@protonic.nl" <david@protonic.nl>, "tklauser@distanz.ch" <tklauser@distanz.ch>, "alexander.stein@informatik.tu-chemnitz.de" <alexander.stein@informatik.tu-chemnitz.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dmitry,

On Monday 19 March 2012 11:36 AM, Dmitry Torokhov wrote:
>
> OK, so I am generally happy with the patch; the only issue is that in
> interrupt mode the only event type that makes sense is EV_KEY so we need
> to make sure we do not accept anything else.
>

Thanks for taking care of patch. I am ok with this policy.

> Also, I do not think that having button_irq() that is called all the
> time is the best solution; I;d rather pulled RQ number up into button
> data.
>

Yes, this is nice cleanups.

> I tried doing the above in the patch below. Please let me know if it
> still works for you. Note that it depends on some other patches for
> gpio_keys that I have; I am attaching them for your reference.
>

This works fine with one small change.
The function gpio_keys_report_event() is gettign called from probe for 
initialing the key state. This function should bypass if it is not the 
gpio based otherwise system crash.
I made following change and after that it works fine.

static void gpio_keys_report_event(struct gpio_button_data *bdata)
{
     const struct gpio_keys_button *button = bdata->button;
     struct input_dev *input = bdata->input;
     unsigned int type = button->type ?: EV_KEY;
     int state;

     if (!gpio_is_valid(button->gpio))
         return;

     state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ 
button->active_low;


