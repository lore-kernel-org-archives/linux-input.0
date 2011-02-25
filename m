From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 3/4] input - wacom : support one finger touch the
 touchscreen way
Date: Fri, 25 Feb 2011 15:44:47 +0100
Message-ID: <20110225144447.GA22165@polaris.bitmath.org>
References: <1297896791-2556-1-git-send-email-pinglinux@gmail.com>
 <20110220122159.GA1720@polaris.bitmath.org>
 <AANLkTikKiZeKcWCGgZ5ZADpA-odXuLP1yDk4847cjuN=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:44043 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754445Ab1BYOpR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Feb 2011 09:45:17 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikKiZeKcWCGgZ5ZADpA-odXuLP1yDk4847cjuN=@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

> touch_down represents the touch status that the driver gets/sets, not the
> actual touch down. Driver touch down (touch_down) is decided by both the
> actual touch and pen status, while it won't be changed by actual touch
> status when pen is in.

Understood, but it hides complex state transitions and therefore
becomes error prone. I believe your code is correct, but less
maintainable than it could be. I would like to take the opportunity to
express that here, with the following argument.

Let us assume we have two variables, A and B, representing the actual
touch and pen down. We can then try to write down the boolean function
for when touch and pen events should not be sent. Starting out simple,
we could try, for an arbitrary time step n,

inhibit_touch(n) = T(A(n), B(n))
inhibit_pen(n) = P(A(n), B(n))

Now, you already stated that this does not work very well, because if
B changes state, for instance, and inhibit_touch changes state at the
same time, we get a race for the pointer events. So, expanding on
this, we could take history into account and try

inhibit_touch(n) = T(A(n), B(n), A(n-1), B(n-1))
inhibit_pen(n) = P(A(n), B(n), A(n-1), B(n-1))

This seems like it could work, since we can detect the state change
and decide how to deal with the pointer events by choosing the
functions T and P appropriately.

The point of all this is that code using simple input variables (A, B)
and a complex boolean function (T, P) has no hidden error
states. Conversely, code using complex input variables and a simple
boolean function may contain an arbitrary number of hidden error
states. As time goes by, those error states may be enabled by accident
during a code change. Sure, both approaches lead to correct code if
performed properly, but the former is less error prone and therefore
easier to maintain.

Henrik
