From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: you should fix typo, "QT2160" versus "KEYBOARD_QT2160"
Date: Fri, 16 Jul 2010 04:39:38 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1007160434590.13824@lynx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:41653 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935955Ab0GPIjy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jul 2010 04:39:54 -0400
Received: from cpe002275e3273f-cm001225dbafb6.cpe.net.cable.rogers.com ([99.235.245.115] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1OZgSV-0002jw-MP
	for linux-input@vger.kernel.org; Fri, 16 Jul 2010 04:39:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


  not sure what you want to do with this, but there's a mismatch:

drivers/input/keyboard/Kconfig:
...
config QT2160
...

  while the corresponding Makefile contains:

obj-$(CONFIG_KEYBOARD_QT2160)           += qt2160.o
             ^^^^^^^^^

  normally, i'd just edit the Kconfig file to be consistent with all
other config entries in that file, but:

$ grep -rw CONFIG_QT2160 *
arch/powerpc/configs/pasemi_defconfig:# CONFIG_QT2160 is not set
arch/powerpc/configs/44x/sam440ep_defconfig:# CONFIG_QT2160 is not set
arch/powerpc/configs/44x/icon_defconfig:# CONFIG_QT2160 is not set
arch/powerpc/configs/wii_defconfig:# CONFIG_QT2160 is not set
arch/powerpc/configs/85xx/stx_gp3_defconfig:# CONFIG_QT2160 is not set
arch/powerpc/configs/ppc64e_defconfig:# CONFIG_QT2160 is not set
arch/powerpc/configs/mpc512x_defconfig:# CONFIG_QT2160 is not set
arch/mips/configs/fuloong2e_defconfig:# CONFIG_QT2160 is not set
arch/mips/configs/mtx1_defconfig:# CONFIG_QT2160 is not set
arch/sparc/configs/sparc64_defconfig:# CONFIG_QT2160 is not set
arch/avr32/configs/atstk1006_defconfig:# CONFIG_QT2160 is not set
arch/avr32/configs/atstk1002_defconfig:# CONFIG_QT2160 is not set
arch/blackfin/configs/BF548-EZKIT_defconfig:# CONFIG_QT2160 is not set
... etc etc ...

  i'll let you decide how to resolve that.

rday

-- 

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Top-notch, inexpensive online Linux/OSS/kernel courses
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
