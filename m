From: loody <miloody@gmail.com>
Subject: is it possible to temporarily not let user mode get hid input event
Date: Sun, 23 Feb 2014 00:35:11 +0800
Message-ID: <CANudz+smSLiEtTRC4t7VxzshDAdR6D4E=zYVJHT8xw0w4JiwGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35351 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbaBVQfN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Feb 2014 11:35:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

hi all:
is there any kernel hid module parameter or test program can
temporarily not letting user mode program not receiving hid event?
1. My hid kos are still inserted in.
2. the kernel usb driver is working well; that mean kernel usb driver
still handle interrupt transaction.

I just not want user mode program see the hid event for a while,

Appreciate your kind help in advance,
