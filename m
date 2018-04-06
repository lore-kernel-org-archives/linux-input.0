From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 3/8] Input: elan_i2c - add trackstick report
Date: Fri, 6 Apr 2018 08:51:47 +0200
Message-ID: <CAO-hwJKiKPYH30oi45AejPEdNA+=EWM_wiSiQDc0Rj=9X31NXg@mail.gmail.com>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
 <20180405132537.3218-4-benjamin.tissoires@redhat.com> <20180405234632.GA57189@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180405234632.GA57189@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 6, 2018 at 1:46 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Benjamin,
>
> On Thu, Apr 05, 2018 at 03:25:32PM +0200, Benjamin Tissoires wrote:
>> The Elan touchpads over I2C/SMBus also can handle a
>> trackstick. Unfortunately, nothing tells us if the
>> device supports trackstick (the information lies in
>> the PS/2 node), so rely on a platform data to enable
>> or not the trackstick node.
>
> Hmm, I'd prefer if we did not add more platform data but rather user
> generic device properties.
>

Fair enough, I'll work on it for v2.

Cheers,
Benjamin
