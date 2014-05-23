From: Prajosh Premdas <premdas.prajosh@gmail.com>
Subject: Additional driver for USB touch support
Date: Fri, 23 May 2014 12:55:58 +0200
Message-ID: <CAAFf3B-1-G9e8+2Ci1MWf2OJfXCWk38e50nOA3piTpAQLM-J7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:60488 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbaEWKz6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 May 2014 06:55:58 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so6031577veb.12
        for <linux-input@vger.kernel.org>; Fri, 23 May 2014 03:55:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: daniel.ritz@gmx.ch, linux-input@vger.kernel.org, rydberg@euromail.se

Hi

I have some USB based touch controllers. These controllers are working
well using the hid_multitouch driver.

I would also like to add some additional protocol support for
diagnostics and re calibration. I am using the touch interface for the
same, whereby the control endpoint is used to send the request and
digitizer end point is used to get the response. (it is a legacy
design so i cannot change it)

My plan is to add the additional driver support to this file
drivers/input/touchscreen/usbtouchscreen.c and disable the default
support for the hid_multitouch by making an entry in the hid-blacklist
array in this file drivers/hid/usbhid/hid-quirks.c

Is there a better idea than this?

-- 
Regards,

Prajosh Premdas
