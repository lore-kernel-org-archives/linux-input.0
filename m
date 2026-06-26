Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645123C6606
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452347; cv=none; b=jGbYJsACQcm32oD2CdI5/Iu8tXGuXmrxs/fkTPQz1eAqC4NfKMkXhl18pjm4bF5xs2kq4COeLe0v1IppolKsminwrvbHYpSSya8GqBXxxBYZyUVOqjgRWJUOvL6rxeNX4bDH9IytQwHm8QNxs8HP3NcteToGWnoYHVcq+2tebGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452347; c=relaxed/simple;
	bh=yg1iR2eX+aSwl1WeDbQ1iGJMeExq9sx+kGcLa1kbL6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7uTvYHjjnKjGRDgO7BrXcE/ghzMtq7kh22OfkHddfXvPMWXTtFwlCWcAVqjhTkExV0d3wQ8iIsR2mgyg1UEsCVj1myQrXGIk20RH0k5FoSGtcG3AXOqmm+Oiunwt+vjzl80iunia6zM2sE49yeDkS+8fLNNi0dH7MD0ZTs5DrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/f4P/dh; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/f4P/dh"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30c03b09e02so871113eec.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782452343; x=1783057143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PhqZPVerKLJBXebvWPDJC0C1pTu6QcXLOIWVjWqdOYk=;
        b=I/f4P/dh+jCMG5RpP6ArymqE1ISPTSS6gZIqambDTuSrDMh840Vd7CDU+vSkOqhait
         F4xA0y9ByvMN7QFYY6qhTT3zAcDFNtPQpTauM7bVo3YiUUIOWknhQs6/jwZPVPV1UHD9
         reAKweUqgyNuF/XsyxgCXgryMJQ9alWRmRDeBqFztGoX2Q8irPyKNS1/BtFy5Xz1I/3j
         TKOP/aKgx1qzPHX7vDHPSoSjvRDHdaBevRx2NurMxb2SkPKG7xmPwn0GdV27yroqo9kL
         h3rnGCcvHTVCiGklrOZs05xRaiqA5SRwStMMyLBmYhtni2HGUfSmPA0lbDXhUi1jKWpe
         2BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782452343; x=1783057143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhqZPVerKLJBXebvWPDJC0C1pTu6QcXLOIWVjWqdOYk=;
        b=aZmJc/q6Jr/BGjNcUmPzrVzRnxvfaBJRoNjL52IpleVvaC1mfcqhMqdKDue49P1Kb1
         DCHrLJy7i5JI2hcIOs75o3n2BM+nCtDHNQCPkhvdeJX8E9fDzPcHN24Bo9n2H/gvuBGC
         r6XdbCCML7NChuTVvhFELA6gpsFgtptA+mpb2eY8mz1y7KpONURbhcbkrUZnRMiDeMeS
         P+3558qMK/+QBRbROpi5ZjEou1ynqdntuKIoTUdd7+12aryJimW+fI/3WZdUqmpCpu/V
         oVyaeDYIMNRFGw4OgG+IDDObj11R7Wffu3Cxace+twyLcEt6eFLG6gwXOCkvejUPQOif
         O1jg==
X-Forwarded-Encrypted: i=1; AHgh+RoxO4w8PmaeZIOkYUlPOdodlGOygG2/TSnh07GW7XFqQr0HMjTSC2PGB9t6unGWkNWnyI+y3tRGeLeWeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXTbPGiOc+92XvfPKQzHGn1pyP2tSwg15ETIh0Kncrx3NYX+u1
	Yqzn9IqM6IplnBCnMdahsTKFCtG21t582Daiuzn8RZc9DEX0kFWXbol/
X-Gm-Gg: AfdE7clJrIb72nf2usP1aRBd8R029UwhGt42VkHwXUFfkRYTevfgqi3EMdwBuHcAmUd
	299PUdSzIWPuQiGHlY2HmsNnXS+RF3KB+UkMzzs5YQTZfPlReaHj6AII7fzn6ytZTs3XSH4KQ7R
	eKi4gRxyjHqwizLEnE26a/7e4s/92nlUx1V3KjWMFBsogZB+tNnYNIYG3mbolqVXzfbxtRxmeFS
	O1qb2l16H9NE+B1lWEgnRBmrDH90rXnBCPBX4OFwcJB+MArHp4/O2VoNbxS/ceIs6CdyYI6eLSK
	t+aOVxgE39UGIRJbgsXmtZ3WAn3NqSOKlmSB0sgfH7fa5w9+pRDV/majQRvO1pk4ck7DCT9BmS3
	CBmR/t6uDgXqb1r716OK/BsHgkl0SWEWbQAtWYalgtjba3eObu5RTETSp5W9TgYcJbtqNJ5dS5v
	n8+0+xUgYOHrvTgqjMQ34Sg9g6JKg7QF+FtAl+AqxXaQqCk33RHKmUjA==
X-Received: by 2002:a05:693c:23c9:b0:30b:c6f0:1cd9 with SMTP id 5a478bee46e88-30c84d7f362mr5143316eec.26.1782452343350;
        Thu, 25 Jun 2026 22:39:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c570b7bsm13347671eec.12.2026.06.25.22.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:39:02 -0700 (PDT)
Date: Thu, 25 Jun 2026 22:38:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vincent Huang <vincent.huang@tw.synaptics.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sdm845-oneplus: Update
 compatible to include model
Message-ID: <aj4QUY5p7gqLplVT@google.com>
References: <20260523-synaptics-rmi4-dt-v2-2-0645122babdc@ixit.cz>
 <ahdoBl3qCTyvlYJf@google.com>
 <1d0e7e31-f808-4347-955a-7246dea208f5@ixit.cz>
 <742c7a13-9465-40e8-8990-e679712e9784@ixit.cz>
 <ajtaUb4YmyZTDLmQ@google.com>
 <52b7dd3a-3f6f-474c-8386-4fc2776b185b@ixit.cz>
 <ajxakXFuKAkhdZLN@google.com>
 <f81e4d83-90d9-47c8-aee9-319df3f8b0fb@kernel.org>
 <aj1OhZQjO5nNYlAo@google.com>
 <32affded-bae2-46c4-a702-2054fbfe46a8@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32affded-bae2-46c4-a702-2054fbfe46a8@ixit.cz>

On Thu, Jun 25, 2026 at 08:39:15PM +0200, David Heidelberg wrote:
> On 25/06/2026 18:57, Dmitry Torokhov wrote:
> > Hi Krzysztof,
> > 
> > On Thu, Jun 25, 2026 at 10:23:54AM +0200, Krzysztof Kozlowski wrote:
> > > On 25/06/2026 06:53, Dmitry Torokhov wrote:
> > > > On Wed, Jun 24, 2026 at 04:37:25PM +0200, David Heidelberg wrote:
> > > > > On 24/06/2026 06:28, Dmitry Torokhov wrote:
> > > > > > Hi David,
> > > > > > 
> > > > > > On Sun, Jun 21, 2026 at 07:11:45PM +0200, David Heidelberg wrote:
> > > > > > > On 28/05/2026 00:13, David Heidelberg wrote:
> > > > > > > > On 27/05/2026 23:56, Dmitry Torokhov wrote:
> > > > > > > > > Hi David,
> > > > > > > > > 
> > > > > > > > > On Sat, May 23, 2026 at 11:45:35AM +0200, David Heidelberg via B4 Relay wrote:
> > > > > > > > > > From: David Heidelberg <david@ixit.cz>
> > > > > > > > > > 
> > > > > > > > > > We know the driver is reporting s3706b, introduce the compatible so we
> > > > > > > > > > can more easily introduce quirks for weird touchscreen replacements in
> > > > > > > > > > followup series.
> > > > > > > > > > 
> > > > > > > > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > > > > > > > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > > > > > > > > ---
> > > > > > > > > >     arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 2 +-
> > > > > > > > > >     1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> > > > > > > > > > b/arch/ arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> > > > > > > > > > index 6b7378cf4d493..148164d456a5a 100644
> > > > > > > > > > --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> > > > > > > > > > +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> > > > > > > > > > @@ -475,17 +475,17 @@ bq27441_fg: bq27441-battery@55 {
> > > > > > > > > >         };
> > > > > > > > > >     };
> > > > > > > > > >     &i2c12 {
> > > > > > > > > >         status = "okay";
> > > > > > > > > >         clock-frequency = <400000>;
> > > > > > > > > >         synaptics-rmi4-i2c@20 {
> > > > > > > > > > -        compatible = "syna,rmi4-i2c";
> > > > > > > > > > +        compatible = "syna,rmi4-s3706b", "syna,rmi4-i2c";
> > > > > > > > > 
> > > > > > > > > So I believe we established that this device (s3706b) does not in fact
> > > > > > > > > implement rmi4 protocol properly. Why do we have "syna,rmi4-i2c" as a
> > > > > > > > > fallback? Shouldn't it be just "syna,rmi4-s3706b"?
> > > > > > > > 
> > > > > > > > The vendor supplies s3706b which does implement the RMI4 properly.
> > > > > > > > 
> > > > > > > > The 3rd party replacement impersonating original parts may not implement
> > > > > > > > it properly, but I don't address this issue in this initial submission.
> > > > > > > > 
> > > > > > > > With this compatible we know which original part is used by the vendor
> > > > > > > > and installed in the phones, so later we can deduct specific sequences
> > > > > > > > for the replacement aftermarket parts to keep phone touchscreen working
> > > > > > > > same as they do on Android without affecting other devices.
> > > > > > > 
> > > > > > > Hello Dmitry.
> > > > > > > 
> > > > > > > May I ask what is currently preventing this series from moving forward?
> > > > > > > 
> > > > > > > The first version was posted in 2023 [1]. I picked it up again in 2025 [2]
> > > > > > > and am now on the 9th iteration (this patchset). At this point, the series
> > > > > > > has been under discussion for well over a year, with relatively little
> > > > > > > feedback and increasingly long gaps between review rounds.
> > > > > > > 
> > > > > > > The current approach is based on the guidance I have received so far,
> > > > > > > including suggestions from the device-tree maintainers. When concerns were
> > > > > > > raised, I tried to address them and rework the series accordingly.
> > > > > > > 
> > > > > > > What I am struggling with is understanding what specific issue still needs
> > > > > > > to be resolved before these patches can be accepted. If there are remaining
> > > > > > > requirements, objections to the approach, or technical concerns that I have
> > > > > > > not addressed, I would appreciate having them stated explicitly so I can
> > > > > > > work on them.
> > > > > > > 
> > > > > > > I also split out the straightforward, self-contained changes in the hope
> > > > > > > that at least those could progress independently while I continued working
> > > > > > > on any follow-up requirements. However, even those patches do not appear to
> > > > > > > be moving forward.
> > > > > > > 
> > > > > > > Could you please clarify what outcome you would like to see from this
> > > > > > > series, and what concrete changes would be required to get it accepted?
> > > > > > 
> > > > > > I am still confused about how you want to differentiate between the full
> > > > > > RMI4 support vs the OnePlus flavor. The "syna,rmi4-s3706b", as you
> > > > > > mentioned, implements RMI4 protocol properly, so we do not need to
> > > > > > actually have it documented neither in binding nor in DTS.
> > > > > 
> > > > > --- part 1 ---
> > > > > 
> > > > > This series addresses identification within device-tree. It's normal
> > > > > recommended practice.
> > > > > 
> > > > > If we know, the device ships specific, but **compliant** variant, we just
> > > > > put it as compatible = "more-specific", "less-specific"; in this case
> > > > > "syna,rmi4-s3706b", "syna,rmi4-i2c"
> > > > > 
> > > > > This approach is used everywhere. This has nothing to do with after-market parts.
> > > > 
> > > > We do this in many cases, sometimes when a part has different timings or
> > > > maybe additional functionality compared to the base model.
> > > 
> > > Generic expectation is to have always dedicated front compatible for
> > > every device. rmi4-i2c is not really specific enough, more like a
> > > family, thus a specific device compatible is essential by the DT rules.
> > 
> > Essential in what way? What will break if such compatible is not there?
> > We have lived without it for many years and will continue live happily
> > without it for years to come.
> 
> Hi Dmitry, Krzystof,
> 
> Device tree should describe the hardware, rmi4-i2c isn't the exact model of
> hardware used, the real hardware is Synaptics S3706B. Device-tree should,
> where possible, describe the actual hardware used.
> 
> > 
> > We keep having this conversation each time there is self-describing
> > protocol that does not require knowledge of a specific part number:
> > i2c-hid, rmi4, spi-hid coming over soon.
> 
> While the protocol doesn't require this knowledge, where is the issue
> provide the model, at least in the places where we know it?
> 
> Does it making things worse to describe hardware in more detail?

OK, I applied the binding change, the dts change should go through some
other tree.

Thanks.

-- 
Dmitry
