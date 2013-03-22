From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/7] HID: input: don't register unmapped input devices
Date: Fri, 22 Mar 2013 15:48:37 +0100
Message-ID: <514C6F45.5010006@redhat.com>
References: <1361984127-912-1-git-send-email-benjamin.tissoires@redhat.com> <1361984127-912-2-git-send-email-benjamin.tissoires@redhat.com> <20130319212511.GA7821@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2071 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862Ab3CVOtm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Mar 2013 10:49:42 -0400
In-Reply-To: <20130319212511.GA7821@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/19/2013 10:25 PM, Henrik Rydberg wrote:
> Hi Benjamin,
> 
>> There is no need to register an input device containing no events.
>> This allows drivers using the quirk MULTI_INPUT to register one input
>> per report effectively used.
>>
>> For backward compatibility, we need to add a quirk to request
>> this behavior.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> ---
>>  drivers/hid/hid-input.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/hid.h     |  1 +
>>  2 files changed, 78 insertions(+)
>>
>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> index 21b196c..7aaf7d3 100644
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -1198,6 +1198,67 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid)
>>  	return hidinput;
>>  }
>>  
>> +static bool hidinput_has_been_populated(struct hid_input *hidinput)
>> +{
>> +	int i;
>> +	bool r = 0;
>> +
>> +	for (i = 0; i < BITS_TO_LONGS(EV_CNT); i++)
>> +		r = r || hidinput->input->evbit[i];
> 
> I believe there is a bit count method that will do this for you (weight).
> 

Actually, weight does not work here. evbit[] is an array of long, and we
still need to check if each field of this array is not null.

Thus, the following can be used (r being a long here):
r |= hidinput->input->evbit[i];

Cheers,
Benjamin
