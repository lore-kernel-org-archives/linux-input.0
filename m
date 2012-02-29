From: Eric Paris <eparis@parisplace.org>
Subject: Logitech MX5500 Bluetooth mouse middle 'button' does not work
Date: Wed, 29 Feb 2012 16:00:40 -0500
Message-ID: <CACLa4pukyDgXeqJ=e7-b+FKw88O32g02zob0R1T9JR1VvR+2mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44947 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab2B2VAl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Feb 2012 16:00:41 -0500
Received: by vcqp1 with SMTP id p1so3745220vcq.19
        for <linux-input@vger.kernel.org>; Wed, 29 Feb 2012 13:00:41 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I'm running an up2date version of Fedora 16 (I am completely input
clueless so have no idea what might be relevant, please tell me what I
can supply).

kernel-3.2.7-1.fc16.x86_64
xorg-x11-server-common-1.11.4-1.fc16.x86_64

I just got a new Logitech MX5500 bluetooth keyboard mouse combo.  I
had no problem at all getting them recognized and connected using the
built in bluetooth on my Lenovo X200 laptop.  My problem is with the
middle mouse 'button.'  On all of my other mice clicking the scroll
wheel acted as a middle button.  On this new mouse it makes a noise
like a 'click' but it doesn't do anything.  I launched evtest and see
events for everything on the mouse (it has a thumb scroll whell, extra
buttons, all sorts of stuff) but it gives no event for 'click'ing the
scroll wheel. (I do see events for scrolling the scroll wheel)

So, what can I do, try, collect, give, test, code, whatever to figure
out if my mouse just wasn't supposed to have have a middle mouse click
(aka return this PoS because I need fast cut and paste).  Figure out
if just this one particular mouse has a broken button (aka replace
this mouse) or if really it's a driver problem.  Any help would be
greatly appreciated!

-Eric
