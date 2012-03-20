From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 06/20] Input: atmel_mxt_ts - allow writing to object sysfs
 entry
Date: Tue, 20 Mar 2012 16:32:10 -0700
Message-ID: <4F69137A.9070403@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-7-git-send-email-djkurtz@chromium.org> <20120320230353.5625540f@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:43718 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757944Ab2CTXcP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 19:32:15 -0400
In-Reply-To: <20120320230353.5625540f@pyramind.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

Alan Cox wrote:
> On Tue, 13 Mar 2012 20:04:09 +0800
> Daniel Kurtz <djkurtz@chromium.org> wrote:
>> Userspace can write a 24-bit value (encoded as a 6 character hex string)
>> to the 'object' sysfs entry to modify a single byte of the object table.
>> The hex string encodes a 3 bytes, in the following format:
> 
> How is this locked against other users and updates of these table data ?
> 
> I don't see how all the objects and their pointers and size are
> guaranteedto always be valid in all the users you have ?

The particular layout of the "objects" on the maxtouch chip only changes if
there is a firmware upgrade (or between different models of chip). It's
just a convenience to allow bits of functionality to be extended or
replaced without getting in a mess of random register in different places,
but it's not dynamic.

In terms of arbitrating between different reads/writes - the I2C bus
locking will handle most of it. To be entirely correct, I think there
should be a mutex so that this interface couldn't be used whilst the chip
is resetting, backing up or upgrading firmware.

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
