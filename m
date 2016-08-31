From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Input: focaltech - mark focaltech_set_resolution() static
Date: Wed, 31 Aug 2016 11:58:50 +0200
Message-ID: <5089277.G6NWohFGP5@wuerfel>
References: <1472632661-32159-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:49294 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756532AbcHaKEW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 31 Aug 2016 06:04:22 -0400
In-Reply-To: <1472632661-32159-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: dmitry.torokhov@gmail.com, pali.rohar@gmail.com, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, xie.baoyou@zte.com.cn

On Wednesday, August 31, 2016 4:37:41 PM CEST Baoyou Xie wrote:
> We get 1 warning when building kernel with W=1:
> drivers/input/mouse/focaltech.c:393:6: warning: no previous prototype for 'focaltech_set_resolution' [-Wmissing-prototypes]
> 
> In fact, this function is only used in the file in which it is
> declared and don't need a declaration, but can be made static.
> So this patch marks it 'static'.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
