From: Roland Stigge <stigge@antcom.de>
Subject: gpio_keys_polled.c and DT
Date: Tue, 19 Jun 2012 17:02:03 +0200
Message-ID: <4FE0946B.8030201@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:55933 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742Ab2FSPCF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jun 2012 11:02:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: dgdunix@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

as far as I can see, gpio_keys_polled.c currently doesn't support DT
initialization. Is there a plan in this regard?

Rather than duplicating the respective code from gpio_keys.c, maybe
gpio_keys.c could be changed to support a polled mode also? This way,
gpio_keys_polled.c could be removed.

I could try to do either of those.

Or am I missing sth. here?

Thanks in advance,

Roland
