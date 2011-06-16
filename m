From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC 05/12] HID: wiimote: Synchronize wiimote input and hid event handling
Date: Thu, 16 Jun 2011 12:29:40 +0200
Message-ID: <BANLkTinwT3CSwkiytCoVbb4Q6UMzDx8tag@mail.gmail.com>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com>
	<201106150834.16081.oliver@neukum.org>
	<alpine.LNX.2.00.1106161119280.22872@pobox.suse.cz>
	<201106161218.55279.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64898 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab1FPK3k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2011 06:29:40 -0400
Received: by vws1 with SMTP id 1so1040128vws.19
        for <linux-input@vger.kernel.org>; Thu, 16 Jun 2011 03:29:40 -0700 (PDT)
In-Reply-To: <201106161218.55279.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, padovan@profusion.mobi

On Thu, Jun 16, 2011 at 12:18 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Donnerstag, 16. Juni 2011, 11:20:18 schrieb Jiri Kosina:
>> > Here an smp_wmb()
>> > It is redundant because input_register_device takes a spinlock which
>> > implies a barrier, but you'll make the automated checking tools happier.
>>
>> Yeah, spinlock implies SMP barrier implicitly.
>>
>> I don't think adding barriers just to make some buggy automatic checker
>> happy is worth it.
>
> Fine by me as long as the problem is understood.

Does that mean that I can omit the smp_rmb(), too? I do not like
relying on input_register_device to use a spinlock. It makes reading
the code hard, so I added both barriers. Should I remove them again or
keep them?

Thank you for reviewing. I have fixed all your concerns. I will resend
the patches if there are no more comments on the code as [PATCH] in
few days.

Regards
David
