Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233863A7831;
	Mon,  9 Mar 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061939; cv=none; b=sXPiU2Td27s5ieX6Mw5znHqJzul4A11pmWiAEeOt30tlLA8m/NW+gM1AzqCYjA9bzZIyK+Zygs279Vn6w8jIuUCiInniqCQMueYqVftUEkzEZYpr398hGoEy6ETIXeUVTwFTqcOBvECFZmsLiR6Ta95vAhLTbMQrYYeu4cOzx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061939; c=relaxed/simple;
	bh=a+z6M0fzWNKl4oXUPogFhNAJQroVuHv5hGLdK+yRYZY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Vd0LwKv/XBnKssGvJDwI42FdXWeNbiKS37jEGIC16iwqhFN8UghKS2NnFPkZXMOtEfddW+FdtKCpMpc2sla2CH0aE0HdY9Q6jCg1uKfyHgu9xI7DzTk60vVFB4Ce+144hqwGiNVP72AZJgvFEEzhKwt4jsioSZGOY+qHqP35D2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=ppndSUwQ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="ppndSUwQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773061922; x=1773666722; i=hendrik-noack@gmx.de;
	bh=a+z6M0fzWNKl4oXUPogFhNAJQroVuHv5hGLdK+yRYZY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Message-ID:In-Reply-To:
	 References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ppndSUwQj7tdGb5kPxVZEaFzAOXZmfD/FQJRucrwsLpRm6TBj/PQIUsf7EJL04P6
	 Dlh0XWJSYpYdAhkjf/B7shFsdd89VcSZZlf+JIwbkPX+Ts596b13ZZofHDw+b3lN0
	 IcuE5ENTyCgU185UVgGnpSEIV1zEUliH25MEG94rJZ/RB2UIXa1ZEei0K88Vq9YrQ
	 GMyrUI6W6zHDmfJuOoW/+uL4IYUF/s1fAyt+BRLjsdqqRW2wUvyVApwY88idI9kF6
	 mg5XdTjpIEuBXbT/kvIIByUUnh6Xd+qcLoxiyg+groqdfmKEec2F2pmXwREqd+uMK
	 O4ZTZzjnShocB+udhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1wHxZV0ulT-00TVJr; Mon, 09
 Mar 2026 14:12:02 +0100
Date: Mon, 9 Mar 2026 14:12:00 +0100
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <f067754d-229c-4418-a367-6df5feb6cee0@gmx.de>
In-Reply-To: <fddf0e3b-707e-41b3-805b-2abeffed6c05@kernel.org>
References: <20260307181557.66927-1-hendrik-noack@gmx.de> <20260307181557.66927-2-hendrik-noack@gmx.de> <20260308-vivacious-coucal-of-current-2d7ac8@quoll> <feae85c4-bea1-40b2-87d5-952b26ff3ee3@gmx.de> <fddf0e3b-707e-41b3-805b-2abeffed6c05@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: Input: Add Wacom W9000-series
 penabled touchscreens
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <f067754d-229c-4418-a367-6df5feb6cee0@gmx.de>
X-Provags-ID: V03:K1:11BeuKk6usqPSqp6gKIOFHGOaqnunYbt1Wbji5NS9uLcZ8FEOxa
 cPxm7y6BEsKERPS0GDJeNFM+CpVcRd16db/st6AaOH1JfMB3qWpoam19ynEotO32yr9knmj
 GLNDPmqqxxxA3ctFQzOZH4F+bshdK/0L6FeFqYX324evUt7LKFiyEOTWOM6ihLIvOkEo7Zh
 qcXO9hD4QJXj164r6EYKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5PCCKj3GbFk=;5TmbVXukPu1rxf+YDiHXPva2CqO
 S/1RNNlsYxDId/UouQccNy99XCip2Faua/59JZti37RgXLUpdULkRFATvggQlOe2icl40L+SL
 CsCrcP69z2iPMPNNF3kwz/kPZZIWnxEgaZWGWdL5NQPM0JKJxbpD7nGuzryPTh1uOirDx20r8
 D65nXo5cpMJ755C8PiPFkoAMDSQCYp00YoRGi5IigR5xg94EW3kDJlC9xyOq+phlcNg7Uiu2H
 zoS5y79228YmShtyjbQQWLXHtZZL3GODOI/EhyVQKgFJYVJZc1y0Td3w2vVpmTp8h9EtHmt1P
 dZpT6f2lUgOCVFpKbI/Frq+evOclLBJl/LInuypzrucub1sHJwf4FQrkIYc18R6DP3Ei1YAP9
 C2YS8VbExP+36i5WVpAuHAOATeINf+e4GUISPcoMsa/eZUuWsVFu819UERWiIPaSpMmnVc91Z
 mncDBVOwz6eZJ/XAvGhsxopbYIeCPcGYa5zjw7BH+DuQdfxqGNs7DeKUiLhmfgif3X3DHePRM
 S6f0Jct3Yzw6lwqWhV17rjtnsm87D6V4B9TNcwc959MXLvhEGTKjERrChUOVtz8Bh2A5xUMdG
 7twjGhrQ1xiUXuWJiJXaWdmFISl8RKoLtRbAxb9oaJ6bdV2HXHjY62MkS0OlDtnWuI7c9yzEK
 ODPC0ZhGwI6dpSIX6xtmRymZ6KQB8KJZmmQkJZLI/lK83mOkXRH99ioY2Xfxg6M3spHmihXCV
 P8MOp0KcfCBdmZlOWCeknO/K1Zp0aw0jlsJYj/Yuk6LFSF4L7Naj8+dY1pQn8fxmnxEnuPfM2
 Th5v/I0SNFnBGeSxW8wDOJ5qOGBPD22Jv3xaBk6Y1Gg3oubQitF99YG8rJgSylI77mC6rc92+
 oawRpyeuctV5XM2wcsVlh1KKHQJR3lav0qGFLTE9CTSpaL3mlf4WJJE5QiNEGO9vx8jA/orDH
 i+Y095eZcfDmX1SMak0gB4RJ9o6/W/he5F0CwC8RbHalJXsO7DmGapzGxxgll+0txJTecq6X9
 auRDus65bMnUJeGAobxLT9lp1w7YsoYQVvzzcOn7jF0PbacD8OcClBmZjADR9yxRrS4B3cKd9
 cBPGsNcuR+jZIyMk8MBvBd5dp/gxjIIWGQefAJYjzPbENQsJp/L7e+ln6b5/m8L6pw9GrS9xj
 pZ7jHMCRXbhcrxrVMnEghS9ujL8X5RZYnVKapu8Gs3v6lE55DQzw647F3jvNr4unZ9HzGNu99
 iNyj87B4qE4XX5ULfVX0/mpI8VXczTDeifOkInLqNVNQuM00RVpl4P8ebHt7pt6BC2U1CVOo7
 /2VByqL8A/qdPP9+je/+Ow8VwFZ9FCDHILDcjpXrGHTindfVJwTqd18VMCwszfhb6gP9KcfoY
 NShtXwpZrlFQ1sgOih23E0K4LSaBiVfncgpBe/OLGsKZzqZO38+9ZygbAXgjCsJd9J8+kx9ri
 joNpJeAsfZlw3xr5xLm8gToTPcffO+2FYNTSJwH1Sj4GjUYxNUowsZeI98FhvLVsri9LDK6xP
 KrpLTFtuv7UkF+VB3nk8jQioYOJ0R3tLk6hO/0ewl22IuexNsYfMmrWhxFXoeyfNKS7pzOjdG
 vBB/Wq6U5DyFu4g1CfAgr+sEPuFT9+7gE0KrNYbutPWbKggVmc913ek4nclWqSK1UmZnCBtxU
 j43D8BgZIcPhTc9mgbLqOJRUQ7dT5KmEZAySY5DQMwnjUeBlWHIPCu6uqutts89S/XdFmRcJH
 SIg2O60U5BoyivCTHfIXbtEzAkCvGCZJM5DVbG8Qmwhl1Ul0B/1Vzkrp95AvOqz1fQH0sYqEX
 w+eSItOiRB1brujjmURoHXzqsTCXk7C79IjqnXWaMYO4sg+3X26dlDAmMWvs627Ki6jaD2+Oh
 KuhbOz0ff7eaDsfqkdXwtHuxc0D5lSCLAp1hnwJcAjgoLgzPVKXSu69F0IaYQpkxbE1YzWLMW
 E19mV26l3ubLjZxjVnGs8V71lOAOO+N//yO3xr/GDpK/6lemIhs4MV3T0lSHUeKUeJE0cYrec
 XCDOzeRGgrw6+8ww1GA5CCadflw8kyQI4bqLmilSBGEokJoYyeVlbbTl5anL+9u/RY+mfyI3U
 LdFznOqy1XZNIyhplGO6v8SY26RkmK8jy/8wXB4kWBtlCAPQ2FRNNDbJTTaofJuMliTjcvfv0
 SYCZjcmtgVamt5AyBLepgvQGkfP0sBxGnnQEuqz57sydvEhXg5bAJrMEe7WfcvmCPy7KszgNh
 RWeUQOGvzYZM2qsCLUw16ThninIN4pHMhjeLiNYULj4XvhltHcWHodl6hUu6YoC2RMok9+4uy
 XpxXY9Rdqkcwckctm161CJBNi9MzJ5+VR9WrZvSIpNO869253/+HKU/AKbC9gAWQoT3A+J4g4
 V+5NnPgll64rKvRqFg1B33WnsH27XZZhT748KV6T1EoItGPp2Erxn9r1WYPsRkMsoBrcDkOth
 K8xdDfozXwAx7Ej2bTxDw6pYkOefmZXf0WR8zVvnaNtH44l0g/3CFa3nlma6BYi/kTJ0/Vlrj
 HNuZ2I9Knfa7IoSDq2uloUTn0ceqTy4zbufWjL48MMk1YLMEQvsO5NReJ/w+OS/Uhp6Ptppr+
 GZLAzK4J2deg+HuQOrXe8zdrU4WwxpxZB0OI24CGChEYgX+ggKhKXvYpS4VgaUHc6/vZgS3eu
 6EdJZFCDc6k+KxMVqbyKhNUyb2+1I9nJEBuqh6FCBvQTj2YAXKeNLWZ8OKP7QDUGvSj+1J61e
 giT+CnNjIh+6aDpAd7tENppQLdVihSl9UlE0FMBtEEeovy7+PGhKOIaG1AVSotZRvnmCle+py
 2dY4NLVuji6xYWXx5r0Mu2L7zafkQVroK148Lc9jBHeKgsj+xG9xykvxd1Osv7ndzPDeb6SmN
 XyMoVyvLWy+O4MXKqtOYjlsGHnq5KPMXmknZzGBUACWO5FV84kr5kRv4b3h2kY5M8DUem8O1X
 5ifO5vhkJwPof/crWwlA41+CUAVwj8sz8UCHNhHQ7rfHtpayFsqMEdejDozRxn8sSAKBoWUdn
 sntkPQklYhXRe+U7gHhGXKppRX1IuaLhs2tjR92bVtrZX9J9e0Dyh/3R0VbXoUEHVpfaJgsTL
 kwZL+bhuyyAjXx7BJjj59nqdE5TJKFjoSW++uYKOyCJshGzJC6gE+FLUpJc4S8zPCDHYk77ei
 IP0W623vXpgI5JXqcWmr6yvjAEf2XsHG2k9LbDdRLHAU30EQF/+6bq0V9tYQS/uKOgo2Z+Lge
 Uhb6q9N8RQro7wJM6Tbdyy9HjJYJoOY8pbIzejHI/cFgdH/k8XiyCqUM1CsFSr0DPf9BPRWka
 ukCIWGIwREVh1JmiccKyT5AUCq20IWShGP8O+zWW17w5KWnoVAVArsKD/pbzFhdkO+e/NsUR9
 PU/khUOFSbz+mSNf6BV0xEN0WEkKpMsSsxpIINDVMvvaF0sLgn4QSh+s8Iyd/3z1bOIIDL+Xs
 AXZPi0PS/+2OxUCroXoPk2UrdLTQ5+dphqM9MjW42y/Xev8hauVFaREjMnmvQ+8xTm9gywkGN
 xddS/nuZ8dIoXF2kj0OuKi/z2BJljAL1DeV3OOHf+Cewo6qFFwciBIxHgYxLjKGrao/ijqm++
 ZhcTB9YifyVLNuvQe3OhwJ0VAwzzqS5tcQMm8gDOWnp2DWfimKeIEbHar6eEGyNVwRB+LNx6n
 xO8HDe6RJki8s7whI7vv0Gb8v+47tEP71Q2i+BW52pzWxbKhrzIDSoTzZ7sMROFIXAoVYe8fA
 NdGWQhbzshQ9ovVjWHon9zTi/8IiN5YthZBIUWh9ST1A92MWhET5XgjKY1YaEH2xka+V56Oiy
 t1Cpum0eQX4sXV/QxwKATGg19TjTQywmcV2qlEe7aCwI4E382VhtuNUBCN5icWNhgi31YCPvL
 lZtM56Yk16+N0K0fAtfsmwJez9wPizvHuaM+KfAFxU40bSmq1j/sAzjzbdbGWNqXr14oFORdU
 H4prZ6U/n9oaMFxBeFfTzzq89bK31d+W6tKULN9tT6agW5j/5GjrsrEGVv7aKBp4QUyRmQu9Y
 GeK1ncBRaK+md8Yve+e+CWeWDrb2VOkqC0MvRla6RSwLtIYD2AGXjHfONYOrcclKfOAa3W1Te
 Z5X4mDREdifi5w3tCw0L4AGTHMqsRV/E1wDnK6iz6I0arln8LAcRO1zPWpbyfAokxLMdHzM/w
 gTvpfxNm2puaf8Jc4FQYuovtp1mWkggSrvnRv5wkn0sm5yLm3yuKFhUCoHDImiyFzy9KbO6WP
 MkEGCUbwxpSwbqJYJIrCDdvBxX2l1qixAQ2HAqkgBpM4KQaMjIdkxUWMVfxAo8ARtuupmQi8b
 XDzarIzVWz7PRCP70aeX5X29aA2YLhmtvkhC1pkNJf4mN5A9BsKlA4DQPfS9EwHpw2fLj1EBR
 WXqEZwu+kL9vidkkevwk0fxnNcjIXVGujFO1MtR9VXcUsEfmdPcILUkY3sZBlaovI74CS8Ojj
 B/rQJUayt0jMuiNUol+Xjb7yBk14QJjEbX0ONB+VQk0LeHdhWX06FQvpWW+UZESS5ooEyhLQ1
 2oQIsEdoZ7bQCAHG2edthGsOaaUyQFjdzUTO78TCFUojdDNBdkw1BqdA2WhDN1EtHAtcysQ5A
 6V82uzvp2CngFeezlynmfZnVE3XlW1pRbXwOXwg4BWd8VonCk1DCelluSzkwggxzavwPZeZ30
 jF0IoMFDzeUgTeI9GpKP8xKfMq22syIM3NQ3K+rhZcoLv1gKY5x/wIFA+U1q61L6ZcH7GH40k
 q1EBrz42encTG5GrAq6oPhNhJlvL0eAQASQqYM5TGo6B4wNTpJso6ffoxFRErgNMy2f1KUzVr
 RrTGJD1qMM/wDkxYl6Ekfa1AZz2Ceo+6OkTu/2VM5O1I5IPbz9KH9/JmeF36BVjQbOAonwGl5
 2Eo55AdEcbF8AsUyVZlUz+xm2DC5djFElWCjgLFhiHFjO2AzNMIvorU4FBl8kk3p9JCA+iSAG
 j03JS+DHMvIbugP30cYb+kls7PNdJXBl3hmZDu8iSSGQsIbjJc9gh8IbmF3BgFBgx4MyNnABB
 HNPJaFslj1vXj/olvscpN8Z30S+vXuDzOaAJ8pFEZRYPoFK/HRFQ8iyTH8XFsYTJanWvBnOD+
 gAU6nhaF8+OaJSlxdkAk3L/VN/kWa0hEmN+R15rdZzGIau7ud5QFvoiSbYtWDrPb8CSZy3AUA
 bcRBokoiOFV1TWY+hDxu4hm00krRfpIkIn8vAZz/PoOxpmi1D6EsyWa80+lGGe0REWsMDu2mV
 lwNYb7Va4sNhQb1107mpWquosTDToXsJf/HAj0naZw==

Hello Krzysztof,

09.03.2026 13:56:41 Krzysztof Kozlowski <krzk@kernel.org>:

> On 09/03/2026 13:54, Hendrik Noack wrote:
>> Hello Krzysztof,
>>
>> 08.03.2026 10:15:35 Krzysztof Kozlowski <krzk@kernel.org>:
>>
>>> You received review and instruction what to do. Did you read it?
>>
>> I read the review of Dmitry and incorporated it into this version.
>
> So you ignored my email completely or it did not reach you (it is on
> lore.kernel.org though)?

I don't know what email you mean. You gave reviews on my first verison, which I already incorporated in v2 and then gave a review-by on v2, which I also added on v3, but now dropped, because I added a property to the DT binding.

Best regards,
Hendrik
