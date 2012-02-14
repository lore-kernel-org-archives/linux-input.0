From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH v2] bcm5974: Add pointer and buttonpad properties
Date: Tue, 14 Feb 2012 20:01:04 +0100
Message-ID: <4F3AAF70.7010904@canonical.com>
References: <1329233199-7424-1-git-send-email-chase.douglas@canonical.com> <20120214185216.GA28060@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44168 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756984Ab2BNTAo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Feb 2012 14:00:44 -0500
In-Reply-To: <20120214185216.GA28060@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmity Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 02/14/2012 07:52 PM, Henrik Rydberg wrote:
> Hi Chase,
> 
> On Tue, Feb 14, 2012 at 07:26:39AM -0800, Chase Douglas wrote:
>> In order to inform userspace of physical properties of the device.
>>
>> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
>> ---
>>  drivers/input/mouse/bcm5974.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
>> index 5ec617e..9faa049 100644
>> --- a/drivers/input/mouse/bcm5974.c
>> +++ b/drivers/input/mouse/bcm5974.c
>> @@ -434,6 +434,9 @@ static void setup_events_to_report(struct input_dev *input_dev,
>>  	__set_bit(BTN_LEFT, input_dev->keybit);
>>  
>>  	input_set_events_per_packet(input_dev, 60);
>> +
>> +	__set_bit(INPUT_PROP_POINTER, input->propbit);
>> +	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>>  }
>>  
>>  /* report button data as logical button state */
>> -- 
>> 1.7.9
>>
> 
> Applied, with fixes. The patch did not apply, and once resolved, did
> not compile. I trust you will test also the trivial patches in the future.

You're right, I compiled the other modules and tested, but I forgot this
one. It was a copy/paste error.

Thanks for fixing it, I'd be happy to fix it up in the future if there
are any issues.

-- Chase
