From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Xorg doesn't find input devices with "Input: allow matching device
 IDs on property bits" applied
Date: Mon, 23 Oct 2017 06:02:06 +1030
Message-ID: <83e020ff-959e-9a75-5bab-380c7e1373b0@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:34254 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751558AbdJVTcY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Oct 2017 15:32:24 -0400
Content-Language: en-AU
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

After a recent git pull and kernel build and reboot, Xorg could not find 
the input devices and I was left with unresponsive mouse and keyboard 
until I could remotely shut-down and boot into an earlier kernel.

With good kernels, Xorg.log showed evdev finding the mouse and keyboard.

Bisecting lead to this commit:

  git bisect good
8724ecb072293f109a6f5dc93be8a98bf61fe14f is the first bad commit
commit 8724ecb072293f109a6f5dc93be8a98bf61fe14f
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon Oct 9 12:01:14 2017 -0700

     Input: allow matching device IDs on property bits

     Let's allow matching input devices on their property bits, both 
in-kernel
     and when generating module aliases.

     Tested-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

:040000 040000 4192943bfd5affbe9e86c14efd690bda5c90bd82 
d30b9d9c3a7ed1a6078f56a3bec2a82e0ba09570 M      drivers
:040000 040000 d39ca313c8d6dc86ad1175bf9374c76d9c134e82 
8717e17cbb0556629dd8cf7a7c34694dd299925c M      include
:040000 040000 ba4684d3706ca73868f39e90f673e3926e23e3ba 
811ed0e561768778c86eefa4c5ea5f866a542156 M      scripts

I am happy to run further tests if needed.

Arthur.
