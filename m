From: Hans de Goede <hdegoede@redhat.com>
Subject: Status of the plan to set i8042.nomux=1 by default ?
Date: Wed, 10 Sep 2014 20:10:09 +0200
Message-ID: <54109401.4000809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770AbaIJSKN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 14:10:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-usb <linux-input@vger.kernel.org>

Hi Dmitry,

I wonder what the status of $subject is ?

I'm asking because a user joined the discussion here:
https://bugzilla.kernel.org/show_bug.cgi?id=77391

And I ended up debugging his problem a bit, and his laptop
needs i8042.nomux=1 .

I've asked him for dmi strings for adding a quirk, but as discussed
a while back, it may be better to just flip the default.

###

Note the bug itself is about an unrelated issue, the user added a
me too comment while he clearly has a completely different issue.

Not sure if I've already brought the issue the bug is about up,
I've a proof of concept patch for working around it here:

http://git.linuxtv.org/cgit.cgi/hgoede/gspca.git/log/?h=input-work

The "psmouse: Add support for detecting FocalTech PS/2 touchpads"
commit explains it if you're curious. Or you can just wait for me to
actually get the patch to work (it still does not work for some
reason), and then I'll post it to the list :)

Regards,

Hans
