From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: libudev, a question about the enumerate API.
Date: Mon, 7 Mar 2011 17:11:29 +0100
Message-ID: <AANLkTin2ykWSx4V_iPT9deigdWZ-0HqFD2mf+O4Txq67@mail.gmail.com>
References: <20110223235053.ae9d6b0a.ospite@studenti.unina.it>
 <AANLkTik7pPUYou9OwD0E5r-Wr3a67kQZPToDepZH8pLu@mail.gmail.com> <4D750151.7070904@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <4D750151.7070904@signal11.us>
Sender: linux-hotplug-owner@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-hotplug@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Mar 7, 2011 at 17:01, Alan Ott <alan@signal11.us> wrote:
> On 03/07/2011 10:27 AM, Kay Sievers wrote:
>>
>> The usual enumeration in udev never uses the device tree in
>> /sys/devices/, only the subsystem lists /sys/{class,bus}/. We could
>> have something to enumerate all child devices of a given device. It'=
s
>> not simple, but could be made working.

> The documentation in Documentation/sysfs-rules.txt seems to warn agai=
nst
> using /sys/class and sys/bus:
>
> - devices are only "devices"
> =C2=A0There is no such thing like class-, bus-, physical devices,
> =C2=A0interfaces, and such that you can rely on in userspace. Everyth=
ing is
> =C2=A0just simply a "device". Class-, bus-, physical, ... types are j=
ust
> =C2=A0kernel implementation details which should not be expected by
> =C2=A0applications that look for devices in sysfs.
>
> ...
> =C2=A0 =C2=A0 =C2=A0- all elements of a devpath must be real director=
ies. Symlinks
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pointing to /sys/devices must always be re=
solved to their real
> =C2=A0 =C2=A0 =C2=A0 =C2=A0target and the target path must be used to=
 access the device.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0That way the devpath to the device matches=
 the devpath of the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel used at event time.
> =C2=A0 =C2=A0 =C2=A0- using or exposing symlink values as elements in=
 a devpath string
> =C2=A0 =C2=A0 =C2=A0 =C2=A0is a bug in the application
>
> ...
>
> =C2=A0 =C2=A0 =C2=A0- accessing attributes reached by a symlink point=
ing to another device,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0like the "device"-link, is a bug in the ap=
plication
>
> ...
>
> - Hierarchy in a single device tree
> =C2=A0There is only one valid place in sysfs where hierarchy can be e=
xamined
> =C2=A0and this is below: /sys/devices.
>
> and more...
>
> I figured that this document was probably out of date, since even lib=
udev
> uses /sys/class. What's your take on this document?

I wrote that document. :) It's partly out-of-date, but this is still tr=
ue.

Udev, since quite some years, even the old and dead HAL supports
/sys/subsystem/ already, which is not in the kernel today, but might
be soon.

If that directory is available, /sys/{class,bus}/ will not be looked at=
:
  http://git.kernel.org/?p=3Dlinux/hotplug/udev.git;a=3Dblob;f=3Dlibude=
v/libudev-enumerate.c;h=3D128813c7d618717690f79d0eca82776a6c4fa011;hb=3D=
HEAD#l776

Kay
--
To unsubscribe from this list: send the line "unsubscribe linux-hotplug=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
