From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: WM97xx touchscreen drivers
Date: Tue, 1 Apr 2008 15:42:26 +0400
Message-ID: <bc64b4640804010442k458bdd10jef0bc722ec25efd1@mail.gmail.com>
References: <20080401102825.GA30868@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:26703 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399AbYDALm1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Apr 2008 07:42:27 -0400
Received: by py-out-1112.google.com with SMTP id u52so3007263pyb.10
        for <linux-input@vger.kernel.org>; Tue, 01 Apr 2008 04:42:27 -0700 (PDT)
In-Reply-To: <20080401102825.GA30868@rakim.wolfsonmicro.main>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dtor@mail.ru>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christ

Hi,

2008/4/1, Mark Brown <broonie@opensource.wolfsonmicro.com>:
> This patch series adds support for the touchscreen controllers found in
>  WM97xx devices.  This revision of the series fixes some races when
>  closing an active device and fixes a shadowed variable.
>
>  This patch series is also available in the git repository at:
>
>   git://opensource.wolfsonmicro.com/linux-2.6-touch upstream


Changelog since last repost?


>
>  Mark Brown (6):
>       Core driver for WM97xx touchscreens
>       Add chip driver for WM9705 touchscreen
>       Add chip driver for WM9712 touchscreen
>       Add chip driver for WM9713 touchscreen
>       Driver for WM97xx touchscreens in streaming mode on Mainstone
>       Build system and MAINTAINERS entry for WM97xx touchscreen drivers
>
>   MAINTAINERS                                  |   10 +
>   drivers/input/touchscreen/Kconfig            |   52 ++
>   drivers/input/touchscreen/Makefile           |    7 +
>   drivers/input/touchscreen/mainstone-wm97xx.c |  300 ++++++++++
>   drivers/input/touchscreen/wm9705.c           |  352 ++++++++++++
>   drivers/input/touchscreen/wm9712.c           |  461 +++++++++++++++
>   drivers/input/touchscreen/wm9713.c           |  459 +++++++++++++++
>   drivers/input/touchscreen/wm97xx-core.c      |  786 ++++++++++++++++++++++++++
>   include/linux/wm97xx.h                       |  311 ++++++++++
>   9 files changed, 2738 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/input/touchscreen/mainstone-wm97xx.c
>   create mode 100644 drivers/input/touchscreen/wm9705.c
>   create mode 100644 drivers/input/touchscreen/wm9712.c
>   create mode 100644 drivers/input/touchscreen/wm9713.c
>   create mode 100644 drivers/input/touchscreen/wm97xx-core.c
>   create mode 100644 include/linux/wm97xx.h
>


-- 
With best wishes
Dmitry
