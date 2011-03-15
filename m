From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: Re: [PATCH] input: generic driver for slide switches
Date: Tue, 15 Mar 2011 14:13:49 +0100
Message-ID: <201103151413.50042.alexander.stein@informatik.tu-chemnitz.de>
References: <1298640558-3030-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jack.hrz.tu-chemnitz.de ([134.109.132.46]:37504 "EHLO
	jack.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553Ab1CONOB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 09:14:01 -0400
In-Reply-To: <1298640558-3030-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Friday 25 February 2011, 14:29:18 Alexander Stein wrote:
> This patch adds a generic driver for slide switches connected to GPIO
> pins of a system. It requires gpiolib and generic hardware irqs.
> 
> Signed-off-by: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
> ---
>  drivers/input/misc/Kconfig         |    9 ++
>  drivers/input/misc/Makefile        |    1 +
>  drivers/input/misc/slide_switch.c  |  268
> ++++++++++++++++++++++++++++++++++++ include/linux/input/slide_switch.h | 
>  16 ++
>  4 files changed, 294 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/misc/slide_switch.c
>  create mode 100644 include/linux/input/slide_switch.h

Did this get overlooked accidentaly?

Alexander
