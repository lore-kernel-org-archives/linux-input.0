From: Tim Schumacher <timschumi@gmx.de>
Subject: Re: [PATCH 01/20] Input: iforce - remove "being used" silliness
Date: Wed, 12 Jun 2019 16:44:00 +0200
Message-ID: <3505434a-f5ec-de50-5f94-7347c6926f40@gmx.de>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
 <0541f46d-1f4f-05f4-8e93-6663f6c13bd9@gmx.de>
 <20180919171039.GA116719@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919171039.GA116719@dtor-ws>
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 19.09.18 19:10, Dmitry Torokhov wrote:
> On Wed, Sep 19, 2018 at 04:51:26PM +0200, Tim Schumacher wrote:
>> On 18.09.18 02:47, Dmitry Torokhov wrote:
>>> The kernel is supposed to handle multiple devices, static flags
>>> in packet handling code will never work.
>>>
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> ---
>>>
>>> This is a random assortment of iforce patches that I made a few weeks =
back.
>>>
>>> Tim, I do not have hardware, so I was bound to screw it up, but if you
>>> have some time I'd appreciate if you try them out (and if I indeed bro=
ke
>>> things if you could identify issues that would be even more awesome).
>>>
>>> Thanks!
>>>
>> Hello Dmitry,
>>
>> I tested those patches and I didn't find any obvious issues. The basic =
functions
>> do work (i.e. buttons and axes, don't have a HAT so I can't test that),=
 force
>> feedback seems to work to the extent it was before (I only have fftest =
though,
>> no games that support force feedback). I'll go through a few more appli=
cations
>> and see if anything not obvious is broken.
>>
>
> Thank you for taking a look.
>
>> Unfortunately, I only have that one wheel and I can only test USB conne=
ctions
>> at the moment (unless I find a proper serial adaptor, but I'm not sure =
if that
>> would even work).
>>
>> Are those patches planned to go into 4.19 or are they intended to be me=
rged in
>> the next development cycle?
>
> Definitely not 4.19. Could be 4.20 or 4.21...
>
> Thanks.
>

Hello Dmitry,

as a followup to the last E-Mail I sent about this topic, the complete cha=
in
of patches has been in my personal tree since September of 2018 and there
have been no issues so far as well. I tested a few more games and utilitie=
s,
and I was able to test with multiple wheels simultaneously as well.

In the end it's still your decision, but imo those patches should be fine
to pull in.

Tim
