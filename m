From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: ABS_PRESSURE and 0 ranges
Date: Thu, 25 Oct 2012 14:59:49 +0200
Message-ID: <2119530.D54ZbrWB3u@devpool02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:44219 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab2JYM6i (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 08:58:38 -0400
Received: from unknown ([::ffff:80.150.94.234]:59270 HELO devpool02.localnet) (auth=eike@sf-mail.de)
	by mail.sf-mail.de (Qsmtpd 0.22svn) with (DHE-RSA-AES256-SHA encrypted) ESMTPSA
	for <linux-input@vger.kernel.org>; Thu, 25 Oct 2012 14:58:35 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

as I found out the hard way tslib does the detection if a touchscreen has been 
"clicked" if the kernel driver says it does not support ABS_PRESSURE. But when 
the kernel says it can do ABS_PRESSURE tslib will not do it's emulation and 
just pass on whatever pressure value the kernel sends.

So far, so good. Sadly there are some drivers that do:

input_set_abs_params(dev, ABS_PRESSURE, 0, 0, 0, 0);

Guess what happens: no clicks at all. The question I have is: does the above 
line make any sense to be in a kernel driver at all? Or is that some voodoo 
that must be there and it's all tslib fault?

Now that I know where the problem is coming from the problem is easily 
fixable, I'm just wondering which patch to make.

Greetings,

Eike
