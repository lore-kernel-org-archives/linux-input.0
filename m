From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Subject: Re: [PATCH v5 0/4] new driver for Valve Steam Controller
Date: Sat, 17 Mar 2018 14:54:07 -0700
Message-ID: <1c75c511-eada-585e-297f-e90feb17ac8c@valvesoftware.com>
References: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
 <CAM4jgCq5UT0SBKA1DMfsAKd8R+yn0ViPr0U-iE8-tWjgA9hTTQ@mail.gmail.com>
 <20180312205158.GB21621@casa>
 <CAO-hwJJqDM5Y7t-hpZ_s7EzjVki00ME7fd_7iUWcgaTZ9o906g@mail.gmail.com>
 <20180315210659.GA16037@casa>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315210659.GA16037@casa>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: =?UTF-8?Q?Cl=c3=a9ment_VUCHENER?= <clement.vuchener@gmail.com>, Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



On 03/15/2018 02:06 PM, Rodrigo Rivas Costa wrote:
> On Wed, Mar 14, 2018 at 05:39:25PM +0100, Benjamin Tissoires wrote:
>> On Mon, Mar 12, 2018 at 9:51 PM, Rodrigo Rivas Costa
>> <rodrigorivascosta@gmail.com> wrote:
>>> On Mon, Mar 12, 2018 at 03:30:43PM +0100, Cl=E9ment VUCHENER wrote:
>>>> 2018-03-11 20:58 GMT+01:00 Rodrigo Rivas Costa <rodrigorivascosta@gmai=
l.com>:
>>>>> This patchset implements a driver for Valve Steam Controller, based o=
n a
>>>>> reverse analysis by myself.
>>>>>
>>>>> Sorry, I've been out of town for a few weeks and couldn't keep up wit=
h this...
>>>>>
>>>>> @Pierre-Loup and @Cl=E9ment, could you please have another look at th=
is and
>>>>> check if it is worthy? Benjamin will not commit it without an express=
 ACK from
>>>>> Valve. Of course he is right to be cautious, but I checked this drive=
r with
>>>>> the Steam Client and all seems to go just fine. I think that there is=
 a lot of
>>>>> Linux out of the desktop that could use this driver and cannot use th=
e Steam
>>>>> Client. Worst case scenario, this driver can now be blacklisted, but =
I hope
>>>>> that will not be needed.
>>>>
>>>> I tested the driver with my 4.15 fedora kernel (I only built the
>>>> module not the whole kernel) and I got double inputs (your driver
>>>> input device + steam uinput device) when testing Shovel Knight with
>>>> Steam Big Picture. It seems to work fine when the inputs are the same,
>>>> but after changing the controller configuration in Steam, the issue
>>>> became apparent.
>>>
>>> I assumed that when several joysticks are available, games would listen
>>> to one one of them. It looks like I'm wrong, and some (many?) games wil=
l
>>> listen to all available joysticks at the same time. Thus having two
>>> logical joysticks that represent the same physical one is not good.
>>
>> Yeah, the general rule of thumb is "think of the worst thing that can
>> happen, someone will do something worst".
>>
>>>
>>> An easy solution would be that Steam Client grabs this driver
>>> (ioctl(EVIOCGRAB)) when creating the uinput device. Another solution
>>> would be that Steam Client blacklists this driver, of course.
>>
>> This is 2 solutions that rely on a userspace change, and this is not
>> acceptable in its current form. What if people do not upgrade Steam
>> client but upgrade their kernel? Well, Steam might be able to force
>> people to always run the latest shiny available version, but for other
>> games, you can't expect people to have a compatible version of the
>> userspace stack.
>=20
> Well, if you don't have Steam then you don't have the double input in
> the first place. Unless you are using a different user-mode driver, of
> course.
>>
>> Also, "blacklisting the driver" from Steam client is something the OS
>> can do, but not the client when you run on a different distribution.
>> You need root for that, and I don't want to give root permissions to
>> Steam (or to any user space client that shouldn't have root privileges
>> for what it matters).
>=20
> Actually Steam needs a system installation that adds udev rules to grant
> uaccess to /dev/uinput and the USB raw device for the controller.
> Adding a /etc/modprobe.d/steam.conf should be possible, too. It would be
> a bit inconvenient because you'll need a distro update of the steam
> package, not just the usual user-mode-only auto-update.

It's definitely a bit tricky; we've rolled out an update to our=20
reference package whenever we've added support for new devices (the=20
final Steam Controller, direct PS4 gamepad led/gyro access through HID,=20
HTC Vive and its myriad of onboard devices, bootloaders of all these=20
things for firmware updates, etc). Whenever we have to do that, the=20
rollout never is as smooth as desired: many users aren't using our own=20
package; even on the distributions we support directly. Then downstream=20
distributions adopt these udev changes with various delays (sometimes=20
never), and port them to their own mechanism of doing things, since=20
everyone has their own idea of a robust security model. I wish local=20
sessions always had proper access to HID devices connected to the=20
physical computer the user is sitting at, but I realize that the basic=20
gaming desktop is just one of many usecases distros out there have to=20
support and it'd be unreasonable to expect them to focus exclusively on it.

>=20
>>>
>>>> And without Steam and your external tool, you get double inputs too. I
>>>> tried RetroArch and it was unusable because of the keyboard inputs
>>>> from the lizard mode (e.g. pressing B also presses Esc and quits
>>>> RetroArch). Having to download and compile an external tool to make
>>>> the driver work properly may be too difficult for the user. Your goal
>>>> was to provide an alternative to user space drivers but now you
>>>> actually depend on (a very simple) one.
>>>
>>> Yes, I noticed that. TBH, this driver without Steam Client or the
>>> user-space tool is not very nice, precisely because you'll get constant
>>> Escape and Enter presses, and most games react to those.
>>>
>>> Frankly speaking, I'm not sure how to proceed. I can think of the
>>> following options:
>>>   1.Steam Client installation could add a file to blacklist
>>>     hid-steam, just as it adds a few udev rules.
>>
>> But what about RetroArch? And what if you install Steam but want to
>> play SDL games that could benefit from your driver?
>=20
> That is an issue of solution 1. I actually have the module blacklisted
> in my PC, and run `sudo modprobe hid-steam` to use SDL.
>=20
>>>   2.The default CONFIG_HID_STEAM can be changed to "n". Maybe only
>>>     on the architectures for which there is a Steam Client available.
>>>     This way DIY projects will still be able to use it.
>>
>> But this will make the decision to include or not the driver in
>> distributions harder. And if no distribution uses it, you won't have
>> free tests, and you will be alone to maintain it. So that's not ideal
>> either
>=20
> Could we set the default to 'y' in non-PC systems. It would be enabled
> in my Raspbian, for example... better than nothing.
>>
>>>   3.This driver could be abandoned :-(. Just use Steam Client if possib=
le or
>>>     any of the user-mode drivers available.
>>
>> This would be a waste for everybody as it's always better when we share.
>=20
> Indeed!
>=20
> I tried a new option:
>    4. The driver detects whether the DEVUSB/HIDRAW device is in use, and
>       if that is the case it will disable itself. If the DEVUSB/HIDRAW is
>       not in use, then the driver will work normally. A bit hackish maybe
>       but it should work.
>=20
> I tried doing this option 4, but I'm unable to do it properly. I don't
> even know if it is possible...
>=20
>>>
>>> If we decide for 1 or 2, then the lizard mode could be disabled without
>>> ill effects. We could even enable the gyro and all the other gadgets
>>> without worring about current compatibility.
>>
>> To me, 1 is out of the question. The kernel can't expect a user space
>> change especially if you are knowingly introducing a bug for the end
>> user.
>>
>> 2 is still on the table IMO, and 3 would be a shame.
>>
>> I know we already discussed about sysfs and module parameters, but if
>> the driver will conflict with a userspace stack, the only way would be
>> to have a (dynamic) parameter "enhanced_mode" or
>> "kernel_awesome_support" or whatever which would be a boolean, that
>> defaults to false that Steam can eventually lookup if they want so in
>> the future we can default it to true. When this parameter is set, the
>> driver will create the inputs and toggle the various modes, while when
>> it's toggled off, it'll clean up itself and keep the device as if it
>> were connected to hid-generic. Bonus point, this removes the need for
>> the simple user space tool that enables the mode.
>=20
> That is doable, but that sysfs/parameter can be changed by a non-root
> user? I looked for a udev rule to grant access to those but found
> nothing.
>=20
> IIUC, when this parameter is false the driver will do nothing, right?
> The user will just need to change it to true to be able to use it, but
> that will have to be done by root.
>=20
> I'll try doing this, but I'd appreciate your advice about what approach
> would be better: sysfs? a module parameter? a cdev? or even a EV_MSC?
>=20
>>> At the end of the day, I think that it is up to Valve what to do.
>>
>> Again, Valve is a big player here, but do not underestimate other
>> projects (like RetroArch mentioned above) because if you break their
>> workflow, they will have the right to request a revert of the commit
>> because it breaks some random user playing games in the far end of
>> Antarctica (yes, penguins do love to play games :-P )
>=20
> And everybody loves penguins! If we take away Steam (say a RaspberryPi
> as a canonical example) and disable the lizard mode, then this driver is
> just a regular gamepad. RetroArch should be happy with that. Unless they
> already have an user mode driver for the steam-controller, of course...

Both of these things seem reasonable to me, with a few caveats:

  - If there's an opt-in mechanism available, it would be good to ensure=20
we have a way to reliably query its state without requiring extra=20
permissions. This way, if we know it's likely to affect Steam client=20
functionality, we'll have the right mechanism to properly message the=20
situation to users.

  - If you find a way for the client to be able to program an opt out=20
when it's running that is not automatic (eg. by detecting the hidraw=20
device being opened), we'd be happy to participate with that scheme=20
assuming it doesn't require extra permissions. As soon as the API is=20
figured out, we can include it in the client, just send me a heads-up.=20
The one thing that I'd be cautious of is robust behavior against=20
abnormal client termination. If it's a sysfs entry we have to poke, I'm=20
worried that if the client crashes we might not always be able to opt=20
the driver back out. It'd be nice if it was based on opening an fd=20
instead, this way the kernel would robustly clean up after us and your=20
driver would kick back in.

Note that there's a general desire on our side to create a reference=20
userspace implementation that would more or less have the current=20
functionality of the Steam client, but would be easily usable from other=20
platforms where the client doesn't currentl run. Unfortunately it's=20
quite a bit of work, so it's unclear what the timeframe would be, if it=20
ever does happen.

Thanks,
  - Pierre-Loup

>=20
> Best regards.
> Rodrigo
>=20
>> Cheers,
>> Benjamin
>>
>>> Best Regards.
>>> Rodrigo.
>>>
>>>> Also the button and axis codes do not match the gamepad API doc
>>>> (https://www.kernel.org/doc/Documentation/input/gamepad.txt).
>>>>
>>>>>
>>>>> For full reference, I'm adding a full changelog of this patchset.
>>>>>
>>>>> Changes in v5:
>>>>>   * Fix license SPDX to GPL-2.0+.
>>>>>   * Minor stylistic changes (BIT(3) instead 0x08 and so on).
>>>>>
>>>>> Changes in v4:
>>>>>   * Add command to check the wireless connection status on probe, wit=
hout
>>>>>     waiting for a message (thanks to Cl=E9ment Vuchener for the tip).
>>>>>   * Removed the error code on redundant connection/disconnection mess=
ages. That
>>>>>     was harmless but polluted dmesg.
>>>>>   * Added buttons for touching the left-pad and right-pad.
>>>>>   * Fixed a misplaced #include from 2/4 to 1/4.
>>>>>
>>>>> Changes in v3:
>>>>>   * Use RCU to do the dynamic connec/disconnect of wireless devices.
>>>>>   * Remove entries in hid-quirks.c as they are no longer needed. This=
 allows
>>>>>     this module to be blacklisted without side effects.
>>>>>   * Do not bypass the virtual keyboard/mouse HID devices to avoid bre=
aking
>>>>>     existing use cases (lizard mode). A user-space tool to do that is
>>>>>     linked.
>>>>>   * Fully separated axes for joystick and left-pad. As it happens.
>>>>>   * Add fuzz values for left/right pad axes, they are a little wiggly=
.
>>>>>
>>>>> Changes in v2:
>>>>>   * Remove references to USB. Now the interesting interfaces are sele=
cted by
>>>>>     looking for the ones with feature reports.
>>>>>   * Feature reports buffers are allocated with hid_alloc_report_buf()=
.
>>>>>   * Feature report length is checked, to avoid overflows in case of
>>>>>     corrupt/malicius USB devices.
>>>>>   * Resolution added to the ABS axes.
>>>>>   * A lot of minor cleanups.
>>>>>
>>>>> Rodrigo Rivas Costa (4):
>>>>>    HID: add driver for Valve Steam Controller
>>>>>    HID: steam: add serial number information.
>>>>>    HID: steam: command to check wireless connection
>>>>>    HID: steam: add battery device.
>>>>>
>>>>>   drivers/hid/Kconfig     |   8 +
>>>>>   drivers/hid/Makefile    |   1 +
>>>>>   drivers/hid/hid-ids.h   |   4 +
>>>>>   drivers/hid/hid-steam.c | 794 +++++++++++++++++++++++++++++++++++++=
+++++++++++
>>>>>   4 files changed, 807 insertions(+)
>>>>>   create mode 100644 drivers/hid/hid-steam.c
>>>>>
>>>>> --
>>>>> 2.16.2
>>>>>
>=20
