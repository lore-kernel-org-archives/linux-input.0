From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/4] Input: =?utf-8?b?YXRtZWxfbXh0X3Rz?= - make it work on Tegra
Date: Mon, 2 Jun 2014 09:50:52 +0000 (UTC)
Message-ID: <loom.20140602T114357-483@post.gmane.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk> <536BB3C9.8070908@wwwdotorg.org> <536BDFFD.4080009@itdev.co.uk> <537128D0.3060005@wwwdotorg.org> <53763B06.7020100@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33828 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbaFBJzG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Jun 2014 05:55:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1WrOxM-0000M7-4u
	for linux-input@vger.kernel.org; Mon, 02 Jun 2014 11:55:04 +0200
Received: from dsl-KK-static-239.193.95.61.airtelbroadband.in ([dsl-KK-static-239.193.95.61.airtelbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Mon, 02 Jun 2014 11:55:04 +0200
Received: from nsekhar by dsl-KK-static-239.193.95.61.airtelbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Mon, 02 Jun 2014 11:55:04 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi Nick,

Nick Dyer <nick.dyer <at> itdev.co.uk> writes:

> Thanks for this. Would you be happy for me to pick these changes up and
> include them along with the other work I am sending to Dmitry? I am just
> beginning to do various updates to the whole series, one of the things I
> need to sort out is the device tree support.

I am starting work on support for Atmel mxT224 present
on TI's DRA7x EVM. What would be a good tree to base
my work on? Like Stephen, my platform is device-tree only.

I looked at your tree:

git://github.com/ndyer/linux.git for-next

it was updated 3 months ago and does not have Stephen's
DT patches yet. It will be great to have a common tree
which we can all base-off on to avoid rework.

Thanks,
Sekhar

