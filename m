From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: Synaptics RMI4 touchpad regression in 4.11-rc1
Date: Tue, 14 Mar 2017 18:20:03 -0700
Message-ID: <6122ac54-4393-e230-a3e8-16f337874f2b@synaptics.com>
References: <375e67b5-2cb8-3491-1d71-d8650d6e9451@gmail.com>
 <7964888d-05dd-b109-973a-e0503884e2e2@leemhuis.info>
 <20170313131356.GH4378@mail.corp.redhat.com>
 <20170313131537.GI4378@mail.corp.redhat.com>
 <07543e67-efef-a764-02e6-d81d30b89a1c@synaptics.com>
 <03d8e6ac-1ba4-36a6-cc07-0c07e61f754f@gmail.com>
 <51f05200-4fc7-9c63-c2c4-bc8d989b1732@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:25548 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdCOBUP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 21:20:15 -0400
In-Reply-To: <51f05200-4fc7-9c63-c2c4-bc8d989b1732@leemhuis.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thorsten Leemhuis <linux@leemhuis.info>, Cameron Gutman <aicommander@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: nick@shmanahar.org, cheiny@synaptics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/14/2017 01:14 AM, Thorsten Leemhuis wrote:
> Lo! On 14.03.2017 06:10, Cameron Gutman wrote:
>> On 03/13/2017 06:35 PM, Andrew Duggan wrote:
>>> On 03/13/2017 06:15 AM, Benjamin Tissoires wrote:
>>>> On Mar 13 2017 or thereabouts, Benjamin Tissoires wrote:
>>>>> On Mar 13 2017 or thereabouts, Thorsten Leemhuis wrote:
>>>>>> Lo! On 12.03.2017 02:55, Cameron Gutman wrote:
>>>>>>> […]
>>>>>>> Compared to hid-multitouch, the RMI stack seems to have completely broken
>>>>>>> palm rejection and introduced some random jumpiness during fine pointing
>>>>>>> motions. […]
>>>>>> Just to confirm: I noticed "jumpiness during fine pointing motions" as
>>>>>> well since switching to 4.11-rc.
>>>> One of my test systems is a XPS 13 9343 and I have not really
>>>> seen any jumpiness. But, based on the data I am seeing that if I
>>>> lift my finger and place it again in a short period of time the
>>>> first event or so will be at the location of the previous
>>>> contact. Then it will switch over to the current location. When
>>>> switching over to hid-multitouch I was unable to reproduce this
>>>> behavior. This definitely could be the source of the jumps.
>> The jumpiness definitely happens without lifting my finger, but I'm willing
>> to test any patch you think would improve the situation. Moving one finger
>> slowly in a figure-8 across my touchpad shows the issue clearly for me. The
>> small variations in speed of my finger due to the friction on the trackpad
>> get magnified to relatively large jumpy pointer movements on screen. It
>> seems much more noticeable in diagonal movements than completely vertical
>> or horizontal movements.
> @Andrew: Is there anything we can do to help track this down? A
> evemu-record of some movements or something like that? Or do we need to
> bring Peter into the loop in case it has something to do with libinput?

Yes, collecting some evemu-record logs of the jumps would be useful. 
Only after installing Fedora 25 was I able to see jumps while moving 
diagonally. I'm interested in seeing what others record and if it is the 
same as what I saw. The log of the jump did show the jump on Fedora 25. 
But, I did not see the jump with Ubuntu 16.10 with libinput 1.4.3.

Andrew

> Ciao, Thorsten


