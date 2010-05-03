From: Dan Carpenter <error27@gmail.com>
Subject: Re: [Bug 15893] Alps: No edge-scrolling since 2.6.34-rc5
Date: Tue, 4 May 2010 00:06:06 +0200
Message-ID: <20100503220606.GP29093@bicker>
References: <bug-15893-5697@https.bugzilla.kernel.org/> <201005032116.o43LGcXi010308@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:59593 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab0ECWGS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 May 2010 18:06:18 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1273024fga.1
        for <linux-input@vger.kernel.org>; Mon, 03 May 2010 15:06:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201005032116.o43LGcXi010308@demeter.kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: f.zweig@yahoo.de, chase.douglas@canonical.com, Dmitry Torokhov <dtor@mail.ru>

It looks like the "Acer Aspire One 532h" and the "HP Pavilion dm3" 
have the same signature but they behave differently.

As a result commit 5e28d8eb68 "Input: ALPS - add signature for HP 
Pavilion dm3 laptops" fixes things for dm3 but breaks the Acer Aspire
One 532h which was working (with a userspace driver maybe??).

Here is the relevant "i8042.debug" output from bz 15893:

drivers/input/serio/i8042.c: d4 -> i8042 (command) [535]
drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [535]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, 1, 12) [535]
drivers/input/serio/i8042.c: 73 <- i8042 (interrupt, 1, 12) [536]
drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, 1, 12) [536]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 1, 12) [536]

What's the right way to handle this?

regards,
dan carpenter
