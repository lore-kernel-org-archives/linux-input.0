From: Numan =?UTF-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
Subject: Re: [regression, bisected] Keyboard not responding after resuming
 from suspend/hibernate
Date: Fri, 30 Nov 2018 15:44:55 +0300
Message-ID: <20181130154455.21578c4d@korsan.localdomain>
References: <20180831215121.1b1f66bf@korsan.localdomain>
        <20181019102031.77015d44@korsan.localdomain>
        <20181025074903.GA9323@amd>
        <20181028220654.7e77e5d7@ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T3r/f7.Qz1nIOR7uPeG1YpL"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181028220654.7e77e5d7@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
Cc: jason.low2@hpe.com, Waiman.Long@hpe.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, dmitry.torokhov@gmail.com, peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>"Waiman.Long@hpe.com" <Waiman.Long@hpe.com>"paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>"tglx@linutronix.de" <tglx@linutronix.de>"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>"peterz@infradead.org" <peterz@infradead.org>"mingo@redhat.com" <mingo@redhat.com>
List-Id: linux-input@vger.kernel.org

--Sig_/T3r/f7.Qz1nIOR7uPeG1YpL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sun, 28 Oct 2018 22:06:54 +0300 tarihinde
Numan Demird=C3=B6=C4=9Fen <if.gnu.linux@gmail.com> yazd=C4=B1:

>Thu, 25 Oct 2018 09:49:03 +0200 tarihinde
>Pavel Machek <pavel@ucw.cz> yazd=C4=B1:
>
>> Hi!
>>=20
>> Here's problem bisected down to:
>>=20
>> commit 9d659ae14b545c4296e812c70493bfdc999b5c1c
>> Author: Peter Zijlstra <peterz@infradead.org>
>> Date:   Tue Aug 23 14:40:16 2016 +0200
>>=20
>>     locking/mutex: Add lock handoff to avoid starvation
>>=20
>>     Implement lock handoff to avoid lock starvation.
>>=20
>> Numan, I assume revert of that patch on the 4.18 kernel still makes
>> it work?
>>  =20
>
>Unfortunately, I could not revert
>9d659ae14b545c4296e812c70493bfdc999b5c1c on kernels from 4.18.16 to
>4.10-rc1 because there were too much conflicts, which I could not solve
>as an "average Joe". I tried a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3
>which is parent of 9d659ae14b545c4296e812c70493bfdc999b5c1c and
>succeeded to compile kernel.
>
>git checkout a3ea3d9b865c2a8f7fe455c7fa26db4b6fd066e3
>
>Then, I compiled kernel and rebooted with it. I tried a couples of
>times suspending and resuming, all of the time keyboard worked as
>expected.
>

With this one line patch from Takashi Iwai, keyboard is working as
expected after resuming from suspend/hibernate.

--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -59,7 +59,7 @@ EXPORT_SYMBOL(__mutex_init);
  * Bit2 indicates handoff has been done and we're waiting for pickup.
  */
 #define MUTEX_FLAG_WAITERS	0x01
-#define MUTEX_FLAG_HANDOFF	0x02
+#define MUTEX_FLAG_HANDOFF	0x00
 #define MUTEX_FLAG_PICKUP	0x04
=20
 #define MUTEX_FLAGS		0x07


Thanks in advance and regards,
--=20
Numan Demird=C3=B6=C4=9Fen

--Sig_/T3r/f7.Qz1nIOR7uPeG1YpL
Content-Type: application/pgp-signature
Content-Description: Dijital OpenPGP imzası

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEKU9fayrDgTGfA1OV4Dh9jqVujDIFAlwBMMcACgkQ4Dh9jqVu
jDKDjAf8D7qxf+fdnacPE31M4QXEPbTRTXip8nTO6iblMI11/8VtOSxsjn1ZKfVX
Pqb887mRmmiHk7ywg2qQYjmO03O2sa/u4/yUljRgVuZaANkhTCrZeZ4yzOfK74BT
RPA7m3KaHdAONby/08HofPaOS3VoUQgKruB/kioGTnW404G5KpZjy1/mEj4NNZAw
QqppjbIeOXmkiQ0C6nPS/KPSVEphhYbcBStmT4gOAIUXQyn6iaXxD4THb6yl2hwp
P+MV+UCA7QR+Xp55R8Mxe35GPb1sfM8oV19401wOUn/gwvA5n9GlCFl8MVuet8YN
g6p6ouahNo+DWONnqJ/yiKY0syEYBw==
=oD5S
-----END PGP SIGNATURE-----

--Sig_/T3r/f7.Qz1nIOR7uPeG1YpL--
