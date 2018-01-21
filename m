From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: trackpoint - force 3 buttons if 0 button is reported
Date: Sun, 21 Jan 2018 13:14:58 -0800
Message-ID: <051BA339-04DD-4AF7-B7CA-BBB5401053D8@gmail.com>
References: <20180112064658.25019-1-aaron.ma@canonical.com> <20180112083940.p36qj6ltzzwtuhng@dtor-ws> <06bbeca0-8a90-8935-9be3-f154db0b9fe9@canonical.com> <20180112181830.ccpkltghgkj3oh3e@dtor-ws> <6a96ce54-9f8a-2424-1e48-34ec6445cb8f@canonical.com> <20180116230713.rppztybwe5ufhoxo@dtor-ws> <20180121201049.GA23310@beacon.debie>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180121201049.GA23310@beacon.debie>
Sender: linux-kernel-owner@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: Aaron Ma <aaron.ma@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On January 21, 2018 12:10:50 PM PST, ulrik=2Edebie-os@e2big=2Eorg wrote:
>On Tue, Jan 16, 2018 at 03:07:13PM -0800, Dmitry Torokhov wrote:
>Hi Dmitry,
>
>>=20
>> On Sat, Jan 13, 2018 at 10:34:19AM +0800, Aaron Ma wrote:
>> > Will your patch go to stable kernel?
>> > If yes, that's fine=2E
>>=20
>> Hmm, it looks like we need this patch after all as we do have screwy
>> Lenovos with apparently 0x01 devices reporting 0 buttons=2E From
>> https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D196253
>>=20
>>  thinkpad_acpi: ThinkPad BIOS R0DET87W (1=2E87 ), EC unknown
>>  thinkpad_acpi: Lenovo ThinkPad E470, model 20H1004SGE
>>=20
>>  psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons:
>0/0
>>=20
>> I'll ask them to try my patch and if it is indeed 0x01 device I'll
>apply
>> your patch=2E
>
>It is quite strange=2E In the past,for commit 293b915fd9be=20
>"Input: trackpoint - assume 3 buttons when buttons detection fails"
>there was
>success reported for lenovo e470 and I see the same success report in
>that
>bugzilla ticket=2E  I can also report success on lenovo e570=2E
>
>But some seem to have problems, could it be that they are not including
>that
>commit in the kernel they are running ? Or did a bios upgrade change
>the
>behaviour ?
>It would be best when we have a confirmation from a e470 owner that
>without the
>proposed patch from Aaron the middle button does not work on his e470,
>and it
>works with it=2E

I suppose Lenovo changed the firmware, because if you take a look at bugzi=
lla link I provided there is a box that does not fail the command but indee=
d responds with 0 as number of buttons=2E It still reports device ID 0x010e=
=2E

Hi Ulrik,
Thanks=2E

--=20
Dmitry
