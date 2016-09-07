From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [HP Pavilion x2 - 12-b003nf] Synaptics touchpad not configured by
 HID RMI
Date: Wed, 7 Sep 2016 16:50:09 -0700
Message-ID: <67fdd18c-7de9-e234-9c00-e6b48f4a77ea@synaptics.com>
References: <CAFR8dhoR2U7QPEvSzho-NNMFnhvRaWVjzf0EF24B8JCsdbyAcQ@mail.gmail.com>
 <6b27a65c-fbc2-4af3-d611-edbb83627dc4@synaptics.com>
 <CAFR8dhpHigvG=2ovb7bVSgB8+3ARRB0rTxzqtwUHjdJB1w4D5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:1519 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbcIGXuK (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2016 19:50:10 -0400
In-Reply-To: <CAFR8dhpHigvG=2ovb7bVSgB8+3ARRB0rTxzqtwUHjdJB1w4D5Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?St=c3=a9phane_RIVIERE?= <greenskol@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>


On 09/07/2016 11:24 AM, Stéphane RIVIERE wrote:
> Hi Andrew,
>
> On Wed, Sep 7, 2016 at 1:53 AM, Andrew Duggan <aduggan@synaptics.com> wrote:
>
>> I have these patches along with a couple others applied to v4.8-rc5 here if
>> you want to test:
>> https://github.com/aduggan/linux
>>
>> Or if you want to something more stable here are the patches applied to
>> v4.7.2:
>> https://github.com/aduggan/linux/tree/4.7.2/synaptics-rmi4/hid-rmi
>>
> Do you want me to test one of them to see if it works or should I
> simply wait for your patches to be accepted and then test the offical
> kernel version that includes them?
>

It is up to you. If you test now we can confirm that these patches fix 
the problem for this system. Or if you want to wait that's fine too. I 
merged the patches to v4.7.2 in case it worked and you wanted to run a 
stable kernel which had support for your touchpad.

Andrew

>> Andrew
>>

