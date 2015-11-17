From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH v2 0/2] hid: sony: Clear and restore controller state on suspend and resume
Date: Tue, 17 Nov 2015 08:57:05 -0500
Message-ID: <E0EFFAFE-F9E3-435B-A89A-089F5C30A471@gmail.com>
References: <1447253378-13939-1-git-send-email-frank.praznik@gmail.com> <20151115163049.a5dc8380db1280ca1532f112@ao2.it>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36052 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbbKQN5I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Nov 2015 08:57:08 -0500
Received: by vkbs1 with SMTP id s1so5592315vkb.3
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2015 05:57:07 -0800 (PST)
In-Reply-To: <20151115163049.a5dc8380db1280ca1532f112@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz


> On Nov 15, 2015, at 10:30, Antonio Ospite <ao2@ao2.it> wrote:
>=20
> On Wed, 11 Nov 2015 09:49:36 -0500
> Frank Praznik <frank.praznik@gmail.com> wrote:
>=20
>> On systems with standby power for charging devices the LEDs and rumb=
le on the
>> controller can continue to function even when the system is in stand=
by since
>> the state is not cleared when the system goes to sleep.
>>=20
>> The state on wakeup can also differ from the state when the system e=
ntered
>> standby as the LEDs can be cleared when the device is reset on wakeu=
p.
>>=20
>> The first patch refactors the output report functions to allow sendi=
ng an
>> output report without going through the work queue.  This is necessa=
ry when
>> clearing the state of the controller before the system is goes into =
standby
>> since the work might not be executed before the system goes to sleep=
=2E
>>=20
>> The second patch implements the suspend and resume callbacks which s=
erializes
>> and clears the LEDs on suspend and restores them on resume.
>>=20
>> Force-feedback is cleared on suspend but the state is not restored o=
n resume
>> since it can potentially result in hardware damage if the device is =
unattended
>> when the system wakes.  A new event will be required to resume force=
-feedback.
>>=20
>=20
> Hi Frank, the changes are basically OK, but there are warnings and
> errors from scripts/checkpatch.pl
>=20
> Would you care to send a v3 which fixes those?
>=20
> Thanks a lot,
>   Antonio
>=20
> --=20
> Antonio Ospite
> http://ao2.it
>=20
> A: Because it messes up the order in which people normally read text.
>   See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?

I think checkpatch.pl has some issues at the moment as all of the white=
space errors it reports are are single spaces and are part of the patch=
 file formatting and not in the code itself (a space at the beginning o=
f lines that don=E2=80=99t begin with a =E2=80=98+' or =E2=80=98-' and =
after the final =E2=80=98=E2=80=94').  To be sure, I double checked tha=
t the formatting in the source file was free of extra whitespace, regen=
erated the patches and checkpatch still complains because it=E2=80=99s =
git format-patch putting the spaces there (as it always has).

Regards,
=46rank--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
