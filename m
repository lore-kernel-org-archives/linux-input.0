From: simon@mungewell.org
Subject: Re: About the PS3 Sixaxis linux driver
Date: Mon, 4 Nov 2013 16:40:29 -0500
Message-ID: <6ead5599102745d03c2c28b640b11fb4.squirrel@mungewell.org>
References: <526A697E.7050605@corpsmoderne.net>
    <1256411740.1745741.1383597450835.JavaMail.root@redhat.com>
    <20131104221824.2bd181e60f01f41e1e4f4898@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:46533 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab3KDVkd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Nov 2013 16:40:33 -0500
In-Reply-To: <20131104221824.2bd181e60f01f41e1e4f4898@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Benjamin Tissoires <btissoir@redhat.com>, case <case@corpsmoderne.net>, linux-input@vger.kernel.org


> Actually I intended to rewrite the whole HID descriptor and add a sane
> mapping for all the buttons (maybe following the Gamepad API and
> even using the new ABS_ACCEL_* and ABS_GYRO_* events from David
> Hermann).

I think that the root of the problem here is simply the large number of
axis, and that the keycodes start at 'axis-x' then overflow into/past the
MultiTouch keycode.

This problem is going to be a more common one as HID drivers present more
buttons/axis.

We did some patching here:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-sony.c?id=refs/tags/v3.12#n301
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/hid/hid-sony.c?id=61ab44bebdefab296487e7cd723a634849278827

Do we need to fix this is the HID descriptor, or in 'hid-sony' input stuff?

Do you have example of another driver to copy?
Simon



