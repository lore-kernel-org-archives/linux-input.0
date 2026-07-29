Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F54C9564;
	Wed, 29 Jul 2026 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340942; cv=none; b=LkavbmV5LVEmSxHAuOr0d58JjLZIsf4xxANpLJN5MzaIhsxA8q5J9H9cez04FgH5zhXNoFmWZYingPueZDiPObkvchWqMIji1U1coWW1X753v4CNFL3vpyynyyXXR7weBn3STGYX0jw2t2nr6bT7BSjoqwJU0WpZpGvyzJeK/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340942; c=relaxed/simple;
	bh=mW4q1NUpWiZCtA2BHmN6n4ewmtio2UFy6U3OYjBYq3k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Q/+9DEwnCD7ChNK9nUhMb0fxhobls0VIutJNtrEWp4gTpenh89bTSchwGof7oPJFk2GHnmUNyP8zMoc+uLrufXg6qsiGw6Y7Fg+oMxpR8feWQImyogbbi0qYHnQG9y1CSCzkrfBg0hTYIc2imMAjWfvk5ZpifPSORtMUgfuWpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fbemAMEp; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fbemAMEp"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1952284AAE;
	Wed, 29 Jul 2026 18:02:18 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9sVqEWKgVOWu; Wed, 29 Jul 2026 18:02:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785340937; bh=mW4q1NUpWiZCtA2BHmN6n4ewmtio2UFy6U3OYjBYq3k=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=fbemAMEpCEuzSp6l7MlvZxIvXqjI0OpY12HyLxWBxvbxW7sTkP9txcddyPZ3oRWbk
	 4Dc79ENZpDmLQOqsiuLXfvURzWO/9JJQC2NsI0TcvuyxAPsI/WbInNOrprIJBYanP4
	 zrh4FpHt3gt9fafCQUkGbc8gGWc4lkhAWNBKecaXIHe/kaYqgdK79b03y5XXbJynmQ
	 HgE833B9eQ47qYVBlCBCK11la17aSos8P2+ugFZ0SdqEqMc5qPY8h+SQ01jBfq2gmG
	 RvbnS7UJC/epu638bmrZWPDGxJofRmksfcUXaqwncNbZzfsK27S3UnNDOFLYbPLHXE
	 COBMfsGCFsscA==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 21:32:00 +0530
Message-Id: <DKB6JC2T38OQ.11ELUOPIMUJ15@disroot.org>
Subject: Re: [PATCH 2/5] Input: zinitix - do not ignore non-moving fingers
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Michael Srba"
 <Michael.Srba@seznam.cz>, "Linus Walleij" <linusw@kernel.org>, "Peter
 Griffin" <peter.griffin@linaro.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, <linux-input@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
 <20260724-zinitix-modes-v1-2-f6df7d86a878@disroot.org>
 <amO1AWyjGltjO0lZ@google.com> <DKB6545IAUEM.31XPRNO2FNBPM@disroot.org>
In-Reply-To: <DKB6545IAUEM.31XPRNO2FNBPM@disroot.org>

On 2026-07-29 21:13 +05:30, Kaustabh Chakraborty wrote:
> On 2026-07-24 12:24 -07:00, Dmitry Torokhov wrote:
>> Hi Kaustabh,
>>
>> On Fri, Jul 24, 2026 at 12:54:04AM +0530, Kaustabh Chakraborty wrote:
>>> With the ZT7548 touchscreen present in the Galaxy J6, multitouch does n=
ot
>>> work reliably. This is due to the fact that the driver reports fingers
>>> only when their state is changed, so it's either placed against the
>>> scren, moved, or drawn away from the screen.
>>>=20
>>> The function which is responsible for this is zinitix_report_finger().
>>> This function is called from the IRQ handler, under the following
>>> condition:
>>>=20
>>> 		if (p->sub_status & SUB_BIT_EXIST)
>>> 			zinitix_report_finger(bt541, i, p);
>>>=20
>>> This implies and ensures that every valid finger must have the
>>> SUB_BIT_EXIST flag.
>>>=20
>>> However, at the beginning of the function, it refuses to recognize any
>>> finger if it has none of SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE. This
>>> excludes fingers in reports which do not move from the position since
>>> the previous interrupt. Add SUB_BIT_EXIST to the list of valid bits.
>>
>> This makes the check basically a no-op as SUB_BIT_EXIST would always be
>> set when we reach this function. It may very well be that we want to
>> delete this check altogether, or maybe we need to add SUB_BIT_UPDATE and
>> SUB_BIT_WAIT. I am curious what status bits you see when this condition
>> (original) triggers for you...
>
> I see 0x03 [EXIST | DOWN] when the finger touches the screen, and 0x05
> [EXIST | MOVE] when it moves. When it stays in the same place (this is
> triggered in multitouch where one finger moves generating an event but
> the other is stagnant) it reports 0x01 [EXIST]. When it's lifted up it
> reports 0x08 [UP].
>
> It looks like report_finger() is meant to be called when the finger is
> up but it isn't because EXIST is not set during the UP event. So I guess
> the solution is to remove the guard in the IRQ func and call
> report_finger() unconditionally.

Actually no, interrupts are also called with 0x00 which should not be
used for reporting instead. So:

		if (p->sub_status)
			zinitix_report_finger(bt541, i, p);

>>>=20
>>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>>> ---
>>>  drivers/input/touchscreen/zinitix.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchs=
creen/zinitix.c
>>> index 3421b8ffb19b..fdcb80f52c91 100644
>>> --- a/drivers/input/touchscreen/zinitix.c
>>> +++ b/drivers/input/touchscreen/zinitix.c
>>> @@ -406,7 +406,7 @@ static void zinitix_report_finger(struct bt541_ts_d=
ata *bt541, int slot,
>>>  	u16 x, y;
>>> =20
>>>  	if (unlikely(!(p->sub_status &
>>> -		       (SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE)))) {
>>> +		       (SUB_BIT_EXIST | SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE))))=
 {
>>>  		dev_dbg(&bt541->client->dev, "unknown finger event %#02x\n",
>>>  			p->sub_status);
>>>  		return;
>>>=20
>>
>> Thanks.

