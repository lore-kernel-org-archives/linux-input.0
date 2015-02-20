From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 20 Feb 2015 15:54:16 -0600
Message-ID: <54E7AD08.9010406@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <CAN+gG=F6TyoOb=nNeBAsdh7RrEUWoeJtznTY4YNmr3UGxQ1Hjg@mail.gmail.com> <54E7A9D6.8060506@dell.com> <201502202246.19686@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:27920 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbbBTVyf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 16:54:35 -0500
In-Reply-To: <201502202246.19686@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>


On 02/20/2015 03:46 PM, Pali Roh=C3=A1r wrote:
> On Friday 20 February 2015 22:40:38 Mario Limonciello wrote:
> Maybe stupid question, but cannot you call that code which put
> sound card into HDA mode from kernel? It could fix problem when
> either sound or touchpad is not working...
>

As I understand with the HW and FW design this action needs to be done =
from the EC and it's only effective for "the next boot".  The current b=
oot will use the value cached from previous boot.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
