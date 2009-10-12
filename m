From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] Haptic class support (v2)
Date: Mon, 12 Oct 2009 19:14:57 +0530
Message-ID: <5d5443650910120644x4180ff6bt45b72be86b50588f@mail.gmail.com>
References: <20091006074533.GA28889@july> <20091011090549.GE1414@ucw.cz>
	 <9c9fda240910111732x262a9510rf3dd862aa16d0bdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932138AbZJLNqI@vger.kernel.org>
In-Reply-To: <9c9fda240910111732x262a9510rf3dd862aa16d0bdf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: linux-input@vger.kernel.org

Hi Kyungmin,

On Mon, Oct 12, 2009 at 6:02 AM, Kyungmin Park <kmpark@infradead.org> w=
rote:
> On Sun, Oct 11, 2009 at 6:05 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> On Tue 2009-10-06 16:45:33, Kyungmin Park wrote:
>>> This patch includes two haptic devices, isa1000 and isa1200
>>> ISA1000 is gpio based haptic, but isa1200 is based on I2C
>>> Both are working on Samsung SoCs and tested.
>>>
>>> To enable the haptic, echo 1 > /sys/class/haptic/${name}/enable
>>> You can adjust the level by echo ${level} > /sys/class/haptic/${nam=
e}/enable
>>> or
>>> With oneshot feature, echo ${msec time} > /sys/class/haptic/${name}=
/oneshot
>>
>> New device classes should certainly be documented in Documentation/.
>>
>> For example... is level 0-100?
>
> Basically. range from 0 to 255. also each device can set max level in
> case of isa1000 it's 6.
>
>> =A0Is it valid to change level while 'oneshot' is running?
>
> we usually use it under 1 sec. but I think it's possible to change it
> but not tried.
>
>> =A0Does oneshot use last level set?
>
> Right. it used last set value.
>
> If you don't mind to update these at Documentation please wait until
> commit first patches merged.

Let's see what Greg prefers. Could you please refresh your patchset
with probably addressing comments given in the isa1200 and samsung_pwm
driver by me?

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
