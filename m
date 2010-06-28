From: Dan Murphy <murpdj72@gmail.com>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen
	driver
Date: Mon, 28 Jun 2010 09:33:41 -0500
Message-ID: <AANLkTikJrtCEEdbtXjFA5PjZo8TvOXqFC872LHJQhfBQ@mail.gmail.com>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
	<4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com>
	<4C285124.1050201@euromail.se> <4C285AB1.7030301@samsung.com>
	<4C285E85.6080008@euromail.se> <4C2865D0.7020605@samsung.com>
	<4C28689A.60701@euromail.se> <4C2872B2.1030405@samsung.com>
	<4C2877F3.8020003@euromail.se> <4C2883A9.5060305@samsung.com>
	<4C28944A.4050501@euromail.se> <4C289C62.5090403@samsung.com>
	<4C28A279.2080100@euromail.se> <AANLkTimf-ku6PcfjVWmH0NwtBBxBGH7NWxC2NK6BPGmJ@mail.gmail.com>
	<AANLkTikNh-LTClIgXGAIEkegLCmWNnN2Zk05XhZWOumb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55999 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab0F1OeE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 10:34:04 -0400
Received: by bwz1 with SMTP id 1so227268bwz.19
        for <linux-input@vger.kernel.org>; Mon, 28 Jun 2010 07:34:02 -0700 (PDT)
In-Reply-To: <AANLkTikNh-LTClIgXGAIEkegLCmWNnN2Zk05XhZWOumb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On Mon, Jun 28, 2010 at 9:26 AM, Dan Murphy <murpdj72@gmail.com> wrote:
>
> I don't see any error handling from the IC here.
>
> Generally this IC should give a few error messages if a X/Y line is b=
roken, the chip goes into reset, or the chip is missed configured.
>
> This is a bad situation here
> +=A0=A0=A0=A0=A0=A0 /* Read dummy message to make high CHG pin */
> +=A0=A0=A0=A0=A0=A0 do {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D qt602240_read_obj=
ect(data, QT602240_GEN_MESSAGE, 0);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn ret;
> +=A0=A0=A0=A0=A0=A0 } while (ret !=3D 0xff);
>
> The chip may have an error and constantly send you the message which =
means you will never get out of this loop.=A0 This can be bad as your p=
robe or load_fw may never return.
>
>
>
> Dan
>
> On Mon, Jun 28, 2010 at 8:41 AM, Joonyoung Shim <dofmind@gmail.com> w=
rote:
>>
>> 2010/6/28 Henrik Rydberg <rydberg@euromail.se>:
>> > Joonyoung Shim wrote:
>> > [...]
>> >> What is the full set of anonymous contacts? It needs the descript=
ion of
>> >> case sending event for a finger going away.
>> >
>> > I disagree. Protocol A deals with devices that do not necessarily =
know what
>> > going away means. There is a whole new protocol devoted to your ki=
nd of
>> > hardware, type B, and using protocol A is simply not encouraged.
>> >
>>
>> If so, i'm fine.
>>
>> Thanks.
>>
>>
>> --
>> - Joonyoung Shim
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
