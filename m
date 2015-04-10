From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 10 Apr 2015 18:32:36 -0500
Message-ID: <55285D94.8030306@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201504110039.40761@pali> <55285797.1080303@dell.com> <201504110114.45676@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:48161 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbDJXcj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 19:32:39 -0400
In-Reply-To: <201504110114.45676@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


On 04/10/2015 06:14 PM, Pali Roh=C3=A1r wrote:
> On Saturday 11 April 2015 01:07:03 Mario Limonciello wrote:
> I could see problem with using older kernels which are in more
> stable or LTS distribution versions...
>
> But it is nice that problems are fixes for future 4.0/4.1
> versions.
>
> And if you located reason for invalid packets in PS/2 mode, will
> you fix it in some new bios versions?
>
> Can you comment if this is also same problem with invalid packets
> on E6440/E7440 machines?
>
Hi Pali,

=46or the XPS 13, yes earlier kernel versions will be affected, but we =
are encouraging users to run with 3.16+.  There are enough other issues=
 with I2C touchpad, MST, HDA audio and other things that people will ha=
ve a better experience on those kernels.  People who will install Ubunt=
u 14.04 LTS we will encourage to install the HWE stack that provides 3.=
16 or 3.19 instead.  Canonical is backporting fixes for I2C and HDA iss=
ues into these kernels already.

The root cause for the invalid packets in PS/2 mode on the XPS 13 is no=
t fixable via a BIOS update.

The invalid packets on the Exx40 machines I believe is caused by some b=
ehavior that happens if the touchpad/trackstick receives data shortly a=
fter the internal keyboard was busy.  An interrupt is fired on the EC t=
hat will cause it discard data.  I think this is why it ends up on the =
other end looking like it does.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
