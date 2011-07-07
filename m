From: =?UTF-8?b?6Z+p5YWD5bSR?= <honyuenkwun@gmail.com>
Subject: Re: [PATCH] HID: uclogic: Add support for UC-Logic WP1062
Date: Thu, 7 Jul 2011 05:41:16 +0000 (UTC)
Message-ID: <iv3gts$91u$1@dough.gmane.org>
References: <1309933421-935-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46619 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826Ab1GGFpH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Jul 2011 01:45:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1QehOb-00063U-Ef
	for linux-input@vger.kernel.org; Thu, 07 Jul 2011 07:45:05 +0200
Received: from 74.67.74.66 ([74.67.74.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 07:45:05 +0200
Received: from honyuenkwun by 74.67.74.66 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 07:45:05 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Wed, 06 Jul 2011 09:23:41 +0300, Nikolai Kondrashov wrote:

> Add support for UC-Logic Tablet WP1062 by fixing its report descriptor.
> 
> This tablet is sold as Monoprice 10X6.25 Inches Graphic Drawing Tablet.


I added quirk for that device (usb id 5543:0064). It was merged in 3.0-
rc4.

http://git.kernel.org/?p=linux/kernel/git/torvalds/
linux-2.6.git;a=commit;h=e23be0a27dcc9297ff0495360d89bc5b0bf12383

Will this way be better? If so, the quirk should probably be backed out.

Jimmy

