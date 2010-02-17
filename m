From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Wed, 17 Feb 2010 12:49:14 -0800
Message-ID: <446821D4-8E9D-4701-9A50-04738C5733B6@gmail.com>
References: <1266356185-10324-1-git-send-email-mjg@redhat.com> <20100217052247.GD7160@core.coreip.homeip.net> <20100217180342.GA22522@srcf.ucam.org> <22ee4e771002171043u2aaf97vd73c1090c2fce901@mail.gmail.com> <20100217191708.GA15554@core.coreip.homeip.net> <22ee4e771002171142q1496842ap4079026a5c0be8c6@mail.gmail.com> <20100217195435.GA15742@core.coreip.homeip.net> <20100217200233.GA24976@srcf.ucam.org>
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f180.google.com ([209.85.210.180]:57792 "EHLO
	mail-yx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab0BQUta (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 15:49:30 -0500
In-Reply-To: <20100217200233.GA24976@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Christian Lamparter <chunkeey@googlemail.com>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "marcel@holtmann.org" <marcel@holtmann.org>

On Feb 17, 2010, at 12:02 PM, Matthew Garrett <mjg59@srcf.ucam.org>  
wrote:

> On Wed, Feb 17, 2010 at 11:54:35AM -0800, Dmitry Torokhov wrote:
>
>> Is there anything currently in works that would make use of this  
>> button?
>> I do not want to allocate keycode "for the future" which may never  
>> come.
>> We did it with KEY_BATTERY but I do not think anyone actually uses  
>> it.
>
> KEY_BATTERY is heavily used in userspace. I think all the hardware  
> that
> generates it does so via i8042 rather than a platform driver, so it
> wouldn't show up in the kernel.
>

Ah, I see. I hope the keycode is not used to signal battery status  
change but to invoke battery/power manager applet...

-- 
Dmitry

