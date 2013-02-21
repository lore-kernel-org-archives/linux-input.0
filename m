From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH 3/3] HID: sensor-hub: don't limit the driver only to USB
 bus
Date: Thu, 21 Feb 2013 11:52:37 +0100
Message-ID: <5125FC75.3000301@ahsoftware.de>
References: <1360578679-7029-1-git-send-email-mika.westerberg@linux.intel.com> <1360578679-7029-3-git-send-email-mika.westerberg@linux.intel.com> <51220A68.9030608@ahsoftware.de> <20130218111217.GL20771@intel.com> <51220F12.2060908@ahsoftware.de> <20130218113320.GA2338@intel.com> <51221290.1040005@ahsoftware.de> <20130218115429.GB2338@intel.com> <51221AFD.1090108@ahsoftware.de> <CAN+gG=EfFBhpvs1zHMtkwiGu0J4kEzSTJBnyqmc=9Eq+kqqkLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:54858 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab3BUKwu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Feb 2013 05:52:50 -0500
In-Reply-To: <CAN+gG=EfFBhpvs1zHMtkwiGu0J4kEzSTJBnyqmc=9Eq+kqqkLQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, srinivas.pandruvada@intel.com

Am 21.02.2013 11:34, schrieb Benjamin Tissoires:
> Hi,
>
> Sorry for coming this late in the discussion (I was sick at the
> beginning of the week, preventing me to answer mails).
>
> On Mon, Feb 18, 2013 at 1:13 PM, Alexander Holler <holler@ahsoftware.de> wrote:
>>>>>>>> Hmm, what happens with Bluetooth sensor-hubs? Is the driver now able
>>>>>>>> to handle them too?
>>>>>>>
>>>>>>>
>>>>>>> It should, yes.
>>>>>>
>
> It should, but the full features are not enabled. We also need to
> patch hidp so that it can handle .request() too. Otherwise, when the
> sensor hub will request a "get feature" or a "set feature", then
> nothing will be triggered.
>
> However, I don't think it will prevent us from removing the test
> against USB/I2C. It's just something we need to work on too.

Thanks. I've just ordered me one of those bt-sensors from TI, maybe I 
will be able to make it HID over GATT aware to play a bit with it. The 
BT spec for HID over GATT doesn't talk about sensors, but if I will find 
a way to program the device without buying more hw, I will have a look 
if it is possible. ;)

Regards,

Alexander
