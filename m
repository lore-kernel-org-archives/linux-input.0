From: Jean Delvare <khali@linux-fr.org>
Subject: Re: + input-add-tsc2007-based-touchscreen-driver.patch added to -mm
 tree
Date: Mon, 8 Dec 2008 10:39:29 +0100
Message-ID: <20081208103929.576e9911@hyperion.delvare>
References: <200812070027.mB70R361001860@imap1.linux-foundation.org>
	<483a38b80812072135iefd5390q82ce022359401451@mail.gmail.com>
	<20081208094601.272dfb8f@hyperion.delvare>
	<483a38b80812080136s468b642cp1085fcf25c8f72ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:28448 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbYLHJjl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2008 04:39:41 -0500
In-Reply-To: <483a38b80812080136s468b642cp1085fcf25c8f72ab@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, mm-commits@vger.kernel.org, dtor@mail.ru, David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com, Trilok Soni <soni.trilok@gmail.com>

On Mon, 8 Dec 2008 18:36:43 +0900, Kwangwoo Lee wrote:
> From efd6b79f2e0220e41f95e5b6acf5aa4fc0b0339a Mon Sep 17 00:00:00 2001
> From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
> Date: Mon, 8 Dec 2008 18:26:18 +0900
> Subject: [PATCH] input: add tsc2007 based touchscreen driver.
>  Use swap16() instead of be16_to_cpu() in tsc2007_xfer().
> 
> Thank you very much for all your comments regaring this driver.
> 
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@gmail.com>

i2c part:
Acked-by: Jean Delvare <khali@linux-fr.org>


> ---
>  drivers/input/touchscreen/Kconfig   |    9 +
>  drivers/input/touchscreen/Makefile  |    1 +
>  drivers/input/touchscreen/tsc2007.c |  376 +++++++++++++++++++++++++++++++++++
>  include/linux/i2c/tsc2007.h         |   17 ++
>  4 files changed, 403 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/tsc2007.c
>  create mode 100644 include/linux/i2c/tsc2007.h
> (...)

-- 
Jean Delvare
