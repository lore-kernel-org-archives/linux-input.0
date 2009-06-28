From: Minkyu Kang <promsoft@gmail.com>
Subject: Re: [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Date: Mon, 29 Jun 2009 08:49:10 +0900
Message-ID: <1f3430fb0906281649i1e4accdbh26efadc3f565a4e4@mail.gmail.com>
References: <4A448926.1030701@samsung.com>
	 <5d5443650906260322n3c4f5f79r3290ebce2e331234@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:40581 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZF1XtI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jun 2009 19:49:08 -0400
In-Reply-To: <5d5443650906260322n3c4f5f79r3290ebce2e331234@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, lm-sensors@lm-sensors.org, suchang.woo@samsung.com, kyungmin.park@samsung.com, linux-input@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

Hi Trilok,

2009/6/26 Trilok Soni <soni.trilok@gmail.com>:
> Hi Minkyu,
>
> Adding linux-input ML, as driver is using linux input subsystem.
>
> On Fri, Jun 26, 2009 at 2:09 PM, Minkyu Kang<mk7.kang@samsung.com> wr=
ote:
>> The GP2A002 is a I2C interfaced Sensor for Proximity/Ambient
>> This patch adds support the GP2A002 sensor
>>
>> Signed-off-by: Minkyu Kang <mk7.kang@samsung.com>
>> Signed-off-by: Suchang Woo <suchang.woo@samsung.com>
>> ---
>> =A0drivers/hwmon/Kconfig =A0 =A0| =A0 =A07 +
>> =A0drivers/hwmon/Makefile =A0 | =A0 =A01 +
>> =A0drivers/hwmon/gp2ap002.c | =A0471 +++++++++++++++++++++++++++++++=
+++++++++++++++
>> =A0include/linux/gp2ap002.h | =A0 21 ++
>> =A04 files changed, 500 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hwmon/gp2ap002.c
>> =A0create mode 100644 include/linux/gp2ap002.h
>>

Thanks for review and I'll make new version as you said : )

--=20
from. prom.
www.promsoft.net
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
