From: =?UTF-8?B?0KHQtdGA0LPQtdC5INCR0LXQu9GP0YjQvtCy?=
	<sergey.belyashov@gmail.com>
Subject: Force feedback (axis information)
Date: Wed, 6 May 2009 22:42:07 +0400
Message-ID: <bb829a0b0905061142k7fd5e384h4a39c516e4084dc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:2735 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbZEFSmI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2009 14:42:08 -0400
Received: by ey-out-2122.google.com with SMTP id 9so121771eyd.37
        for <linux-input@vger.kernel.org>; Wed, 06 May 2009 11:42:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello
   I look code of ff-utils (fftest.c) and found that this program
checks axis information for FF effects. For example, if kernel
provides an ABS_X (also supported ABS_Y and ABS_WHEEL) via
EVIOCGBIT(EV_FF, ...), then fftest shows "Axes query: Axis X". But I
cannot found this feature in any existing driver. Moreover,
documentation does not contain any information about it. So, is it
really neccessary feature (I think yes)?
   I am ready to create autocenter support patch for Logitech Force 3D
Pro (046d:c286). But all tested by me Logitech Joysticks with FF has
support for autocentering in same way. May be it is good idea to add
this feature for all joysticks in hid-lgff.c? If some joystick do not
support it (users reported), then it is possible to exclude
autocentering for this joystick later.

Best regards,
Sergey Belyashov
