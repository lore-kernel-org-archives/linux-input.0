From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/3] xen: Sync up with the canonical protocol definitions in Xen
Date: Tue, 12 Jun 2018 23:11:50 -0700
Message-ID: <D53587A2-5B1B-4D8F-8772-04D453B93D38@gmail.com>
References: <20180612074856.28451-1-andr2000@gmail.com> <20180612074856.28451-2-andr2000@gmail.com> <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com> <20180612234020.GI38773@dtor-ws> <3605901d-4a72-3f5a-6d74-cb13d2414a0b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3605901d-4a72-3f5a-6d74-cb13d2414a0b@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, lyan@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On June 12, 2018 10:49:31 PM PDT, Oleksandr Andrushchenko <andr2000@gmail=
=2Ecom> wrote:
>On 06/13/2018 02:40 AM, Dmitry Torokhov wrote:
>> On Tue, Jun 12, 2018 at 03:46:10PM +0200, Juergen Gross wrote:
>>> On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam=2Ecom>
>>>>
>>>> This is the sync up with the canonical definitions of the input,
>>>> sound and display protocols in Xen=2E
>>>>
>>>> Changes to kbdif:
>>>> 1=2E Add missing string constants for {feature|request}-raw-pointer
>>>>     to align with the rest of the interface file=2E
>>>>
>>>> 2=2E Add new XenStore feature fields, so it is possible to
>individually
>>>>     control set of exposed virtual devices for each guest OS:
>>>>       - set feature-disable-keyboard to 1 if no keyboard device
>needs
>>>>         to be created
>>>>       - set feature-disable-pointer to 1 if no pointer device needs
>>>>         to be created
>>>>
>>>> 3=2E Move multi-touch device parameters to backend nodes: these are
>>>>      described as a part of frontend's XenBus configuration nodes
>>>>      while they belong to backend's configuration=2E Fix this by
>moving
>>>>      the parameters to the proper section=2E
>>>>
>>>> Unique-id field:
>>>> 1=2E Add unique-id XenBus entry for virtual input and display=2E
>>>>
>>>> 2=2E Change type of unique-id field to string for sndif to align with
>>>> display and input protocols=2E
>>>>
>>>> Signed-off-by: Oleksandr Andrushchenko
><oleksandr_andrushchenko@epam=2Ecom>
>>>> Cc: Konrad Rzeszutek Wilk <konrad=2Ewilk@oracle=2Ecom>
>>> Reviewed-by: Juergen Gross <jgross@suse=2Ecom>
>>>
>>> I'm fine with this patch being added via the input tree with the
>other
>>> patches=2E In case I should take it via the Xen tree, please send me a
>>> note=2E
>> Juergen,
>>
>> I created an immutable branch off v4=2E17 with these 3 patches in case
>you
>> would want to merge them into your tree without waiting for them to
>> appear in mainline:
>>
>> git pull git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/dtor/input=
=2Egit
>ib/4=2E17-xen-kbdfront-runtime-config
>>
>> Thanks=2E
>>
>Thank you,
>I would prefer the fastest path of course

It will be part of 4=2E19 pull request; the immutable branch is for Juerge=
n if he does not want to wait till 4=2E19 merge window to get the changes=
=2E


Thanks=2E

--=20
Dmitry
