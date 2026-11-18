Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036444;
	b=xlJIktORs9/o/JM/gFqUj+XI+eh+140uTMQUTA5WjQwQ2j7Q10lSTi92PNXpZlN9k7I6
	 d7pkASRGsBXz/ieIJtlVQ1SRnDLNNsTq7VgC64m+Z9ON5htqIIny8EcR97hL92PNuzm9/
	 IOdALlxc37ZfGDi9PdWvb/fuUM4L1q5Jg01WyN6YkPVYQPZXXcOULp+z6NxayQiqvD+22
	 Ea0pwLDeB8mO3Aab0hQ8bRmumMLq+JGRcnpQkewLfmFbW3KoSzmnrAHQblXJMwfsmCHE7
	 DUZDQLdbb5bebnKp+YzXgEtT3N2X9NxQ5kcF4+KS0K6ih7/slcgysxGHxM0X8S59qhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036444;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=ZuHXjpE3Ssj/q6CJrENArIWwpLyfX9a8DsZjeFkz+PE=;
	b=ImCX1h6cgbu0HI9Kcs3zGmETmqVf2Ij2tz+SieARzgdIRYEuk9BojiLOgf2l+pWpftBw
	 IwAZNrjsbu5OUjoomyuGU/dqyXGh2N5Ac8Q0BwtupzonqY7QlSYBFThKQECJJSSVoP0Jv
	 R5DCZ4LEwCP89KTaEjlW2onWT5CWzepbyMLcyrnrT0RK8dyy69fFuKL37qVeo5A2Z8LfB
	 /39+G3B7Ax8lMvZoQe6fufHBYT3ZEbIAknRl5+hdxayEHtQrLxgwQ7hcjDBOIH8XjufGN
	 G82HYQvz5Edt9sdtOk4UNic09eon93hVkJX3bHr5rOgLCGRZ8O1PZbC6OLMQRcdasbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rGj6lL3V;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5605606A32C
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 21:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5605606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rGj6lL3V
DKIM2-Signature:  i=1; m=1; t=1795036440;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.de;
 s=s31663417:rsa-sha256:cX9edQjBmakxLyFt6eIlSkvLqXOH
   KKNBPWEeELyYqPrPZiJ0g1xWdtdtRbnT6Doh0mIjsAnPz7e8RSZRXvcMY1gcJJbtcYUWw40y8fV
   RN9sBsZxwZzDHAXyUwrhbKSc4H/YVEiH6Cx56gRSgBSCKx3+8+B6CwQ1rIoY6nYwOlATNi6hM2C
   oY8lxTQeNtN8MUj4kj6YyaDLohWw03JX0p9m9FCQifm/Ypl0Ii7E5pU8xqYL8nGsux3pcUT0Z/1
   tqPltlufrGmZs2NHk5bdSRL4C/I3sETnjIEbpkLrr4HArV1EeWMSsYUXvcV1XwN/hvkcYDclNxp
   kIKDcS2tc9oEBQ==;
Message-Instance:  m=1;
 h=sha256:
   8KOaJP6c4tpCjGKBtLaFCAe98Lxsg2KcHQ/zKohkEHs=:
   ZuHXjpE3Ssj/q6CJrENArIWwpLyfX9a8DsZjeFkz+PE=,
  sha512:
   irHzBPDmxiausBZEaBjZpAPTpreylpn8sOaPsnY/FOK0OeQdhZeJsmw/FL47ztLvoBnecWsQrIY8HnzW/rnCYA==:
   F4FldLNalSKeyf7aqku8n9qZlcP7n6JGG932FaWrm8sdnw5MytPCFg0IAKbJd6pQnUTWG2Zvqyme9Z51sybnjw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795036436; x=1795641236; i=deller@gmx.de;
	bh=ZuHXjpE3Ssj/q6CJrENArIWwpLyfX9a8DsZjeFkz+PE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rGj6lL3V18K6v/GxQoIiX7Vom/ZCVrnaEvdQJUav2dkyBJ5ehAG0zX15LD32g/9H
	 mnIA7LD9at7j/009LroagDwh+KVFpqoKi83FBvB/bmQNenXly/4lKMrpHFbGBPsK/
	 1JnjIT/YTaZSqWSKNnHlD62KJSMguyakZYOejBrNnK0KpuhWWOJqyEDzRiOEonsD0
	 4aQs+wuzW1cXOT/H/v5nh6CfpxzKep4brSqOL2DmcWxj0mp3ErVvolrgDOO3brRJw
	 imlF8Cfjc+GJy6jGyXSis/00rex+bPWmpTWEcs4fs9tN8U9XiFUxoFkLXt1OaeBJX
	 RXcvSJJvjp0STzCHpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbirE-1wqszS27AM-00fCxa; Wed, 18
 Nov 2026 22:13:56 +0100
Message-ID: <f52cd9ed-4e23-4160-b305-650d853bc18b@gmx.de>
Date: Wed, 18 Nov 2026 22:13:55 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] HID: picolcd: Avoid framebuffer last-close
 deadlock
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Aveline Noir <jm5905938@gmail.com>
Cc: linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
 <CANOyQmHF-gjvnLqTGEVBcU6+AWj5ha+7tJhE2E_Cv9aj-gRXdA@mail.gmail.com>
 <76cddcc5-2cf8-40da-9139-e78353975e41@gmx.de>
 <179308935900.645289.17780178981863221787@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <179308935900.645289.17780178981863221787@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aDWixJldpCJ/UiTgCBUmqEJvLS0Oj7s94Q8zereDheZsJr/muKv
 ZNGdxgsdAXB7k0vDTp+//3CGabi0echTWj0OciVHAc5bXEy7Pxh/oTm1vS2ozaXXewneQtn
 qZVao9tslgQtCLk8+zjYcAMXFyQCof19GbEDwLCoGk8xNLApS2Hs8h8BCo+CWiCcsUIpNiT
 1KlnhMl6/cmW31ssodJJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FbTGy7foiCU=;v4o9dWY0XAX+0IK8aen+yQi6djM
 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

Jiri & Benjamin, can you check and decide on patch #1 of this series ?

Thanks!
Helge

On 10/27/26 09:22, Aveline Noir wrote:
> On Sun, 25 Oct 2026 09:20:36 +0100, Helge Deller wrote:
>> For this patch:
>> Acked-by: Helge Deller <deller@gmx.de> # fbdev
>=20
> Thanks for the ack!
>=20
>> I'm not sure about how to handle this patch series at all.
>> There is still a review missing for patch #1.
>> Shall I take this patch (#2 of 2) via fbdev git tree?
>=20
> Since patch #2 depends on patch #1, I think it would make sense
> to keep both patches together, perhaps through the HID tree.
>=20
> Jiri, Benjamin, could you take a look at patch #1 and let us
> know how you'd prefer to handle the series?
>=20
> Thanks,
> Aveline

