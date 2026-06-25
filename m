Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A732D0EE
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406635; cv=none; b=Sd5FB8cb4iG6QcpSj/nWNVX1aL0ky1hh4hi7/fQOV57AnnlygxIUVUQKhPXdHtFQmtCsb2X9A4ZWZq1X9ZsIAyoYBhvy4YC+3+39QmfL9WzgNHpOZC9bDGU2IUPBpx8X/aaEqFbah5s6NyopGN4r5bY158LCk6WrWdNbx4c+wRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406635; c=relaxed/simple;
	bh=5uLM2t1OK9gV1VxaAFLmOfm0nFQOJErrRtB3jxbGggU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzt61n3GKqAYZBs5hls1EnDzo+vhc2C4s1c0afYXoXCGluvEKn9GiTdH85xuDCXtPi/s+tiykJWu9TuErOEoMrSKBC1tMIezzypGJ60Cfbr1vXlZ10E8/hc+Vrxikov82N9lvkThh9+ziKveYYCvLo+PXBnaVCAec3p6qDiHdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPZD0Nez; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPZD0Nez"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so11209b3a.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782406632; x=1783011432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GBrVOyTAenBaFj8eYAWNpvmiXRoSIrh2l/x5bH7lDzM=;
        b=rPZD0Nezvo01mmRYBoXVeSx/+N/CgR0dr3F5Qp/mncCL+VWiICcDZ1DnaBK+LTcBFq
         Z62A+CpSKFz+RQs+9u+1QnjEe1Zu6ZRuRY+MgDoNBEz8upAF2G2cI+M3cmVeWuPrZ3eA
         tnD4cIWnn+e+zePKiGhc6rby+QgWkME72Xod+npHE4th2HLkX2dB839/1Y6RqIAGt6VT
         qG+T0eZGxi5jb8O4OJv3BzbUgjIDAoZUOIypbQRTxwZb7fNe/5Jcn5LPJ+gGaseGqEEL
         m1E8BjsEJh0awBcAYPbv6xxsGBCfvFNJU/CQ9xrR+L+RFmPhTlsMngVeTyV2NdslWUpr
         ik4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782406632; x=1783011432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBrVOyTAenBaFj8eYAWNpvmiXRoSIrh2l/x5bH7lDzM=;
        b=nF6atmyLWyHnQwLaVLNnxpKZ2LMXZqxAylqNr8si+U70WsTtLth57DgUkJRAF7hKN+
         CrBH1n/72dMoobWmxfrHwfu2wD2NUN5MPQaRL10exvrJTMkXDxmVs+vy0w/O7KMzJnGB
         Mhl0bhKCUHypVh9EBWudnvGcT2AOxzd3r4EkNw5tjWTZbayo7Rcw3jCcPjbLvD95N9Nx
         sK7CD6sctozkplu0MhN8IdC1vttpEMWb+fabt0HHfiZxQ+qiTcNnSwlmlVP3zC1sjsGM
         8kbS83p7GplD0cm1/BB7EojqU031tgULdNEqtgEORU42mAsOqz54fmSSL2r8zBKr8Kt1
         Xf4A==
X-Forwarded-Encrypted: i=1; AHgh+Rq2qrsPkCunItyQLNU2jRBkgIX2c7+kQ40fbHjaUKO+GadsY1zuVHRJDBgc93jXer1t56Co0bhddHXeig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwsFcxGti3QKUUbXTHoJPmUs8L45JLIn/P2ZyNOUFPJyuvbxX
	nbNiwaEFN5TovZdnnhy5kIAHwjy2xn/iX9Jrojevf08urkAlII3wrc8O
X-Gm-Gg: AfdE7cm9OVvT6GMZuRHb/W9CS3wtIAYZcUarZaypynQV3l/9qZwlxxrILvd92qiD3J8
	A0lstlVSViUIFm//rl0sRrJbNKE0o5ZgRxQJXjMjDZ4CTRSlkaW0p6X9uCuoqGjPI85o9ROtfiq
	V8b6Oq6UBDvJg+B3+c3VgNS2L4pWAAhOQHVRmrwgs2Hl7s6ejrDeBW/q7DviEIGrY+hy+ILlhkw
	9CS/+upFLO/Muujeme5cxuyB1ywirTyMOi1NU3oxMG7HkfdAenVf2JwicBF6Vp4wnfk7pXrRaxD
	ctuzk+5LMHYbV81X5DBq0PpH9Agv9vi5PalDdiiEcJbhqhDHPR3+Yot1qUPWYTsENobQknYZ8iW
	kQ3QoorRY6BqxI+EwNxb2rXFI0zc+mW+srt4r1thY/swq1ejNnU+Ou4mdk8v23a/ITjkU6Ni54c
	CiowmghRVn9eirowFhNjmFL13duYIyC+mAiaSOIkC4w06mAIY3Hc47QA==
X-Received: by 2002:a05:6a00:8598:b0:845:b735:5a7 with SMTP id d2e1a72fcca58-845b73509c4mr1975057b3a.25.1782406632431;
        Thu, 25 Jun 2026 09:57:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c782:a4ca:fcbd:6ba7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413f604sm4927524b3a.60.2026.06.25.09.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:57:11 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:57:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Heidelberg <david@ixit.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vincent Huang <vincent.huang@tw.synaptics.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sdm845-oneplus: Update
 compatible to include model
Message-ID: <aj1OhZQjO5nNYlAo@google.com>
References: <20260523-synaptics-rmi4-dt-v2-0-0645122babdc@ixit.cz>
 <20260523-synaptics-rmi4-dt-v2-2-0645122babdc@ixit.cz>
 <ahdoBl3qCTyvlYJf@google.com>
 <1d0e7e31-f808-4347-955a-7246dea208f5@ixit.cz>
 <742c7a13-9465-40e8-8990-e679712e9784@ixit.cz>
 <ajtaUb4YmyZTDLmQ@google.com>
 <52b7dd3a-3f6f-474c-8386-4fc2776b185b@ixit.cz>
 <ajxakXFuKAkhdZLN@google.com>
 <f81e4d83-90d9-47c8-aee9-319df3f8b0fb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f81e4d83-90d9-47c8-aee9-319df3f8b0fb@kernel.org>

Hi Krzysztof,

On Thu, Jun 25, 2026 at 10:23:54AM +0200, Krzysztof Kozlowski wrote:
> On 25/06/2026 06:53, Dmitry Torokhov wrote:
> > On Wed, Jun 24, 2026 at 04:37:25PM +0200, David Heidelberg wrote:
> >> On 24/06/2026 06:28, Dmitry Torokhov wrote:
> >>> Hi David,
> >>>
> >>> On Sun, Jun 21, 2026 at 07:11:45PM +0200, David Heidelberg wrote:
> >>>> On 28/05/2026 00:13, David Heidelberg wrote:
> >>>>> On 27/05/2026 23:56, Dmitry Torokhov wrote:
> >>>>>> Hi David,
> >>>>>>
> >>>>>> On Sat, May 23, 2026 at 11:45:35AM +0200, David Heidelberg via B4 Relay wrote:
> >>>>>>> From: David Heidelberg <david@ixit.cz>
> >>>>>>>
> >>>>>>> We know the driver is reporting s3706b, introduce the compatible so we
> >>>>>>> can more easily introduce quirks for weird touchscreen replacements in
> >>>>>>> followup series.
> >>>>>>>
> >>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>>>>> Signed-off-by: David Heidelberg <david@ixit.cz>
> >>>>>>> ---
> >>>>>>>    arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 2 +-
> >>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> >>>>>>> b/arch/ arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> >>>>>>> index 6b7378cf4d493..148164d456a5a 100644
> >>>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> >>>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> >>>>>>> @@ -475,17 +475,17 @@ bq27441_fg: bq27441-battery@55 {
> >>>>>>>        };
> >>>>>>>    };
> >>>>>>>    &i2c12 {
> >>>>>>>        status = "okay";
> >>>>>>>        clock-frequency = <400000>;
> >>>>>>>        synaptics-rmi4-i2c@20 {
> >>>>>>> -        compatible = "syna,rmi4-i2c";
> >>>>>>> +        compatible = "syna,rmi4-s3706b", "syna,rmi4-i2c";
> >>>>>>
> >>>>>> So I believe we established that this device (s3706b) does not in fact
> >>>>>> implement rmi4 protocol properly. Why do we have "syna,rmi4-i2c" as a
> >>>>>> fallback? Shouldn't it be just "syna,rmi4-s3706b"?
> >>>>>
> >>>>> The vendor supplies s3706b which does implement the RMI4 properly.
> >>>>>
> >>>>> The 3rd party replacement impersonating original parts may not implement
> >>>>> it properly, but I don't address this issue in this initial submission.
> >>>>>
> >>>>> With this compatible we know which original part is used by the vendor
> >>>>> and installed in the phones, so later we can deduct specific sequences
> >>>>> for the replacement aftermarket parts to keep phone touchscreen working
> >>>>> same as they do on Android without affecting other devices.
> >>>>
> >>>> Hello Dmitry.
> >>>>
> >>>> May I ask what is currently preventing this series from moving forward?
> >>>>
> >>>> The first version was posted in 2023 [1]. I picked it up again in 2025 [2]
> >>>> and am now on the 9th iteration (this patchset). At this point, the series
> >>>> has been under discussion for well over a year, with relatively little
> >>>> feedback and increasingly long gaps between review rounds.
> >>>>
> >>>> The current approach is based on the guidance I have received so far,
> >>>> including suggestions from the device-tree maintainers. When concerns were
> >>>> raised, I tried to address them and rework the series accordingly.
> >>>>
> >>>> What I am struggling with is understanding what specific issue still needs
> >>>> to be resolved before these patches can be accepted. If there are remaining
> >>>> requirements, objections to the approach, or technical concerns that I have
> >>>> not addressed, I would appreciate having them stated explicitly so I can
> >>>> work on them.
> >>>>
> >>>> I also split out the straightforward, self-contained changes in the hope
> >>>> that at least those could progress independently while I continued working
> >>>> on any follow-up requirements. However, even those patches do not appear to
> >>>> be moving forward.
> >>>>
> >>>> Could you please clarify what outcome you would like to see from this
> >>>> series, and what concrete changes would be required to get it accepted?
> >>>
> >>> I am still confused about how you want to differentiate between the full
> >>> RMI4 support vs the OnePlus flavor. The "syna,rmi4-s3706b", as you
> >>> mentioned, implements RMI4 protocol properly, so we do not need to
> >>> actually have it documented neither in binding nor in DTS.
> >>
> >> --- part 1 ---
> >>
> >> This series addresses identification within device-tree. It's normal
> >> recommended practice.
> >>
> >> If we know, the device ships specific, but **compliant** variant, we just
> >> put it as compatible = "more-specific", "less-specific"; in this case
> >> "syna,rmi4-s3706b", "syna,rmi4-i2c"
> >>
> >> This approach is used everywhere. This has nothing to do with after-market parts.
> > 
> > We do this in many cases, sometimes when a part has different timings or
> > maybe additional functionality compared to the base model.
> 
> Generic expectation is to have always dedicated front compatible for
> every device. rmi4-i2c is not really specific enough, more like a
> family, thus a specific device compatible is essential by the DT rules.

Essential in what way? What will break if such compatible is not there?
We have lived without it for many years and will continue live happily
without it for years to come.

We keep having this conversation each time there is self-describing
protocol that does not require knowledge of a specific part number:
i2c-hid, rmi4, spi-hid coming over soon.

We might need a device-specific compatible if we need to implement
particular power on sequence/adjust timings, and that's when it starts
making sense to introduce one.

> 
> It does not matter if that specific compatible is ever used.
> 
> > 
> > How does this new compatible for controller that fully implements RMI4
> > protocol help here? 
> 
> It does not matter. This is a different device, thus it needs
> front-specific compatible.

Different from what?

$ git grep syna,rmi4 -- arch/ | wc -l
43

Do you have plans to list each and every chip currently covered by
syna,rmi4* ?

> 
> Also, the commit msg actually did mention how this helps: allowing
> further quirks (I did not verify that in practice, but explanation is
> plausible).

Well, the devil is in the details. And that is what I am trying to
understand.

> 
> > 
> >>
> >> --- part 2 (irrelevant for this series) ---
> >>
> >>>
> >>> The issue you have with after-market parts that are not compliant and we
> >>> need to figure out how to deal with them. Inside the driver I
> >>
> >> As was suggested by device-tree folks, this is the first step, there isn't
> >> better one available. If there is, please suggest one, and I'll apply it.
> > 
> > Was it clearly communicated to DT folks that the compatible you are
> > adding is fully compatible with the base "syna,rmi4-i2c" but other ones
> > will not be compatible?
> 
> That was not communicated but also did not have to. You can install in
> your board whatever you wish, e.g. replacing foo device with bar being
> something completely different and incompatible. Does not matter really
> if this is after-market or a person just swapped things.
> 
> DT does not solve that problem simply, because we describe static
> hardware configuration.

But the core issue that David is trying to solve is the fact that these
headsets do not work well with aftermarket parts with the upstream
kernels. It is not a theoretical problem for him, it is something that
he's been trying to solve for a while.

However from my POV I need to make sure the changes to the driver do not
affect or limit well-behaved devices implementing RMI4 protocol
properly.

> 
> > 
> >>
> >>> essentially need a"incomplete protocol" flag that we can use to
> >>> implement additional checks or skip known to be not implemented
> >>> functions/queries. In DT we could introduce something like
> >>> "oneplus,rmi4-i2c" that is decidedly not compatible with "syna,rmi4-i2c"
> >>> and neither one should be a fallback for the other.
> >>>
> >>> This of course needs buy-in from DT maintainers.
> >>
> >> As you can see, this still holds Acked-by and Reviewed-by from the relevant
> >> people - Krzysztof and Konrad.
> > 
> > I see that but the commit does not explain how exactly you are planning
> > to deal with knockoffs.
> 
> I think it does not have to. David does not need to solve all possible
> problems. He is solving his problems and not preventing the other
> problems to be solved in the future. Unless you expect that the second
> part - future problems - will be blocked by this code.

Well, as I mentioned above my understanding is that David really wants
to solve the issue with after market parts not working properly.

> 
> But then I think no one ever solved in DT a problem of replacement of
> valid parts with after-market incompatible parts. Therefore I do not
> even know what solution I could suggest to David.
> 
> > 
> >>
> >>>
> >>> Does this make sense?
> >>
> >> For the scope we're discussing it doesn't seems so.
> >>
> >> This discussion should be associated with the last revision of the full
> >> series I sent 3 months ago. We're in very unflattering state, where:
> >>
> >>   2018 - these aftermarket touchscreen worked on Android well enough for
> >> people to have working touch (let's say with slightly worse experience then
> >> the original).
> >>
> >>   2026 in the mainline, we cannot even more forward and report to user-space
> >> there is aftermarket non-compliant piece of hardware installed.
> >>
> >> Actionable steps I suggest after this series lands:
> >>
> >> 1. don't do any changes, but since we know what 3rd party touchscreen do
> >> incorrectly deviating from the standard, REPORT it to the userspace, so USER
> >> know, their device (phone/tablet) doesn't have original part.
> >>
> >> 2. then figure out, IF we can reasonably well workaround it and HOW to do it
> >>
> >> These two steps present some progress which could be discussed and could
> >> lead us somewhere, what do you think?
> > 
> > So since we know that these devices can come with controllers that do
> > not implement RMI4 fully, can we:
> > 
> > 1. Establish a new compatible that is separate from syna,rmi4-i2c? As I
> > mentioned, it could be oneplus,rmi4-i2c or event a concrete controller
> > vendor,id combo. The point that it should be completely separate from
> > the current compatible and not use the current compatible as a fallback.
> 
> Board/machine level compatible already gives you that.
> after-market-incompatible-parts is not a problem of this s3706b, if I
> understood correctly. It feels to me more of a problem of the board:
> people install into this board some incompatible replacement parts.

So is the suggestion to check if the board matches "oneplus,enchilada",
"oneplus,fajitas" with of_machine_compatible_match()? 

> 
> I would understand that this is not a board/machine level problem, if
> multiple different boards with s3706b were affected. Is this the case?

David?


Thanks.

-- 
Dmitry
