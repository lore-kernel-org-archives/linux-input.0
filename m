From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: 8042 - only one i8042_filter
Date: Sat, 21 Sep 2013 19:04:43 -0700
Message-ID: <20130922020443.GA30148@core.coreip.homeip.net>
References: <CABWXVkNeZ4_UjFsMGyzU9HhR1NRbzs7qXkBj5q6R8FMzCKQ5zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:56223 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab3IWDvl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Sep 2013 23:51:41 -0400
Content-Disposition: inline
In-Reply-To: <CABWXVkNeZ4_UjFsMGyzU9HhR1NRbzs7qXkBj5q6R8FMzCKQ5zg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Moiseev <o2g.org.ru@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Andrey,

On Sat, Sep 21, 2013 at 10:48:21AM +0400, Andrey Moiseev wrote:
> Is it ok that in /drivers/input/serio/i8042.c it's allowed to install
> only one i8042_filter? Theoretically, there may be several different
> devices that need their drivers to install i8042_filter, to eat out
> some device-specific subset of scancodes. Shouldn't that single
> pointer to the i8042_filter be replaced by a list, for example?

The expectation that there will be a single platform specific driver
living in drivers/platform/x86/... that will install platform specific
filter and will do all necessary processing. So far there was no need
for more than one filter.

Thanks.

-- 
Dmitry
