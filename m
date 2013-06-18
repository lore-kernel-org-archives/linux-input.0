From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 3/5] arm: pxa: use matrix_keymap for all boards
Date: Tue, 18 Jun 2013 16:02:16 +0200
Message-ID: <201306181602.16261.arnd@arndb.de>
References: <1371527778-5236-1-git-send-email-chao.xie@marvell.com> <1371527778-5236-4-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:57187 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932824Ab3FROCe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Jun 2013 10:02:34 -0400
In-Reply-To: <1371527778-5236-4-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <chao.xie@marvell.com>
Cc: dmitry.torokhov@gmail.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, drwyrm@gmail.com, stefan@openezx.org, laforge@openezx.org, robert.jarzmik@free.fr, marek.vasut@gmail.com, sleep_walker@suse.cz, slapin@ossfans.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, xiechao.mail@gmail.com

On Tuesday 18 June 2013, Chao Xie wrote:
> Compile passed for configurations
> 
> em_x270_defconfig
>   em_x270x.c(MACH_EM_X270, MACH_EXEDA)
> 
> ezx_defconfig
>   ezx.c(MACH_EZX_A780, MACH_EZX_E680, MACH_EZX_A1200,
>         MACH_EZX_A910, MACH_EZX_E6, MACH_EZX_E2)
> 
> palmz72_defconfig
>   palmld.c(MACH_PALMLD), palmtreo.c(PALM_TREO),
>   palmtx.c(MACH_PALMTX), palmz72.c(MACH_PALMZ72),
>   palmt5.c(MACH_PALMT5)
> 
> pxa3xx_defconfig
>   littleton.c(MACH_LITTLETON), tarvorevb.c(MACH_TAVOREVB),
>   zylonite.c(MACH_ZYLONITE320), mioa701.c(MACH_MIOA701),
>   z2.c(MACH_ZIPIT2)
> 
> mainstone_defconfig
>   maintone.c(MACH_MAINSTONE)
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the quick update.
