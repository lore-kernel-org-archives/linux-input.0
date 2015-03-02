From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/4] thinkpad_acpi: Remember adaptive kbd presence
Date: Mon, 02 Mar 2015 14:11:31 -0300
Message-ID: <1425316291.516850.234429205.7068CEE9@webmail.messagingengine.com>
References: <1425303916.16791.32.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38530 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755435AbbCBRLc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2015 12:11:32 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 0815C20A3D
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2015 12:11:31 -0500 (EST)
In-Reply-To: <1425303916.16791.32.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Mon, Mar 2, 2015, at 10:45, Bastien Nocera wrote:
> Rather than checking on each suspend and resume whether the laptop
> has an adaptive keyboard, check when the driver is initialised.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 37
>  ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c
> b/drivers/platform/x86/thinkpad_acpi.c
> index 3b8ceee..763aef0 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -319,6 +319,7 @@ static struct {
>  	u32 sensors_pdrv_attrs_registered:1;
>  	u32 sensors_pdev_attrs_registered:1;
>  	u32 hotkey_poll_active:1;
> +       u32 has_adaptive_kbd:1;
>  } tp_features;
>  
>  static struct {
> @@ -3227,6 +3228,15 @@ static int __init hotkey_init(struct
> ibm_init_struct *iibm)
>  	if (!tp_features.hotkey)
>  		return 1;
>  
> +       /*
> +        * Check if we have an adaptive keyboard, like on the
> +        * Lenovo Carbon X1 2014 (2nd Gen).
> +        */
> +       if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
> +               if ((hkeyv >> 8) == 2)
> +                       tp_features.has_adaptive_kbd = true;
> +       }
> +
>  	quirks = tpacpi_check_quirks(tpacpi_hotkey_qtable,
>  				     ARRAY_SIZE(tpacpi_hotkey_qtable));
>  
> @@ -3836,28 +3846,21 @@ static void hotkey_notify(struct ibm_struct *ibm,
> u32 event)
>  
>  static void hotkey_suspend(void)
>  {
> -       int hkeyv;
> -
>  	/* Do these on suspend, we get the events on early resume! */
>  	hotkey_wakeup_reason = TP_ACPI_WAKEUP_NONE;
>  	hotkey_autosleep_ack = 0;
>  
>  	/* save previous mode of adaptive keyboard of X1 Carbon */
> -       if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
> -               if ((hkeyv >> 8) == 2) {
> -                       if (!acpi_evalf(hkey_handle,
> -                                              
> &adaptive_keyboard_prev_mode,
> -                                               "GTRW", "dd", 0)) {
> -                               pr_err("Cannot read adaptive keyboard
> mode.\n");
> -                       }
> +       if (tp_features.has_adaptive_kbd) {
> +               if (!acpi_evalf(hkey_handle,
> &adaptive_keyboard_prev_mode,
> +                                       "GTRW", "dd", 0)) {
> +                       pr_err("Cannot read adaptive keyboard mode.\n");
>  		}
>  	}
>  }
>  
>  static void hotkey_resume(void)
>  {
> -       int hkeyv;
> -
>  	tpacpi_disable_brightness_delay();
>  
>  	if (hotkey_status_set(true) < 0 ||
> @@ -3872,14 +3875,10 @@ static void hotkey_resume(void)
>  	hotkey_poll_setup_safe(false);
>  
>  	/* restore previous mode of adapive keyboard of X1 Carbon */
> -       if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
> -               if ((hkeyv >> 8) == 2) {
> -                       if (!acpi_evalf(hkey_handle,
> -                                               NULL,
> -                                               "STRW", "vd",
> -                                              
> adaptive_keyboard_prev_mode)) {
> -                               pr_err("Cannot set adaptive keyboard
> mode.\n");
> -                       }
> +       if (tp_features.has_adaptive_kbd) {
> +               if (!acpi_evalf(hkey_handle, NULL, "STRW", "vd",
> +                                       adaptive_keyboard_prev_mode)) {
> +                       pr_err("Cannot set adaptive keyboard mode.\n");
>  		}
>  	}
>  }
> -- 
> 2.1.0
> 
> 


-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
