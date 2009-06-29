From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: min/max and actual values on absolute axes
Date: Tue, 30 Jun 2009 09:42:58 +1000
Message-ID: <20090629234258.GA30771@dingo.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:61464 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760381AbZF3AG7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 20:06:59 -0400
Received: from leo.clearchain.com (localhost [127.0.0.1])
	by mail.clearchain.com (8.14.3/8.14.3) with ESMTP id n5TNhQ00053127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2009 09:13:26 +0930 (CST)
	(envelope-from peter.hutterer@who-t.net)
Received: (from whot@localhost)
	by leo.clearchain.com (8.14.3/8.14.3/Submit) id n5TNhQlL053126
	for linux-input@vger.kernel.org; Tue, 30 Jun 2009 09:13:26 +0930 (CST)
	(envelope-from peter.hutterer@who-t.net)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi guys,

A question regarding min/max values on absolute axes of input devices. I
have a few bugreports related to the synaptics driver and the trigger for
the bug are coordinates outside the min/max range.

Example evtest output: http://bugs.freedesktop.org/attachment.cgi?id=27229

 Event type 3 (Absolute)
    Event code 0 (X)
      Value   6044
      Min     1472
      Max     5472
    Event code 1 (Y)
      Value   1261
      Min     1408
      Max     4448


>From Documentation/input/input-programming:
"This setting would be appropriate for a joystick X axis, with the minimum of
0, maximum of 255 (which the joystick *must* be able to reach, no problem if
it sometimes reports more, but it must be able to always reach the min and
max values), [...]"

Do I read this correct that min/max is intended as guideline only and cannot
be relied on for actual coordinate boundaries?

Cheers,
  Peter
