From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 9/9] Input: wm97xx: add new AC97 bus support
Date: Thu, 27 Oct 2016 10:13:02 +0100
Message-ID: <20161027091302.GH28180@localhost.localdomain>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-10-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:45957 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751448AbcJ0JQP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 05:16:15 -0400
Content-Disposition: inline
In-Reply-To: <1477510907-23495-10-git-send-email-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

On Wed, Oct 26, 2016 at 09:41:47PM +0200, Robert Jarzmik wrote:
> This adds support for the new AC97 bus code, which discovers the devices
> rather than uses platform data.
> 
> As part of this discovery, it enables a multi-function device wm97xx,
> which supports touchscreen, battery, ADC and an audio codec. This patch
> adds the code to bind the touchscreen "cell" as the touchscreen driver.
> 
> This was tested on the pxa architecture with a pxa270 + wm9713 + the
> mioa701 touchscreen.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
