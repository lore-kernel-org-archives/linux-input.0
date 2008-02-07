From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: joydev compat_ioctl still broken
Date: Thu, 07 Feb 2008 08:34:42 -0500
Message-ID: <47AB08F2.7060603@didntduck.org>
References: <47AAFAD9.30006@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from quark.didntduck.org ([69.55.226.66]:35450 "EHLO
	quark.didntduck.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbYBGOBT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Feb 2008 09:01:19 -0500
In-Reply-To: <47AAFAD9.30006@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-input@vger.kernel.org

Daniel Drake wrote:
> Hi Brian,
> 
> In 2005 you rejected a patch rejecting some COMPATIBLE_IOCTL entries for
> joydev:
> http://readlist.com/lists/vger.kernel.org/linux-kernel/28/144445.html
> 
>> The joydev ioctls are already fixed (using ->compat_ioctl) in more
>> recent kernels.
> 
> This appears to still be non-functional as of the present day (tested on
> 2.6.22). Any chance you could weigh in on the following bug:
> http://bugzilla.kernel.org/show_bug.cgi?id=9652
> 
> Thanks!
> Daniel
> 

Commit 024ac44c701d43f5e2d34bd6a35b2813a36e6010 should have fixed the
compat ioctls in the correct manner.

Running "jstest --old js0" works for me on my amd64 system (kernel
2.6.23.14-107.fc8).

--
				Brian Gerst
