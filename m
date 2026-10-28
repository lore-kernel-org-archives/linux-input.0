Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219535;
	b=FXKQc86yLahkVk1V1+z5o4kRbfQyd+1nHs5hjKpas3Z9tiq1PvQDQW0if79rjSFXZ4ZK
	 49rqwV29yqo5NOQPjuGBct0O7RHwuqP4YZE7dkaOobsc8jJR/ACmN8bXibsD+9t8LTBuh
	 Mz4SuO9vbbuolV+1hhoJflwQWnUE/ycECNbOGIiIqpGtxPPiLaioMv6awp3icIOFh4vt5
	 pXTZkqXKf9INVYHF4ac8Ev18Wqsg0tyx+Sb+4aqdUcyYBlvmz58qO/qtwFIbQ7THEEpkk
	 cNi8s+DHmP1HY51c3GVxo+UpIs3tfZ+k5fWU+zL1pjO8DfvDU1kCLCnLha8HryB2JlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219535;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=zMC+H5tUF3kscmU7zp4hWDIYHBRoykJp+CuX0oMkOkM=;
	b=E1zmOm4QWBu210CVWNHK1CK2rRxcwaQKyP+wb1ogw9+W07aK3UUVMVO8aOiptw95j7fI
	 oT3E2+Ond+wCUuZoTZpRixuAFClNhYsorAwwfYYgfwY3QHQ12VTTpmAIw7XueDiQ63fM9
	 OUYkfPrg0jOBpNKVTPvgDP5tUULwnq6AqvAy1H6CSyroPYkDdL9d/Dyno2bPHMsa/7ByA
	 VdCbR/aa3Sjm+INDshv/DSeeKKoH0yHV6VOb+JVRlrn6/oo72mogTHcXwZlrqZd5qL/06
	 J5D3pGDwpn/C6Z8GTMs9GUgfhDWxqOZkO5sWZkLk3tE/UQd7d5na1SFhIrrBDzzu/Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1E258606A31A;
	Wed, 28 Oct 2026 20:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E258606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68114.dsl.pool.telekom.hu [::ffff:81.182.129.20])
  (AUTH: CRAM-MD5 soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 00000000000808F8.000000006AE25BCE.0003297B; Wed, 28 Oct 2026 21:32:14 +0100
Message-ID: <102801f29dbb60d977aabd191a680ab0c3677c22.camel@irl.hu>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7325-motorola-dubai: Add
 vibrator support
From: Gergo Koteles <soyer@irl.hu>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
  Krzysztof Kozlowski <krzk@kernel.org>
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
Date: Wed, 28 Oct 2026 21:32:05 +0100
In-Reply-To: <96405224-72e6-4786-b13e-d73134b58ca2@oss.qualcomm.com>
References: <cover.1793135056.git.soyer@irl.hu>
	 <8717c3739be282747cbef611d242acfc5a40656b.1793135056.git.soyer@irl.hu>
	 <20261028-thick-gainful-pegasus-e1b430@quoll>
	 <96405224-72e6-4786-b13e-d73134b58ca2@oss.qualcomm.com>
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

Hi Konrad,

On Wed, 2026-10-28 at 13:04 +0100, Konrad Dybcio wrote:
> On 10/28/26 12:08 PM, Krzysztof Kozlowski wrote:
> > On Tue, Oct 27, 2026 at 11:01:25PM +0100, Gergo Koteles wrote:
> > > Add the required node for haptic playback (Awinic AW86224).
> > >=20
> > > Signed-off-by: Gergo Koteles <soyer@irl.hu>
> > > ---
> > >  .../boot/dts/qcom/sm7325-motorola-dubai-common.dtsi   | 11 +++++++++=
++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dt=
si b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
> > > index ef91986a1fb9..434846be51d9 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm7325-motorola-dubai-common.dtsi
> > > @@ -924,6 +924,17 @@ &i2c4 {
> > > =20
> > >  	status =3D "okay";
> > > =20
> > > +	vibrator@58 {
> > > +		compatible =3D "awinic,aw86224";
> > > +		reg =3D <0x58>;
> > > +
> > > +		interrupts-extended =3D <&tlmm 47 IRQ_TYPE_EDGE_FALLING>;
> > > +		reset-gpios =3D <&tlmm 46 GPIO_ACTIVE_LOW>;
> > > +
> > > +		pinctrl-0 =3D <&aw86224_int_default>;
> > > +		pinctrl-names =3D "default";
> > > +	};
> > > +
> > >  	wl2864c@29 {
> >=20
> > There is no such code.
> >=20
> > Please work on mainline, not some fork.
>=20
> + please keep the entries sorted
>=20
> Konrad

Thanks for the review.

I will sort it by address in the v2.

Best regards,
Gergo
