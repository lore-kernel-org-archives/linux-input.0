From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: Regression in hid-multitouch?
Date: Sat, 7 Jul 2012 20:26:01 +0200
Message-ID: <CAN+gG=Ewk-wNszs+iaiQ+v31QMbrGom+fjN4WoCeA2o++sRxww@mail.gmail.com>
References: <20120707215541.GB2484@slate.Speedport_W723_V_Typ_A_1_00_092>
	<20120707224832.GA2074@slate.Speedport_W723_V_Typ_A_1_00_092>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:45176 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab2GGS0B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Jul 2012 14:26:01 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so9359072ggl.19
        for <linux-input@vger.kernel.org>; Sat, 07 Jul 2012 11:26:01 -0700 (PDT)
In-Reply-To: <20120707224832.GA2074@slate.Speedport_W723_V_Typ_A_1_00_092>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cedric Sodhi <manday@gmx.net>
Cc: linux-input@vger.kernel.org

Hi Cedric,

I'm a little bit lost there. You still have the same problems than the
one described in the thread in xorg-devel? I don't get the "though the
touchpoints are correctly recognized"...

Can you send us your dmesg output and the trace from evtest?
I also would like to know which kernel version is working and which is not.

Thanks,
Benjamin

On Sun, Jul 8, 2012 at 12:48 AM, Cedric Sodhi <manday@gmx.net> wrote:
> Sorry, this is not a regression. I just reverted to said commit and I
> still have those problems (described in detail, here:
>
> http://comments.gmane.org/gmane.comp.freedesktop.xorg.devel/31159
>
> - though the touchpoints are correctly recognized).
>
> On Sat, Jul 07, 2012 at 11:55:41PM +0200, Cedric Sodhi wrote:
>> What previously seems to have been fixed by
>>
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=3ac36d15557d1bedfb1151d9911b9587b2d40759
>>
>> has again stopped working in 3.5.0-rc5 - at least I get the exact same
>> problems I used to have before 3ac36d... although the code from 3ac36d
>> is still there.
>>
>> regards,
>> Cedric
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
