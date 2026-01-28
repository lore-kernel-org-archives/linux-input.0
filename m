Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E99E36F411
	for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622511; cv=none; b=kR9bZN+abL75+YopMCH06cYAKDdNTq7kfrr6IcARaMg3gjaWTGxIJr23WGn0/QSpmbSFxO60J1zgF9eeU/KRKkyuTS9jXRbnL2HFhdIZYKLP7jtTm6RwwGFYDBvZVZguhEUzDp3P85DhJZsRESC0WIw09Cd+rdTLbO6RnK/4rIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622511; c=relaxed/simple;
	bh=/aCEqNZqW1J8iAgI0Mn7n2w/ZX0/+xBlGJ+Nc6A0GW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TqZ2ZL6rWSvpspoVMEXthnq2sEA0r+UBJHorEW8QRo1to9UUOq+ELYnmHb3WVjvNQghmW6IMH54GIJ2U4QK6kdqgUMcRIl3FZqSbkAQ65t8Q57Jg2XO51FI+y/2+/bG+jQkKEfVyZZxm2pswtkPsoSVbwaKeryZRCX7oQmXytQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3FBA43960;
	Wed, 28 Jan 2026 17:48:21 +0000 (UTC)
Message-ID: <809dc7359ac03ef94133f31da6984638d25774ef.camel@hadess.net>
Subject: Re: [hid:for-6.20/pm_ptr 7/12]
 drivers/hid/hid-picolcd_core.c:651:33: error: 'picolcd_suspend' undeclared
 here (not in a function); did you mean 'picolcd_reset'?
From: Bastien Nocera <hadess@hadess.net>
To: Jiri Kosina <jikos@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-input@vger.kernel.org
Date: Wed, 28 Jan 2026 18:48:21 +0100
In-Reply-To: <n7o7o70s-3pp0-r590-p65n-2175r761q79p@xreary.bet>
References: <202601260353.Dk5ekiee-lkp@intel.com>
	 <4ecf6a790596c4814c6666805b53aa7b1dd5a793.camel@hadess.net>
	 <n7o7o70s-3pp0-r590-p65n-2175r761q79p@xreary.bet>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffeiueduvedutdffieehudetlefggfefgeeufeehudeujefhtdduvdekhfdvkefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeufefhueetgeefleeitddpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepl
 hhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrgh

On Wed, 2026-01-28 at 18:46 +0100, Jiri Kosina wrote:
> On Wed, 28 Jan 2026, Bastien Nocera wrote:
>=20
> > The wrong version of the patch got scheduled in that branch.
> >=20
> > The branch has v1 of the patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=
=3Dfor-6.20/pm_ptr&id=3D318f7b0f1bea13d3aa0506fe6f40399f11c4ae52
> >=20
> > This is what v2 looks like:
> > https://patchwork.kernel.org/project/linux-input/patch/20260113092546.2=
65734-8-hadess@hadess.net/
> > which should fix the problem.
> >=20
> > Note that my v2 patchset also dropped
> > "HID: surface: Use pm_ptr_sleep instead of #ifdef CONFIG_PM_SLEEP"
> > which is still in that branch.
>=20
> Hm, something went wrong with my b4 workflow then, sorry for the
> noise.
>=20
> I'll take a look and ensure that the correct version gets queued.

No problems.

I was a little bit worried as I spent quite some time making sure to
test for those problems in patchsets that I sent for hid and for the
Bluetooth subsystem.

I'm glad it's something as simple as the wrong patch being used rather
than my testing being lacking.

Cheers
