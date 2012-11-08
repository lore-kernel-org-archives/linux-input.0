From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: Why Cypress does not upstream its trackpad driver?
Date: Wed, 07 Nov 2012 16:00:52 -0800
Message-ID: <509AF634.2040500@gmail.com>
References: <CAFub=KTf2dWxM9=saG2JaNJpEioJM8rM3UBG9BkyxRN-+j0psQ@mail.gmail.com> <1352313131.2751.152.camel@fourier> <C825ADB6BE8AC2468577BFFCE7DF5B8A1F080FA111@VMBX133.ihostexchange.net> <EE629F2C-DD83-403C-AD73-E9ED966EEA91@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41485 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab2KHAA6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Nov 2012 19:00:58 -0500
In-Reply-To: <EE629F2C-DD83-403C-AD73-E9ED966EEA91@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Solda <dso@cypress.com>
Cc: Troy Abercrombia <ta@cypress.com>, Kamal Mostafa <kamal@canonical.com>, =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, customercare <customercare@cypress.com>, "mario_limonciello@dell.com" <mario_limonciello@dell.com>

On 11/07/2012 03:30 PM, David Solda wrote:
> Kamal,
>
> My name is Dave Solda and I would be happy to answer any other questi=
ons that you have. Troy's response is correct however as in order to su=
pport the default Linux mouse class, our firmware would also have to be=
 modified to do so, which cannot be done in system. Our packet protocol=
 maxes out at an 8 byte packet, which requires a change to the Linux st=
andard in this case.
>
> Our goal in working with canonical was to provide something on Linux =
that would support multi-touch and not only have default single finger =
movement supported.
>
> If I am mistaken and he Linux kernel would accept this, then we can p=
roceed to upstream, however all indications we have is that this patch =
would be rejected.  If you (or others on from the locus alias) have any=
 inputs, I would be happy to receive them.
>

Really you should ask yourselves:

1) What benefit do you enjoy by keeping the code out of the upstream ke=
rnel?

2) What are the benefits of having a driver for your hardware in the=20
upstream kernel?

If 2 > 1, then the course of action seems obvious.

Doing nothing because of some perceived impediment doesn't help anybody=
=2E

David Daney

> Dave
>
>
>
> On Nov 8, 2012, at 7:13 AM, "Troy Abercrombia" <ta@cypress.com> wrote=
:
>
>> Hello Kamal
>>
>> Unfortunately, We're not able to upstream the driver as it would be =
denied because it changes the Linux mouse structure framework.
>>
>> Thanks
>> Troy
>> -----Original Message-----
>> From: Kamal Mostafa [mailto:kamal@canonical.com]
>> Sent: Wednesday, November 07, 2012 10:32 AM
>> To: Ozan =C3=87a=C4=9Flayan
>> Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org; dmitr=
y.torokhov@gmail.com; customercare; mario_limonciello@dell.com
>> Subject: Re: Why Cypress does not upstream its trackpad driver?
>>
>> On Tue, 2012-11-06 at 17:47 -0500, Ozan =C3=87a=C4=9Flayan wrote:
>>> Hi,
>>>
>>> This driver [0] was written with a cooperation of Cypress, Dell and
>>> Canonical Engineers within the last 3-4 months. It is very nice tha=
t
>>> Cypress as a vendor cooperated with Canonical (Because Canonical wo=
rks
>>> with Dell for their Project Sputnik and Dell XPS13 is used as the m=
ain
>>> hardware for that project and Dell XPS13 has this type of trackpad,
>>> Bingo!), and I am also glad that Ubuntu users benefits from this
>>> driver.
>>>
>>> The driver brings multi-touch scrolling, disable-while-tapping and
>>> makes Fn+Fx touchpad disable/enable work for not only Dell XPS13 bu=
t
>>> for all laptops having this trackpad (My Lenovo Ultrabook U300s for
>>> example, I tested the patches on fedora 17's 3.6 kernel and it work=
s
>>> quiet nice)
>>>
>>> But what I am not getting that why NOBODY from Cypress/Canonical/De=
ll
>>> isn't bothering to push this driver to upstream?
>>
>>
>> In fact, Canonical is working on preparing the Cypress PS/2 trackpad=
 driver for submitting upstream.
>>
>>
>>> Is it too hard? I don't think so as the patches are quite non-invas=
ive
>>> and small.
>>
>>
>> Your estimate of the work/risk involved not withstanding, I chose to=
 deploy this experimental driver in stages -- first in the oem-specific=
 "Sputnik project" kernel, then (recently) in the main Ubuntu kernel, t=
hen finally (soon) upstream -- so as to minimize regressions while shak=
ing out the bugs.  For example, the version to which you linked does in=
clude a regression (breaks some ALPS touchpads) which we discovered onl=
y after deploying in Ubuntu.
>>
>> I expect to submit the Cypress driver upstream within two weeks.  Of=
 course, my work on the driver is (and has been) publicly available[1].
>>
>> -Kamal Mostafa <kamal@canonical.com>
>>
>> [1] The latest version of this driver is represented by the patch se=
t:
>>     http://kernel.ubuntu.com/git?p=3Dubuntu%2Fubuntu-quantal.git&a=3D=
search&h=3DHEAD&st=3Dcommit&s=3DCypress+PS%2F2
>>
>>
>>>
>>> Is the only distribution around is Ubuntu?
>>> Is the only laptop sold in the world is Dell XPS13 with an Ubuntu?
>>>
>>> I'm not trying to be impolite but it hurts me to see that a vendor
>>> produces an open-source driver for its device but makes use of it o=
nly
>>> through a specific distribution.
>>>
>>> If Cypress is just beginning developing open-source drivers for the=
ir
>>> devices, I hope that after this mail they will be much sensitive ab=
out
>>> the issue and push their drivers even before the release of their
>>> devices to make user experience flawless.
>>>
>>> (I googled and searched the archives of LKML and linux-input but
>>> couldn't find a discussion or patch series about the driver. If I
>>> missed it, ignore the whole stuff above)
>>>
>>> [0]: http://patchwork.ozlabs.org/patch/178903/
>>
>
> This message and any attachments may contain Cypress (or its subsidia=
ries) confidential information. If it has been received in error, pleas=
e advise the sender and immediately delete this message.
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BDzX=EF=BF=BD=EF=BF=BD=17=EF=BF=BD=EF=BF=BD=DC=
=A8}=EF=BF=BD=EF=BF=BD=EF=BF=BD=C6=A0z=EF=BF=BD&j:+v=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD+zf=EF=
=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BDi=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=
=BF=BD=EF=BF=BD=EF=BF=BD?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD=
)=DF=A2=1Bf=EF=BF=BD=EF=BF=BD^j=C7=ABy=EF=BF=BDm=EF=BF=BD=EF=BF=BD@A=EF=
=BF=BDa=EF=BF=BD=EF=BF=BD=7F=EF=BF=BD=0C0=EF=BF=BD=EF=BF=BDh=EF=BF=BD=0F=
=EF=BF=BDi=7F
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
