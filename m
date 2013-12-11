From: Paul Cercueil <pcercuei@gmail.com>
Subject: kernel panic on gpio-keys
Date: Wed, 11 Dec 2013 20:17:29 +0100
Message-ID: <52A8BA49.7080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44383 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab3LKTRd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Dec 2013 14:17:33 -0500
Received: by mail-wi0-f172.google.com with SMTP id en1so7571562wid.17
        for <linux-input@vger.kernel.org>; Wed, 11 Dec 2013 11:17:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

Hi there,

I am trying to use the gpio-keys driver to inject joystick events.
There seems to be some basic support of it, looking at <linux/gpio_keys.h>.

However, registering the following will trigger a kernel panic in the 
kernel:

static struct gpio_keys_button my_buttons[] {
	{
		.gpio = GPIO_FOO,
		.type = EV_ABS,
		.code = ABS_HAT0X,
		.value = 1,
	},
};

(tested on kernel 3.12).

I don't know well the input subsystem, so I have no idea of what is 
going wrong. Could anybody try to at least reproduce the issue?

Regards.
