From: Pingbo Wen <pingbo.wen@linaro.org>
Subject: Re: [PATCH V3] hp_sdc: convert struct timeval to ktime_t
Date: Fri, 23 Oct 2015 20:19:46 +0800
Message-ID: <6193EA0A-49EB-44FC-950A-F126B855E724@linaro.org>
References: <3901659.bcGNtuE6xV@wuerfel> <1445599779-11733-1-git-send-email-pingbo.wen@linaro.org> <4634704.Sh0UHGgRyQ@wuerfel>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36262 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbJWMTu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2015 08:19:50 -0400
Received: by pacfv9 with SMTP id fv9so122846269pac.3
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2015 05:19:50 -0700 (PDT)
In-Reply-To: <4634704.Sh0UHGgRyQ@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


> =D4=DA 2015=C4=EA10=D4=C223=C8=D5=A3=AC19:45=A3=ACArnd Bergmann <arnd=
@arndb.de> =D0=B4=B5=C0=A3=BA
>=20
> On Friday 23 October 2015 19:29:39 WEN Pingbo wrote:
>> 1. struct timeval is not y2038 safe, convert it to ktime_t, and ther=
e is no need to handle sec and usec separately
>>=20
>>=20
>=20
> The patch looks good now, but the changelog still needs a tiny bit of
> work. First of all, your line wrapping is off, please start a new lin=
e
> after around 70 characters as you do in an email.
>=20

Well, little fault:)
Will be fixed in next version.

> Also, we don't normally have enumerated lists in a changelog, just us=
e
> normal text. The best changelogs typically have three paragraphs:
>=20
> The first paragraph describes what the driver currently does. For rea=
lly
> obvious cases, this can be combined with the second paragraph.
>=20
> The second paragraph explains why that is bad. This is where you can
> mention the monotonic time vs real time issue and say whether we
> just want the timeval removed to fix the kernel in general or whether
> this particular driver is broken.
>=20
> The third paragraph explains what the patch does to resolve the issue
> described in the second one. This is also where you can list other
> approaches that would have solved the problem, and why you picked on
> over the others.

Do we really need this in ChangeLog? Commit msg already states this. I =
think
the purpose of ChangeLog is let people know the main difference of two
version patch at a glance, and the =A1=AEwhat=A1=AF and =A1=AEwhy=A1=AF=
 should be placed in
commit msg.

Pingbo--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
