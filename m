From: Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 2/2] Add a device driver for the Apple Magic Mouse.
Date: Wed, 10 Feb 2010 22:20:13 -0500
Message-ID: <878wb0e9w2.fsf@troilus.org>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>
	<87y6j2eeqv.fsf_-_@troilus.org> <87pr4eeemz.fsf_-_@troilus.org>
	<201002102205.58967.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201002102205.58967.edt-Yad3+ZauZac@public.gmane.org> (Ed Tomlinson's message of "Wed,
	10 Feb 2010 22:05:58 -0500")
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ed Tomlinson <edt-Yad3+ZauZac@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Ed Tomlinson writes:

> Hi,
>
> When I apply this to head, I get:
>
> drivers/hid/hid-magicmouse.c: In function 'magicmouse_probe':                                                         
> drivers/hid/hid-magicmouse.c:393: error: too many arguments to function 'hdev->hid_output_raw_report'                 
> drivers/hid/hid-magicmouse.c:400: error: too many arguments to function 'hdev->hid_output_raw_report'                 
>
> I only need the second patch - the first seems to be in tree.
>
> Any ideas as to what I am missing?
>
> TIA
> Ed

You're missing the patch that makes hid_output_raw_report() more generic.
It is in the HID tree[1] as commit d4bfa033.

[1]- http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git

Michael Poole
