Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4739792E;
	Wed, 29 Jul 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339824; cv=none; b=YkRNl468X8wjxR5N5vhe9lMd+bf4eGQlAZCwllHgKFkEiwip/zJyXiJgUfwf+f1J5MPM16fI0sFqeO3WofDaycWKYTjQ1R4yfz8KODRgvRNgRA62GSgr12DcvJwovEocxU+NaP9JKYNQeS+HKzBIQnNJg8rPQoX/L3u9HpBqp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339824; c=relaxed/simple;
	bh=2A7Ua+gGboyx9Qu3yZUlx+cQ5spqoldtu1knNnc9JE8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=XsaOOWqUmevV7JK/TNes7jOgCxxu5ZTgimzx8RkNWp2SNToWoMQKdzu2Aop4Jp/rjFx1x2T51976mEZND9e0R2l86pOOKuN4G4gP9smoa0lOoDL/NFXEzouU63Tg8ztcjSpfBLlUHId4PY+ZMsu8N0VeuWRm/QsfRmjo7qmezNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OXN1/If7; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OXN1/If7"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 068578616C;
	Wed, 29 Jul 2026 17:43:40 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xLk8gZc0mQH4; Wed, 29 Jul 2026 17:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785339819; bh=2A7Ua+gGboyx9Qu3yZUlx+cQ5spqoldtu1knNnc9JE8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=OXN1/If7d5tooCBw/+/V1NtXl87ApdLG3jJbzBj6rNm3+Gq7Y0gRW0ofxXcM9bMLH
	 eoAJaw3Eow8cecVoB32hOUHGBqRgY75c8I1nssgg+iFEmJY0qzesY1VAGRN/2nN9OO
	 BBs0Jl6MYPyVH/OL1b7byvp51FdMxTD2m3RCSTRDXY/nkjC9y6Gxzumlo4FyIucevI
	 n94SRroFoA2HZhrBUiR9w4A4PcMr6oXhXiC1PSTmjBKPUpa7SU44KE5sOyaTzTegpO
	 cndn471sxcIw1kfdMxsYG3WYpbp8RnL+Dle9bxNeN3EVSdesxWxSWyJmq2mV3UDG7d
	 lDFOZ44ktr+MA==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 21:13:25 +0530
Message-Id: <DKB6545IAUEM.31XPRNO2FNBPM@disroot.org>
Subject: Re: [PATCH 2/5] Input: zinitix - do not ignore non-moving fingers
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Michael Srba"
 <Michael.Srba@seznam.cz>, "Linus Walleij" <linusw@kernel.org>, "Peter
 Griffin" <peter.griffin@linaro.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, <linux-input@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
 <20260724-zinitix-modes-v1-2-f6df7d86a878@disroot.org>
 <amO1AWyjGltjO0lZ@google.com>
In-Reply-To: <amO1AWyjGltjO0lZ@google.com>

On 2026-07-24 12:24 -07:00, Dmitry Torokhov wrote:
> Hi Kaustabh,
>
> On Fri, Jul 24, 2026 at 12:54:04AM +0530, Kaustabh Chakraborty wrote:
>> With the ZT7548 touchscreen present in the Galaxy J6, multitouch does no=
t
>> work reliably. This is due to the fact that the driver reports fingers
>> only when their state is changed, so it's either placed against the
>> scren, moved, or drawn away from the screen.
>>=20
>> The function which is responsible for this is zinitix_report_finger().
>> This function is called from the IRQ handler, under the following
>> condition:
>>=20
>> 		if (p->sub_status & SUB_BIT_EXIST)
>> 			zinitix_report_finger(bt541, i, p);
>>=20
>> This implies and ensures that every valid finger must have the
>> SUB_BIT_EXIST flag.
>>=20
>> However, at the beginning of the function, it refuses to recognize any
>> finger if it has none of SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE. This
>> excludes fingers in reports which do not move from the position since
>> the previous interrupt. Add SUB_BIT_EXIST to the list of valid bits.
>
> This makes the check basically a no-op as SUB_BIT_EXIST would always be
> set when we reach this function. It may very well be that we want to
> delete this check altogether, or maybe we need to add SUB_BIT_UPDATE and
> SUB_BIT_WAIT. I am curious what status bits you see when this condition
> (original) triggers for you...

I see 0x03 [EXIST | DOWN] when the finger touches the screen, and 0x05
[EXIST | MOVE] when it moves. When it stays in the same place (this is
triggered in multitouch where one finger moves generating an event but
the other is stagnant) it reports 0x01 [EXIST]. When it's lifted up it
reports 0x08 [UP].

It looks like report_finger() is meant to be called when the finger is
up but it isn't because EXIST is not set during the UP event. So I guess
the solution is to remove the guard in the IRQ func and call
report_finger() unconditionally.

>>=20
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>  drivers/input/touchscreen/zinitix.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchsc=
reen/zinitix.c
>> index 3421b8ffb19b..fdcb80f52c91 100644
>> --- a/drivers/input/touchscreen/zinitix.c
>> +++ b/drivers/input/touchscreen/zinitix.c
>> @@ -406,7 +406,7 @@ static void zinitix_report_finger(struct bt541_ts_da=
ta *bt541, int slot,
>>  	u16 x, y;
>> =20
>>  	if (unlikely(!(p->sub_status &
>> -		       (SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE)))) {
>> +		       (SUB_BIT_EXIST | SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE)))) =
{
>>  		dev_dbg(&bt541->client->dev, "unknown finger event %#02x\n",
>>  			p->sub_status);
>>  		return;
>>=20
>
> Thanks.

