From: Rik Theys <rik.theys@gmail.com>
Subject: Bug#679750: Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic Mouse"
Date: Thu, 5 Jul 2012 11:15:38 +0200
Message-ID: <CAPwv0J=wwMJZn0mZpH4c5U9Td=y4LtZxj2XrUeKUR4Ez38pW8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:39392 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab2GEJPj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jul 2012 05:15:39 -0400
Received: by gglu4 with SMTP id u4so7140597ggl.19
        for <linux-input@vger.kernel.org>; Thu, 05 Jul 2012 02:15:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>, dashing.meng@gmail.com
Cc: linux-input@vger.kernel.org, seth.forshee@canonical.com, 679750@bugs.debian.org

Hi,

I believe this is the same bug as launchpad bug 606238:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/606238

The bug discusses various Dell laptops with ALPS touchpad that don't
work. They now work in the ubuntu 12.04 kernel (and I believe upstream
as well), but some (such as the one found in an Inspiron 15R N5110)
still don't work because they use yet another protocol version.

Regards,

Rik
