Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E3285CBC
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663630; cv=none; b=Xj6T1ed8JYFIHbLVlcpXyxQeOds8SJzJ/Q1YZ56QXFmTROlwsx2OSZMmGXc3/hS9COnfdGuFEEk6Kf2cqYRLaTlJQU426lnoZRejZlQOESJhVlsYDVLOHlXN41z171gDH79S+OczNbBh/hhnsDziedwEM7DvcnfNLawZlozK5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663630; c=relaxed/simple;
	bh=5G0suQ3hrbWJ2HWoaa7Mrv9On7N2jhCuHT1f3QoAKbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=db0QBHC2qjlGnX6Ip95nyqONu64NXW46z7iRN65wgTDP7Xz7o0kwvIGQs1cTN9mL66zMQI/V6+xCxThAnSgb6dHo24+189HiJeECXIhyuoJEOdzdg5Eh71I4pPDwNRT3OENJhkq8aZsKqBnLeSaD585L5PzpGbarME6SHRTJHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=h5vSAjF3; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="h5vSAjF3"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id E584741A33
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 18:47:19 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 41FF341C06
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 18:47:19 +0300 (EEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 9E95A1FEBBB
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 18:47:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1775663238;
	bh=5G0suQ3hrbWJ2HWoaa7Mrv9On7N2jhCuHT1f3QoAKbg=;
	h=Received:From:Subject:To;
	b=h5vSAjF3YXFqsM1USo8PTebzmjLixZZ2HT1GUjSHrk/rMLuOO4kK/T9md/j3Iyycu
	 8IfxVvtr79LdPpzTeTqLqLKTap39HXm3lmY2mrzjO89+Vl+9/a+3HstMiuk3fxINyz
	 zVA5s04xB1NFjCJ71r9oPg7xhJSN2PLQjSolWO22JX765owkDiHAU+3MNPUrpQdDZV
	 /YRhg2zcpJb0OEBTTuqb1oolo82uSaJy0OKzq4BaSEbo8I3Cojas/nkmK+6uihc0lj
	 wSsAA+n+TKgsz+ammNBcL0mQzwqJxMoN4PGkDpXOepBUmqMMtBZ0CxeByefnmzwoi6
	 Wrzha9SV221yQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.51) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f51.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-35d8e548a05so6864545a91.1
        for <linux-input@vger.kernel.org>;
 Wed, 08 Apr 2026 08:47:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVdvi4gIVOWhHF1diqjEgq4y1TgGKu0y93qyAdEVapHIRas8Ml2thUQwPY7t+xz4qYhdoN7Ept7mqsRjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEdQw5T4cWCmyvicN+nJO+KYe1tqvbMQkaG1wPNGpJemV/2HC
	pV3YJjsBSLGWvSWiheyj/gv8zu7661l7RYupCWKAfMIfQwAUQy45NbQJ4oZmW0Pn9F3Pelujr1P
	73VfPucPTSpE2o4QctPyYqySjVbhG1ow=
X-Received: by 2002:a17:90b:53cb:b0:359:fd9a:c513 with SMTP id
 98e67ed59e1d1-35de697ef49mr20810255a91.24.1775663237284; Wed, 08 Apr 2026
 08:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404083928.489966-3-sanjay.govind9@gmail.com>
 <adSJp5U47g1JnImj@google.com>
 <CALQgdA0oYzWqFtyG2eZKgwKr-QLYz5dLbsFbpY8qDrpxK7vj8Q@mail.gmail.com>
 <CALQgdA0UpJb7Lztkts3LrFtWrAP3V3CivFv3NKJDFg1VY_q_0A@mail.gmail.com>
 <adXe452989A6k2PJ@google.com>
 <CALQgdA04mczQoJ4HyjSwgeXMHwLT+Rv0AEoArpwBohzL9oa1nw@mail.gmail.com>
In-Reply-To: 
 <CALQgdA04mczQoJ4HyjSwgeXMHwLT+Rv0AEoArpwBohzL9oa1nw@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 8 Apr 2026 17:47:06 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEoFWG-sQAbT8zxqEg8Q=+=xULj-a9y7yoEqu3ehZtSUw@mail.gmail.com>
X-Gm-Features: AQROBzAQrR0pegYuWzC2WPjdCs-ITicEMHyOID2OJPXtgF6ksTXw4CIlmSxylN0
Message-ID: 
 <CAGwozwEoFWG-sQAbT8zxqEg8Q=+=xULj-a9y7yoEqu3ehZtSUw@mail.gmail.com>
Subject: Re: [PATCH v2] xpad: Overhaul device data for wireless devices
To: Sanjay Govind <sanjay.govind9@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vicki Pfau <vi@endrift.com>,
	Nilton Perim Neto <niltonperimneto@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177566323881.1111105.10497220080692465839@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 8 Apr 2026 at 07:04, Sanjay Govind <sanjay.govind9@gmail.com> wrote=
:
>
> On Wed, Apr 8, 2026 at 4:52=E2=80=AFPM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > I think you'd have to spin up your own instance for that...
>
> makes sense
>

Hi Sanjay,
I have a workflow for running an llm and getting reviews locally.
Perhaps I will post it to the mailing list soon. I can cc you. I have
been out for the Easter holidays

Of course, you will need your own LLM and harness for that, Claude
code/Antigravity/Copilot/Opencode, etc. I know they aren't
particularly cheap.

Dmitry, sashiko looks great, I left a star. I could also cc you. I
will also reference the prompts used in that as it claims some
subsystem specific ones. From a quick glance it seems to might suffer
from context bloat though. There are a lot of guideline files that
could have higher information density.


Antheas

