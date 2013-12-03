From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: logitech-dj: add HIDRAW dependency in Kconfig
Date: Tue, 3 Dec 2013 15:03:52 +0100
Message-ID: <CAE7qMroSinrr21hq60bXok8yKDRhjdWq+otGq8VOpV4sadzGAQ@mail.gmail.com>
References: <1386026244-21553-1-git-send-email-ogay@logitech.com>
 <alpine.LNX.2.00.1312030852410.24931@pobox.suse.cz> <CAFLMSp-7X568ZdZ-JAAX9ttmMFhYP+DeLuc_-yCw1WCuvVAHng@mail.gmail.com>
 <alpine.LNX.2.00.1312031350130.24931@pobox.suse.cz> <CAE7qMrq6YzvprAGDTO8uEU9WZXXGpP=TG_OxB6=-1KuF1Tr8sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39411 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753402Ab3LCOKn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Dec 2013 09:10:43 -0500
Received: by mail-ve0-f181.google.com with SMTP id oy12so10460682veb.12
        for <linux-input@vger.kernel.org>; Tue, 03 Dec 2013 06:10:42 -0800 (PST)
In-Reply-To: <CAE7qMrq6YzvprAGDTO8uEU9WZXXGpP=TG_OxB6=-1KuF1Tr8sg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Olivier Gay <ogay@logitech.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mathieu Meisser <mmeisser@logitech.com>

Sorry, no html now.


On Tue, Dec 3, 2013 at 3:01 PM, Nestor Lopez Casado
<nlopezcasad@logitech.com> wrote:
>
>
>
>
> On Tue, Dec 3, 2013 at 1:51 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>>
>> On Tue, 3 Dec 2013, Olivier Gay wrote:
>>
>> > Without hidraw driver, we get this:
>> >
>> > <3>[  210.131988] logitech-djreceiver 0003:046D:C52B.0005: claimed by
>> > neither input, hiddev nor hidraw
>> > <3>[  210.132202] logitech-djreceiver 0003:046D:C52B.0005:
>> > logi_dj_probe:hid_hw_start returned error
>> >
>> > In logi_dj_probe, we call hid_hw_start with HID_CONNECT_DEFAULT
>> > argument and if hidraw driver is not present, the call fails and we
>> > return an error in logi_dj_probe.
>> >
>> > > It's clear that without hidraw it's not possible to change the pairing
>> > > from userspace, but I fail to see why probing the receiver should be
>> > > affected?
>> >
>> > As of today, hid-logitech-dj.c depends on hidraw API to work. All HID
>> > reports sent to control / configure the receiver are sent using hidraw
>> > API. That's why we fail logi_dj_probe if we cannot connect to hidraw.
>>
>> Hmm, so unifying receiver is not claimed by hid-input at all?
>> (HID_CONNECT_DEFAULT also contains HID_CONNECT_HIDINPUT) How so?
>>
>> (again, I will not be able to test it with my receiver up until the day
>> after tomorrow).
>
> The unifying receiver has 3 usb interfaces. When hid-logitech-dj driver is loaded, interfaces 0 and 1 are discarded.
>
> Interface 2 consists of a hid class interface with 3 collections, each of which sports the 'vendor' usage, thus, there is no reason for hid_input to claim any of them. On the other hand, hidraw has no issue in claiming the collections, even if they are 'vendor'. As of today, hid-logitech-dj uses hidraw api to send configuration/control reports to interface 2 of the Unifying receiver.
>
> Without the hid-logitech-dj driver, interfaces 0 and 1 are claimed by hid-input, as they correspond to a keyboard and a mouse. But that is not relevant to the discussion.
>>
>>
>> Thanks,
>>
>> --
>> Jiri Kosina
>> SUSE Labs
>
> Cheers,
> -nestor
>
