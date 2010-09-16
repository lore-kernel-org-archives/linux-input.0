From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/7] add tnetv107x input drivers
Date: Thu, 16 Sep 2010 10:53:56 -0700
Message-ID: <87vd658thn.fsf@deeprootsystems.com>
References: <1284395388-32687-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59055 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab0IPRyF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Sep 2010 13:54:05 -0400
Received: by pvg2 with SMTP id 2so415236pvg.19
        for <linux-input@vger.kernel.org>; Thu, 16 Sep 2010 10:54:05 -0700 (PDT)
In-Reply-To: <1284395388-32687-1-git-send-email-cyril@ti.com> (Cyril
	Chemparathy's message of "Mon, 13 Sep 2010 12:29:41 -0400")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cyril Chemparathy <cyril@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Cyril Chemparathy <cyril@ti.com> writes:

> Texas Instruments' TNETV107X is an ARM1176 based SoC, with on-chip
> touchscreen and keypad controllers.  This patch series adds drivers for these
> controllers.

Dmitry,

With you're review/ack, I can merge these via the davinci tree so the
drivers can merge with the platform code that goes with them.  That way
we can avoid potential conflicts from other davinci changes touching the
same platform files.

Kevin

>
> Cyril Chemparathy (7):
>   davinci: define tnetv107x keypad platform data
>   input: add driver for tnetv107x on-chip keypad controller
>   davinci: add tnetv107x keypad platform device
>   davinci: add keypad config for tnetv107x evm board
>   input: add driver for tnetv107x touchscreen controller
>   davinci: add tnetv107x touchscreen platform device
>   davinci: add touchscreen config for tnetv107x evm board
>
>  arch/arm/mach-davinci/board-tnetv107x-evm.c    |   51 +++
>  arch/arm/mach-davinci/devices-tnetv107x.c      |   54 +++
>  arch/arm/mach-davinci/include/mach/tnetv107x.h |   24 ++
>  drivers/input/keyboard/Kconfig                 |    9 +
>  drivers/input/keyboard/Makefile                |    1 +
>  drivers/input/keyboard/tnetv107x-keypad.c      |  324 ++++++++++++++++
>  drivers/input/touchscreen/Kconfig              |    6 +
>  drivers/input/touchscreen/Makefile             |    1 +
>  drivers/input/touchscreen/tnetv107x-ts.c       |  481 ++++++++++++++++++++++++
>  9 files changed, 951 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/keyboard/tnetv107x-keypad.c
>  create mode 100644 drivers/input/touchscreen/tnetv107x-ts.c
>
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source@linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
