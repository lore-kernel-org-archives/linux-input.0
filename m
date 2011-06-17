From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC 12/12] HID: wiimote: Add sysfs support to wiimote driver
Date: Fri, 17 Jun 2011 16:58:12 +0200
Message-ID: <BANLkTinM-Or0f+8M+JWQN00gTgwiR_RM5Q@mail.gmail.com>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
	<1308095157-4699-13-git-send-email-dh.herrmann@googlemail.com>
	<alpine.LNX.2.00.1106162035360.22872@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62938 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993Ab1FQO6N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2011 10:58:13 -0400
Received: by vws1 with SMTP id 1so1995037vws.19
        for <linux-input@vger.kernel.org>; Fri, 17 Jun 2011 07:58:13 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1106162035360.22872@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi

On Thu, Jun 16, 2011 at 8:35 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 15 Jun 2011, David Herrmann wrote:
>
>> Add sysfs files for each led of the wiimote. Writing 1 to the file
>> enables the led and 0 disables the led.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>
> As sysfs is part of kernel ABI, please document it in Documentation/ABI.

I've already documented it in the distribution package:
https://github.com/dvdhrm/xwiimote/blob/master/doc/INTERFACE_SYSFS
I forgot to include it in the patch, I now added the important parts.

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs

Thanks
David
