From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH] HID: usbhid: extend polling interval configuration to
 joysticks
Date: Mon, 6 Mar 2017 14:54:27 +0100
Message-ID: <0d451be5-0c26-c8ed-b67c-042be022e3d2@math.uni-bielefeld.de>
References: <1488050847-6250-1-git-send-email-tjakobi@math.uni-bielefeld.de>
 <alpine.LSU.2.20.1703061435060.31814@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:52087 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753002AbdCFOBA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 09:01:00 -0500
In-Reply-To: <alpine.LSU.2.20.1703061435060.31814@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Sat, 25 Feb 2017, Tobias Jakobi wrote:
> 
>> For mouse devices we can currently change the polling interval
>> via usbhid.mousepoll. Implement the same thing for joysticks, so
>> users can reduce input latency this way.
>>
>> This has been tested with a Logitech RumblePad 2 with jspoll=2,
>> resulting in a polling rate of 500Hz (verified with evhz).
>>
>> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> 
> Applied to for-4.12/upstream. Thanks,
Thank you as well! :)

- Tobias

