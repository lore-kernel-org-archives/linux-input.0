From: Andrey Moiseev <o2g.org.ru@gmail.com>
Subject: synaptics: PS/2 touchpad isn't detected if a keyboard key is held
 down on boot
Date: Fri, 6 Dec 2013 21:22:01 +0400
Message-ID: <CABWXVkMdyDNxG3QFOvyx4=6EiJQ5ik9aJxa7jQvtO+UJKwc8Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44577 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756819Ab3LFRWC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Dec 2013 12:22:02 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is an ancient bug, I noticed it since I bought my notebook.
Synaptics PS/2 touchpad is not detected and is not shown in
/dev/input/event* if I hold a keyboard key down when booting just
started.
