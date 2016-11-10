From: Hn Chen <hn.chen@weidahitech.com>
Subject: RE: [PATCH v3] HID:i2c-hid: add a simple quirk to fix device defects
Date: Thu, 10 Nov 2016 09:19:19 +0000
Message-ID: <22498D53301C4D4A8FFA8F02C7C3C7C06DDE767C@mail02.WHT.local>
References: <1478749633-28185-1-git-send-email-hn.chen@weidahitech.com>
 <alpine.LNX.2.00.1611100940020.29400@cbobk.fhfr.pm>
 <22498D53301C4D4A8FFA8F02C7C3C7C06DDE7669@mail02.WHT.local>
 <alpine.LNX.2.00.1611101014150.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2512 "EHLO
        ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbcKJJTh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 04:19:37 -0500
In-Reply-To: <alpine.LNX.2.00.1611101014150.29400@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Jiri,

Thanks !

Hn.chen.

-----Original Message-----
From: Jiri Kosina [mailto:jikos@kernel.org] 
Sent: Thursday, November 10, 2016 5:15 PM
To: Hn Chen
Cc: benjamin.tissoires@redhat.com; dmitry.torokhov@gmail.com; linux-input@vger.kernel.org
Subject: RE: [PATCH v3] HID:i2c-hid: add a simple quirk to fix device defects

On Thu, 10 Nov 2016, Hn Chen wrote:

> Hi Jiri,
> 
> We had a proprietary driver for WDT8756 in /input/touchscreen.
> Just thought the product_id might be useful in the future.
> Should I remove it out ?

Yeah, please bring it in only if it's actually used in code. I will remove it while applying the patch, no need for you to resubmit just because of this.

--
Jiri Kosina
SUSE Labs

