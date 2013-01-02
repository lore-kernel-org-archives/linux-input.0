From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: How to identify a gpio-keys-polled input device from userspace?
Date: Wed, 2 Jan 2013 11:43:55 +0100
Message-ID: <CAH9NwWdbKePDUGHp1yxxxZ0sRU_GJ8x_pSHsd5ULZNOZtPxCNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:54557 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab3ABKoQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jan 2013 05:44:16 -0500
Received: by mail-vc0-f180.google.com with SMTP id p16so13862733vcq.25
        for <linux-input@vger.kernel.org>; Wed, 02 Jan 2013 02:44:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all...

I am running in a small problem right now. I need to identify the
reset button from userspace on different boards.

I thought that I could iterate over all /dev/input/eventX devices and
use some ioctl magic to get the correct one.

        char name[256] = "Unknown";
        ioctl(inputdev->handle(), EVIOCGNAME(sizeof(name)), name);

Returns gpio-keys-polled... looks fine, but I have more then 1 button.

In my out-of-tree platform-glue-driver I have this:

static struct gpio_keys_button bpc600_gpio_keys[] = {
        {
                .code = BTN_EXTRA, /* See include/linux/input.h */
                .gpio = 12,
                .active_low = 1,
                .desc = "reset",
                .wakeup = 0,
        },
};

Is there a way to get desc value from userspace?

thanks
--
Christian Gmeiner, MSc
