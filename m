Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12C1FBC8C
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981385; cv=pass; b=fyovcbEUgMVcajEmpiZp49aLkBH5Ua7a5D5aSqkqc6U6ZyrW6yRCSrDQq+12cGBlO/gqvXBEHZOeJRrwgzm1rBjaZjgPtD1HNxYZ33BrLdpMwPnbW4Gogxy6Es/HJGsR+EmijrfHmHhpujGcqT0WNxDowZ2UIVdeFDyIef6p6OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981385; c=relaxed/simple;
	bh=uW95L79+oRSfL6rUWy9JAkaDOq8YV0W5D8GzHWw5BHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAKxsPCLaDdUWc8oOsnOiHxiTNRVgYk+CpjN4z7YA3QzNtl4Z1Iz8Krlf6do/wX/khRKxQdIKy5vaqC9MIqTDFPwYnXoiZfh8WS4K6EsSlpWisXOgiZ2Ie1eQCDxo41Lw5amtQT3inqOTtCIKkhPsO8cPGBaY0c/L8Mw9A/stZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlvDeqWZ; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlvDeqWZ"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba895adfeaso5496323eec.0
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 04:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777981383; cv=none;
        d=google.com; s=arc-20240605;
        b=dkg2FjUhbgt/ZNHrnSiKORZJ4+XLax2NaZYKeljL5S4wrVIgwFL9es3yDaeLfJZMvl
         35AMzkbkTs4tuPcBUcbgl2o6ZO1VyYpNuifmpDyEDhSWpqvCU9N5yjjn4pF4vBkR3ZW3
         q5Ga0WE9/sz5zXm4VzXtxXsj7CA/6jp9jEwJnK3TZOb2Q21WTvuslzegIWiggKvzf5AT
         GysZDVMxkXQfq9EZNuLm4TJpipNOz3BqKXlLeHheNuKhYeeUCJgy3J/upnK1SBn9fpPV
         nXiubuzKfPu+euzBUKENv00pc/bevCOo2YPJcIjqqWHqL50cC7eU+aqEnJ5uqkkO6i3J
         JR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uW95L79+oRSfL6rUWy9JAkaDOq8YV0W5D8GzHWw5BHo=;
        fh=Usl4S39v2nJITDoRTCSiK0UuP+axJ+mg4iqINDvVfgA=;
        b=Do1SXLzzcR9TByamVH3mvD4zTqJqQ/xaKNMBGZjQfDmRhjmLh710l33aYIRpe91qus
         clCp5/5DYN6FJaP8Bc7AJbZV87kUW9qnLPeuohHQv4atYC4nJDxNI6Vfj+dhUlWsS/Mh
         Llx3Sdk+v3AwHLqpcmwp9RjijazLFrFUwQ4gRbZqpJGqqH1IFWRaXDaDVdyVT1nEmVuW
         62nncMNHNJ7KVsySM3Hp8kD8vbnS86iMvNfhv2AYzSkFpM+NGiit/Aez1+xyrtP2y56c
         AfyILxZOjf69bnwf5fypDxRf7RLLVulCn+SuPS1u9cFs0qFbCyIZqdgtO16/dx1RIM0F
         lzXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777981383; x=1778586183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uW95L79+oRSfL6rUWy9JAkaDOq8YV0W5D8GzHWw5BHo=;
        b=LlvDeqWZ3LOUSYK/+CkN0q6gDnkNxVdHakloChAskA/ra95flTUDBEpVxdkddlcnXw
         XLLkMqZb3uHBuTae7csHl9WrQAiBo0K2r6wQggS0aIkkUQtbSkFrflii3Fb7MVuULXyt
         2vfHVX6qU4Uguy6gky6lf8FWcpAtbSagnyPXJfCOke3YTj1IYgAEedxN5FPNW9a6JCIs
         bAeM5MQVlrMghKZxrNvNTwkUDTIG1Wc1qDERyIV6YYpIptb/YguJJFHsBNyWZAu++QXn
         AZqfsywihkyUVkMOArLep0jtBwPrEJOQRljt8DuocFCG6JzOIl4f85Rx12/pwdFTDL40
         8v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777981383; x=1778586183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uW95L79+oRSfL6rUWy9JAkaDOq8YV0W5D8GzHWw5BHo=;
        b=CSK2cPgFSz+3aCA1yrEtJn9tW+olvgz8EWtucXCaP8/0SvoPbodNovQbVg9siDhnpK
         Ep0vLtDk3obe7JunMWZTaLnOtxyoStdVwdc+FJDAtN4GDca944U1+gDf5WL9R16lU/VM
         SNS8U/xOPtLrPO4O7onwnLQy3z6Jnnk8dC9pSPjaGOs6UMhKQltr/XOja+CNNJNARa+m
         1AAU/l2rX+TpBFGcMJUoJnGCxqXnEBz7fv/vGhU8hn8C+eTMG6czKTBV2h/8+hk1gMts
         hACX4Lukr+MCgSnKAPzT/JZqlMUIL8uVuaqjIpmwCAgz8YDs8+aQeThZb9u7abdn3BOs
         CzOA==
X-Forwarded-Encrypted: i=1; AFNElJ/JdczG1PgRItBC5fKNoQyh0qdPjOzAWi0yVMQR+vfjX47rc3KUFsFLJ8elqkP9vrLjl/nus6+to8gDQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9pXlqUjLZUzfQ/fn0UJfNNAtSrwz+j6pnrpVsTCBysUr9LfsF
	LSpj5T0WCmGCDxU8v6CgzcbmXXKokcTm2WAFttEsy46vXCsMfwCASy/5MIxbwwGVQyj76MDt2xL
	EIFGeBMGBL1iNshEYEgwFP1dlk4ouYL8=
X-Gm-Gg: AeBDieuhyfa6hoTHMnJ8AbPOR0d4gXqw87LJTBnho0GkmUlUVBwxH6dwbCLw9n5Xkse
	ZrIbXE+RMSNECsrgzzCDy3RM+oQU684ygHty9uidMCpAZYxx0aFKg+AdJKDtxufYLiyobDIB9dX
	uDhzXK+1LlCCeQQqDxW0x7P4zyX0L97KazsT1sqsfiwI8GwCfQODlDpdjiKyGnld0TG9iYlvhbr
	4DI6NAZm+O7Sv6g7wdxvWRIJcWA7oJNhqlC8CknrPoNtzB5cHErWOsjfbw1y8fdx73EicURj8qK
	WEWzuK2rvxtfp0pjYUZ00muMpqrJ7w==
X-Received: by 2002:a05:7300:6422:b0:2f4:3a9c:819c with SMTP id
 5a478bee46e88-2f43a9c8382mr1004597eec.25.1777981382922; Tue, 05 May 2026
 04:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428114308.113253-1-clamor95@gmail.com> <20260428114308.113253-3-clamor95@gmail.com>
 <CAD++jLkU-G38xtzzfAV_otiYuM2G5NHdCdtjFjsy2AjpG22_rg@mail.gmail.com>
 <CAPVz0n3h+zWi-b-ZTLqwXR-9JNGcUgVodUgo+ywhBfK-UDQJAw@mail.gmail.com> <CAD++jLk_SojErY4gxjixzwEF3sfSownH=jBYaoPD2LeoxibhWw@mail.gmail.com>
In-Reply-To: <CAD++jLk_SojErY4gxjixzwEF3sfSownH=jBYaoPD2LeoxibhWw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 5 May 2026 14:42:51 +0300
X-Gm-Features: AVHnY4ITV9EyPZ98FbxObZvxz5c2SoAcqHGxP-Gd0GWhXxPPqB1dn3Lmq_w-bg0
Message-ID: <CAPVz0n15mgd4pJ-H1Tv8Rgr_7r0J2ycBo-3KnruoY9MnApqr+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Linus Walleij <linusw@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 5 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:39=
 Linus Walleij <linusw@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Apr 30, 2026 at 11:46=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail=
.com> wrote:
> > =D1=87=D1=82, 30 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
12:22 Linus Walleij <linusw@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> > In you original code
> > /*
> > * This is done in the vendor tree with the commment
> > * "Duty 0x64 =3D=3D nForce 90", and no force feedback happens
> > * unless we do this.
> > */
> > if (isa->clk)
> > regmap_write(isa->map, ISA1200_HCTRL5, 0x64);
> >
> > 0x64 is actually some conversion of duty cycle, you got this accurately=
.
>
> I wonder if 0x64 =3D 100 is simply 100% duty cycle?
> So the value in this register can only be 0..100.
>

Assumption is interesting, but it is still just a guess based on
observation of a single hw configuration. For example, Samsung Galaxy
Tab 10.1 (GT-P7501) passes 133 (0x85) into duty register.

> Yours,
> Linus Walleij
