From: Jaikumar Ganesh <jaikumarg@gmail.com>
Subject: Re: hid-magicmouse driver race condition (second try)
Date: Fri, 16 Sep 2011 15:15:04 -0700
Message-ID: <CACMz=xi+5jPBCXjB2Kc5x31xRN1ebmQTCvjBH1jKUkLuf_xV9w@mail.gmail.com>
References: <CACMz=xj=85kVEvu7RS5Zbaj2tE5ihu-owgUVDnq9u+0nPuC2+w@mail.gmail.com>
 <CACMz=xiYUcGmot1RcBDste2nivt9pvXNRDOLMoX+CvdYGpmf_Q@mail.gmail.com> <CAOU-OAKYa2sWw1KQFQEfp5wjcXr1AW8gfEYUj5teLY6pQxvPjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:42135 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab1IPWPY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 18:15:24 -0400
Received: by gwb17 with SMTP id 17so5009264gwb.1
        for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 15:15:24 -0700 (PDT)
In-Reply-To: <CAOU-OAKYa2sWw1KQFQEfp5wjcXr1AW8gfEYUj5teLY6pQxvPjg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org, Chase Douglas <chase.douglas@canonical.com>

Hello,

On Fri, Sep 16, 2011 at 12:23 PM, Michael Poole <mdpoole@troilus.org> w=
rote:
> On Fri, Sep 16, 2011 at 3:15 PM, Jaikumar Ganesh <jaikumarg@gmail.com=
> wrote:
>> Hello,
>>
>> On Thu, Sep 15, 2011 at 5:28 PM, Jaikumar Ganesh <jaikumarg@gmail.co=
m> wrote:
>>> Resending as the first email bounced.
>>> --------
>>> Folks,
>>> =A0 There is a race condition in hid-magicmouse driver that I am
>>> encountering. In the probe function, we call magicmouse_setup_input
>>> after hid_hw_start which calls
>>> hidinput_connect.
>>>
>>> So if a userspace thread scans "/dev" to see if there is a new inpu=
t
>>> device and on seeing the new magicmouse device added, makes the ioc=
tl
>>> call EVCIOGBIT for EV_ABS or EV_KEY or any other type it will get
>>> wrong values as magicmouse_setup_input has not been called yet.
>>>
>>> So these keybits will change under the hood for the userspace progr=
am
>>> on an open file descriptor.
>>>
>>> I am able to reproduce this race condition easily. To verify the
>>> above, as a hack, I called magicmouse_setup_input just before calli=
ng
>>> input_register_device in hidp_connect and things were fine.
>>>
>>> We were not using hidp-input parser but in the following commit we
>>> moved to it which introduced the race condition:
>>>
>>> commit 64eb105d7f92fa48798106ac0d8bf17668eb2524
>>> Author: Michael Poole <mdpoole@troilus.org>
>>> Date: =A0 Fri Sep 24 13:58:18 2010 +0200
>>>
>>> =A0 =A0HID: magicmouse: Use hid-input parsing rather than bypassing=
 it
>>>
>>> Any pointers for a clean fix ? Do we want to add a new field to
>>> hid_driver structure so that we can use it to call from hid-input t=
o
>>> indicate parsing is done before the input device is registered ?
>>
>> I had a look at the hid-apple.c driver which also has a setup_input =
function.
>>
>> But that function is called inside input_mapping - so that gets call=
ed
>> every single time input_mapping is called.
>> That will fix this issue too, but seems like an overkill to call
>> magicmouse_setup_input every single time in input_mapping.
>
> Perhaps it is worth doing that, but adding a flag so that the bulk of
> magicmouse_setup_input() only runs once.

I had a patch already ready with this flag, just sent to the list.
Have referenced this discussion.

>
> (I can write and test a patch on Monday, once I get network access at=
 home.)
>
> Michael
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
