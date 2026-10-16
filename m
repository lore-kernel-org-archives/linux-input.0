Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F368C37DABD;
	Fri, 16 Oct 2026 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131058; cv=none; b=RmHpw9TtiROw6GOtBkDhTVb575gE8zq+Bkk872JO2kq6qo4oKTIpQddmlKOWD2stQSVRQtZmHXRtcnPHi+5WizydkjxH21wBCNyhSMONNTpfspIjs5WkVfTC+ERcba/rrKhjb//cwd9FT41HBC7hg4jTMbG4JgL3B+QrNBNezJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131058; c=relaxed/simple;
	bh=rdeO5Ll/ICkWwY5Tv0ri0tb9PYJiDw+8TCPr68tBpbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXIX8aJJX+PHkfnMisfJDbuyGH0GttyGjLpb5dyO0bIIJd0/mBY0+0LeCFrtL6u9TdH5GXQZKeI0Wl7I0vxkakjbbeTShL69SFyeT3T2eE9I3fVWhd6e9mG+9aMH97f/Io6IBGOGU64Ddv3NbME8L2NEIexxgvdZltR+Js4SI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Nb6be3ta; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Nb6be3ta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792131048; x=1792735848; i=markus.elfring@web.de;
	bh=UNIRLDsvI+ObA6ME8hD6SPKgb/RMvt0b4MGNPdty76w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Nb6be3ta952J4pBP/KUPx3lETihH0N1YTab6XOjNOXSRa6Toh1vohgkOf306es+7
	 O1yttxf1xgBamdjMePdfn/ADg5t6TSb774phfy7H1o+LjKT5E6Y+V/UNwdg0BfceI
	 yAk5rOtlXTAUJygWgZTa19fKniZiMWU0RzAijm95TtFKFqYuDiSd1njeGCRM8Puhn
	 yiu4eSbdF9oND2CUBFVnUlo58gc7TrPWhRBcVQ7/TLBQkDRkCWF4AiTT5j1aIV2f6
	 IMNO4N2RF04QCtUkg38+NrGRbWsk2oTcHdmlyObxz1wQ3AondD07l4FRdGDZa3V9X
	 8hqGxHBrYudMSfov5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mo6Jz-1wp4cd0HlL-00akPn; Fri, 16
 Oct 2026 08:10:48 +0200
Message-ID: <9ac1d196-0e4c-4592-812f-c44c56e135b3@web.de>
Date: Fri, 16 Oct 2026 08:10:34 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v11 6/7] power: supply: Add driver for ASUS Transformer battery
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev
Cc: Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Florian Krischer <florian.krischer@fkr.dev>, Ion Agorria <ion@agorria.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20261013173504.451391-7-clamor95@gmail.com>
 <f26b6bba-2c2e-46b3-9350-0ba0785cf3ba@web.de>
 <CAPVz0n2ubBgOGO5q4ZBYkw-eDSuNh-MpdBk7uoWW69m2QduSgQ@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAPVz0n2ubBgOGO5q4ZBYkw-eDSuNh-MpdBk7uoWW69m2QduSgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Og/xnhOV5H1WgxWddSU6Ipna+J3+eEuOFf/5B25M9oEv9ib2UPT
 3tISJCjUzXPFFKyBedR3k2STFV6SSKKhieDoKSt4bYTXFEBRgUk0KdxvLNm7F+Ru7ZFYakM
 k7WR8gz3ueSHBQZd81T54PEJlsaht0clnhNFBUOnjtNuoeh778WI3NYAmd4bbsz+BzmZVUF
 bq14I/cWQ1HQnAm/tw1EQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s1Sp4uy5lng=;0Kc+ByO0abU7ADoGWvgTKzNx8mY
 yiG7J5PyZqBxkVt5g82Uxhi+5NEKcHQh0f1TFnkAKpV1JGZ4+szZBLZPnc9xqqMEw9PUwyFHL
 MnqVbTAQ4eWwEwZPLgbXt/AyYY7bEjI5wAU1DvuSPeOYEsPPt+ZJmzEIAP9f82/XsczFK7rLY
 U8VXdCG3rGOipRrvUzvqQJW9ULunycuekv8COgug0jiLJhJcOwgTfsEX7Gq822SWBkQBVy4zl
 dUsuJWuHZi34Hvd+5BrC0WYSlXDTx1QHzACJ95OGvlwZ2nsKzK/XHYG4aGqNwMIt2jKzGWoNR
 1cs1W0SjnCUlnbDhNXPh1EGEYPYxueeA6KW16cvCF9ICeHWkEKGRCUBE4ugkTr03vAO/oulxA
 EfkFOf0srM2GnkRySkiA3UXgnmxVAf3or4ySiWyt2d+5YG2cXGUQzxjm3srYhwiD9VV/YR/2I
 AkATg+/Q37I6g6luVU7cvof0Kc0cxj7YmbMMuuG79B+G6x6stTEvRvgtGjUPna6gXCcjtu2RR
 /JZzNchlPTYtjHi52tUPQWEiiM0puPRvLfGHxM41VhjJBuSX7sOpNLfaGdUmLpB3NyoiCOYwX
 LQkCft9j94CluD6zEqGAGUW9BCdqxVnNH+EyxUVowVmNuLfGpj8YW5VDJeEuRPKoxeVbLjcx/
 x33roETKiOkuwtjcLlmWrf1iAJPygbA8t8R2GVXXh8vv7YX2IZRNWW/U09s9OfMNfSQ3VKfPY
 83tReiAEGxMKC10TVuuUaFQhZPjk/EpIVW9q3jJeNv9PBf/sIepHkDM7U9G9qBrGcOOkYxobW
 OgIyRoZsuGwQqe7kekBDlizokxQXY4LSoSRvQZLp7zKQDgcuTFgOL/eW/M8yuHqDPizNWNTwP
 22obw9vxoSmK1SBUWe4wYmsLECPAc9ANehE1j0sDCh+5vQ/mua4HaXrZ3qEj8JAfCO6JfM1RA
 nVmnGyBknpKDKE/UyPs2v20CkXtQl505YbDXbxFJSLyVhqh2ufVkBKAu2lc9CBms5iDaxf49+
 90XxjKISdoDXAufzneo3SNjGLnzzL1gb5WUYYTRkaexAqjGKpjnWRUvVdrrBnVp65VnskdACh
 py0Jz2Nt/NpPt9+eb3zfnZSVLJCFKgbQkuP7vCQaeqyn/NCcugeb8UnIT9l4D5Y83HEkLQQlp
 n6QTjunUf60JJ2mzI5Zk8l/NG17vVUgkS9vBibui7oiqMH+C9CIYhG3R4PwGKOlimyBEvejOj
 LALiJO9tE2g0fFDQ9ISTV1smSw8r/nrlKO0Y6i6Y5D/73JSPVX6Mi4PlGRSDCBujp9pRfGddC
 02ZBHUVNBiTJaTUkBM6TqmLMbjFpWEYfu5clQzvAIYeGxGnBe/MOGOX3navx6Hp+koPviDdRX
 DoERS5YzboAu3Rqh5mRagwFDjFEkEcZae2gN54YGe43yIN3VZRJJre5K2VjeZkyzh8NM6j2Yx
 Oi0KyZiQbfs7KIRrAVcCTM37mHlV5S4SWBvDA/OQ6AJv92f77AoLDwofmhz9Zka3KdS58TXpd
 OMF4kbqNZjEWqfAQV3LIW2vsZ1T0X72Au8Yx5n7nnqTVvGiptzO35lqo6WmICO4xy1sLjSi+2
 ckrx0dHjyAY8jZ/O1DJOtxuiwOEOiulZ380PCYh5/az2vpKwMUHTskgh6JC5grdSbC6QgqVfx
 sosruBr8fYG7XYwLb8D8eluW67JXtio3/XyQSu8EBY2uB2brRVBg0ggExZJSvf8btJc7uGuxX
 Wq1wEo8u99ZNCeqzspry5pYSmm3IpFunlRLa8VgKZgy3C7so/Oayj94CDiLSPyoyI83LFn6q9
 c8ggvnDEcHf2xrATysWLUePiNgoZbz0JUzJjFsNJjL96MFcDj5QUwfWO/dZCHY9KY/niHRvbH
 TXcUa1i44XkErYUZ4ILb6iWAKsZ8AwFkklJbaCVYRKA4o99xEFu9iUW2QLp728mrdup1LQzFK
 +IwBsREaEx8pUJ8qsHbth26tokwXjqqYYcQcuvzEPYZzLIHj+495myFX6CAhb2KXwA/0DzBsZ
 cXETK1XO9J/v7vGTmuOzGyKlgQW47Z9k36OTe0UpHUtIrgeI0evaDSPRn2gUD6Gum1JSg2nLZ
 41a6TM9tNjUXFM/IfqvGZISqfVoDcDoUUJe/hJPTayA8gouqie8aiSBfB8lOkdwFBoLWdV6rA
 Rd+QjNHkEPDrt+y5U6Maj50Zt90LiOtrkm2qvxOuLNcn9hENXmMuXBCNosKDTifC6WREa62YG
 4pzK5u+t92QLlUPbz/8zKHhReEi7qsYGfhx+Sjm5gUKWuLhqiuYm4CS9LCDICPPTpqHqAWARt
 EEZ6GfE30O4DK5yzZVbFaBdUZIiCzL1r5oIEWbG/6xX+Zlmg8EW3YZcaS9QiKJMbPegC5QMjK
 +rtbgdB2396v0PS7obPLPyQFg02+XUoYLgoWL9MegcJcHUglZKNdajMzqTXkPpGy0RAgUbzId
 /3qAoRBFU1+JKZKiA9kQQkacz7VfBLSe30dsBNfX9IVpxywsrosIcq7dJI8s4NqWbEf/xn3rO
 QEGX+ADG84/oNdvkbNCq7I6rUY6oWfeyASc2SYq4IPJLD0VE2Cx7gtlbLxjsA7Dze51TPCXz6
 1/lyZzI3h2cQ2MTIuLJKxpHfXLCn4IDhL9prxwQVaJ71tOIIDt7ZGLNzpZ1DWsm6AGo2FFhD/
 cO3yBKADc4/0x6kurZIo1884OnR/NzVjyi3qZzBqC0ciqZcYrZ93f45BSTMRWs0/ZxfUp9fS0
 YY9oBW/zCLkxxhnnTsZqw/1VXpzV8q1wvOtacYfvDCxy6nPhKgoSf95D0t3urpdf15sdDhZwW
 G1cBvj++rY8TvMH6/D00Ea3MTkakO0Ly2zOhbgjXxuipfsWJxoRroqY9Ud1c1XtJH8ASzqZbL
 T8yeDo4amDau0BiStk2N+KKYEb5ipO7EZkKQLNb2O+Lxaglc17xeW2UhupMU44an4OYzK+YLw
 XfcXyGHbRSB8Nxf4bNIiQHnIEIaGFuXnoNiQExNIEveR6eDKVjEBTTpCOzRnKzcCdTuMcqonC
 inNpR8o7YeE6fp6NaJtCbLp5KeNn1MAxCfLnu7gZsgTAcvVn64HrdNp6a781Q5ma7td0HcDGe
 z+bo+kc8bEAj1s3GV6Wz9rAOkHzTeeS5nit2arPT3Ixxlol5o0mHmjjYzLoBGxTf2HEegj+Lj
 2HO6yYPElQ9abbqb3k6ilZNvYTA+zVjDfjdaVCVb/saeJN1IKkZJ0ybYmzdQQC2fnKBeCRbFg
 PDrk60Im6Iem4E849K3avNkKDJRdiEKQUgX5IwCBe3qmjjnMfLYdQbSvW7KT0dFCkeeHX0wo+
 Ia9/vAhBk2nin78oy+PnHC+YXh5qP15uAp5A2Ar5lHdy9JHF59RBR8jDbc6He2jzdEb94h24v
 BIPMhlTmy9f+BwHOZcLABmwRPD06OrRndBlfPQwYdK5yiEurqc8oghXP+kMBtcqreP++2yRnr
 x582sXAkum5GFAssD/r9j8FcLKDypK6dDoEE3FIY9KWnwqltTQFiZ++fid8iJq4syy60XaV6B
 HS9ETy0tVIGfkscvjNXZI2OG95UEF385IAaMw7R2X/A20ndv5oiMVFWP7OHX761sXZsqTvjko
 K4RFbhsp8/XK7+tea4d2uBq1OGdKSxrTIvslMKG512nSc4aGW6vY+S0IxrAPzXpvgZjviNgUd
 Xj6iqTIVJSpeAK9COBJUeXoXnw2VPvreXxxZbLOu8WbKOSikxQl6NW6/RK3HZ2eUlvbbSfOFk
 A0oPw7Cvmlu7nJ1TCmaIKOk5lpSIGQubxMCUOcEhMbrMlWKgss6aDUPVVypTV9LrFNSoYcpqr
 5OtsCHldyvK7uWg7YUMN2vn6V57TbIwiuVt2Vi5CMcQNoD796qpTtA/HUSVlh30ZI+3W5O0ME
 L1vnL5CYpzzEQiwrQbAk0V5VG32/el7sJ0y6kcIVyED2OxhBW3PxPxRBiwi8Gs9QrpwOv2/Kb
 SxBUc3VBklQLj92KIO94GGW1qj4Gm15Hb+coDxuLeA8TB1xXddjghBhuYOveIWZ9C4fdJ8OxR
 dYMuRqtWEHqbq+kwDzPwq7REn2tNSQ08toWZsdnPFeG+Rk+yzFlpqDD+jaj92ZYU72r3PtYqu
 NsBB2bHZc4fw3LkufOzXpy/vsM/Ml3h10xdTRx3EFd3MYQvA8FV0zt5ctGJoU5OKJ8UKnP/Ga
 aL94p8cN0EAAYU5+LG++crdMn3b7GSMX101necYAMlhjsX3iR2U2lUYqEf5QXS11pPUg63PZX
 BV9Hvlz3SQP5C93DO9uueoPv3RSur8Lxh0Ph3I1NXW5Qh6tE/3T7xf9bKflCZm/967t0RscjS
 DDh3KrDgxBykGbezoo2kbu8jd2XgmYyw33Hl4AZXjB6Q7Fh634dauWfu6KEH6EmqILaf0nSNR
 BOEDW9Q66m61aQgljRd7mTjuOYljY5XM1LGQEZwZvmF5TEAxzo4G37h6d/CAqbWX6NTLtote4
 Ey8zCaYS+hSwQsQD8W7k9StvJjkbNBunwv32HG+m1iXp6ALeou+P75xVi8+6OcHKG4lZ5XzRJ
 hAS8UJXE6H4DwGEKBi82riLxu82POp9UcS1Hf1G0FZCVG1T0q0+0mCZHjt6x3uIG1r0shXx/N
 N4i0oNN6lhP1gvWCdNEcUjwBZBzvGeC9x94RAu0hR/gwLt8xxe0GsmcjOHRpLiw/1JHuTnAYH
 h39ycAUmQ7a2jaZj7e9dI21NJsIfLjIa2v4mWe7RrG8ZO9IhUtq1M6myR2E9XBIWP8WOEk9Ks
 PliiEu/mV1rsNYMs9t0mYUwzpP1qYL1aKFYeBodytYnCYwjCu9F8WLAXYH2p1eFqXEzMasMw0
 2q0ySgK2E7wAC/j9qLMxVzMhJli/P8Zi7kiHIjx+xZSKTBbYh7eBeMXsLazKqyY5CR7x6CUAk
 07wboyVKWc6i5Cx6FUtSUTyg/m8st+u8He8vrROA1FG6h0Urn6LqjleSX5lGh4hAOFPpZd9UI
 EbjrKSa79STY1VsAKcjTytVmbSdnZYvcCXUes1TUjDMmxYrw5vT4mnNSLP1dE514qvxg8F+bq
 nQmUvWpbqjZKwSNnRCxcycWoBLxtV3Pgy/z7yASikkO6Bwhhs8O6XbxlTCqCqXvpYcjLzvsbV
 neqdPYSeRdn30+9nVjvTaly+329DD651zxYBwePC4z//pIBzrEskZDTdXiFEIMPJWi5diXy6k
 7+5j2KEprcq/MrCzdicgFcelserAFrEvajWB+wjqIVV2jYrtaoXKz3Pwz9hmdJwhtEjcp/FDY
 kaJ4J4PRFYh/G+yODrtS0RAEtCxrhk+rI+0NfpiF2/FZe5wvjDBHisxg8CPcnkWPTBH73U2+b
 115t1n3Fyck+SgEIPhTbKHTMbHEWZEralKJJ32oF4/H4XRJxQprMR8HfbJRiJWAJbLId2CD3b
 RIAaLRMGLtKgsgp4d8h7QRa3eLtgQv1KyARuMO4eIPIEm9Dk4GQ8kGYmJ/tfEur0RX/3RDKEi
 DMi7J6UIoye87EnW46AhOPtZQdwSjmtNYq/HqaaZ2tMRZO9eUZuPf+jioyYax/zUn+UylliiR
 gQWUGbiqT92tZ0ce8CVWjYiPqsPKM0cUdeI+tPs0AZJLFlc+3xw4l+MoBUoov8uPth9OBljji
 SEsXAmfiZXtSWlNe130pgrTd86/4dFGPskDk4MUOnwOQr1EG1qm81uAz4b/VvikKRAg8jR6PJ
 F5vbhEEys+iB97BiDUDf6tU3mo7n7ux7JjjfmSy+DX46J/pmOquq+1/Nu2LRztxne2QuK20gh
 S0MqvI0Yz4ZPR2AOdLAWXgjJ29zdAiMSZGAercvNWS1WqK/aMd/ElvU1ycpPoph1XZmOQ0whx
 9YTkcJp1+KR2qi3/oe4lrQd48AoJ9Z/UhFXB7wqDCz3jQTQH3/VD+6v+YaFONI4Hpo13TMjkh
 9uQZcFXm3NvZUC4At8CJALkMbev0GBulW35Pe5J4LFsvoreTFxSNBr5SYGIxbr6SK7/PeuPBV
 UDYZ4xDOjxzKTguGncpNH7hgngFaq2ThfoFDL5O6AmTraW1YTi1kEP+Xs8v0Gf9zEiRgUQhaW
 wRcCSzt+DvAm6t845yhJh0szeO2XWRQkMMJISqwRUs0pVISBAN2a8x1wuaYBNsUDGBmXmoREd
 8lWePoZBg7yFtn4hTAdQo8s8qm01fypDQKzcHtpRzdE8m25dkIkSCUL9cPdmH0iQ6Ocl0wf7F
 EwGlksvzpVGrFfIPqofDOb64OwDai7BM19PhWF3HVka5s7BjwwrP7AWdHqCbE7MiF0GqdgT6F
 MiSkRFu2vTxLFXFGuqc9BKcdRgiCRYOT1ZBnBq/CJo+SAyl+OSnFHpg3o+c0jIOTcdHTxulaE
 PwBvfNlI7Qu3RK5h1wQo1oLaUtkcIJtSdzJvchMu6Qj8OmtV+KWGFDl0biVfLSIEpeJj4NBLD
 P28AXCEn0/Z4+VZgDmWOQdHG7sFszIzxKNf6WF0Jlmy4GdAZZa3ZraIWejFhLVn+h7NH

>> =E2=80=A6
>>> +++ b/drivers/power/supply/asus-transformer-ec-battery.c
>>> @@ -0,0 +1,289 @@
>> =E2=80=A6
>>> +static const unsigned int asus_ec_battery_prop_offs[] =3D {
>>> +     [POWER_SUPPLY_PROP_STATUS] =3D 1,
>> =E2=80=A6
>>> +};
>>> +
>>> +static int asus_ec_battery_get_value(struct asus_ec_battery_data *pri=
v,
>>> +                                  enum power_supply_property psp)
>>> +{
>>> +     int ret, offs;
>> =E2=80=A6
>>
>> The referenced array provides unsigned integers.
>> Would you like to specify a more appropriate data type for the correspo=
nding variable?
>=20
> This is a nitpick, it does not affect anything.
Will consistent data type specifications be preferred in subsequent softwa=
re revisions?

Regards,
Markus
