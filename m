From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
 IR 	system?
Date: Sat, 28 Nov 2009 19:17:56 +0100
Message-ID: <4B116954.5050706@s5r6.in-berlin.de>
References: <m3r5riy7py.fsf@intrepid.localdomain> <BDkdITRHqgB@lirc> <9e4733910911280906if1191a1jd3d055e8b781e45c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:47981 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZK1SSO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Nov 2009 13:18:14 -0500
In-Reply-To: <9e4733910911280906if1191a1jd3d055e8b781e45c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Christoph Bartelmus <lirc@bartelmus.de>, khc@pm.waw.pl, awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, maximlevitsky@gmail.com, mchehab@redhat.com, superm1@ubuntu.com

Jon Smirl wrote:
> There are two very basic things that we need to reach consensus on first.
> 
> 1) Unification with mouse/keyboard in evdev - put IR on equal footing.
> 2) Specific tools (xmodmap, setkeycodes, etc or the LIRC ones) or
> generic tools (ls, mkdir, echo) for configuration

About 2:  If at all, there only needs to be a decision about pulse/space
to scancode converter configuration.  In contrast, scancode to keycode
converter configuration is already solved; the interface is
EVIOCSKEYCODE.  If you find the EVIOCSKEYCODE interface lacking, extend
it or submit an alternative --- but this does not affect LIRC and
whether to merge it in any way.

PS:  Drop your "specific vs. generic tools" terminology already.  Your
configfs based proposal requires "specific" tools as well, it's just
that they can be implemented in bash, among else.
-- 
Stefan Richter
-=====-==--= =-== ===--
http://arcgraph.de/sr/
