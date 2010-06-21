From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 0/7] elantech: various improvements for 6-byte protocol
Date: Mon, 21 Jun 2010 22:59:28 +0200
Message-ID: <4C1FD2B0.1080504@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:36563 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758257Ab0FUVH7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 17:07:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Florian Ragwitz <rafl@debian.org>

Hello,

Following the better understanding of the 6-byte protocol for the
elantech touchpad by reading the Dell/Ubuntu driver, here comes a series
of patches. It should bring support for more or less all the features
supported by the hardware.

All the patches have been tested with my elantech touchpad reporting
firmware version 2.8.1, and with nothing else. Hopefully, more people
can test and confirm it works fine with them (any other firmware version
is useful to test, including hardware vesrion 1).

The first two patches are unmodified from the one sent 3 weeks ago. I
haven't added yet the MT support with the MT protocol, but it should be
very easy, and will try to do it soon.

It's against 2.6.35-rc3. Dmitry, would it be possible to have them as
2.6.36 merge window material? Hopefully we can catch all the potential
regressions during 2.6.36 development.

Cheers,
Eric
