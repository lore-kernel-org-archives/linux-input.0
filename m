From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Date: Thu, 8 Mar 2012 12:21:51 +0100
Message-ID: <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>  <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz> <20120308105737.GA11201@polaris.bitmath.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 88-230.252-81.static-ip.oleane.fr ([81.252.230.88]:38517 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab2CHLbd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Mar 2012 06:31:33 -0500
In-Reply-To: <20120308105737.GA11201@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Le 8 mars 2012 =E0 11:57, Henrik Rydberg a =E9crit :

> On Wed, Mar 07, 2012 at 10:36:41PM +0100, Jiri Kosina wrote:
>> On Tue, 6 Mar 2012, benjamin.tissoires wrote:
>>=20
>>> From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>>>=20
>>> The code is inspired from the one present in the bttv module.
>>>=20
>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>>> ---
>>>=20
>>> As I mentioned in the mail 0/5, I'd really like to have your opinio=
n on this
>>> one. I copied the code from bttv, but it forces us to change hid_de=
vice which
>>> is not very good for ABI changes reasons.
>>=20
>> Haven't closely inspected the patch yet, I will comment on it later.=
 But=20
>> generally, I wouldn't be worried about changing hid_device per se ..=
=2E it's=20
>> not really an ABI, it's not exported to userspace.
>>=20
>> It's internal kernel-ABI, yes. But we are free to change that in any=
 way=20
>> we wish.
>>=20
>> --=20
>=20
> Thanks for having another go at this problem. Obviously, it is hard t=
o
> find a completely satisfactory solution to auto-loading in the curren=
t
> hid framework. This latest attempt somehow comes close to the smalles=
t
> hackery that makes it possible. If we want to go beyond that, I think
> we need to restructure more than the internal hid device
> representation.

Yes. I'm not sure it is what you have in mind, but my personal feeling =
is that the parsing of report descriptors could be restructured to make=
 things clearer. It was designed with a simple HID-field-to-evdev-field=
 mapping in mind, and multitouch breaks this.


>=20
> What if we were to change the definition of a HID device on the
> modalias level?
>=20
> In practise, a HID device can be either an usb device, a hid device,

Just to be sure: do you mean "bluetooth device"? or is there such a thi=
ng as a hid device per se? I'm asking because I've always been surprise=
d at seeing usbhid/ in hid/, which kind of breaks the potential symmetr=
y between USB and Bluetooth wrt hid.

> a single interface on a usb bus, a special class determined by examin=
ing
> the reports, etc. Yet, the hid modalias contains only bus type, vendo=
r
> and product id. This is true for the generic usb and bluetooth driver=
s
> (and some very special drivers), but not really for the other devices=
=2E
> If we were to extend the modalias description, we could cater for a
> whole tree of hid devices. For instance, the usb id 1234 could be
> handled by the generic usb bus driver. The multitouch sub-device
> 1234:MT could be handled by hid-multitouch. The mouse device
> 1234:Mouse could be handled by some other driver, etc. All the driver
> handling could be automated in userland using the same udev mechanism
> we have today, if only the hid uevents were modified to incorporate
> the needed extra information.

No comments on this, I need to read up on modaliases before being able =
to comment at all. I have a vague feeling that we are going to end up d=
ebating where it is decided to assign a device to a driver (today it's =
done in the kernel, you seem to suggest userland), but I know too littl=
e about modaliases to be sure.


>=20
> Would this be a problematic change in userland, or would it be a
> feasible, in principle?
>=20
> Thanks,
> Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
