From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH v3 0/4] zForce upstreaming
Date: Thu, 19 May 2016 07:26:06 +0200
Message-ID: <bb194907-8541-f7c1-5c66-85a896eb14c1@de.bosch.com>
References: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:54670 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcESF0J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 01:26:09 -0400
In-Reply-To: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>

On 04.05.2016 12:24, Dirk Behme wrote:
> From: Oleksij Rempel <linux@rempel-privat.de>
>
> Changelog:
> v2
>  - rename scan-freq-idle and scan-freq-finger
>    to scan-idle-hz and scan-active-hz.
>  - rebase with already acked "Input: zforce_ts: Fix dual touch recognition"
>    from previous patchset.
>
> v3
>  - rename touch-size-min to touch-size-min-mm
>  - fix typo
>  - replace "zforce_ts: Reject open if initialization not finished" patch.
>    Instead of reject open event, we will call zforce_start() from zforce_boot().
>
> Knut Wohlrab (2):
>   Input: zforce_ts: Add device tree support for scanning frequency
>   Input: zforce_ts: Add support for minimum touch size limit
>
> Marcel Grosshans (1):
>   Input: zforce_ts: Reinitialize touch controller when  BOOT_COMPLETE
>     received
>
> Oleksij Rempel (1):
>   Input: zforce_ts: allow open even if initialisation is not completed
>
>  .../bindings/input/touchscreen/zforce_ts.txt       |   6 +
>  drivers/input/touchscreen/zforce_ts.c              | 174 ++++++++++++++++++---
>  include/linux/platform_data/zforce_ts.h            |   3 +
>  3 files changed, 157 insertions(+), 26 deletions(-)


Any further comments for this series? Or could it be applied, now?


Best regards

Dirk

