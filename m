From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] msm: trout: add keypad support
Date: Fri, 10 Dec 2010 13:02:06 +0530
Message-ID: <4D01D776.6000309@codeaurora.org>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>	 <4D00800E.7050004@codeaurora.org>	 <1291916733.18827.1.camel@c-dwalke-linux.qualcomm.com>	 <AANLkTi=3LHHNJUh35AUkq--KtRCnRaBHx8Ky2bhxxzE4@mail.gmail.com> <1291932216.18827.16.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:11190 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0LJHcJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 02:32:09 -0500
In-Reply-To: <1291932216.18827.16.camel@c-dwalke-linux.qualcomm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Daniel,

On 12/10/2010 3:33 AM, Daniel Walker wrote:
> On Thu, 2010-12-09 at 14:01 -0800, Arve Hj=C3=B8nnev=C3=A5g wrote:
>> On Thu, Dec 9, 2010 at 9:45 AM, Daniel Walker <dwalker@codeaurora.or=
g> wrote:
>>> On Thu, 2010-12-09 at 12:36 +0530, Trilok Soni wrote:
>>>
>>>>> +static char *keycaps =3D "--qwerty";
>>>>> +#undef MODULE_PARAM_PREFIX
>>>>> +#define MODULE_PARAM_PREFIX "board_trout."
>>>>> +module_param_named(keycaps, keycaps, charp, 0);
>>>>
>>>> I would like to know what is the use of this param?
>>>
>>> No idea .. It was part of Google's implementation ..
>>>
>>
>> You removed the code that uses it. If you look at the original file
>> you can see how it is used:
>> http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dblob;f=3Darch/=
arm/mach-msm/board-trout-keypad.c;hb=3Drefs/heads/android-msm-2.6.35
>> It is set by the bootloader according to the hardware version.
>>
>> You can also see that the "/* userspace needs to know about these
>> changes as well */" comments refer to the code that changes the name
>> of the input device.
>>
>> I don't think this change will work correctly with our existing
>> user-space code though since you are now reporting the power-key,
>> camera-key and slide-switch from a separate input device.
>=20
> Yeah, I did remove those parts.. I'm not sure where to put that stuff=
 in
> this new implementation. I can try to find an appropriate place , unl=
ess
> you have some suggestions ?

To support this, we need to override the input device .name and submit =
the patches
for matrix keypad and gpio keys and let the name come through platform =
data.=20

You can refer how I am doing in PM8058 keypad driver patch.

But the real question is why can't we just do this in userspace? we sho=
uld be able
to override the keymap using setkeycode functionality, isn't it?

---Trilok Soni

--=20
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
