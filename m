From: Tracey Dent <tdent48227@gmail.com>
Subject: Re: [PATCH 1/2] Drivers: hid: Makefile: Cleaned up Makefile
Date: Tue, 16 Nov 2010 22:28:19 -0500
Message-ID: <AANLkTikKTLpzafaE9oxRz1f_ZE9zv1eL6K8aAkYmR+TB@mail.gmail.com>
References: <1289141188-1447-1-git-send-email-tdent48227@gmail.com>
	<alpine.LNX.2.00.1011151557510.7420@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36988 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757952Ab0KQD2U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Nov 2010 22:28:20 -0500
In-Reply-To: <alpine.LNX.2.00.1011151557510.7420@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: dmitry.torokhov@gmail.com, chatty@enac.fr, spbnick@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/15/10, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sun, 7 Nov 2010, Tracey Dent wrote:
>
>> Changed Makefile to use <modules>-y instead of <modules>-objs because
>> -objs is deprecated and should now be switched. According to
>> (documentation/kbuild/makefiles.txt).
>
> Actually, where exactly does this file document it?
>

It documents how it should be done in the section entitled --- 3.7
Compilation flags (which starts on line 284).

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>

regards

Tracey Dent
