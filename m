From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Thu, 18 Aug 2011 14:01:42 +0800
Message-ID: <CAGS+omDT1WNBoC-T4zmKx1SnVofLwUdt-pfQDWGicO87xUBqxw@mail.gmail.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw>
 <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw> <4E4C80A0.8090708@cn.fujitsu.com>
 <87d3g347ey.fsf@emc.com.tw> <4E4CA3A9.2010900@cn.fujitsu.com>
 <CAGS+omB0Ys-vEVq64W85Jmsz=TkgvNqn_iJkxynZJr8wvqifGQ@mail.gmail.com> <4E4CA6B4.5060807@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:31342 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1HRGCG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 02:02:06 -0400
Received: from hpaq13.eem.corp.google.com (hpaq13.eem.corp.google.com [172.25.149.13])
	by smtp-out.google.com with ESMTP id p7I624fv030327
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 23:02:04 -0700
Received: from iym1 (iym1.prod.google.com [10.241.52.1])
	by hpaq13.eem.corp.google.com with ESMTP id p7I622Bn020242
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 23:02:03 -0700
Received: by iym1 with SMTP id 1so2813723iym.14
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 23:02:02 -0700 (PDT)
In-Reply-To: <4E4CA6B4.5060807@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On Thu, Aug 18, 2011 at 1:44 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com=
> wrote:
> On 08/18/2011 01:34 PM, Daniel Kurtz wrote:
>>
>> On Thu, Aug 18, 2011 at 1:31 PM, Wanlong Gao<gaowanlong@cn.fujitsu.c=
om>
>> =A0wrote:
>>>
>>> On 08/18/2011 01:26 PM, JJ Ding wrote:
>>>>
>>>> Hi Wanlong Gao,
>>>>
>>>> On Thu, 18 Aug 2011 11:01:52 +0800, Wanlong
>>>> Gao<gaowanlong@cn.fujitsu.com>
>>>> =A0wrote:
>>>>>
>>>>> On 08/18/2011 09:57 AM, JJ Ding wrote:
>>>>>>
>>>>>> v3 hardware's packet format is almost identical to v2 (one/three
>>>>>> finger
>>>>>> touch),
>>>>>> except when sensing two finger touch, the hardware sends 12 byte=
s of
>>>>>> data.
>>>>>>
>>>>>> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
>>>>>> ---
>>>>>> =A0 Documentation/input/elantech.txt | =A0104 ++++++++++++++++--
>>>>>> =A0 drivers/input/mouse/elantech.c =A0 | =A0218
>>>>>> ++++++++++++++++++++++++++++++++++---
>>>>>> =A0 drivers/input/mouse/elantech.h =A0 | =A0 11 ++
>>>>>> =A0 3 files changed, 303 insertions(+), 30 deletions(-)
>>>>>>
>>>>>> +static int determine_packet_v3(struct psmouse *psmouse)
>>>>>
>>>>> elantech_check_parity_v1
>>>>> packet_simple_check_v2
>>>>> determine_packet_v3
>>>>>
>>>>> Why not consistent them?
>>>>
>>>> OK, how do these names sound to you?
>>>>
>>>> elantech_check_parity_v1
>>>> elantech_packet_check_v2
>>>> elantech_packet_check_v3
>>>>
>>>> Thanks,
>>>> jj
>>>
>>> Yeah, sounds perfectly.
>>
>> Or just:
>>
>> elantech_packet_check_v1
>> elantech_packet_check_v2
>> elantech_packet_check_v3
>>
>> :)
>
> Hmm... maybe they can go into an elantech_packet_check()?
> like:
> case 1:
> =A0 =A0 =A0 =A0...
> case 2:
> =A0 =A0 =A0 =A0...
> What do you think? ;)
>
> Thanks
> -Wanlong Gao

Since we've already parsed the hardware type at this point, it seems
inefficient to parse it again inside another function.
I would prefer individual functions.

Thanks,
-Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
