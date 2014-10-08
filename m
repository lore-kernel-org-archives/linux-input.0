From: Zachary L <admin@computerquip.com>
Subject: Xbox Controllers: Should hid be used?
Date: Wed, 8 Oct 2014 07:09:40 +0000 (UTC)
Message-ID: <loom.20141008T082724-46@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33063 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492AbaJHHKB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Oct 2014 03:10:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1XblNm-0007cr-JI
	for linux-input@vger.kernel.org; Wed, 08 Oct 2014 09:09:58 +0200
Received: from 99-22-209-106.lightspeed.hstntx.sbcglobal.net ([99.22.209.106])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 08 Oct 2014 09:09:58 +0200
Received: from admin by 99-22-209-106.lightspeed.hstntx.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 08 Oct 2014 09:09:58 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Other 3rd party drivers (and seemingly Microsoft's driver as well) uses HID to 
describe the [any Xbox] controller's features. We can see uses of this in other 
drivers:

TattieBogle - 
http://tattiebogle.net/index.php/ProjectRoot/Xbox360Controller/OsxDriver

XBCD - http://www.redcl0ud.com/xbcd.html

Xpad has avoided the use of the hid subsystem for whatever reason, for over a 
decade now. That said, I don't know of any compelling reason to not avoid it. 
But I did it anyways... I made a small usb driver, implemented a stub 
hid_ll_driver, copied the descriptor from TattieBogle... and it works... sort 
of. 

The button layout is obviously different from what we have now and I cannot get 
the D-pad working using a Hat Switch usage or the D-pad usages to save my life. 

I realize that just because other drivers use HID, doesn't mean I should 
although perhaps there's a compelling reason that I'm missing. Is there any 
worth to this work?

What I have is bare bones but works for (incorrectly mapped, using 
TattieBogle's report descriptor) input: https://github.com/computerquip/xpad4

Any feedback would be appreciated.

