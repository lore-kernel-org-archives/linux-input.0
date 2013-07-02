From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 2/3] Input: tps6507x-ts - remove vref from platform data
Date: Tue, 2 Jul 2013 08:49:14 -0700
Message-ID: <CAGa+x87xEO7AeDyQCp+T+Pkhne1SDWqqUuHQyqLVaYmBCYnP1w@mail.gmail.com>
References: <1370843627-30823-1-git-send-email-dmitry.torokhov@gmail.com>
	<1370843627-30823-2-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:37664 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab3GBPtP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Jul 2013 11:49:15 -0400
Received: by mail-we0-f180.google.com with SMTP id w56so4492623wes.11
        for <linux-input@vger.kernel.org>; Tue, 02 Jul 2013 08:49:14 -0700 (PDT)
In-Reply-To: <1370843627-30823-2-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

On Sun, Jun 9, 2013 at 10:53 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Although defined in platform data, vref is not used anywhere.
>
> Also remove model, irq, and clear_penirq as they are not used either.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Actually, it's used in arch/arm/mach-davinci/board-da850-evm.c.

The following should be folded into this patch.  Found by build
failure in linux-next building da8xx_omapl_defconfig for ARM.

Kevin

diff --git a/arch/arm/mach-davinci/board-da850-evm.c
b/arch/arm/mach-davinci/board-da850-evm.c
index 8a24b6c..bea6793 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -985,7 +985,6 @@ static struct regulator_init_data
tps65070_regulator_data[] = {
 static struct touchscreen_init_data tps6507x_touchscreen_data = {
  .poll_period =  30, /* ms between touch samples */
  .min_pressure = 0x30, /* minimum pressure to trigger touch */
- .vref = 0, /* turn off vref when not using A/D */
  .vendor = 0, /* /sys/class/input/input?/id/vendor */
  .product = 65070, /* /sys/class/input/input?/id/product */
  .version = 0x100, /* /sys/class/input/input?/id/version */
