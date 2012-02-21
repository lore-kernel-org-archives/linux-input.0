From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] hid-magicmouse: Add pointer and buttonpad properties
 for Magic Trackpad
Date: Tue, 21 Feb 2012 12:17:26 +0100
Message-ID: <4F437D46.6090604@canonical.com>
References: <1329192751-6041-1-git-send-email-chase.douglas@canonical.com> <alpine.LNX.2.00.1202211152220.31150@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40603 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab2BULR3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 06:17:29 -0500
In-Reply-To: <alpine.LNX.2.00.1202211152220.31150@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On 02/21/2012 11:52 AM, Jiri Kosina wrote:
> On Mon, 13 Feb 2012, Chase Douglas wrote:
> 
>> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
>> ---
>>  drivers/hid/hid-magicmouse.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
>> index 2ab7175..7cf3ffe 100644
>> --- a/drivers/hid/hid-magicmouse.c
>> +++ b/drivers/hid/hid-magicmouse.c
>> @@ -418,6 +418,8 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
>>  		__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
>>  		__set_bit(BTN_TOOL_QUADTAP, input->keybit);
>>  		__set_bit(BTN_TOUCH, input->keybit);
>> +		__set_bit(INPUT_PROP_POINTER, input->propbit);
>> +		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>>  	}
>>  
>>  	if (report_touches) {
> 
> Applied, although a bit more verbose commit message would be welcome next 
> time :)

Will you push this for 3.3, or keep it for 3.4?

-- Chase
