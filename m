From: Joey Oravec <joravec@drewtech.com>
Subject: linux raw serio driver 32 byte maximum
Date: Tue, 30 Aug 2011 17:59:49 -0400
Message-ID: <4E5D5D55.5060207@drewtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from drewtech.com ([66.36.241.150]:60885 "EHLO server.drewtech.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab1H3WGn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Aug 2011 18:06:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org

Dmitry -

In serio_raw.c function serio_raw_write() there's a check:

if (count > 32)
    count = 32;

which coerces any call to write a maximum of 32 bytes. Do you know why 
this limitation is in the code? Characters get written one-by-one to the 
tty layer so I don't understand why it's there.

I'm not sure which section of the manpage defines write for a serial 
port. In the ordinary case I expected this function to keep transmitting 
until complete or an error occurs. If O_NONBLOCK was specified then I 
might expect EAGAIN. Right now my calling code doesn't expect a 
successful partial write. Do you think this module is doing the right 
thing? Can you comment on what the caller must expect?

-joey
