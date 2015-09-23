From: Aleksa Sarai <cyphar@cyphar.com>
Subject: Apple Keyboard (SPI) Driver
Date: Wed, 23 Sep 2015 14:41:04 +1000
Message-ID: <CAOviyajWFvgZqsGXDAoHZN4kWWhKqbL+j-bdGtRXz_xdhmuwmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37359 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbIWElG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2015 00:41:06 -0400
Received: by igbni9 with SMTP id ni9so22031652igb.0
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2015 21:41:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

AFAICS, nobody is working on writing a driver for the MacBook8,1
keyboard (which uses SPI as opposed to USB). Oddly, the vendor ID and
product ID are the same as the USB counterpart. Would it be possible
to port the logic of the hid-apple driver to SPI, or are the two
serial protocols too different to make this a worthwhile activity? In
either case, is there some information on how the hid-apple driver was
written (was the logic from the open source apple driver adapted, or
were they written from scratch?) and if a similar technique could be
applied to creating an SPI driver?

Cheers.

-- 
Aleksa Sarai (cyphar)
www.cyphar.com
