From: Anthony Kim <ktyrun@gmail.com>
Subject: Re: [PATCH] Input: add support for HiDeep touchscreen
Date: Wed, 9 Aug 2017 16:54:26 +0900
Message-ID: <CA+d1ZXK_f82RL4pmiCLr5f4=YPssYYzWZLWzJ8MegvPKQyT7Uw@mail.gmail.com>
References: <1500510154-6661-1-git-send-email-anthony.kim@hideep.com>
 <1500965607-2446-1-git-send-email-anthony.kim@hideep.com> <20170803175013.3a4kbotidleipkwe@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:33985 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbdHIHy1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 9 Aug 2017 03:54:27 -0400
In-Reply-To: <20170803175013.3a4kbotidleipkwe@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, mark.rutland@arm.com, rydberg@bitmath.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org

Hi, Dmitry.
My company is registering the Approved Vendor List for the Chrome OS.
So I need to upstream my driver code. For it, I need your confirm.
Please confirm my driver code.
Thank You.
Anthony.

2017-08-04 2:50 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Tue, Jul 25, 2017 at 03:53:27PM +0900, Anthony Kim wrote:
>> The HiDeep touchscreen device is a capacitive multi-touch controller
>> mainly for multi-touch supported devices use. It use I2C interface for
>> communication to IC and provide axis X, Y, Z locations for ten finger
>> touch through input event interface to userspace.
>>
>> It support the Crimson and the Lime two type IC. They are different
>> the number of channel supported and FW size. But the working protocol
>> is same.
>>
>> Signed-off-by: Anthony Kim <anthony.kim@hideep.com>
>> ---
>>  .../bindings/input/touchscreen/hideep.txt          |  35 +
>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>
> For the binding,
>
> Acked-by: Rob Herring <robh@kernel.org>
>
>>  drivers/input/touchscreen/Kconfig                  |  11 +
>>  drivers/input/touchscreen/Makefile                 |   2 +
>>  drivers/input/touchscreen/hideep.h                 | 318 +++++++
>>  drivers/input/touchscreen/hideep_core.c            | 916 +++++++++++++++++++++
>>  drivers/input/touchscreen/hideep_dbg.c             | 405 +++++++++
>>  drivers/input/touchscreen/hideep_dbg.h             |  24 +
>>  drivers/input/touchscreen/hideep_isp.c             | 592 +++++++++++++
>>  drivers/input/touchscreen/hideep_isp.h             |  96 +++
>>  drivers/input/touchscreen/hideep_sysfs.c           | 245 ++++++
>>  11 files changed, 2645 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
>>  create mode 100644 drivers/input/touchscreen/hideep.h
>>  create mode 100644 drivers/input/touchscreen/hideep_core.c
>>  create mode 100644 drivers/input/touchscreen/hideep_dbg.c
>>  create mode 100644 drivers/input/touchscreen/hideep_dbg.h
>>  create mode 100644 drivers/input/touchscreen/hideep_isp.c
>>  create mode 100644 drivers/input/touchscreen/hideep_isp.h
>>  create mode 100644 drivers/input/touchscreen/hideep_sysfs.c
