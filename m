Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC63D566A
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643874; cv=pass; b=qIaVYKAlqlTadYkzS6SOlI96h973zC0yV5T8fNOGz+DXPNnVQv0yMFwrek5ZpOGDTyt2iF9EdIR/AFmOjkg+U3hzKE91/ABYc7tqtMTkvfD+fenpkp7a0OxppJjRjwd/R06Sat1lOA0+l2QNlUvV65Mno1womi9l653YbWgoHKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643874; c=relaxed/simple;
	bh=Mii/DeCzm2nMtl3hgGSjPHkjrDmEfCYXtshu5NQAkD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4izILwzA6faB8zYR/TD2REAP9eajpGPlRMs7yx6ugRFp2JcM5BlUrSbbhaYl5poPqxZLiQ1aMklon5keA2F5meH+d264dgmtGn2T/CY7UnLTxBk7xp46dxg4OMPS+NihK84js5csMXPEHYLeXJGuniexh/tifTkJvLJgy3BbpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JLr3KL47; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JLr3KL47"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66c711b7f2aso6452940d50.3
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 00:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787643872; cv=none;
        d=google.com; s=arc-20260327;
        b=Ayi3z5lfoxQxiTHwG4d50F/oO4PQE20bVZD3lG4knaAXYh18Xm0e9+T85Y6aZHXNie
         932WpV0KWFdm5G2/4TB9y1ri+Zvei7TT7/CmeJZlSoPOEfz5FLYPXD4BWmiaIAmUdxS7
         XTyeUixrwaOioJm4mZSHq2YrS0k/1S1NXt2u4J3fbECDrTp5wiRPfyy8BDsWynxuT65m
         IRN4SnAJ1Mn3xnONdsy0z+CA8ZJnV4xy7TeuTQ5X3LOGb/B99oQ+oigWQDMAe9ft3b6U
         fUREhB617vex4CHg1mxNXCmIV5+3D3fsGk49KnxIU0DvpD/Mw/5vRItzZQuGeTbzUdas
         zSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V/xJK88pfs277nwbYNBwPuRxCY6IirnLC5W4+cq/H6A=;
        fh=xBr/G9QF75qHzOJWIGBrXRDEyZEcV0pYZpTKHl0iJFY=;
        b=OYp1auprdwl7ngiUdU5jXeNCEQZ5oAD78LLG5KdIp2o8fM9qzvvbsTNSt9UMsSJbPZ
         t3OyGOKhx3ST4sw5tNNYyWJK+EBGv2J/dhiQDlhp22lI9qeDV4EF3S1Pl9M7UqLiwaF9
         hHlGjZnxNxc5SYDnpWTXHM/maSYKLIUd1p9ZelLyVU12Zc2UkHKtFJZc3hDVMda+ovZ0
         r4Jgj4e4ANaX4sFIqlyB2EAxpzFp0ZWGLwcHG0QhPbY6T7o+YOXJYWnhl4sOT7A10gZz
         rc22z9jT//BWLxHQQqIrBf6EegRur5cAdBXBdz3DhGA8yh08qNKbzmwksMGTGIhTeiiJ
         r0IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787643872; x=1788248672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V/xJK88pfs277nwbYNBwPuRxCY6IirnLC5W4+cq/H6A=;
        b=JLr3KL47G4Cb+UYRYWyCFGDjVUpsKQwlnkO7htak24Xgd7PDtjfTg2gNjGnWSXY1Hn
         eapcVJmFJBl44VIEq6wcBHEZCnmZ9QYYBV3wC61d3sZei+nIbrcOpHee52YhHqEDDrpn
         4GfuC2xBh6ZJNaVU9czMBJdtJ+TxAZdSBMTA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787643872; x=1788248672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/xJK88pfs277nwbYNBwPuRxCY6IirnLC5W4+cq/H6A=;
        b=Z8AIpEQB73vErHvv4hU93Lyhfd7nuITNsIJgZInqUE94piadwptBH0tO2fZ3J6ddSG
         bl4N8SoQozpqjtCiUvp6cFvgAIAkV8GS7O+/MA70kCv0FeNBiLP7s/IGfg+M6T62PccM
         AkuoL+aGnAtrs1B2ORlFErUpeqP8FBLtZ2IDuhThjWf9lDr1Rso4WfkzwZo5JaQ2z2Se
         7GowZ6LrrYqbENg/FzXi9p9DPJiNWnBpOmF+DIBSko2tozqnOJTMtkxSCj7OEq/lHFGo
         Q7SjPBFq3FLQSYxSFAxYF+IOI2Pl2ItcWrfF2DTmJXTxrdsWoF/TtINqCKRkotJvGIHP
         HmCw==
X-Forwarded-Encrypted: i=1; AHgh+RodeerTJ5bwOjDvNI/MrPsDyRrGSQGBbCj/GW9BryZVkG9bamyAsmRMQdp2ItqSTsHeKDgawv/SoY3fTg==@vger.kernel.org
X-Gm-Message-State: AFuF++nfREzps8Bil8aw0nkDjOGrnhezdb8dR7qyYKK5etyMgDlpVcJ2
	AEFINH+rhJXMucIKL1oQTtS74KsQ4hbeVrfYQ75aKysdD2lkBnIVoyYqH/WOtm11rRdNeOJ3rnc
	1UmDX66AmkJtmO6YUca1GIoC46WxLJFYiSwI4AkPd
X-Gm-Gg: AR+sD12mKWYeI074mec9dh6kWbeMQFDETXhVkNj31kF5+OHycIeiGFtGrYCkb95UTkX
	ptHesS/LMSVDh2iRYTuQ4sww4o10pYPeZJP/2X3igjIM39VpyiqNb43Axq/PXYmYY7P4NQZ+cjr
	GJf0lbS9Fn+3z2y2Djw4QNrgBhHhQ9kqtHiszh1fGZWGySknumnOclpoFeX8QOHoEJFnmtXfW8z
	Qxnp1UPDiPzKOEMUYQC2rwzukP31Y7V446UDnyauV0vO/1MlZWbZ8RDNgVbfg+j4MPSwMPzswkX
	oLSmiUojm+nSyAvG63fmtCKjkJh8ysfts1tjFpYwAkc1fCS5nmAZO36z2i6ks/E8p+3EZSlX
X-Received: by 2002:a05:690e:1449:b0:66d:1131:b81d with SMTP id
 956f58d0204a3-66d1131bc41mr2549091d50.29.1787643871703; Tue, 25 Aug 2026
 00:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825041628.988369-1-wenst@chromium.org> <20260825041628.988369-2-wenst@chromium.org>
In-Reply-To: <20260825041628.988369-2-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 25 Aug 2026 15:44:21 +0800
X-Gm-Features: AcwNN1VHbO3y1ftfkF_7R2W7KDk8RFMySudnf-TTSiUhjGplV2Fwnh0fieb32LM
Message-ID: <CAGXv+5Het3zp_OTp=_ktg+_d5Q55zkE0SwQnM7TVyJDmOdBtyA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] regulator: core: Add "enable and wait" functions
To: Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 12:33=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> In device power sequencing and initialization use cases, it is common
> for the driver to enable the regulator and then wait for a certain
> period of time to pass before continuing.
>
> In cases where the regulator supply is always on, or has been turned on
> or left on by another consumer, the driver could shorten the delay or
> skip it altogether, provided that enough time has already passed since
> the regulator was _actually_ turned on.
>
> Tracking this requires support from the regulator core. Introduce a
> "last turned on" timestamp field to the regulator device, and "enable
> and wait" functions to the single and bulk regulator consumer APIs.
> The existing "enable without wait" functions are then converted to
> macros that expand to the new functions.
>
> The timestamp is updated each time the regulator is actually turned on.
> For regulators left on by hardware default or by firmware, the core will
> set the timestamp if it detects it was left on and its supply (and their
> supply, and so on) is on as well. This is unfortunately best effort
> only. The core can only assume a dangling regulator (one without a
> supply) has power. This also applies to the dummy regulator.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v4:
> - Try to update last_on timestamp for regulators that were left on

Sashiko flaged a few issues with the changes:

- _regulator_is_enabled() called and subsequent timestamp update
  without lock
- bulk consumer wait_us incorrectly assigned
- _regulator_is_enabled() could return an error

Will fix and send a new version. I probably should get a local AI review
working first.


ChenYu
