From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH v2 6/8] HID: sony: Add an IDA allocator to assign unique
 device ids
Date: Thu, 13 Mar 2014 10:30:14 -0400
Message-ID: <5321C0F6.5090109@oh.rr.com>
References: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>	<1394145176-24174-7-git-send-email-frank.praznik@oh.rr.com> <20140310232526.4dde47de732f8498a58fb731@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:45846 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751260AbaCMOaS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Mar 2014 10:30:18 -0400
In-Reply-To: <20140310232526.4dde47de732f8498a58fb731@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>, Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, dh.herrmann@gmail.com

On 3/10/2014 18:25, Antonio Ospite wrote:
> Hi Frank,
>
> On Thu,  6 Mar 2014 17:32:54 -0500
> Frank Praznik <frank.praznik@oh.rr.com> wrote:
>
>> Add an IDA id allocator to assign unique, sequential device ids to Sixaxis and
>> DualShock 4 controllers.
>>
>> Use explicit module init and exit functions since the IDA allocator must be
>> manually destroyed when the module is unloaded.
>>
>> Use the device id as the unique number for the battery identification string.
>>
> Have you thought about using the bdaddr as the battery id?
>
> I think that decoupling led numbers (from the following patch) and
> battery ids would be saner. For instance in a scenario when userspace
> decided that the _second_ sixaxis has LEDs saying "controller
> 3" (because of different kind of joypads, remember?) we would have
> battery still saying "2" because the battery id is assigned at probe
> time while LEDs can change at any time. This mismatch may become
> confusing.
>

That's a good idea and it will match the naming scheme of the wiimote 
battery device, which I think is the only other game controller that 
reports battery status.  I'll make the change for v3.
