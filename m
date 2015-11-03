From: Marcos Souza <marcos.souza.org@gmail.com>
Subject: Re: Touchpad stops to work after a suspend/hibernate and resume
Date: Mon, 2 Nov 2015 22:12:21 -0200
Message-ID: <CAH0vN5+S+4uarOWM9vmg=87Ezu=EBxSjL0914pmr2Q-fq1O=zQ@mail.gmail.com>
References: <CAH0vN5L=grqQROdsZ=PkARFP0PGixU=D6oWxW7-kRUcssdb2Ew@mail.gmail.com>
	<CAF8px54vNhN10U+-izJ6S3PnFTALrViWrMh-ZE7ZhHiGDWSX_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35758 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbKCAMW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 19:12:22 -0500
Received: by ykek133 with SMTP id k133so655778yke.2
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2015 16:12:21 -0800 (PST)
In-Reply-To: <CAF8px54vNhN10U+-izJ6S3PnFTALrViWrMh-ZE7ZhHiGDWSX_g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Mestnik <cheako@mikemestnik.net>
Cc: linux-input@vger.kernel.org

HI Mike,

thanks for the quick answer!

Here I'm using Fedora 22 with GNOME. So, the problem is related to
gnome-settings-daemon and not with the kernel itself?

Thanks,

2015-11-02 22:10 GMT-02:00 Mike Mestnik <cheako@mikemestnik.net>:
> For some reason Debian is shipping a version of gnome-settings-daemon that
> does this.  Upgrade to sid.
>
> On Nov 2, 2015 6:07 PM, "Marcos Souza" <marcos.souza.org@gmail.com> wrote:
>>
>> Hi guys,
>>
>> some time ago I sent a patch to Linux kernel to enable my touchpad to
>> be recognized by Linux[1]. Everything was going smoothly, until I
>> check my touchpad stops to work after a suspend o hibernate.
>>
>> There is some troubleshoot that I need to check first, or maybe some
>> test that I could do?
>>
>> Please let me know if you need more info. Also, please CC me because
>> I'm not subscribed to this list.
>>
>> Thanks a lot,
>>
>> Marcos Paulo de Souza
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Att,

Marcos Paulo de Souza
Github: https://github.com/marcosps/
