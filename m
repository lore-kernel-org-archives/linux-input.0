Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C953822BB;
	Tue,  4 Aug 2026 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868582; cv=none; b=OxZdT/vwXvIp+zWY072nYekSv5swSKnzgQTH24kB36gO5LCqXArMZHtvaJxawD9UxTCTX+PiF1oOhg32IS0560+kOCiVjQhlsk8bWVzrMfhY6oDISeMX6LCh7fhmJiuWx4/vikYK52orUfresK0jp4i5glx4qEf/JJ3F2yny89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868582; c=relaxed/simple;
	bh=MMYUIwA1iXtpwGuSRLodo0a7oF9bMeHlYx/qR2zRXNY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zdb8emuatLR1agUT4EygZWodQY56v0aP876ZBISD44TO/B7AUce6xLvFcH+pcKVIVznJf1zFrjc5E1PheIfVfOBFHRan9LtVdrUbU84fcHKiyO+Z1LESXlwbhSh3kqSw39/Zp1jr4SLW6vfoesAZf3DyZgrOwp60HA0/4SzZbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=YVkmDwkz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="YVkmDwkz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785868578; x=1786473378; i=deller@gmx.de;
	bh=MMYUIwA1iXtpwGuSRLodo0a7oF9bMeHlYx/qR2zRXNY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YVkmDwkzu1DaS4qxZwdBQwFcBPhWv4PwN1Go0j4vAR/iiHmRHZPvtMwkhqltmao4
	 0WbhrFTFRhryhaGX/faWmYNz8Lq6e+tJ/C60r+MCGRSou8J6SVmjTHE2z2M7HQZkD
	 Q8l89tPngiXrSmbWGJk2cFq3o0ofT4cB8+8dcIx/NoTObMUaEdI4Z+HtcklkPwF8s
	 SnoHP9rab6IqU+yBCFi8WUYzK8YSqIGy3kEFaasL8Jd8hY3GLBKg3BZ26N2XXrpb3
	 V8l28efrSb9+t7DWxOwCFPSneqZ/X6W0v4lVOlYdkU+gtNQohsazN6xlos9vtkO37
	 4VXBEqFtY0iu+ntZHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1wa4830I41-00Kk15; Tue, 04
 Aug 2026 20:36:18 +0200
Message-ID: <f0d96059-31c1-434c-b3d0-b2119f915d61@gmx.de>
Date: Tue, 4 Aug 2026 20:36:17 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: gscps2 - supply PA-RISC keyboard keymap via device
 property
From: Helge Deller <deller@gmx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-parisc@vger.kernel.org
References: <am_9BvmZu9g4RlUM@google.com>
 <4346aa03-1d8c-4a9a-bad3-0c4186dbc65d@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <4346aa03-1d8c-4a9a-bad3-0c4186dbc65d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:szssqnGTdqLM4TIZZw75B4GBuBUBjbRA05jv0uS29v/UZeySlvo
 vr+Q6sWkiTEWPecyzwEJNHGoV8EacwSdQkeqWXbB5CA4fow4IDtIFLceSP3F13gfnTXKJKk
 lfUQwnXtvr+EbbF9bdZuw70oagHKrRBFDPruXJ832nkZLv7eCFhCaeAUDq4M99AhyIUMw9O
 +bWzStNM0EXcHZYKpwXRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jEbwNVmrjDo=;ACcDIXlPFpbD4ILNQxtVYMERo9p
 he1jk0/i2cwdh5G76IXLCdrNu5+4XrUVbDm4gHixt+9fEYMz+SB7IH02VnE57ZX026Kwcb1yt
 loytzrpzLisFGTAM6DwIam5XX4RaB4u0arPkZt6nW0Y81N/tS7aVAXq3vIN4AhpSbFjFZpx/r
 FGtcslOynJ748jarJMlY45xHu0cg+f0LTayJ2tizJRM3bWsfWJOniXitHvTJ7hBK5f3LajhXP
 +1cwX5cTxyerZLZkkDs/ezDGMXhBfhpSojtNq5Xq5OPfgg7kJMsCdES1UPstjQj0kx6E5xqqy
 5NUvtgMsOhyAPtSUH7tzol/VNqX6qrIcAQfHYoK9BwuNL1+r/uoBM8ndFNvNxXULYVHDN4WQS
 /2w33iOYWhSvRo9JBYavT/2+XUkQQUTighjEFTlZOSVS0tAOX7YF3iANm3XhjlHxYrNzaA2qF
 9jZIiAyI07XXzc2mPgAXANBKmyUINDeVMiMbA+6JD5i9sXyfZaWtu9PgDSauTN4/efkT4IxK9
 G64aUNZRvuajdfdHAPdq9t3HibfRCueVfAEEKHbZNN+xHPhE/X1Yhaeq++WiHURmnZ6KJ1Ekt
 72TJNFHM7vDIQtNPVXhDrCw8AuECyJ/+YVYaF/reMP1vkK6foeX88TvxSgoX3+a7f1tMOtot5
 73ll0/ms/fMnaarMUIxpoUfM8oJ2VkwheTjQ7ZJ5AUXtK5u3grISic8SpJOX8n4tV7QxdNz9Q
 6b/R6BTP6vPO2aYJsdG733ebc8C5GxK/9hfFTbdNjxMePqWP1w8eduWL5TEe1v+vGX4XF0vfI
 6V62ofwOCGeOrXcvS606uJtw0kEh7f2OLLWrWZwb5L7yTxgKaCRvIwpyu+RQZKRrNDd9lDyOs
 JrgJf6bqy2JCGbZiSdotXDspjkK1F6h3XeFPAY5+0l99U9JFxX6Kmp+RJhWS4yk6LaPhs/QG1
 AiL4xO/I7f3O2AyBngzZwNK8NHu8CtBTz8n/BHnT5MJ+TdX9b/jvZDufBvBBTUeo38AGz/0dV
 Xx5r0AlmNj/NTCuYJmKzXwYNWRvC3hcjch3SiHNcECR2N61SxTnsh0z6ZDbkkZAMFoQmRBZ/g
 A5xzILCr0h4xJYgTUwWKBJaUlEE7vupyPsI4QzHtoE/uCPw8LCpV6ICkb4t4IMimAugCStbgm
 mssj942W+ftG8VbV4zKqNJb7WkVbS/qq/I8Eeb60PX9po7scpXYRTHjG0NTZP3Qcrxw+ca62l
 9EcEtk4NTkgESuh5E8FxsWTiAdx6qmiEeGS+kvy8Q4vjYfnKy2UtHEqaAnjL1ZFkWE800ZIO6
 6xJKFcFIdtWMaSNkjslAu/Q9Nm6WmgF8Pi4+7w5vUc2OZeFkiCx+YDIcSUvnmAS3E0S2NV4fp
 t0zrn+blrEjRg+ULDvU5mxHrUuQ2O4nNYAjfOtA5OIphNWnMVv7mHuaXGvGzmwXeUpduk6Suu
 OAREA40KLH8F8JAEpUipkVjU0iDSPmG/ubdRJJJAOj0+lym0k3s25gIt9qUV1YoimF7TLR6sw
 oobjFNN4vtMLrU7NVyAMkZbQVsqzqGrWrguFicpzi67kaUnW7x+dBOH2OclN/UJhCn5D9OS2f
 5gMt9RIpdqh8f/JygUcQ+GN4dYdkeq2oaJ4L1LQ/KnvQnZLI1Br5j6NpPcQ0xmvO+haGWhY3E
 cacsR0t8f91n2+i+GeHcEXw1MW2CILVKiCKAY6JRYsf9gGfNXi1YJQfw7kFReJpDVzikMtzXT
 5Q40YUhOqHGuCP10svb2X/IbtfnVPFC/khgmiU8KKWuJF0qOh6LDrTuzpVzvexo7MSnhmhRHY
 ihtWel1qTL9sxWdQ7AeBUaxF5XXgKnP44NtoP/AhkKrL5hNmtYtSAGDJZF4KiY0ifTQq1YEbQ
 JVQL+GXpsUagTSZSnUz3YyIgGII+T/fUqdTWgNoRsQ/YJ3MkSTy8K16UAEtCds607SZFaIMce
 OjkXrUex3z5VMKnWo3K8OsfS3TkSJgWUQA1Mz/NvdIR1ofRIwAuo2c1n3uHRFA5WzIPgXeoo5
 iPq9VGeo+hX7Qwne1gLSm3+w3ErR1yVI2MSPl6AbBQG9/a95I0yMpgI0cOPdGzV8zKIYAcfV4
 igBjfaPVLVZH0QOoPBh/MqYQ+cbt5qrQFXITcr6Aw+Fj3Sf60xVVEU5k2W70hy83roGwSn/oi
 qswYxJF+OwAladXKK7k7pbkvKfMtljzWxTkOA8bV1lWRBqVk4k8xU8B9Ueb50IMZL8naCPelz
 ar4ZWkLlzICZkzNFN3rzIz4aiGz+k1Y+U3pZFJyR9DfgloIiZYrVqDiCjfDECQS5JBG+JeZ62
 2N/CRjIzb9FM9aph7zyKeFyKoE/yqZMX6r51IsiWV+Pz2BRrLQMVrdzZBq2ZScEN5Sgoc8LpL
 4mG1JnQwJcC7f0F1lngMI+7IDNqgdXOFHB3QH1afI0zxhOoCT37XcIE37L6syJpOlwnMdUbQ8
 zGHCLvZeAfx3vc4wAnLOHhjGMKyml2fGwx96R6OlTsD2ygHzEmgELo3EpoJm1or7zfCnZmYHw
 wQ0WK0Yxmj/tip1XG66znVuW1+OkpU6SqjzhlrryEF0X9LxmXJrPhdqFFQ7RG6map4PDSLfs7
 7f57mqpzs5wYQH3cjVYkMemNkmEFEpVXWl0QXB+nANbGr8h6SiU0XDnWVmnHhCeHYXD/JZAhT
 x9NTwkYwkm3oRhGvc38ZeS6h87ekxZe4VohUEFgWzNY79PbCeoczKwKN9guPjA3KpDsm3lNM2
 dlycrN50Ln5YyoaKbi3jlEVI4Z7AVFUBugI8Z9Yosf5T7qoD/OPbAZkTGwC2ys6D5IB/O+qE/
 9vNWt4ep2z3rEXYwFvgyKvgso/qtELyr4+ZeflquGNmjLa3/gVWB9ElyeFhjK+dLygmReVMci
 G5IFIjhsl+PzzSbNbFWSWMqMiHBfb7heVvsfFavlPwhjTlG6z9Qa2f9wi6IpvcC8+1AlDG0Iq
 veIdhCMU+p+R9vSTfSnJjxqIITzNpn1TNCxShTEirN+6Za/ek2kLCB24Pn10+IRB6cS/588/8
 wdv+sBLTIzcgHSO5yCdyqSXOHx9mUj5rszFjtkcVabnJTZnz8XooFKiLSuD2zGFscCK3WK8/u
 t5mxeSR0bxk2CV3wkm2aZQF0L1ZQiB8fYXNG4+M0+8l7DlXUmB66JuUF7Kr8WjcFyU8DWSq3A
 jQy3EKEAT2oD6VG85jT2nIwSk0zOqASLQyUgKMO8o/pybNmCDJQYaK3i4829jr6sZXjentZY6
 N2qObKJkBOlr7mLL/iGUPVCDSbUyzUOGCZBSO/Uo4F6Nzv8znEBrDosCcpona3iimBfz68QFb
 IO1mM7TR8nwADhqElcxblsjAU9O/pHjfYSlxHbppg1yRXowcSVrVLOnvWHF5FrbjbsVeWj17J
 WpluCIiV1Ay8sDYMReu5IM4G6Pe2svY/U+gPVavgwFEaaaVsTBwnf+vx3QEjLuwsQeusWqe69
 mzcsb40qUWm4F6Xc8v1adv3JFwugZLF7ip++hgFUPVObFylSj4H6T332PQmKziuEt09crSO2q
 phKxN+udwSeCMGGbowBK6SQUJuJ6VwbbKIb9CfNIbQEIt0X8bAMf6CX6i5g0WDmgpqxzRU9eK
 FK0drN4YWOoRUKz5q5ac5QeOoyyOISEwsEIMJP5JZm5amE9EEV96fyY2LY6M/SBap7DALCnyn
 MJ4H7nP4pgia2pj6drNdeBu+rH7Ft3WNRAUydzoWUNUrY5/zAU7+VaKDBBzoNtT11LxF3IBnl
 wCAUE4X11yOMr+vrGGv98SrRhR/61e6wnJr99RX0mT2NWJdymn25O7V51mT/PaeFQNF6JSUes
 m1tzGrlmuAmn8NRmIGXN98UraREytmzfCmWsryyRrIBBvRb843XYtbxORqhKQb5dHVwljsRL2
 fOMIzSUvwXldOCQPV6e6oOxL8+eG0OqpDFbxHDGFO6Kgw6mC4emU5xVNw9rJmqgmP9++qPuun
 qg5aeJyvIPJsEnJZN0Tn8UMLDSIwMF0cNA2kfXvtUx/STXtJsPuOaJ0xpmslKOWTbQVSJGB3U
 mNxUnSZHifadnUFdg12n8GqxSYWm12B1+3DrDScF+Zgiodwd6SE+JvHjwwkE2wn9QSNzQIO5S
 efdagRaKqMSPGMoBxyz04kF9h0HQLNdoXWE98Awb03U/Pb7+UJu5Vkhgdt/+XAr0u/oB6vgPQ
 xfXGlamIzL2WfRsGfkWRixbax6T/p3ZIo2IB4sk/Qahg71lKyZkbScUmydl/R6dk0V7/+cZcT
 Ad3s/Eg7diQVCNeQ4LVqlunGaMQeSBFbM75n3GALM/zBxK853yHMxYw+wcv2dMPDE1l/ZjW7N
 D8Cnyt3zUtbDGnPW/h85qkYEKpR3fdsnY/PZS+E0NL58S/ALPMj8Bx6GDV0Y/cI5+Rilvw/4T
 jrMLJ+OB3q61zG+nIarU5FaNoSbgubaT32+7fn7e34LbdUNUwauAx1t6xjYkXZd02LzSYuQ27
 zTWuLarj6X48sqbYpYRYoT3sOXIgHBCNZzP12zQdImiIXXtJwgAaYZZUT0+PYusJ4k63/iAE2
 VJA5xmnl/z4FsJxQuuQ/oL7FZf/SJtgpXmYe1dL8TV+3O5LNw83M0uAeU73Fd2RpPhzh7TOux
 ov4egstBpt9q3cgYUu7l6e1rPKLJd7PWEMVdY+s3jpFDQv1T1Mqk18/2S8Kf3xw3b135zh2pS
 HLenJgy+JNf31JPy0zEW8sWXuajc0BAYXTUuDjuPheBggzi1xhe0D7IEScWXtCw5x/skIbKka
 Gb6l8nI/NPq3BAhffDlO4PNls4exiiA+ikrRFrSclzBIAGmzPyAKYbHMHNB+G2CbNgdukj1bq
 tNON/NzCINB6731IwlHEft2EHYWJQOjIqph2Ai/nZhFt5pv/1nA2BUqoExLw3KbSW88HIoXZL
 HKz+0vXuQlaE2+Byn8MNFz6VwRYBn/RjcJZ/GlBI7i4X9tfFGLumGnRejAG2JY9MpzWQ6piU7
 u4lNnr1m1VBtMVKFiWH0KG/9bOMrjZaaBaUm1S8/5TIVC9qoz3BLc6aLSLlfxoipDwsCSVDjl
 ZAk7s0W+r4t1AHxMZW4QGmOXglCJSvy4/YJYjM3vIf5WOP0UhL/zPTxJ18ln/dE32VWcx7fk4
 pSkVLFIs2lqCuPoq405TdC0ryTyhPyHkxnNMBOecz1ObWwP/EjKK9iJM3kXQaWSKqYap9YT9K
 oXI0UZD2JmShYQBxCP6l4sVVs8r1PNMKPJt7nijSMGjbaO7oDJ8vOGLanZ2T/Nn/TssnNraq/
 LK8AQGGbb9m8fjWYIw0pkKBJMsxHP3QHH4IRmqFBbSIBRrb/cAFMe60RHBdDZrZj16xAxcmR+
 h9p9PSAPlzKuYopFqkPdNfJzJEeESLotCv3crw1XyATzMJ4TO6QDtg0aabBMs3SxElopDMMgw
 6Jxu96SiBAbzkbFvvnCeJnA/7siaY16jzdyaUZj/tFe41SV1c6TbGDqdrCCJeYHbYb26snE+z
 OaAXpZJk309i073NFFrCHgzpkjBBIDAP2w/uqGFk5gR3JI7OJfere0riDlauh38ID+p/Py5lW
 GLpew3509lqM9pl55uWOD/idu8Z7rXbO3nD1a08BiPd2wjlO0Lpr1j8k+orzOO9dFA9DVd8Vh
 zjBzRNs36q3UT8FxXeIPrjo5DR6iF/r9KRzOZeISqSsuYs9zDlZ1n8NeIJC0OM9yLATP9/C55
 avaFBC9JlBvdeBYv7vYfK756usbK7r05eJaY7n1Bfs/66RDkV7T2mZm+iy6+OHtmfc3RHbneA
 p4S3+BerDRfBKLyG6SBOZeRuymarIO59ELcTuS4CadTAg/2EA+n2xNOA/4Dg1raf2jwx//osX
 uHA+ZBKw5CLauGLBn3DuKA6VfRkvc2R4Iq8VPpMkQNoyE1fkz9iwPiELasWm57oZqJw7rIJcI
 kQaECc1b4co560ftvCsunSTLWlpYM8yermfo4WNGvEfX6PkVi56FLSJUEDCn2K/XB8V0Hx/yD
 pbDVRwngitZKFMIML1jvOe2qk9MFY64zEj/GyEtx54BcaWl3zcaj9ob2VHF++c+Wge+cwXFk6
 J49bjpFZa2eC0FsRUWticgnvpQGA=

On 8/4/26 15:59, Helge Deller wrote:
> Hi Dmitry,
>=20
> On 8/3/26 06:39, Dmitry Torokhov wrote:
>> Instead of hardcoding PA-RISC specific keycode tables into atkbd via
>> compile-time inclusion, have the gscps2 PS/2 port driver attach a
>> linux,keymap software node device property to the serio device when
>> a keyboard port is registered. This allows atkbd to dynamically fetch
>> and apply the custom keymap when probing the port using generic
>> firmware property helpers, removing architecture-specific hacks from
>> generic keyboard driver code.
>>
>> Co-locate the keymap definitions with the serio port driver by moving
>> hpps2atkbd.h from drivers/input/keyboard/ to drivers/input/serio/.
>> To handle the five conflicting keys on RDI PrecisionBook laptops withou=
t
>> runtime model string checks or duplicate keymap tables in memory, add
>> CONFIG_SERIO_GSCPS2_RDI_KEYCODES to drivers/input/serio/Kconfig and
>> resolve the conflicting keycodes at compile time via preprocessor
>> macros.
>>
>> Assisted-by: Antigravity:gemini-3.5-flash
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>
>> v2:
>> - instead of using device_create_managed_software_node() that has issue
>> =C2=A0=C2=A0 if serio port is unregistered before it is fully registere=
d, switch to
>> =C2=A0=C2=A0 creating software node when initializing the driver and at=
tach it to
>> =C2=A0=C2=A0 the serio port
>> - added keycodes lost in movement (0x92 - silently ignored, 0xca -
>> =C2=A0=C2=A0 KEY_KPSLASH, 0xda - KEY_KPENTER).
>>
>> =C2=A0 drivers/input/keyboard/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 38 ---------
>> =C2=A0 drivers/input/keyboard/atkbd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 8 --
>> =C2=A0 drivers/input/keyboard/hpps2atkbd.h | 110 ----------------------=
=2D--
>> =C2=A0 drivers/input/serio/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 27 +++++++
>> =C2=A0 drivers/input/serio/gscps2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 47 ++++++++---
>> =C2=A0 drivers/input/serio/hpps2atkbd.h=C2=A0=C2=A0=C2=A0 | 120 +++++++=
+++++++++++++++++++++
>> =C2=A0 6 files changed, 184 insertions(+), 166 deletions(-)
>=20
> Thanks for cleaning it up.
> Your solution is much cleaner and gets the hacks away.
> I'll test and report back very soon.
>=20
>> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.=
c
>> index bf9b993f5733..cd1bca57fda3 100644
>> --- a/drivers/input/serio/gscps2.c
>> +++ b/drivers/input/serio/gscps2.c
>> @@ -22,20 +22,19 @@
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 was usable/enabled ?)
>> =C2=A0=C2=A0 */
>> -#include <linux/init.h>
>> -#include <linux/module.h>
>> -#include <linux/slab.h>
>> -#include <linux/serio.h>
>> +#include <linux/delay.h>
>> =C2=A0 #include <linux/input.h>
>> =C2=A0 #include <linux/interrupt.h>
>> -#include <linux/spinlock.h>
>> -#include <linux/delay.h>
>> +#include <linux/io.h>
>> =C2=A0 #include <linux/ioport.h>
>> +#include <linux/property.h>
>> +#include <linux/serio.h>
>> =C2=A0 #include <asm/irq.h>
>> -#include <asm/io.h>
>> =C2=A0 #include <asm/parisc-device.h>
>> +#include "hpps2atkbd.h"
>=20
> Doesn't it makes sense to move the contents of the new file
> "hpps2atkbd.h" directly in here instead of keeping in own header?
Other than that, you may add:

Acked-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge
