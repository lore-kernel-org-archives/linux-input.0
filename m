From: Florian Echtler <floe@butterbrot.org>
Subject: Preferred way for a multitouch driver?
Date: Sun, 11 Apr 2010 18:41:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004111828030.29274@butterbrot.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:41631
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab0DKQkG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Apr 2010 12:40:06 -0400
Received: from localhost (unknown [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by butterbrot.org (Postfix) with ESMTPS id A855815407A
	for <linux-input@vger.kernel.org>; Sun, 11 Apr 2010 18:41:04 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello everyone,

I've just bought a Lenovo S10-3t convertible netbook, and now I'm 
experimenting with the "multitouch" screen (dual-touch, rather). It's 
being recognized as a HID device, and using hid-device-dump, I can nicely 
read the reports of both fingers. There's also some hacks floating around 
which use xf86-input-hidtouch, but AFAICT that doesn't do any kind of 
multitouch.

>From lurking here on the list, I've gathered that the evdev interface by 
now fully supports all kinds of multitouch events, so I guess the 
preferred way would be a hiddev-to-evdev bridge of some kind, right?

Can somebody point me into the right direction, e.g. to some other driver 
which also works that way?

Many thanks,
Florian
-- 
"_Nothing_ brightens up my morning. Coffee simply provides a shade of
grey just above the pitch-black of the infinite depths of the _abyss_."
