From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 4/5] vfio: platform: Convert to use devm_*()
Date: Thu, 6 Apr 2017 22:17:31 +0800
Message-ID: <20170406141731.GA27245@leoy-linaro>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-5-git-send-email-leo.yan@linaro.org>
 <10625a88-3d6d-de52-8299-3ba0031317f8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33577 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934375AbdDFORr (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Apr 2017 10:17:47 -0400
Received: by mail-pg0-f46.google.com with SMTP id x125so37776741pgb.0
        for <linux-input@vger.kernel.org>; Thu, 06 Apr 2017 07:17:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <10625a88-3d6d-de52-8299-3ba0031317f8@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Linus Walleij <linus.walleij@linaro.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, alsa-devel@alsa-project.org

On Sun, Apr 02, 2017 at 04:45:28PM +0200, Auger Eric wrote:
> Hi Leo,
> 
> On 26/03/2017 16:41, Leo Yan wrote:
> > Convert driver to use devm_*() APIs so rely on driver model core layer
> > to manage resources. This eliminates error path boilerplate and makes
> > code neat.
> > 
> > This patch also renames amba_id structure, the old code used some code
> > which directly copied from other driver.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Looks good to me
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for reviewing, Eric.

> May be interesting to go further converting as well the vfio-platform
> driver but this can be done later on.

Looked a bit for vfio-platform driver and I'm not sure if need some
converting within function vfio_platform_probe_common(). So I'd like
to leave this to who really understand the subsystem :)

[...]

Thanks,
Leo Yan
