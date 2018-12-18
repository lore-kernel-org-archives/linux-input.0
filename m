From: Numan =?UTF-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
Subject: Re: [regression, bisected] Keyboard not responding after resuming
 from suspend/hibernate
Date: Tue, 18 Dec 2018 10:23:02 +0300
Message-ID: <20181218102302.2b029612@korsan.localdomain>
References: <20180831215121.1b1f66bf@korsan.localdomain>
        <20181019102031.77015d44@korsan.localdomain>
        <20181025074903.GA9323@amd>
        <20181028220654.7e77e5d7@ubuntu>
        <20181130154455.21578c4d@korsan.localdomain>
        <20181202222809.GA29467@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ug/JvfsHSZuytceYAejq0DI"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181202222809.GA29467@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: jason.low2@hpe.com, Waiman.Long@hpe.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, dmitry.torokhov@gmail.com, peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--Sig_/ug/JvfsHSZuytceYAejq0DI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sun, 2 Dec 2018 23:28:09 +0100 tarihinde
Pavel Machek <pavel@ucw.cz> yazd=C4=B1:

>On Fri 2018-11-30 15:44:55, Numan Demird=C3=B6=C4=9Fen wrote:
>> Sun, 28 Oct 2018 22:06:54 +0300 tarihinde
>> Numan Demird=C3=B6=C4=9Fen <if.gnu.linux@gmail.com> yazd=C4=B1:
>>  =20
>> >Thu, 25 Oct 2018 09:49:03 +0200 tarihinde
>> >Pavel Machek <pavel@ucw.cz> yazd=C4=B1:
>> > =20
>> >> Hi!
>> >>=20
>> >> Here's problem bisected down to:
>> >>=20
>> >> commit 9d659ae14b545c4296e812c70493bfdc999b5c1c
>> >> Author: Peter Zijlstra <peterz@infradead.org>
>> >> Date:   Tue Aug 23 14:40:16 2016 +0200
>> >>=20
>> >>     locking/mutex: Add lock handoff to avoid starvation
>> >>=20
>> >>     Implement lock handoff to avoid lock starvation.
>> >>=20
>> >> Numan, I assume revert of that patch on the 4.18 kernel still
>> >> makes it work?
>> >>    =20
>> >
>> >Unfortunately, I could not revert
>> >9d659ae14b545c4296e812c70493bfdc999b5c1c on kernels from 4.18.16 to
>> >4.10-rc1 because there were too much conflicts, which I could not
>> >solve as an "average Joe". I tried
>> >a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3 which is parent of
>> >9d659ae14b545c4296e812c70493bfdc999b5c1c and succeeded to compile
>> >kernel.
>> >
>> >git checkout a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3
>> >
>> >Then, I compiled kernel and rebooted with it. I tried a couples of
>> >times suspending and resuming, all of the time keyboard worked as
>> >expected.
>> > =20
>>=20
>> With this one line patch from Takashi Iwai, keyboard is working as
>> expected after resuming from suspend/hibernate.
>>=20
>> --- a/kernel/locking/mutex.c
>> +++ b/kernel/locking/mutex.c
>> @@ -59,7 +59,7 @@ EXPORT_SYMBOL(__mutex_init);
>>   * Bit2 indicates handoff has been done and we're waiting for
>> pickup. */
>>  #define MUTEX_FLAG_WAITERS	0x01
>> -#define MUTEX_FLAG_HANDOFF	0x02
>> +#define MUTEX_FLAG_HANDOFF	0x00
>>  #define MUTEX_FLAG_PICKUP	0x04
>> =20
>>  #define MUTEX_FLAGS		0x07
>>=20
>>=20
>> Thanks in advance and regards, =20
>
>Ok. So it is a regression, and you can ask Linus to apply this
>.. but... that's kind of heavy solution. Peter, do you have any other
>ideas?
>
>									Pavel

Hi,

I did not mention the one line patch from Takashi Iwai as a means of fix
but as a hint. Sorry for misunderstanding.

Here is a another hint from another user:

I found that passing the options i8042.reset=3D1 i8042.dumbkbd=3D1 i8042.di=
rect=3D1
results in the keyboard functioning after resume. However, there is a
long delay before the keyboard or mouse will respond to input on the
lock screen.[1]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D195471#c39

--=20
Numan Demird=C3=B6=C4=9Fen

--Sig_/ug/JvfsHSZuytceYAejq0DI
Content-Type: application/pgp-signature
Content-Description: Dijital OpenPGP imzası

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEKU9fayrDgTGfA1OV4Dh9jqVujDIFAlwYoFYACgkQ4Dh9jqVu
jDIa7Qf/RTbkNmO3EHq+cL82Bv18SDJQFgM6haeV4uLp+VsVrwuQq8vFwUByLreW
pYZ2kS1km16hEyJiYzigc/WAy/BvPdXw7kswsxqQMM1uMMmiKAXIgvuFQtMXiGdo
FmRA14ufO7k03i8krnd+hFF9yQGznbIsySe2YWLvL/8zdFCQ6Fq0Qd8eRHMsIi3i
ZufdHxtQEzgZkUtTCeYOw7S3KyjS3YujfxzH3WpFK+Mi0JGodJrla5KY+t1SXCHg
JEk5S2O0EC/XB+oBzhUJMKc8Vw0ZGAwwc2V5o6QrOjJ7vY6ZljR6hHdQVyxUuLXF
2gk2zDO5e9njtKA/+U1jk7ngS5bVtA==
=Zr39
-----END PGP SIGNATURE-----

--Sig_/ug/JvfsHSZuytceYAejq0DI--
