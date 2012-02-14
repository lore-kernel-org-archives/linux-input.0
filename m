From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH resend] bcm5974: Add pointer and buttonpad properties
Date: Tue, 14 Feb 2012 16:23:48 +0100
Message-ID: <4F3A7C84.4000901@canonical.com>
References: <1329193448-15219-1-git-send-email-chase.douglas@canonical.com> <20120214151903.GA5616@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43032 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2BNPX1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Feb 2012 10:23:27 -0500
In-Reply-To: <20120214151903.GA5616@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 02/14/2012 04:19 PM, Henrik Rydberg wrote:
> Hi Chase,
> 
> On Mon, Feb 13, 2012 at 08:24:08PM -0800, Chase Douglas wrote:
>> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
>> ---
>> I sent to the wrong mailing list address the first time. Sorry!
>>
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
> I can take this for 3.4, but the patch needs a commit message. "In
> order to move userspace in the direction of simpler and more accurate
> device setup, emit device properties..."?

I can add that, it's just superfluous. It doesn't really tell the reader
anything if they need to know what is going on. Unless the message is
supposed to copy the definition of the properties themselves, which is
rather pointless.

It's like documenting a function:

bool is_object_mutable();
Returns true if object is mutable;

There's really no point.

I'll send a v2 version of this patch with some kind of commit message
just to get it over with, but I don't know where the insistence of a
commit message body comes from...

-- Chase
