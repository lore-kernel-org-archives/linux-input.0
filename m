From: Richie Ward <richies@gmail.com>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Wed, 8 Jun 2011 19:51:21 +0100
Message-ID: <BANLkTinFjX1Ya_Qhep6+NsXWjxQi0_Yoeq-cTYNj7maSHtC5vg@mail.gmail.com>
References: <4B2ABC62.2030600@physik.uni-muenchen.de>
	<alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz>
	<20091218175046.GB23450@core.coreip.homeip.net>
	<4B2D6377.1020703@physik.uni-muenchen.de>
	<20091221074419.GD3234@core.coreip.homeip.net>
	<20091221082259.GG3234@core.coreip.homeip.net>
	<4B39FA1D.6070107@physik.uni-muenchen.de>
	<1AD572D6-2C2F-4664-9B52-36A8D1BE8B29@gmail.com>
	<20091230032326.GC7049@core.coreip.homeip.net>
	<4B3B16CD.1050700@physik.uni-muenchen.de>
	<20091230104744.GB2214@core.coreip.homeip.net>
	<4B3B3A46.5010300@physik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51010 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab1FHSvX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jun 2011 14:51:23 -0400
Received: by iyb14 with SMTP id 14so662205iyb.19
        for <linux-input@vger.kernel.org>; Wed, 08 Jun 2011 11:51:23 -0700 (PDT)
In-Reply-To: <4B3B3A46.5010300@physik.uni-muenchen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Is there any progress on this driver? Johannes seems to of gotten it
working from what I have read.

I own a Cyborg Evo Force but I would like the force feedback driver to
be committed to the mainline so that it can be released with future
Linux distributions.

As of today, I cant see any mention of the Saitek Cyborg Evo Force in
the IForce driver in Linux 3.0 rc2's source. What seems to be the
roadblock to committing it to mainline?

On 30 December 2009 11:32, Johannes Ebke
<johannes.ebke@physik.uni-muenchen.de> wrote:
> Dmitry Torokhov wrote:
>> On Wed, Dec 30, 2009 at 10:01:01AM +0100, Johannes Ebke wrote:
>>> Dmitry Torokhov wrote:
>>>> On Tue, Dec 29, 2009 at 02:40:21PM -0800, Dmitry Torokhov wrote:
>>>>> =C2=A0Dec 29, 2009, at 4:46 AM, Johannes Ebke
>>>>> <johannes.ebke@physik.uni-muenchen.de> wrote:
>>>>>
>>>>>> Dmitry Torokhov wrote:
>>>>>>> On Sun, Dec 20, 2009 at 11:44:19PM -0800, Dmitry Torokhov wrote=
:
>>>>>>>> On Sun, Dec 20, 2009 at 12:36:23AM +0100, Johannes Ebke wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> It seems that the force feedback works well, I have ported
>>>>>>>>> the force
>>>>>>>>> feedback for my favorite game to linux now, and it works well=
=2E
>>>>>>>>>
>>>>>>>>> What does not work is updating effects - there just nothing
>>>>>>>>> happens, and
>>>>>>>>> the old event is played. I have circumvented this by
>>>>>>>>> deleting/re-uploading the effect, but this should probably
>>>>>>>>> been made to
>>>>>>>>> work. Does it work well with other hardware?
>>>>>>>>>
>>>>>>>>> Thirdly, I have re-discovered one kernel oops that occurs if =
the
>>>>>>>>> joystick is unplugged if some process still has the event
>>>>>>>>> device open.
>>>>>>>>> Steps to reproduce:
>>>>>>>>> * plug joystick in
>>>>>>>>> * fftest /dev/input/eventXX
>>>>>>>>> * unplug joystick
>>>>>>>>>
>>>>>>>>> (kern.log extract attached)
>>>>>>>>>
>>>>>>>>> Sometimes this just gives an oops, sometimes it escalates
>>>>>>>>> into a kernel
>>>>>>>>> panic.
>>>>>>>>>
>>>>>>>> Hmm, it looks like iforce unbinding is completely busted:
>>>>>>>>
>>>>>>>> static void iforce_usb_disconnect(struct usb_interface *intf)
>>>>>>>> {
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 struct iforce *iforce =3D usb_get_intfdat=
a(intf);
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 int open =3D 0; /* FIXME! iforce->dev.han=
dle->open; */
>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 usb_set_intfdata(intf, NULL);
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 if (iforce) {
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iforce->usbde=
v =3D NULL;
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_unregis=
ter_device(iforce->dev);
>>>>>>>>
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!open) {
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 iforce_delete_device(iforce);
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 kfree(iforce);
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>>>>> =C2=A0 =C2=A0 =C2=A0 }
>>>>>>>> }
>>>>>>>>
>>>>>>>>
>>>>>>>> Any chance you could fix that FIXME ;) ?
>>>>>>>>
>>>>>>> Actually, does the below fixes it for you?
>>>>>>>
>>>>>> This fixes the kernel oops - thanks! However it also disables FF=
,
>>>>>> unless
>>>>>> I remove "usb_kill_urb(iforce->out);" from iforce_close.
>>>>> >From some debug statements I found that iforce_close is called
>>>>>> twice if
>>>>>> you just plug in the joystick, so the effect is immediate.
>>>>> I still believe that usb_kill_urb is needed however we need to wa=
it
>>>>> for packet disabling FF to complete.
>>>>>
>>>> Does the patch below (on top of the unmodofied previous one) fixes=
 the
>>>> issue for you?
>>>>
>>>> Thanks.
>>>>
>>> This fixes it completely, both the FF and the clean shutdown on
>>> unexpected disconnect! Thank you very much!
>>
>> Ah, great!
>>
>>> Finally, for correct orientation of the rudder axis, I have attache=
d one
>>> small change to packets - this makes it work for me if i remove the=
 old
>>> configuration.
>>
>> Hmm, that might break some other users though (or does it only kick =
in
>> for Cyborg?
>
> This is in the part that only kicks in for the Cyborg, or perhaps oth=
er
> devices as well (if(HI(cmd)=3D=3D6)..)
>
>>
>>> One other question: Since the USB HID driver can actually discover =
the
>>> joystick buttons and axis ranges sucessfully, would it not be easie=
r to
>>> use that for generic input and only add force-feedback in iforce, o=
r is
>>> that just too much overhead?
>>
>> We do prefer to have HID driver handle the devices and have only
>> non-HID-compliant devices use specialized drivers. Iforce is an olde=
r
>> driver though, working with both USB devices and devices attached to
>> serial ports.
>>
>> Does your joystick works well with HID driver (sans FF)?
>>
>
> Yes, with one grievance: Since the "dead man switch" is not physicall=
y
> present on the cyborg but logically present and "always on", some
> applications like the flightgear joystick calibration "fgjs" cannot b=
e used.
> However, I am not sure how the information "this is a dead man switch=
"
> can be published to userspace most efficiently, and the application
> should probably deal with it anyway (stuck key in old joystick, etc..=
=2E)
>
> Cheers,
> Johannes
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Thanks, Richie Ward
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
