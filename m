From: Kay Sievers <kay@vrfy.org>
Subject: Re: issues with unknown/new alias
Date: Thu, 13 Sep 2012 13:09:17 +0200
Message-ID: <CAPXgP12vD65VmR7V8Mg7U2he0EoQr5PuLBDN+bUnQmMf_sq7TQ@mail.gmail.com>
References: <50518A75.4030608@codemercs.com> <505198E5.6000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59669 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2IMLJj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 07:09:39 -0400
Received: by bkwj10 with SMTP id j10so453537bkw.19
        for <linux-input@vger.kernel.org>; Thu, 13 Sep 2012 04:09:38 -0700 (PDT)
In-Reply-To: <505198E5.6000101@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc: Christoph Jung <jung@codemercs.com>, linux-input@vger.kernel.org, linux-modules@vger.kernel.org

On Thu, Sep 13, 2012 at 10:27 AM, Alan Jenkins
<alan.christopher.jenkins@gmail.com> wrote:
> On 13/09/12 08:25, Christoph Jung wrote:

>> Now we have some new custom product IDs but this two new devices get no
>> node in dev/usb/ , but I can find the with "lsusb".
>> If I run "modinfo iowarrior" there will be 5 alias (with the default pIDs)
>> .
>>
>> The two new pIDs are: 0x158A, 0x158B
>>
>> I have not much experiance with linux (I work with Ubuntu 12.04).
>
> Same OS and version, but I have no /dev/usb/ directory at all.  My guess is
> your problem isn't about modules.  I do have /dev/input/ though :).

He probably meant: /dev/bus/usb/, which everybody should have these
days, while /dev/usb/ is no ususal place.

Kay
