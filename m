From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC][PATCH] input: Introduce device information ioctl
Date: Tue, 7 Dec 2010 13:52:28 +0100
Message-ID: <AANLkTi=Av1N2URqpgrAUCreFoJXb6ZtEkkgp_Jo4BgRw@mail.gmail.com>
References: <1291706726-8835-1-git-send-email-rydberg@euromail.se>
 <20101207105620.GB23729@core.coreip.homeip.net> <AANLkTinmcKgUJfs+0_E6Zke6Y0+nfMU71Z8sY_-7-0iE@mail.gmail.com>
 <201012071344.01173.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:57510 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab0LGMwo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Dec 2010 07:52:44 -0500
In-Reply-To: <201012071344.01173.arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>

On Tue, Dec 7, 2010 at 13:44, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 07 December 2010, Kay Sievers wrote:
>> On Tue, Dec 7, 2010 at 11:56, Dmitry Torokhov <dmitry.torokhov@gmail=
=2Ecom> wrote:
>> > On Tue, Dec 07, 2010 at 11:48:28AM +0100, Kay Sievers wrote:
>>
>> >> Please don't add new ioctls which are not extensible. The ioctl s=
hould
>> >> carry the length or the version of the structure it asks for, so =
it
>> >> can be extended in the future.
>> >
>> > Size of ioctl data is encoded in ioctl, it can be extended easily.=
 For
>> > examples take a look at how EVIOCGKEYCODE and EVIOCGSKEYCODE are h=
andled
>> > in recent kernels.
>>
>> Oh, how does that work? With the ioctl call, userspace has to supply
>> the size it expects to be returned from the kernel. How does the
>> kernel otherwise know how much it is allowed to copy to the user?
>
> The ioctl command number itself is calculated from the size of the
> data that gets passed:
>
> #define EVIOCGDEVINFO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_IOR('E', 0x0=
9, struct input_devinfo)
>
> If struct input_devinfo ever changes (which it can, but should not),
> the command changes as well.

So unlike statet, it's not extensible, and this struct and this ioctl
can never change?

Kay
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
