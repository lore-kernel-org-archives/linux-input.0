From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Mon, 13 Apr 2015 13:55:40 -0500
Message-ID: <552C112C.1030105@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201504110039.40761@pali> <55285797.1080303@dell.com> <201504110114.45676@pali> <55285D94.8030306@dell.com> <871tjrv23b.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871tjrv23b.fsf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


On 04/10/2015 09:19 PM, Ben Gamari wrote:
> Mario Limonciello <mario_limonciello@dell.com> writes:
>
> snip
>
> snip
> Is this to say that the issue will be fixed with a BIOS update?
>
> Cheers,
>
> - Ben
>

 From what I have gathered this is expected behavior that won't change.  The EC will intentionally drop packets while processing keyboard input.
