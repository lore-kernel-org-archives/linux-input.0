From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 3/5] input/cma3000_d0x: Keep configuration on poweroff
Date: Tue, 18 Oct 2011 14:07:15 +0200
Message-ID: <CAPybu_1JsTTOn5wP53Qd-jm+JhgwUTLhRb4BPjKaMab6174CNQ@mail.gmail.com>
References: <1318926486-10330-1-git-send-email-ricardo.ribalda@gmail.com>
 <1318926486-10330-4-git-send-email-ricardo.ribalda@gmail.com> <4E9D3A45.1040103@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E9D3A45.1040103@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 18, 2011 at 10:35, Jonathan Cameron <jic23@cam.ac.uk> wrote=
:
> On 10/18/11 09:28, Ricardo Ribalda Delgado wrote:
>> When the device goes to poweroff keep the spi/i2c configuration.
>> Otherwhise the device could not wake up if it was in spi mode.
>>
> Run checkpatch.pl over these
>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

I did :(

ricardo@newpili:~/hacking/linux$ scripts/checkpatch.pl
cmr_patches/v1/0003-input-cma3000_d0x-Keep-configuration-on-poweroff.pa=
tch
total: 0 errors, 0 warnings, 19 lines checked

cmr_patches/v1/0003-input-cma3000_d0x-Keep-configuration-on-poweroff.pa=
tch
has no obvious style problems and is ready for submission.

But I fix that right away


>> ---
>> =A0drivers/input/misc/cma3000_d0x.c | =A0 =A06 +++++-
>> =A01 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/c=
ma3000_d0x.c
>> index 9899742..15577b7 100644
>> --- a/drivers/input/misc/cma3000_d0x.c
>> +++ b/drivers/input/misc/cma3000_d0x.c
>> @@ -44,6 +44,7 @@
>> =A0#define CMA3000_RANGE2G =A0 =A0(1 << 7)
>> =A0#define CMA3000_RANGE8G =A0 =A0(0 << 7)
>> =A0#define CMA3000_BUSI2C =A0 =A0 (0 << 4)
>> +#define CMA3000_BUSSPI =A0 =A0 (1 << 4)
>> =A0#define CMA3000_MODEMASK =A0 (7 << 1)
>> =A0#define CMA3000_GRANGEMASK (1 << 7)
>>
>> @@ -230,8 +231,11 @@ static int cma3000_poweron(struct cma3000_accl_=
data *data)
>> =A0static int cma3000_poweroff(struct cma3000_accl_data *data)
>> =A0{
>> =A0 =A0 =A0 int ret;
>> + =A0 =A0 u8 ctrl =3D CMAMODE_POFF;
>>
>> - =A0 =A0 ret =3D CMA3000_SET(data, CMA3000_CTRL, CMAMODE_POFF, "Mod=
e setting");
>> + =A0 =A0 ctrl |=3D data->bus_ops->ctrl_mod;
>> +
>> + =A0 =A0 ret =3D CMA3000_SET(data, CMA3000_CTRL , ctrl, "Mode setti=
ng");
> no space before comma.
>> =A0 =A0 =A0 msleep(CMA3000_SETDELAY);
>>
>> =A0 =A0 =A0 return ret;
>
>



--=20
Ricardo Ribalda
