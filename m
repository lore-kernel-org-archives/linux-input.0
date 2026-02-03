Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03730DED1;
	Tue,  3 Feb 2026 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145611; cv=none; b=mF0gKBMYCFBMB0x0ZVRdfJc8wO62mChFKlVkWNqv/ppOi/sn5KlFJlxCvBA2dMtzyr5lcuH6R+t2XQBk+btL840u4n1Fronl8WEEqboCqaQNzQIJRVmvJC39C3O+psDcoK6pn4PGx1hYL5uzA9Ym5lZI/Nyb/ODCir4D7kpoHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145611; c=relaxed/simple;
	bh=8gr3qOXZ3tA1i40hROC2gBxjneDU5P2VxmbWfDSn+aY=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=sgFwB50II2dqSDptDxYx2sX9hV2jmroHtGBFjIbsFGg2VggGg2oGGfMyr1L0Y2RareNfgmbufivB618lzYjIWvWAuFB1FDJKo+8egVDeLpnrsHx9zSxR/pHSEG8lLAn6Kfin6ZpJwNqXlllyB5UxXu5TmzEr6jTbX+SpyFe96ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=UVYTzGqO; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="UVYTzGqO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=l/Htvb/iCfHCifE+qaqNetKeoYo2DUSCzKmoAPP7kLw=; b=UVYTzGqOHWiSJogMC2Li3DyNM4
	TTJi94l3Dgvb7ob/coyo2UBZ2NdCLoV0UNNSwJs2lF9rN3o8TJYax9Q/+K46Hxc3wmabqr7XvyewR
	YmQKAqDmcm6PT1LM2tXWA+Nzg+UZBc9Q5Yirz++Rnq18A22I720Lp/DCxEh8KWEd4ceY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:60440 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vnLja-0002eq-Gv; Tue, 03 Feb 2026 14:06:47 -0500
Date: Tue, 3 Feb 2026 14:06:45 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, hvilleneuve@dimonoff.com,
 linux-input@vger.kernel.org, krzk+dt@kernel.org
Message-Id: <20260203140645.3c0a320763cc92e27181f96a@hugovil.com>
In-Reply-To: <177014266917.3376127.756776677952580015.robh@kernel.org>
References: <20260203155023.536103-1-hugo@hugovil.com>
	<20260203155023.536103-2-hugo@hugovil.com>
	<177014266917.3376127.756776677952580015.robh@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 1/2] dt-bindings: input: add GPIO charlieplex keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 03 Feb 2026 12:17:49 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> 
> On Tue, 03 Feb 2026 10:49:47 -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add DT bindings for GPIO charlieplex keypad.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../input/gpio-charlieplex-keypad.yaml        | 88 +++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Lexical error: Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.example.dts:30.17-27 Unexpected 'MATRIX_KEY'
> Error: Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.example.dts:30.29-30 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
> make: *** [Makefile:248: __sub-make] Error 2

Hi,
I will add:
  #include <dt-bindings/input/input.h>
to the example section to fix this in V2.

Thank you,
Hugo.


> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260203155023.536103-2-hugo@hugovil.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
> 


-- 
Hugo Villeneuve
