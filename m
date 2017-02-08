From: "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH] Input: pwm-beeper: support customized freq for SND_BELL
Date: Wed, 8 Feb 2017 10:11:21 +0000
Message-ID: <850c2508720a41b3bfb95cd7093433a4@SI-MBX1030.de.bosch.com>
References: <1486444894-18321-1-git-send-email-hs@denx.de>
 <20170207181309.GC38092@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170207181309.GC38092@dtor-ws>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Schocher <hs@denx.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "GUAN Ben (ST-FIR/ENG1-Zhu)" <Ben.Guan@cn.bosch.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Mark Rutland <mark.rutland@arm.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

> > extend the pwm-beeper driver to support customized frequency
> > for SND_BELL from device tree.
>=20
> No, SND_BELL is literally SND_TONE @1000Hz. There should be no
> customizing. If applications want to use different frequency then should
> be using SND_TONE.

We are not aiming for an application shortcut here. Instead, changing the b=
ell frequency shall be a system setting. That is, every application which w=
ants to make a bell sound shall use the alternative frequency.

The reason why we are deviating from the default 1000 Hz is that on our har=
dware we are using a loudspeaker which is rated for 2.7 kHz. That is, it wi=
ll only sound at the specified volume and frequency if you feed it with a 2=
.7 kHz square wave. If you deviate from it, e.g. by using 1000 Hz, the outp=
ut will be dim and squeaky. Worst case, SND_BELL would be completely silent=
 on our system. So the only bell sound we can reliably generate on our syst=
em has 2.7 kHz.

The good news for everybody else's systems is that the patch does not chang=
e the default behavior. If not specified in the DT, the frequency will stil=
l be 1000 Hz. But other systems which are similarly challenged could now of=
fer a reasonable bell sound, too.

Can you point me to a specification or standard which defines that SND_BELL=
 has to be 1000 Hz without any exception?

I did some research on that topic and was not able to discover such a speci=
fication or standard. What I did find though was that the ASCII or Unicode =
BEL character is most likely very closely related to SND_BELL. And for BEL =
there is no frequency specified. Historically it once was a real bell which=
 was rung. The intention was to notify the human on the other end of a tele=
type to have a look at it. And that is guaranteed with 1000 Hz as well as w=
ith 2.7 kHz as long as the sound is perceptible to the human ear.

https://en.wikipedia.org/wiki/Bell_character

Regards,
Mark
