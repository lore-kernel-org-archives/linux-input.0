From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] i2c-HID: Delete unnecessary checks before the function
 call "gpiod_put"
Date: Thu, 9 Jul 2015 11:18:52 +0300
Message-ID: <20150709075813.GQ4341@mwanda>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <559D8874.7090407@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:29453 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbbGIIT2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2015 04:19:28 -0400
Content-Disposition: inline
In-Reply-To: <559D8874.7090407@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

This one deserves some extra review because it introduces a call to:

	WARN_ON(extra_checks);

in gpiod_free().  That may or may not matter...

regards,
dan carpenter

