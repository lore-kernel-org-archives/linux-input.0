From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 0/2] Input: atmel_mxt_ts - Add support for T100 multi-touch
Date: Fri, 27 Mar 2015 21:29:58 +0100
Message-ID: <5515BDC6.1040606@collabora.co.uk>
References: <1426600846-13346-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39786 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbbC0UaF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 16:30:05 -0400
In-Reply-To: <1426600846-13346-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Chung-yih Wang <cywang@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Dmitry,

On 03/17/2015 03:00 PM, Javier Martinez Canillas wrote:
> 
> This is a resend of the T100 muli-touch object type support for the Atmel
> maXTouch touchscreen driver. Old chips use the T9 multi-touch object type
> while newer chips use this T100 multi-touch object type which is currenty
> not supported by the driver.
> 
> Nick Dyer posted his patch to add T100 support a couple of times, the last
> one being 3 months ago [0]. Ben suggested using ABS_MT_DISTANCE to handle
> fingers hovering and pointed to Chung-yih Wang work [1] in the ChromiumOS
> downstream tree. Nick said he would work on that and re-post but he didn't.
> 
> Using ABS_MT_DISTANCE to indicate contact hovering is also suggested in
> Documentation/input/multi-touch-protocol.txt so I took Nick's patch, rebased
> on top of linux-next, refactored a bit to remove some code duplication and
> addressed Ben concerns by integrating Chung-yih's work to report hovering
> using ABS_MT_DISTANCE.
> 
> The series is composed of the following patches:
> 
> Nick Dyer (1):
>   Input: atmel_mxt_ts - Implement support for T100 touch object
> 
> Sjoerd Simons (1):
>   Input: atmel_mxt_ts - Split out touchpad initialisation logic
> 
>  drivers/input/touchscreen/atmel_mxt_ts.c | 371 +++++++++++++++++++++++++++----
>  1 file changed, 330 insertions(+), 41 deletions(-)
> 
> Patch #1 adds the support for the T100 touch object and patch #2 is a
> cleanup to simplify the driver's input device initialization function.
> 
> The series were tested on an Exynos5800 Peach Pi which needs T100 support
> and on an Exynos5420 Peach Pit to be sure that T9 is still working.
> 

Any comments about this series?

Best regards,
Javier

