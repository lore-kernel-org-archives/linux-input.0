From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: More info on the elantech touchpad
Date: Mon, 10 May 2010 22:21:18 +0200
Message-ID: <4BE86ABE.5040400@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:60605 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757192Ab0EJUVV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 16:21:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Ragwitz <rafl@debian.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello,

There is a version apparently developed for the Dell mini 10 of the
elantech driver which brings some light on the versions and the protocol.

It was hidden in some ubuntu git trees [1] (warning, the code hurts the
eyes):
http://zinc.ubuntu.com/git?p=mid-team/hardy-netbook.git;a=blob;f=drivers/input/mouse/elantech.c;h=d0e2cafed162428f72e3654f4dda85e08ea486b3;hb=refs/heads/abi-22

In particular the elantech_init() function is very instructive about the
various available versions.

Hopefully someone can merge this code with the current kernel version,
so we get something that detects automatically most hardware...

See you,
Eric

[1] kudos to Bastien Nocera for spotting it out:
http://www.hadess.net/2009/05/dell-mini-10-gah.html
