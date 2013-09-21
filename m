From: Andrey Moiseev <o2g.org.ru@gmail.com>
Subject: Input: 8042 - only one i8042_filter
Date: Sat, 21 Sep 2013 10:48:21 +0400
Message-ID: <CABWXVkNeZ4_UjFsMGyzU9HhR1NRbzs7qXkBj5q6R8FMzCKQ5zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36764 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab3IUGsW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Sep 2013 02:48:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Is it ok that in /drivers/input/serio/i8042.c it's allowed to install
only one i8042_filter? Theoretically, there may be several different
devices that need their drivers to install i8042_filter, to eat out
some device-specific subset of scancodes. Shouldn't that single
pointer to the i8042_filter be replaced by a list, for example?
