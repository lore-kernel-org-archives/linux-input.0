From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v2 07/18] HID: wacom: generic: Support and use 'Custom
 HID' mode and usages
Date: Tue, 18 Oct 2016 10:09:40 -0700
Message-ID: <ad4c3179-8c01-cb04-9ad4-2af49c07ca8c@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161007221653.26941-1-killertofu@gmail.com>
 <20161007221653.26941-7-killertofu@gmail.com>
 <alpine.LNX.2.00.1610181725150.31629@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33817 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755582AbcJRRJt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Oct 2016 13:09:49 -0400
Received: by mail-pf0-f170.google.com with SMTP id r16so7308pfg.1
        for <linux-input@vger.kernel.org>; Tue, 18 Oct 2016 10:09:49 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1610181725150.31629@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On 10/18/2016 08:26 AM, Jiri Kosina wrote:
> On Fri, 7 Oct 2016, Jason Gerecke wrote:
> 
>> @@ -1711,7 +1736,7 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
>>  
>>  
>>  	if (usage->usage_index + 1 == field->report_count) {
>> -		if (usage->hid == wacom_wac->features.last_slot_field)
>> +		if (equivalent_usage == wacom_wac->features.last_slot_field)
> 
> What tree is this based on please? In all the codebase I have, 
> last_slot_field is a member field of wacom_wac's hid_data, not a member of 
> struct wacom_features.
> 

This was based on your for-4.9/wacom tree, whose tip (for me) was commit
1924e05 ("HID: wacom - add touch_arbitration parameter to wacom module").

It looks like my tree only has commit 601a22f ("HID: wacom: Report input
events for each finger on generic devices") but not commit 003f50a
("HID: wacom: Update last_slot_field during pre_report phase"). Not sure
why though.

What would you like me to do?

Jason
---
Now instead of four in the eights place /
you’ve got three, ‘Cause you added one /
(That is to say, eight) to the two, /
But you can’t take seven from three, /
So you look at the sixty-fours....
