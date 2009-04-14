From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Apple Wireless Mighty Mouse HWheel quirk
Date: Tue, 14 Apr 2009 21:45:37 +0200
Message-ID: <49E4E7E1.7040109@gmail.com>
References: <3aaafc130904141224w3bb76cc1ic39c8c4fd738a458@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:60659 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbZDNTpl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2009 15:45:41 -0400
Received: by fxm2 with SMTP id 2so2593407fxm.37
        for <linux-input@vger.kernel.org>; Tue, 14 Apr 2009 12:45:39 -0700 (PDT)
In-Reply-To: <3aaafc130904141224w3bb76cc1ic39c8c4fd738a458@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "J.R. Mauro" <jrm8005@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Marcel Holtmann <marcel@holtmann.org>, linux-input@vger.kernel.org

On 04/14/2009 09:24 PM, J.R. Mauro wrote:
> I have an Apple bluetooth mouse (info below) and have noticed that the
> horizontal scrolling is inverted. I've noticed some bug reports from
> others getting the same behavior. I looked at drivers/hid/hid-apple.c
> , and around line 444 I see that APPLE_INVERT_HWHEEL gets ORed in. I
> tried to trace the origins of the code, but I lost track of it before
> 8c19a515, where you moved Apple quirks to their own file. Is this
> quirk definitely correct?
> 
> Mouse's entry in /proc/bus/input/devices
> I: Bus=0005 Vendor=05ac Product=030c Version=0200
> 
> I'm running Gentoo, vanilla 2.6.29 with no patches.

Hi,

I have no idea whether the inversion is correct or not. Or where the
information comes from :).

It was added in
cb3fecc2f29056e89658e7eb371e7f9be66cda6d
by Jiri Kosina, maybe he may shed some light on it?
