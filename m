Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219518;
	b=hDbgO5HWjIGgXxjngSDDjwx2kgLsNkFkELJreIOOTK1OBS0Q4ZV3j1u+ooSxhhscUgSi
	 M2cgmtMyduiJOr7B/pr95CdAZVVz/yyiyJ0RHK806LZQDCm0P0XL2FEL4UPTrE0+xffvQ
	 arbFVfr3fiEbyOZwDT66umetL9f5Vp1JfQGFS8nUp/GzRpdzq1GjQDu+qKWOHtOri5GhN
	 gO0Wdxi8C0qi17E0F10UWZJHp3Jv8fjsmU3a+xkr1/dstBK1ChCw8WNG9iLri8o+HsLNm
	 2VaaW7+B8fSVNU9MK7G6LQRZr0RglePL1S2WLGE3q0iUfItohUsmNQhbxzfL2VsuN4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219518;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=na0Oh3TAI0ex8L400Yz+9rIyulgdb+s9SFwVhlKcmfo=;
	b=yearv3I3y7/r1Pe6iIgKkFRoFJd9QwZJ/3RuxOUkYkIKZrPuXgIVNuOYekNDD/zrAwJn
	 mIqCBuXmZPzE39hYfLeDQhPck57SZz956MDCp6+R+KmQvlwzOjL/1PnBQit9k9XTVZjvz
	 tNMbdmCbzGyJgn/wnHGOINILWJIZpZCGtSEzdhUFRpLnxw7qh08DLqHaiUBqSz7YGOCV0
	 qAENkCAxSDm0xpSRj+aUt9zeGyohwx88dcMdIPMkUoxPr4y/kIpyAptO51j1cy7O2QS7A
	 OewHkVIjO5itb2sNR+xSqvz9BsJu/FkjGaKHkGUIZi8T11JcAQiLYnA1ULt2yf10+LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4644E606A31C;
	Wed, 28 Oct 2026 20:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4644E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68114.dsl.pool.telekom.hu [::ffff:81.182.129.20])
  (AUTH: CRAM-MD5 soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 00000000000808F8.000000006AE25BBA.0003295D; Wed, 28 Oct 2026 21:31:54 +0100
Message-ID: <7b293547b11817297f54ac36d3a441aa26e2eec3.camel@irl.hu>
Subject: Re: [PATCH 1/3] dt-bindings: input: Add compatibility for Awinic
 AW86224
From: Gergo Koteles <soyer@irl.hu>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,
  Konrad Dybcio <konradybcio@kernel.org>,
  Arnd Bergmann <arnd@arndb.de>,
  Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
  Enrico Cic <enrico@privacyrequired.com>, linux-input@vger.kernel.org,
  devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
  ~postmarketos/upstreaming@lists.sr.ht
Date: Wed, 28 Oct 2026 21:31:46 +0100
In-Reply-To: <20261028-invisible-malachite-agouti-99fcf6@quoll>
References: <cover.1793135056.git.soyer@irl.hu>
	 <353fe3fa68e74c46b88df51b303a7d23235d5ea7.1793135056.git.soyer@irl.hu>
	 <20261028-invisible-malachite-agouti-99fcf6@quoll>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Krzysztof,

On Wed, 2026-10-28 at 12:06 +0100, Krzysztof Kozlowski wrote:
> On Tue, Oct 27, 2026 at 11:01:23PM +0100, Gergo Koteles wrote:
> > Add the AW86224 haptic driver to the binding documentation for the
> > AW86927 and AW86938, as this binding needs the same properties.
> >=20
> > They are not compatible though, because the chip identification works
> > differently compared to the 86927/86938
> >=20
> > Signed-off-by: Gergo Koteles <soyer@irl.hu>
> > ---
> >  Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yam=
l b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> > index bd74b81488f6..655633527c01 100644
> > --- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> > +++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> > @@ -12,11 +12,9 @@ maintainers:
> >  properties:
> >    compatible:
> >      oneOf:
> > +      - const: awinic,aw86224
> >        - const: awinic,aw86927
> > -      - items:
> > -          - enum:
> > -              - awinic,aw86938
> > -          - const: awinic,aw86927
> > +      - const: awinic,aw86938
>=20
> I do not understand why you are changing this and commit msg is not
> explaining that. You only say that new device is not compatible, but how
> is that relevant for existing binding? Anyway, separate commits with
> separate reasoning.
>=20

Thanks for the review.

There was some confusion regarding this in my head, but I now
understand that it validates the entire compatible array.
I will add it accordingly in v2.

Best regards,
Gergo
