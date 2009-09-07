From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
	series SoCs
Date: Mon, 7 Sep 2009 15:33:41 +0900
Message-ID: <20090907063341.GT3962@prithivi.gnumonks.org>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com> <4AA49C53.3030400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:47414 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbZIGG7G (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 02:59:06 -0400
Content-Disposition: inline
In-Reply-To: <4AA49C53.3030400@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: =?utf-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?utf-8?B?6rmA6rK97J28L0FQ6rCc67Cc7YyAKFNZUy5MU0kpL0UzKOyCrOybkCkv7IK8?= =?utf-8?B?7ISx7KCE7J6Q?= <ki0351.kim@samsung.com>, =?utf-8?B?J+q5gOq1reynhC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FNSjssYXsnoQpLw==?= =?utf-8?B?7IK87ISx7KCE7J6QJw==?= <kgene.kim@samsung.com>, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

On Mon, Sep 07, 2009 at 02:38:27PM +0900, Joonyoung Shim wrote:
> We already implemented and tested the keypad driver for s5pc100 &
> s5pc110 and maybe it will operate on s3c64xx. We use the samsung prefix
> to support three cpu. Because there is no the arch for s5pc100 and
> s5pc110, this driver doesn't compile yet on upstream kernel.

The schedule of System LSI (the department that makes the SoC and provides the
BSP) is to first complete the 6410 support in the mainline kernel, and then
incrementally submit the core architecture code for 6440, c100 and c110,
followed by driver additions.

So the events (ordered by time) have to be in the following order

1) the s3c-keypad driver with 6400/6410 support needs to be submitted and
   submitted mainline.  This is what Jinsun was starting, and which he
   will continue until it is included mainline.

2) the c100 / c110 or other SoC core architecture support needs to be
   submitted mainline.  Nobody at System LSI is working on this yet,
   but they already have a tree based on 2.6.31-rcX for this.  I suppose
   the real work on submitting this will only be started after most of the
   pending 6410 stuff has been submitted.

3) Samsung (either system LSI or DMC) can then send an incremental patch
   for adding 6440/c100/c110 support to the s3c-keypad driver.

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
