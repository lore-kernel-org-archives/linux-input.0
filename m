From: Daniel Drake <dsd@gentoo.org>
Subject: joydev compat_ioctl still broken
Date: Thu, 07 Feb 2008 12:34:33 +0000
Message-ID: <47AAFAD9.30006@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from probity.mcc.ac.uk ([130.88.200.94]:63823 "EHLO
	probity.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbYBGM5x (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Feb 2008 07:57:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-input@vger.kernel.org

Hi Brian,

In 2005 you rejected a patch rejecting some COMPATIBLE_IOCTL entries for
joydev:
http://readlist.com/lists/vger.kernel.org/linux-kernel/28/144445.html

> The joydev ioctls are already fixed (using ->compat_ioctl) in more
> recent kernels.

This appears to still be non-functional as of the present day (tested on 
2.6.22). Any chance you could weigh in on the following bug:
http://bugzilla.kernel.org/show_bug.cgi?id=9652

Thanks!
Daniel
