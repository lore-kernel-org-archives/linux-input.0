From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [Question: Drivers/input/evdev.c] How to get instance of struct evdev
 in some driver ?
Date: Sun, 3 Aug 2014 12:05:11 +0530
Message-ID: <CADYu30-RSdvCmtyn0NmZ4weDsgqhcieV86s9+7OTVJOQEQiSpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:50320 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaHCGfN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Aug 2014 02:35:13 -0400
Received: by mail-la0-f53.google.com with SMTP id gl10so4478532lab.12
        for <linux-input@vger.kernel.org>; Sat, 02 Aug 2014 23:35:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dear Mr. Torokhov and Linux-Input Community,
Greetings of the day !! :)

I am stuck at one point and could not find the solution over internet.
Can you please help in answering my query below:

As you know, struct evdev is defined in evdev.c and not in some header file.
So, Is it possible to get instance of struct evdev in some input
peripheral driver ?
If possible, then how can we get it ?

In the input peripheral driver,
we can get instance struct input_dev by including input.h file
and then calling input_allocate_device().
struct input_dev = input_allocate_device();

May be evdev is embedded somewhere in input_dev.
So, can we get the instance of evdev using input_dev ?

Thanks in Advance !

-- Aniroop Mathur
