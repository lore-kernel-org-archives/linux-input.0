From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH 00/13] input: cyapa: intruction of cyapa patches
Date: Mon, 20 Oct 2014 01:15:34 +0000
Message-ID: <7360f60b5cb6448bbc260fa1907b6a6c@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1413357567-26177-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [207.46.100.139] ([207.46.100.139]:15152 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751846AbaJTCvO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Oct 2014 22:51:14 -0400
In-Reply-To: <1413357567-26177-1-git-send-email-dudl@cypress.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudley.dulixin@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>
Cc: "bleung@google.com" <bleung@google.com>, "patrikf@google.com" <patrikf@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dmitry,

Is there any update the v8 patchs for input cyapa trackpad drivers?

Thanks,
Dudley

> -----Original Message-----
> From: Dudley Du [mailto:dudley.dulixin@gmail.com]
> Sent: 2014?10?15? 15:19
> To: dmitry.torokhov@gmail.com; rydberg@euromail.se
> Cc: Dudley Du; bleung@google.com; patrikf@google.com;
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 00/13] input: cyapa: intruction of cyapa patches
>
> Based on Dmitry's comments, I made v8 patches of cyapa trackpad device
> with below updates compared with v7 patches:
> 1) [PATCH v8 01/13] - Remove the async thread for device detect in
>    proble routine, now the device detect process is completly done within
>    the device proble routine.
> 2) [PATCH v8 01/13] - Split the irq cmd hander function to separated
>    function cyapa_default_irq_cmd_handler() and set it to interface
>    cyapa_default_ops.irq_cmd_handler.
> 3) [PATCH v8 06/13] - Add cyapa->gen check in cyapa_gen3_irq_cmd_handler()
>    to avoid miss-enter when device protocol is still in detecting.
>
>
> V7 patches have below updates compared with v6 patches:
> 1) [PATCH v7 01/13] - Split the irq cmd hander function to separated
>    function cyapa_default_irq_cmd_handler() and set it to interface
>    cyapa_default_ops.irq_cmd_handler.
> 2) [PATCH v7 06/13] - Add cyapa->gen check in cyapa_gen3_irq_cmd_handler()
>    to avoid miss-enter when device protocol is still in detecting.
>
>
> V6 patches have below updates compared with v5 patches:
> 1) Remove patch 14 of the lid filtering from the cyapa driver.
>
> V5 patches have below updates compared with v4 patches:
> 1) Uses get_device()/put_device() instead of kobject_get()/kobject_put();
> 2) Fix memories freed before debugfs entries issue;
> 3) Make cyapa_debugs_root valid in driver module level
>    in module_init()/moudle_exit() ;
> 4) Fix i2c_transfer() may return partial transfer issues.
> 5) Add cyapa->removed flag to avoid detecting thread may still running
>    when driver module is removed.
> 6) Fix the meanings of some comments and return error code not clear issue.
>
> This patch set is aimed to re-architecture the cyapa driver to support
> old gen3 trackpad device and new gen5 trackpad device in one
> cyapa driver for easily productions support based on
> customers' requirements, and add sysfs functions and interfaces
> supported that required by users and customers.
> Because the earlier gen3 and the latest gen5 trackpad devies using
> two different chipsets, and have different protocol and interfaces.
> If supported these two trackpad devices in two different drivers, then
> it will be difficult to manage productions and later firmware updates.
> it will cause customer don't know which one to use and update
> because these two trackpad devices have been used and integrated
> in same one productions at a time, so must to support these two trackpad
> devices in same on driver.
>
> The new architecture is made of:
> cyapa.c - the core of the architecture, supply interfaces and
> functions to system and read trackpad devices.
> cyapa.h - header file including macros and data structure definitions.
> cyapa_gen3.c - functions support for gen3 trackpad devices,
> cyapa_gen5.c - functions support for gen5 trackpad devices.
>
> Beside this introduction patch, it has 14 patches listed as below.
> For these patches each one is patched based on previous one.
>
> patch 1/13: re-architecture cyapa driver with core functions,
> and applying the device detecting function in async thread to speed
> up system boot time.
>
> patch 2/13: add cyapa driver power management interfaces support.
>
> patch 3/13: add cyapa driver runtime power management interfaces support.
>
> patch 4/13: add cyapa key function interfaces in sysfs system.
> Including read firmware version, get production ID, read baseline,
> re-calibrate trackpad baselines and do trackpad firmware update.
>
> patch 5/13: add read firmware image and read raw trackpad device'
> sensors' raw data interface in debugfs system.
>
> patch 6/13: add gen3 trackpad device basic functions support.
>
> patch 7/13: add gen3 trackpad device firmware update function support.
>
> patch 8/13: add gen3 trackpad device report baseline and do force
> re-calibrate functions support.
>
> patch 9/13: add gen3 trackpad device read firmware image function support.
>
> patch 10/13: add gen5 trackpad device basic functions support.
>
> patch 11/13: add gen5 trackpad device firmware update function support.
>
> patch 12/13: add gen5 trackpad device report baseline and do force
> re-calibrate functions support.
>
> patch 13/13: add gen5 trackpad device read firmware image and report
> sensors' raw data values functions support.
>
> This message and any attachments may contain Cypress (or its subsidiaries)
> confidential information. If it has been received in error, please advise the sender
> and immediately delete this message.

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
