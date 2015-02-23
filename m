From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Mon, 23 Feb 2015 17:31:52 -0600
Message-ID: <54EBB868.2040405@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201502202141.16017@pali> <54E7A567.5030501@dell.com> <201502221755.05587@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201502221755.05587@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org


On 02/22/2015 10:55 AM, Pali Roh=C3=A1r wrote:
> Thank you for information!
Sure, no problem.
> Mario, do you know if it is possible to "switch" keyboard into
> mode under which Fn key will send scancode (like Ctrl or Alt)
> when presses, so it could be possible to use any Fn+key
> combination for keyboard shortcuts? Because now Fn+F* send one
> scancode (e.g. suspend key) and other combination of Fn+something
> does not work...
Sorry, this is not possible with today's BIOS and EC as I am aware. I'l=
l inquire about this for the future though.

> Dmitry, should not Linux follow this Windows input behaviour? For
> year we have seen people complaining about non working keyboard
> on Dell laptops under Linux (when user Windows it worked)...

This is a bit surprising to me.  Completely non-working?  Or similar pr=
oblem to what's getting fixed in the BIOS update we discussed above?

> Now that BIOS/EC problem is fixed for some dell laptops (probably
> new versions of BIOSes for other modules will be released too),
> but it is really bad to see *new* laptop (with broken BIOS) that
> does not work under Linux (and work under Windows)...
>
Yes, if you're aware of any models that are not fixed by the BIOS updat=
e this month, I would be interested to know.  A majority of our hardwar=
e does undergo testing with Linux during development, so usually these =
types of things are caught.  Once we declare a BIOS stable it's a much =
lengthier process to issue future fixes however.
