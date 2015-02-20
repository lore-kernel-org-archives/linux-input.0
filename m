From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 20 Feb 2015 13:56:23 -0600
Message-ID: <54E79167.6070701@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <54E62893.1060806@dell.com> <20150220184717.GC20060@dtor-glaptop> <201502202024.20741@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from AUSXIPPC110.us.dell.com ([143.166.85.200]:10614 "EHLO
	ausxippc110.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbBTT4l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 14:56:41 -0500
In-Reply-To: <201502202024.20741@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Pali & Dmitry,

On 02/20/2015 01:24 PM, Pali Roh=C3=A1r wrote:
> On Friday 20 February 2015 19:47:17 Dmitry Torokhov wrote:
>> Hi Mario,
>>
>> On Thu, Feb 19, 2015 at 12:16:51PM -0600, Mario Limonciello
> wrote:
>>
>> Can it be related to ther Dell models (Latitudes with ALPS
>> touchpad) also sending junk data under certain conditions
>> (adding Pali to teh CC as he was looking at this issue)?
>>
We use the same embedded controller design and codebase on many of our =
laptops.  Depending on the root cause, it's possible to be the same pro=
blem that's happening on Latitude 6x40.  I'm leaning on it's likely not=
 the same problem though because on Latitude 6x40 II understand the iss=
ue does not show up on the other side of the EC when the waveform was a=
nalyzed in Windows.
> Dell Latitude Exx40 models (with ALPS touchpads) have similar
> problems. Linux psmouse.ko/alps.c driver receive invalid packets
> which cause lot of problems... ALPS people told me those packets
> which was found on i8042 bus are really invalid ALPS packets and
> do not come from ALPS touchpad. Unless there is invisible bug in
> ALPS touchpad firmware (which was not discovered yet), problem is
> either in Dell EmeddedController where is connected ALPS touchpad
> or in Dell BIOS/UEFI (which I believe can modify any such data).
A colleague has shared to me some information about the issue on 6x40 l=
aptops as well.  There was a recent EC change (released within last 2 w=
eeks or so) that helps to fix problems with i8042 traffic. It was inten=
ded to fix keyboard repeating, but it may also fix the touchpad data.  =
Can you please confirm if the new BIOS/EC update fixes the problem?

> If Dell share EC firmware code in more models (Latitude and XPS)
> or share some BIOS parts, then problem can be really there.
>
Yes, specifically with XPS 13 (2015) the code base for the EC has commo=
n components with Latitude and Precision.  For the XPS problem, the EC =
code has been reviewed but not found any issues with it pointing to an =
EC problem.  There are other aspects that are being explored such as th=
e input to the EC being overamplified by a mis configured buffer in the=
 touchpad.  This would cause the data to saturate outside of spec in th=
e EC.

>>> Yes, the logs do fill up with error messages about the bad
>>> data within the first few minutes of usage.  In my opinion
>>> not freezing but getting errors in the log is better than
>>> freezing and getting errors in the log, so we're at least
>>> trying to provide a workaround for the problem.  If we come
>>> up with a firmware based solution I'd be happy to adjust or
>>> remove this later.
>> I am not saying we do not need the solution, I am wondering if
>> we can suppress errors altogether. I am also curious why
>> reset does not work as it should reinitialize the driver
>> completely.
Thanks.  I think it's fair to hide them when resetafter=3D0 is configur=
ed (such as the quirk turns on).  If you agree, i'll adjust the patch t=
o do this.
To clarify the problem, the errors will show up and after 5 the touchpa=
d is reset.  The reset is what causes the freeze because the touchpad d=
river takes 1-3 seconds to reinitialize.  The problem will happen conti=
nue to happen though as it's believed to be higher up the chain.
If resetafter=3D0 is set, the errors will show up in the logs, but the =
touchpad recovers on it's own.
>>
>> And even if you do fix the firmware majority of users will
>> still need the software solution as updating BIOS is not
>> something that happens often.
>>
>> Thanks.
Yes, thanks I agree on this.  We are working on making firmware flash o=
n Latitude/Precision/XPS easier for Linux users, but we're not there ye=
t on everything.  If you look on XPS 13 (2015) it's one of the first to=
 support firmware flash from F12 boot menu.  It will search any USB dis=
ks and partitions that firmware can mount such as EFI system partition.
> I do not know what can kernel do when it receive invalid PS/2
> data from i8042 bus. If bogus packets are total random we can
> just try to ignore them and try be not out-of-sync. No idea how
> working solution it would be for new XPS model. Looks like for
> Latitude Exx40 models with their problems it is working...
>
> Of course correct way is to fix firmware or BIOS or which part of
> HW is buggy. Ideally distribute that firmware fix to users. I
> heard that synaptics touchpad supports something like on-the-fly
> firmware load (without flashing it) which will be active until
> notebook shutdown.
>
Yes, if we can fix this in firmware, that's our goal too.  If/when we g=
et a firmware fix, the quirk can be configured to only activate on earl=
ier versions of the firmware that are affected.

I'm not aware of the on-the-fly firmware load for Synaptics.  Do you kn=
ow more about this?  In dual mode touchpads is this only present on the=
 I2C mode?

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
