From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: ADXL34X orientation definition
Date: Sat, 7 Dec 2013 01:53:36 -0800
Message-ID: <20131207095335.GA10573@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:50899 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab3LGJxl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Dec 2013 04:53:41 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so2492094pbc.29
        for <linux-input@vger.kernel.org>; Sat, 07 Dec 2013 01:53:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org

Hi Michael,

I was going though Coverity reports and it looks like definition of

#define ADXL346_2D_ORIENT(x)            (((x) & 0x3) >> 4)

is not correct as it will always evaluate to 0. Should the mask be 0x30
instead?

Thanks.

-- 
Dmitry
