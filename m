From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: serial touchscreen and inputattach
Date: Sun, 15 Jun 2008 21:01:09 +0200
Message-ID: <200806152101.10156.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:37679 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYFOTBP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Jun 2008 15:01:15 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4824CDFEB272
	for <linux-input@vger.kernel.org>; Sun, 15 Jun 2008 21:01:14 +0200 (CEST)
Received: from [91.19.29.124] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1K7xTW-0008Bs-00
	for linux-input@vger.kernel.org; Sun, 15 Jun 2008 21:01:14 +0200
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm currently working on a serial touchscreen driver and have some questions.

What's the rule for creating a new name for serio protocol in serio.h for use
in serio_device_id.proto and input_dev.id.vendor? Can I just take a free
number? I guess then I should take the next one (currently 0x37 after
SERIO_ZHENHUA), however there are some gaps in the list.

Is there an official version of inputattach? I found different sources. The
last change at [1] is about 2 years ago. At [2] there is a broken CVS link to
[1]. The inputattach tool in buildroot's tslib package is derived from [1] with
some minor changes. The inputattach from Debian's joystick package is derived
from a three years old version of [1], the tool from Gentoo's joystick package
is the same as in [1].

So it seems as if [1] is quite official, because everything is pointing to it.
But there is another inputattach at [3] with a reworked code base, which is
only 1 year old and supports some more devices, mainly touchscreens.

Or is there another preferred way beside inputattach to bind the touchscreen to
its driver and inputattach is obsolete?

[1] http://linuxconsole.cvs.sourceforge.net/linuxconsole/ruby/utils/
[2] http://atrey.karlin.mff.cuni.cz/~vojtech/input/
[3] http://kernel.org/pub/linux/kernel/people/dtor/

Markus

