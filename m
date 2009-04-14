From: "J.R. Mauro" <jrm8005@gmail.com>
Subject: Re: Apple Wireless Mighty Mouse HWheel quirk
Date: Tue, 14 Apr 2009 17:15:28 -0400
Message-ID: <3aaafc130904141415i676e82bew188eeb3404dd3867@mail.gmail.com>
References: <3aaafc130904141224w3bb76cc1ic39c8c4fd738a458@mail.gmail.com>
	 <49E4E7E1.7040109@gmail.com>
	 <alpine.LNX.2.00.0904142307260.13028@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:6802 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbZDNVP3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2009 17:15:29 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2840592ywb.1
        for <linux-input@vger.kernel.org>; Tue, 14 Apr 2009 14:15:28 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904142307260.13028@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-input@vger.kernel.org

On Tue, Apr 14, 2009 at 5:09 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 14 Apr 2009, Jiri Slaby wrote:
>
>> > I have an Apple bluetooth mouse (info below) and have noticed that the
>> > horizontal scrolling is inverted. I've noticed some bug reports from
>> > others getting the same behavior. I looked at drivers/hid/hid-apple.c
>> > , and around line 444 I see that APPLE_INVERT_HWHEEL gets ORed in. I
>> > tried to trace the origins of the code, but I lost track of it before
>> > 8c19a515, where you moved Apple quirks to their own file. Is this
>> > quirk definitely correct?
>> > Mouse's entry in /proc/bus/input/devices
>> > I: Bus=0005 Vendor=05ac Product=030c Version=0200
>> > I'm running Gentoo, vanilla 2.6.29 with no patches.
>> I have no idea whether the inversion is correct or not. Or where the
>> information comes from :).
>> It was added in
>> cb3fecc2f29056e89658e7eb371e7f9be66cda6d
>> by Jiri Kosina, maybe he may shed some light on it?
>
> I created this patch based solely on a bugreport, I didn't physically own
> the hardware at that time.
>
> I think I have it somewhere. I will try to find it tomorrow or the day
> after tomorrow and verify whether the quirk is really needed. Maybe the
> original bug reporter messed up, or he had different hardware revision.
>
> --
> Jiri Kosina
> SUSE Labs
>

Just for reference, it seems that other people have been having the
same problems, and finger the same quirk:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/291408

Thanks for looking into this.
