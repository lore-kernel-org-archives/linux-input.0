From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: New ALPS not detected EC=88 b6 06 - Lenovo Ideapad Flex 15D
Date: Sat, 18 Jan 2014 20:45:53 +0800
Message-ID: <CA+F6ckOKEtbP=+bk8UY+uhv2qjD7GDV9Tg_KSgM_8qUzNuQ=1g@mail.gmail.com>
References: <1390003610.16861.YahooMailNeo@web162404.mail.bf1.yahoo.com>
	<CA+F6ckMtidbKYONs=cFLvhqePwWhg14UDRCxVZ+8eTa_8P2hAA@mail.gmail.com>
	<1390022292.30501.YahooMailNeo@web162402.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:45880 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbaARMpy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jan 2014 07:45:54 -0500
Received: by mail-la0-f54.google.com with SMTP id y1so4467139lam.27
        for <linux-input@vger.kernel.org>; Sat, 18 Jan 2014 04:45:53 -0800 (PST)
In-Reply-To: <1390022292.30501.YahooMailNeo@web162402.mail.bf1.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Omar Loggiodice <ologgio@yahoo.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Elaine Chen <elaineee66@gmail.com>, Qiting Chen <qiting.chen@cn.alps.com>

Hi Omar,

I'm glad to hear this good news and also thanks for your trying with
our patch : )

Thanks
-- 
Best Regards,
Tommy

2014/1/18 Omar Loggiodice <ologgio@yahoo.com>:
> The patch works very well! I now need to adjust the settings. I wanted to let you know  two
> finger middle button works, along with two finger scrolling, circular
> scrolling, edge scrolling, right button, etc. Everything is working.
>
>
> Thank you all for the good work you do for the linux community.
>
>
>
>
>
> On Friday, January 17, 2014 9:49 PM, Tommy Will <tommywill2011@gmail.com> wrote:
> Hi Omar,
>
> Thanks for your mail. This is Tommy from ALPS.
> According to your info "E7=73 03 0a, EC=88 b6 06", I think you're now
> using ALPS_PROTO_V7 device.
> My colleague Elaine(Qiting) is now working with this touchpad's
> support and has released a patch last week.
> You can have a try ~
>
>     http://www.spinics.net/lists/linux-input/msg29084.html
>
> If you find any issue or have any suggestion, please kindly let us
> know. We'll try our best to make the driver better.
>
> Thanks!
>
> --
> Best Regards,
> Tommy
>
>
> 2014/1/18 Omar Loggiodice <ologgio@yahoo.com>:
>> Hi,
>>
>>
>>    First, thank you for your excellent work. I recently bought a new Lenovo Ideapad Flex 15D, it comes with Windows 8.1.
>>
>> I have been able to run linux, however the ALPS touchpad is only recognized as a PS/2 mouse. I also have some problems with the screen
>> turning off and the GPU stalling, but this is outside of the scope of
>> this list.  This is what dmesg shows for the touchpad:
>>
>> psmouse serio1: alps: Unknown ALPS touchpad: E7=73 03 0a, EC=88 b6 06
>>
>> I hacked alps.c with the following code in alps_identify(...):
>>
>> [...]
>>
>> } else if (ec[0] == 0x88 && ec[1] == 0xb6 &&
>>                    ec[2] == 0x06 )
>>  {
>>                 priv->proto_version = ALPS_PROTO_V5;
>>                 alps_set_defaults(priv);
>>
>>                 return 0;
>>         }
>> [...]
>>
>> With this code the module seems to recognize the card and dmesg reports the following:
>>
>> [  791.663876] input: PS/2 Mouse as /devices/platform/i8042/serio1/input/input22
>> [  791.692023] input: AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/serio1/input/input21
>>
>>
>> However, the touchpad still operates only as a PS/2 mouse (no scroll, no middle
>> button emulation, no touch gestures) even if I disable the PS/2 mouse
>> with xinput.
>>
>> any help would be appreciated, I am willing to test patches if you send them to me.
>>
>> Thanks!
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
