From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2 0/7] RMI4 cleanups and switch hid-rmi to rmi_core
Date: Fri, 2 Dec 2016 16:33:48 -0800
Message-ID: <d80edafa-fa72-2ae0-6134-4da2b04ea42a@synaptics.com>
References: <1480678916-6469-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:43153 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbcLCAnt (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Dec 2016 19:43:49 -0500
In-Reply-To: <1480678916-6469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

Thanks for adding the irq handling to hid-rmi and fifo support in the core.

On 12/02/2016 03:41 AM, Benjamin Tissoires wrote:
> Hi,
>
> Well, the cleanup part of the series has already been applied, so
> I guess this is just "switch hid-rmi to rmi_core".
>
> The series applies on top of Dmitri's synaptics-rmi4 branch
>
> However, as mentioned in v1, I'd like to get some testings from actually
> integrated devices befor we flip the switch for HID. Andrew, Dennis?

Tested on a Dell XPS 13 9343 and a Lenovo S21e. That covers the two 
generations of our HID touchpads which have gone into production.

Andrew

> Function f03 has been tested in the rmi4-smbus, and the attn data API
> on a test synaptics board.
>
> Cheers,
> Benjamin
>
> Andrew Duggan (3):
>    HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4
>    HID: rmi: Handle all Synaptics touchpads using hid-rmi
>    HID: rmi: Support the Lenovo Thinkpad X1 Tablet dock using hid-rmi
>
> Benjamin Tissoires (2):
>    Input: synaptics-rmi4 - allow to add attention data
>    Input: synaptics-rmi4 - store the attn data in the driver
>
> Dennis Wassenberg (1):
>    Input: synaptics-rmi4 - F03: grab data passed by transport device
>
> Lyude Paul (1):
>    Input: synaptics-rmi4 - add support for F03
>
>   drivers/hid/Kconfig             |   4 +
>   drivers/hid/hid-core.c          |   4 +-
>   drivers/hid/hid-ids.h           |   1 +
>   drivers/hid/hid-rmi.c           | 974 ++++++----------------------------------
>   drivers/input/rmi4/Kconfig      |   9 +
>   drivers/input/rmi4/Makefile     |   1 +
>   drivers/input/rmi4/rmi_bus.c    |   3 +
>   drivers/input/rmi4/rmi_driver.c |  50 ++-
>   drivers/input/rmi4/rmi_driver.h |   1 +
>   drivers/input/rmi4/rmi_f03.c    | 251 +++++++++++
>   drivers/input/rmi4/rmi_f11.c    |  12 +-
>   drivers/input/rmi4/rmi_f12.c    |  43 +-
>   drivers/input/rmi4/rmi_f30.c    |  11 +-
>   include/linux/rmi.h             |  16 +-
>   14 files changed, 508 insertions(+), 872 deletions(-)
>   create mode 100644 drivers/input/rmi4/rmi_f03.c
>

