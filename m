From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Wed, 25 Feb 2015 12:26:18 -0600
Message-ID: <54EE13CA.1090101@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201502202141.16017@pali> <54E7A567.5030501@dell.com> <201502221755.05587@pali> <20150224005109.GD604@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224005109.GD604@dtor-glaptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?windows-1252?Q?Pali_?= =?windows-1252?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org


On 02/23/2015 06:51 PM, Dmitry Torokhov wrote:
> On Sun, Feb 22, 2015 at 05:55:05PM +0100, Pali Roh=E1r wrote:
> I am not sure what exactly the issue is... We do need to have the bre=
ak
> code to know when the key is released. We can't go and say that we wi=
ll
> release old key when we detect another key press as that would mess u=
p
> key combination handling (like control, meta, etc).
>
> What does Windows driver do?
>
> Thanks.
>
To me it sounds like the Windows driver understands a situation that th=
ere are a bunch of key down events without a keyup event until you lift=
 your finger rather than expecting a pair every time.
https://msdn.microsoft.com/en-us/library/windows/desktop/ms646267(v=3Dv=
s.85).aspx
