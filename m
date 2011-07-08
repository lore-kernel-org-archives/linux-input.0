From: "H. Peter Anvin" <hpa@zytor.com>
Subject: INPUT_COMPAT_TEST
Date: Fri, 08 Jul 2011 11:45:35 -0700
Message-ID: <4E17504F.5070806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:32872 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548Ab1GHSpq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Jul 2011 14:45:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philip Langdale <philipl@overt.org>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>

Hello,

I'm trying to figure out what system calls can actually invoke code that
depends on INPUT_COMPAT_TEST, and in particular which of those changes
actually matter.

The input system and seccomp are the *only* arch-neutral subsystem in
Linux which appear to trigger on if we are in compat mode, and this is
causing some serious consternation in trying to freeze the proposed x32
(32-bit x86-64) ABI.

I would really like to understand if that dependency can be eliminated
or mitigated; as it currently sits we may need an entirely separate
system call table *just to support the input system*.

The problem is that I am personally not familiar enough with the input
subsystem to know what the dependencies are.  ioctls are not an issue;
there is already an entire infrastructure to handle compatibility ioctls
(and that infrastructure should be used!), but it looks like input also
does things like change the format(?!) of sysfs entries, all of which
makes me very concerned.

Any help in creating an inventory for this would be appreciated.

	-hpa
