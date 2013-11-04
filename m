From: Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: About the PS3 Sixaxis linux driver
Date: Mon, 4 Nov 2013 15:37:30 -0500 (EST)
Message-ID: <1256411740.1745741.1383597450835.JavaMail.root@redhat.com>
References: <526A697E.7050605@corpsmoderne.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:40525 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab3KDUhe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Nov 2013 15:37:34 -0500
In-Reply-To: <526A697E.7050605@corpsmoderne.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: case <case@corpsmoderne.net>
Cc: linux-input@vger.kernel.org

Hi Marc,

(adding in CC the linux-input mailing list)

Regarding your problem I vaguely remember something about not having duplicated axis with the buttons. My memory is rather confuse about this, so I may be wrong (but others on the list may have a fresher memory).
Other than that, if only one axis is not working, then it is definitively a bug...

I'll try to add this to my todo list, but I can not guarantee anything soon. If someone else can confirm and fix this, I'll be happy.

Cheers,
Benjamin

----- Original Message -----
From: "case" <case@corpsmoderne.net>
To: "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
Sent: Friday, October 25, 2013 8:52:14 AM
Subject: About the PS3 Sixaxis linux driver

Hello Benjamin,

I'm mailing you because it seems you're one of the kernel developers
the most involved with the hid-sony.c driver lately, with which I think
I've an issue. If you feel like I'm mailing the wrong person,
I apologize, and would be glad if you could point me to the right
person.

I'm a game developer experimenting with the sixaxis for a while, and
I've a big issue with the current state of the driver:

On the sixaxis all the buttons (except select and start) are mapped
as buttons but also as axis, which is pretty rad. That was working great
in 2010 when I started to experiment with the sixaxis but in more
recent versions of the kernel, one the the buttons has lost his axis.
It's the left button the the D-PAD, witch is only mapped as button 7
(up is button 4 and axis 8, right is button 5 axis 9, bottom is button
6 axis 10).

This is quite inconsistent and makes impossible to rely on the axis for
all the D-PAD buttons.

Again, this bug wasn't there in 2.6.32 . I noticed it for the first time
in 3.5.x . I'm currently running 3.11.0 and this bug is still here.

As my experience with kernel hacking is minimal I'm not even sure
the problem lies in hid-sony, but that's where my investigations lead
me.

Thank you to have taken the time to read my mail, I hope it will help
to fix this issue, and again, sorry if you're not the right person to
write to.

Regards,
-- 
Marc Planard
