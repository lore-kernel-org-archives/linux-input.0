From: "Tero Saarni" <tero.saarni@gmail.com>
Subject: touchpad with unequal horizontal and vertical resolution
Date: Sun, 21 Dec 2008 23:42:02 +0200
Message-ID: <ad348feb0812211342h51f76e90u831e0435ee496188@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:3285 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYLUVmD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Dec 2008 16:42:03 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1862195wfd.4
        for <linux-input@vger.kernel.org>; Sun, 21 Dec 2008 13:42:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Some laptops have touchpads with non-standard aspect ratio.  Currently
they are quite painful to use since the driver does not compensate the
ratio.  In my HP 2510p moving finger vertically moves the pointer
twice as fast as moving it horizontally.  Same has been reported at
least on HP Mini-note and Lenovo S10.

Issuing SYN_QUE_RESOLUTION on 2510p returns "units per millimeter"
values infoXupmm=74 infoYupmm=160.  For another laptop with normal
touchpad they are 81 and 95.  I believe the reported absolute
coordinates need to be compensated according to units per millimeter
in order to get even speed in both directions.

I tried to study how to expose the values to user space but didn't
find anything obvious.  Would it be correct to do the compensation in
synaptics kernel driver instead of xorg?

-- 
Tero
