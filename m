Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A323D8139
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670376; cv=none; b=EhC7aEZjYHIqvibdu8rRn4+UZpD4i05MhW69TURfXZf/Boo8wMCKkcZLTaQzuGc3qdKSMls/xTWRBhIqsOh0GY063VBQ6+aWshQ43qzMNjdEwnF2Af66cEbkWAzqjdJiiR4BFyf/iwKTXBxykrufR0DC+G+1zwyFQ41QTdakfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670376; c=relaxed/simple;
	bh=xjSuwusdQsmcBrGGY+DBB9PDuOHcfBhgyIuln9dU+HU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A4BJxpM1PMOKB31dU/iO0KEHJqd1wMjohcznMkJa6yZ10O57JHLmEIRjljJ2gxOEWysJ7NjdVckM850UJ/218wbPwEmsB4Ib2T9m1nxb1wG2tDi0lv2ajfvVMIrLEiUu9SEqi9b6MkUFvus/bXBcs59pRZBqH7jVss55LiArXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xb/pocGZ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xb/pocGZ"
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775670363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjSuwusdQsmcBrGGY+DBB9PDuOHcfBhgyIuln9dU+HU=;
	b=xb/pocGZPk4SVRy3HIpqyNlYIEQ7A9LMJodGungB9Bms+camjiBzRH2xE14dyHxnpA244m
	6FGgg+QvO3YIn6znx3xBpfkzNtM4r70Q0tPwc0kgu7mm7E85UnN4p5iUlVU/XhTCcf42xh
	C9kdHXn+9My9J6zfo501KwJTq9uWB6E=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] xpad: Overhaul device data for wireless devices
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <adaOmEQNXXPhxmmx@google.com>
Date: Wed, 8 Apr 2026 10:45:47 -0700
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
 Sanjay Govind <sanjay.govind9@gmail.com>, Vicki Pfau <vi@endrift.com>,
 Nilton Perim Neto <niltonperimneto@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <B636001C-FB54-49EB-9A30-D255879788E7@linux.dev>
References: <adaOmEQNXXPhxmmx@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 8, 2026, at 10:24=E2=80=AFAM, Dmitry Torokhov <dmitry.torokhov@gmai=
l.com> wrote:
>=20
> =EF=BB=BFOn Wed, Apr 08, 2026 at 05:47:06PM +0200, Antheas Kapenekakis wro=
te:
>>> On Wed, 8 Apr 2026 at 07:04, Sanjay Govind <sanjay.govind9@gmail.com> wr=
ote:
>>>=20
>>> On Wed, Apr 8, 2026 at 4:52=E2=80=AFPM Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>> I think you'd have to spin up your own instance for that...
>>>=20
>>> makes sense
>>>=20
>>=20
>> Hi Sanjay,
>> I have a workflow for running an llm and getting reviews locally.
>> Perhaps I will post it to the mailing list soon. I can cc you. I have
>> been out for the Easter holidays
>>=20
>> Of course, you will need your own LLM and harness for that, Claude
>> code/Antigravity/Copilot/Opencode, etc. I know they aren't
>> particularly cheap.
>>=20
>> Dmitry, sashiko looks great, I left a star. I could also cc you. I
>> will also reference the prompts used in that as it claims some
>> subsystem specific ones. =46rom a quick glance it seems to might suffer
>> from context bloat though. There are a lot of guideline files that
>> could have higher information density.
>=20
> I am just a happy user of sashiko, I'll leave it to Roman to comment on
> the potential bloat concerns.

All I can say is Sashiko is an open-source project and I=E2=80=99m happy to t=
ake
any pull requests (including alternative prompts) which are improving=20
the quality of reviews. I=E2=80=99m not attached to any particular approach t=
o the
prompting and happy to change it assuming there is data showing that
some other approach is better.=20

Thanks!=
