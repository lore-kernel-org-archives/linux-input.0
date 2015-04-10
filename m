From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 10 Apr 2015 18:07:03 -0500
Message-ID: <55285797.1080303@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <54EE1917.4020805@dell.com> <201502252145.22577@pali> <201504110039.40761@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:18067 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193AbbDJXHF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 19:07:05 -0400
In-Reply-To: <201504110039.40761@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


On 04/10/2015 05:39 PM, Pali Roh=C3=A1r wrote:
> On Wednesday 25 February 2015 21:45:22 Pali Roh=C3=A1r wrote:
> Hello Mario,
> have you patched synaptics driver with some resetafter parameter?
> And have some team in dell found reason for invalid packets?
>
Hi Pali,

The reason was found for the invalid packets in PS2 mode, but I can't g=
o into the details about it publicly.

I think it's better to not bother including my proposed solution, howev=
er.  The vector of users in PS2 mode should be very small now.
Here's why:
With no kernel command line options applied the touchpad will run in I2=
C mode with the current kernel.  The only reason that users were being =
exposed to the PS2 mode was if they ran with the kernel command line op=
tion acpi_osi=3D"!Windows 2013".  This was required with BIOS A01 due t=
o the problem with I2S audio.  This I2S audio problem has been resolved=
 for BIOS A02 and BIOS A03.  With no options applied on the kernel comm=
and line the system will run in I2C touchpad and HDA audio.
All new machines will be coming with A03 or later.  Users with earlier =
versions have been advised to upgrade to fix this among other issues.

The HDA audio will work correctly for output with 4.0.  It will work pr=
operly for input when these two patches are applied (which will land in=
 4.1)

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?h=3D=
for-next&id=3De1e62b98ebddc3234f3259019d3236f66fc667f8

and

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?h=3D=
for-next&id=3Df3b703326541d0c1ce85f5e570f6d2b6bd4296ec


If the patch to disambiguate the value of _REV() lands in 4.1 the audio=
 will begin to operate fully in I2S mode and the necessary support will=
 be included in 4.1 as well.

So with all those factors I feel that it's a very low risk that users w=
ill end up in PS2 mode with the current development focus kernels.

Thanks,
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
