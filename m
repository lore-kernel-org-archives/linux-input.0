From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: How to unset CONFIG_SERIO_I8042 on x86?
Date: Mon, 15 Jun 2009 08:53:11 -0700
Message-ID: <4A366E67.4040300@oracle.com>
References: <1244915236.3288.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:23905 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZFOP44 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2009 11:56:56 -0400
In-Reply-To: <1244915236.3288.7.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thomas Meyer wrote:
> Is it possible? Does it make sense?

Enabled CONFIG_EMBEDDED, then disable KEYBOARD_ATKBD and
disable MOUSE_PS2, then you can disable SERIO_I8042.


Is the Macbook all USB for input devices?


> I always get this message at boot up on my macbook pro:
> 
> [    0.929828] PNP: No PS/2 controller found. Probing ports directly.
> [    0.930761] i8042.c: No controller found.
> [    0.931038] mice: PS/2 mouse device common for all mice
> 
> Or please make these messages warnings only, so I don't see them with
> kernel option quiet.


-- 
~Randy
LPC 2009, Sept. 23-25, Portland, Oregon
http://linuxplumbersconf.org/2009/
