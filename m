From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to setup Touchscreen IRQ mode?
Date: Wed, 30 Mar 2016 00:03:13 +0000
Message-ID: <CA+V1LzqP+tzQ9b8=6xu9vjgYqM93zQXfJe5sUoYEArgzv+A5fw@mail.gmail.com>
References: <CA+V1LzrL6G1FJ6qXuTuiQQiMrZnj_QaHbGhFwBxpJrB9J=ZSGw@mail.gmail.com>
	<56EF459E.8000808@gmail.com>
	<CA+V1Lzph-W2eXhp22_jjObeu-ywzO===9EYWkKccuGuvdJDYRg@mail.gmail.com>
	<20160329095244.GI2099@lahna.fi.intel.com>
	<CA+V1LzqzMyxoAQv=DDFvWr_MOTThVnhJwTt8uS_piwVhGJtWgQ@mail.gmail.com>
	<20160329125642.GM2099@lahna.fi.intel.com>
	<CA+V1Lzov4WXXjERAwAV03VdMEQKDC_=ADAgr2-0p-k=gYC8i3w@mail.gmail.com>
	<20160329133307.GO2099@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34122 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbcC3ADO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 20:03:14 -0400
Received: by mail-qk0-f196.google.com with SMTP id u128so1651538qkh.1
        for <linux-input@vger.kernel.org>; Tue, 29 Mar 2016 17:03:13 -0700 (PDT)
In-Reply-To: <20160329133307.GO2099@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, Gregor Riepl <onitake@gmail.com>

Hi Mika,
 full acpidump of the machine is located here
https://gitlab.com/SergK/icn8528/blob/master/DSDT/dsdt.dsl

>From Android:
"What does 'ls -l /sys/bus/i2c/devices' show under android?"
1) sysi2cdev  /sys/bus/i2c/devices
https://gitlab.com/SergK/icn8528/blob/master/Androiddata/sysi2cdev

2) sysbusacpidev - /sys/bus/acpi/devices
https://gitlab.com/SergK/icn8528/blob/master/Androiddata/sysbusacpidev

there is no nothing with CHPN0001 as it is under vanilla linux 4.2.2

3) Dmesg  https://gitlab.com/SergK/icn8528/blob/master/Androiddata/andrdmesg
please note - there is also in it focal_tech mention - it strange but
the guys from Chuwi declared every possible variant in sysfs and  only
that is present in tablet revision (my is rev11 with chipone
icn8528.h) is initialized through corresponding linux module.

<6> : input: chipone-ts as /devices/virtual/input/input3
>> cat /devices/virtual/input/input3/modalias gives
>>
>> input:b000v0000p0000e0000-e0,1,3,k8B,9E,D9,ra2F,30,32,35,36,39,m1sfw
>> - I guess the key is m1sfw which means loaded firmware.

4) /proc/bus/input/devices
https://gitlab.com/SergK/icn8528/blob/master/Androiddata/procbusinputdevices

Kind regards,
                      Serge Kolotylo
