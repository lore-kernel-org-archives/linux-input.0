From: Ferruh Yigit <fery@cypress.com>
Subject: Re: [PATCH] input / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Thu, 4 Dec 2014 09:58:56 +0200
Message-ID: <54801440.2040300@cypress.com>
References: <8119438.MdkFLx3Wvh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1on0119.outbound.protection.outlook.com ([157.56.110.119]:14048
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751110AbaLDIO7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Dec 2014 03:14:59 -0500
In-Reply-To: <8119438.MdkFLx3Wvh@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 12/03/2014 03:47 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
>
> The alternative of CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME may be
> replaced with CONFIG_PM too.
>
> Make these changes in 2 files under drivers/input/.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ferruh Yigit <fery@cypress.com>


> ---
>
> Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
> PM_SLEEP is selected) which is only in linux-next at the moment (via the
> linux-pm tree).
>
> Please let me know if it is OK to take this one into linux-pm.
>
> ---
>  drivers/input/keyboard/samsung-keypad.c  |    2 +-
>  drivers/input/touchscreen/cyttsp4_core.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/input/keyboard/samsung-keypad.c
> ===================================================================
> --- linux-pm.orig/drivers/input/keyboard/samsung-keypad.c
> +++ linux-pm/drivers/input/keyboard/samsung-keypad.c
> @@ -463,7 +463,7 @@ static int samsung_keypad_remove(struct
>       return 0;
>  }
>
> -#ifdef CONFIG_PM_RUNTIME
> +#ifdef CONFIG_PM
>  static int samsung_keypad_runtime_suspend(struct device *dev)
>  {
>       struct platform_device *pdev = to_platform_device(dev);
> Index: linux-pm/drivers/input/touchscreen/cyttsp4_core.c
> ===================================================================
> --- linux-pm.orig/drivers/input/touchscreen/cyttsp4_core.c
> +++ linux-pm/drivers/input/touchscreen/cyttsp4_core.c
> @@ -1716,7 +1716,7 @@ static void cyttsp4_free_si_ptrs(struct
>       kfree(si->btn_rec_data);
>  }
>
> -#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
> +#ifdef CONFIG_PM
>  static int cyttsp4_core_sleep(struct cyttsp4 *cd)
>  {
>       int rc;
>
>


--


regards,
ferruh


This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
