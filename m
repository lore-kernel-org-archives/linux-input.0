From: ScotX <shcsottrxw@yahoo.com>
Subject: comprehension for non-programmers: evdev, uTouch, Multi-Touch
Date: Tue, 24 Sep 2013 23:16:33 +0100 (BST)
Message-ID: <1380060993.17074.YahooMailBasic@web172501.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm11.bullet.mail.ird.yahoo.com ([77.238.189.64]:47381 "EHLO
	nm11.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754976Ab3IXWXK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Sep 2013 18:23:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi everybody,

if you have a look at this diagram of the Linux graphics stack [1] can somebody point out, how uTouch respectively multi-touch is build up?
Is it a user-space component like libdrm that talks to the kernel-module evdev? Is it a kernel module?

I also created some other diagrams as well [2]. //Obviously I am not a programmer//, I'd simply like to better comprehend the software I am running (or will be running in the future).

I would like to get a better grasp of the handling of touchscreens nonetheless. No, I do not have a touchscreen.
I read about Wayland, recreated the entire Mesa 3D article and wrote about the free and open-source graphics drivers [3]. What about the INPUT?

While I am at it, I would also like to query, whether there is some API for the INPUT, analogue to OpenGL for rendering acceleration or OpenAL for sound. SDL?

Regards,
ScotXW

[1] https://commons.wikimedia.org/wiki/File:Linux_Graphics_Stack_2013.svg
[2] https://commons.wikimedia.org/wiki/User:ScotXW
[3] https://en.wikipedia.org/wiki/Free_and_open-source_device_drivers:_graphics
