From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Wayland and the keyboard
Date: Sat, 6 Nov 2010 17:51:30 -0400
Message-ID: <AANLkTi=HvyGL7DKw=+uGDowirY9sw0mnkng8FL1H4Vh-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43249 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab0KFVvd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 17:51:33 -0400
Received: by wwb39 with SMTP id 39so2610903wwb.1
        for <linux-input@vger.kernel.org>; Sat, 06 Nov 2010 14:51:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: krh@redhat.com, linux-input@vger.kernel.org

Wayland presents and opportunity to ditch xkeys. What do you think
about having Wayland apps use the kernel keysyms and drop the whole
legacy xkey world? Of course we would keep that library around for
legacy purposes.

We have a opportunity here to redesign the keymap system for direct
Wayland apps and not repeat the legacy problems from X. Clearly there
is more to this than just using scan codes out of the kernel. I'm no
expert on keymapping but I'll try and get the discussion started.

There's some discussion here about the deficiencies in X keyboard handling...
http://www.freedesktop.org/wiki/Software/LibXklavier

-- 
Jon Smirl
jonsmirl@gmail.com
