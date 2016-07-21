From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 2/2] ACPI / button: Add document for ACPI control
 method lid device restrictions
Date: Thu, 21 Jul 2016 13:32:46 -0700
Message-ID: <20160721203246.GA9841@dtor-ws>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
 <84ca7337d20620946b671f212abfc82698ddcbf4.1468915808.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35498 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbcGUUcz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2016 16:32:55 -0400
Content-Disposition: inline
In-Reply-To: <84ca7337d20620946b671f212abfc82698ddcbf4.1468915808.git.lv.zheng@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org

On Tue, Jul 19, 2016 at 04:11:21PM +0800, Lv Zheng wrote:
> This patch adds documentation for the usage model of the control method lid
> device.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> Cc: Bastien Nocera: <hadess@hadess.net>
> Cc: linux-input@vger.kernel.org
> ---
>  Documentation/acpi/acpi-lid.txt |   89 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/acpi/acpi-lid.txt
> 
> diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
> new file mode 100644
> index 0000000..2addedc
> --- /dev/null
> +++ b/Documentation/acpi/acpi-lid.txt
> @@ -0,0 +1,89 @@
> +Usage Model of the ACPI Control Method Lid Device
> +
> +Copyright (C) 2016, Intel Corporation
> +Author: Lv Zheng <lv.zheng@intel.com>
> +
> +
> +Abstract:
> +
> +Platforms containing lids convey lid state (open/close) to OSPMs using a
> +control method lid device. To implement this, the AML tables issue
> +Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
> +changed. The _LID control method for the lid device must be implemented to
> +report the "current" state of the lid as either "opened" or "closed".
> +
> +This document describes the restrictions and the expections of the Linux
> +ACPI lid device driver.
> +
> +
> +1. Restrictions of the returning value of the _LID control method
> +
> +The _LID control method is described to return the "current" lid state.
> +However the word of "current" has ambiguity, many AML tables return the lid

Can this be fixed in the next ACPI revision?

> +state upon the last lid notification instead of returning the lid state
> +upon the last _LID evaluation. There won't be difference when the _LID
> +control method is evaluated during the runtime, the problem is its initial
> +returning value. When the AML tables implement this control method with
> +cached value, the initial returning value is likely not reliable. There are
> +simply so many examples always retuning "closed" as initial lid state.
> +
> +2. Restrictions of the lid state change notifications
> +
> +There are many AML tables never notifying when the lid device state is
> +changed to "opened". Thus the "opened" notification is not guaranteed.
> +
> +But it is guaranteed that the AML tables always notify "closed" when the
> +lid state is changed to "closed". The "closed" notification is normally
> +used to trigger some system power saving operations on Windows. Since it is
> +fully tested, the "closed" notification is reliable for all AML tables.
> +
> +3. Expections for the userspace users of the ACPI lid device driver
> +
> +The ACPI button driver exports the lid state to the userspace via the
> +following file:
> +  /proc/acpi/button/lid/LID0/state
> +This file actually calls the _LID control method described above. And given
> +the previous explanation, it is not reliable enough on some platforms. So
> +it is advised for the userspace program to not to solely rely on this file
> +to determine the actual lid state.
> +
> +The ACPI button driver emits 2 kinds of events to the user space:
> +  SW_LID
> +   When the lid state/event is reliable, the userspace can behave
> +   according to this input switch event.
> +   This is a mode prepared for backward compatiblity.
> +  KEY_EVENT_OPEN/KEY_EVENT_CLOSE
> +   When the lid state/event is not reliable, the userspace should behave
> +   according to these 2 input key events.
> +   New userspace programs may only be prepared for the input key events.

No, absolutely not. If some x86 vendors managed to mess up their
firmware implementations that does not mean that everyone now has to
abandon working perfectly well for them SW_LID events and rush to switch
to a brand new event.

Apparently were are a few issues, main is that some systems not reporting
"open" event. This can be dealt with by userspace "writing" to the
lid's evdev device EV_SW/SW_LID/0 event upon system resume (and startup)
for selected systems. This will mean that if system wakes up not because
LID is open we'll incorrectly assume that it is, but we can either add
more smarts to the process emitting SW_LID event or simply say "well,
tough, the hardware is crappy" and bug vendor to see if they can fix the
issue (if not for current firmware them for next).

As an additional workaround, we can toggle the LID switch off and on
when we get notification, much like your proposed patch does for the key
events.

Speaking of ACPI in general, does Intel have a test suite for ACPI
implementors? Could include tests for proper LID behavior?
1. The "swallowing" of input events because kernel state disagrees with
the reality

Thanks.

-- 
Dmitry
