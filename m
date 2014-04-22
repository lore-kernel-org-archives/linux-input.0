From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH 0/6] input: cyapa: integrated with gen5 trackpad
 supported in one driver.
Date: Tue, 22 Apr 2014 08:39:43 +0000
Message-ID: <77BC725C9062764F874D79F51E1F1A8F40C153FF@S04-MBX01-01.s04.local>
References: <77BC725C9062764F874D79F51E1F1A8F40C1404A@S04-MBX01-01.s04.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <77BC725C9062764F874D79F51E1F1A8F40C1404A@S04-MBX01-01.s04.local>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
To: "Dmitry Torokhov (dmitry.torokhov@gmail.com)" <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@google.com>, Daniel Kurtz <djkurtz@google.com>, David Solda <dso@cypress.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Could you help review the patches of input: cyapa for re-architecture and supporting new trackpad devices, I'm really looking forward your responses.

Thanks,
Dudley


> This patch set is made based on kernel 3.14.0. It's aimed to re-architecture the cyapa driver to support the old gen3 trackpad device and new gen5 trackpad device in one cyapa driver for easily products support based on customers' requirements, and add sysfs functions and interfaces supported that required by users and customers.
>
> Beside this patch, it has 6 patches listed as below.
> For these patches each one is patched based on previous one.
>
> patch 1/6: change the architecture of cyapa driver to support function pointers and applying the device proble function in async thread to speed up system boot time.
>
> patch 2/6: add gen5 trackpad devices supported in cyapa driver.
>
> patch 3/6: add full power mode and runtime power mode supported.
>
> patch 4/6: enable/disable trackpad device based on LID state.
>
> patch 5/6: add sysfs interfaces supported for gen3 trackpad device.
>
> patch 6/6: add sysfs interfaces supported for gen5 trackpad device.
This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
