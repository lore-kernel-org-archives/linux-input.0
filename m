From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH resend] Input: silead - Add support for capactive home
 button found on some x86 tablets
Date: Sat, 14 Oct 2017 10:34:23 +0200
Message-ID: <a2efc457-5c23-2327-948a-e85e780b7e03@redhat.com>
References: <20171011094606.6455-1-hdegoede@redhat.com>
 <20171013234846.35vwp5m7qc3biamd@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751109AbdJNIe1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 14 Oct 2017 04:34:27 -0400
In-Reply-To: <20171013234846.35vwp5m7qc3biamd@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

Hi,

On 14-10-17 01:48, Dmitry Torokhov wrote:
> On Wed, Oct 11, 2017 at 11:46:06AM +0200, Hans de Goede wrote:
>> On some x86 tablets with a silead touchscreen the windows logo on the
>> front is a capacitive home button. Touching this button results in a touch
>> with bits 12-15 of the Y coordinates set, while normally only the lower 12
>> are used.
> 
> Do we know which ones?

Not really, but since we need to pass resolution info, etc. through
device-properties (set in drivers/platform/x86/silead_dmi.c) we
could add a device-property for this, this should also work for
devicetree based models (although I've only seen the capacitive
home button as the Windows logo on X86 hardware so far).

> Can we only set it in capabilities for devices
> that actually have it?

If we add a device property for it, yes. I guess that is how
you want me to handle this, so you will want a v2 which
keys the enabling of the home button from a device-prop ?

Regards,

Hans
