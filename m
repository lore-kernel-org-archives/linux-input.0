From: Melchior FRANZ <melchior.franz@gmail.com>
Subject: Re: [BUG?] hid-core.c: hid->name = dev->manufacturer + dev->product ... why not + dev->serial?
Date: Tue, 9 Mar 2010 19:52:40 +0100
Message-ID: <201003091952.40853@rk-nord.at>
References: <201003071655.06644@rk-nord.at> <201003091342.20273@rk-nord.at> <20100309184127.GE19814@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from warsl404pip6.highway.telekom.at ([195.3.96.89]:53697 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755526Ab0CISwl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 13:52:41 -0500
In-Reply-To: <20100309184127.GE19814@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Dima Zavin <dmitriyz@google.com>, Jonathan Cameron <jic23@cam.ac.uk>, LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amit.kucheria@verdurent.com>, Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>, linux-iio@vger.kernel.org

* Dmitry Torokhov -- Tuesday 09 March 2010:
> Have you considered the fact that maybe you not using the right interface?

No. Because I'm not talking about *writing* an application, but about
*using* applications written by others. The producer of my two BU0836A
knows that the devices are different, I know that they are different,
the kernel knows that they are different, but the applications don't
know that, because the kernel doesn't tell them (via JSIOCGNAME).



> You need to work with guys at linux-iio@vger.kernel.org (which stands
> for Industrial I/O which is exactly what you are working with).

Hmm, then I wonder why the joystick names are different on Windows and
Linux already.  :-}
 
  unpatched Linux:  "Leo Bodnar BU0836A Interface"
  (Vista?) Windows: "BU0836A Interface" (not even the manufacturer ... pff)

Oh, well. Forget it. I'll just distribute the patch, then. I didn't have
much hope, anyway.

m.
