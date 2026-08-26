Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD03BF69E
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745836; cv=pass; b=Uy4LtFMvFkgK+NIE+YcTwORrrTyumIXZv2013GfBQX15GXrsLxCSD6Ox4i3Pa22yhiaPvL4yb9nE3kLfwD0ulvXNmzrZsXCmtH8Q8exAGLj7CFiB3MsfieLAX2UHACNMdle/ps9Vs0lULoDDCEOEDyzEgX6OqnVrbvu+eDSiyPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745836; c=relaxed/simple;
	bh=kqQV7FOuBNOfwsjfxs67LL/EcCSG5E3GWVr1Xi4F30E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6W3cJLwKplrovZUk7pZqVcw/vmD3OUiGg89QBllPZ7WGZNCuTv+Ll/BuA5T9BGBALnPicPd3dYR8+2Lpp859kkxkG8tIaX1tcCazZLxULj3Ut5qh/nPScqLVmgGNjs9DDcs2w/T/vIHlQ2oDi1jWNgeB6IpfhhaANPiQ/tSXoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJsSdFTU; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJsSdFTU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-482e2fdf5abso314927f8f.2
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 05:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787745833; cv=none;
        d=google.com; s=arc-20260327;
        b=B8CPx0C0/f78rF1e7/vJrtJdj8cKVX7ucEK9vQlHVStNlBLRMSCmLNmIwclPyXL44i
         nnpFFM4S1/XF7gl/eGJ2xqWyKo9vnTHY0uMdszksYMwdovwMZAgizW5GJhbhmI4QD9vK
         /eE48/sI1kYbfSCBCve4qj2e0SGulOjpWEWDoGl2Qm7K2TrpCUu2S+O7BVaEY4FK5ef9
         KfiR1GpTwzsJpvEStmuYBL9HYIHNbF/EVMVrful6T0tkCqoKvD0j4+hBuTIXBxJIS+KO
         x3bFmpBts7PJEaPXbuyrsulXIcipkXNTZjmQDlwhAFiGZuUyHAO5mE6p7XmG6VcBFce6
         82+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sZarIr+UucWyTVzB+5Hzy/ryJOKG+tI53G/aED1uVt4=;
        fh=JIkDOPD1E5kA+GgObwfD6MUxdbEgCScT3zhN8nji70o=;
        b=N2eBx08n2FRJYCW491RUCOgfnZ0plX+ORb6YQE45UXokM1BRh7yT0H7164TaKr45Ti
         7qxNvKYy5CbSowZLawa8d7NZbM5jLoN/QLfISj75pSfx0ekCk7imZSZjEs0z6NGJoyIs
         z14Qwyc4G2IlRlKVpoybesVHv4ta3xPK30Whl8cKu7RF7vgxgCK6LFXYSq2k0gtlIRNw
         UG7Y9JKhQmrvIWe6tTcIEctUTYth0Nqwq94WQxXxac20CPgWL9ueWHMjKl/NV59erk9S
         l//Tp3iUZ5Anh6vuOchUjnPdtg+Bl6s+pkT+MLjLfp6BE78SZGOlXdp87JrRGndfikYX
         H/MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787745833; x=1788350633; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZarIr+UucWyTVzB+5Hzy/ryJOKG+tI53G/aED1uVt4=;
        b=LJsSdFTUFlhSxjlwFeCaUPlDhs4gHq5PKVyPb71YXFH1Zz53gaMuyY2sM+2dA3vOvZ
         p3kbx8NX0/ms7/NUu7/mHBk5HMnTA+mJfKC5yg4W5ZuzydeLepyIgpul57bscDTJlRDw
         85S9ti9/YTMqNqrftvLqN9OZkCuTNJQDjyi/I9enoHZbLKp3paRDteTldMoU27Irb6qM
         ABFyDVGt2GZGlno1Hnmi7jKk+hYy8jdQIHYmj455cdk2cgoWOvkahDuvHACmP2p2TAXz
         hLtR1csMoD2WThlVpt3saL1Xc46tSFmeLk/5RG7LMWtx3rLp+O6YxTgLETS5afjN+v7H
         8ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745833; x=1788350633;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sZarIr+UucWyTVzB+5Hzy/ryJOKG+tI53G/aED1uVt4=;
        b=cOhIwJCHEEF74Awm0DZveMfK/Nqso8C0/Xl6vF0pbDFNo8ZjmmDhXm5fah2aiJMaSG
         PsAhFfq/bXyjQg0mk6z1Y3/8Bqb0IVOHdqzmbVoXaRFppCcdXxwFWDjQDTaunAd4l8hn
         epfVqxlNCQXlPDIyNOYLi7gCCfsQRjXjPeOninLHphqYNsv50KObM8hehO/iZcOarHal
         YYLByXYzh9Id48A1vYRRcz1z1B9kC4VzPvfTBOzldBKH852rOM0K2Y8SgvgQSaMNlQLn
         ZD598IqsuJFLGsLemJIJhwNSJx73ueJ9HxfEiZlrFuLTSsPz4AJEON5Sp9qNV1B0eUHk
         wP5w==
X-Forwarded-Encrypted: i=1; AHgh+RoskH10Z9vRFRd9ydTl9sAl34mAHI6n/apsDSCZNEribyQajjn3kOwT5xO2kkvSHyAsuPAe20ALbZx95w==@vger.kernel.org
X-Gm-Message-State: AFuF++ng0ct5fqTNxq8UhdKmQytNQmRx9eVSL2obq1CO343IDbxk1sR8
	tTj/6rYRqxk388fBXF5nLUfqDIX+4c0ON08/QsYMHcu0xXq7pic1vfXD9TVYLd+pjtgayjHsVFe
	5pwIIw0FNT/WPjvIC3SXHd+GU4hcTajQ=
X-Gm-Gg: AR+sD11g79TFs84UG3RKhRLos8vsQRSWdCetGq/iynAJTjl89Ixxj+NO4mrUiUu4UmS
	1lOlapElj8/0mNyPRyzY+8ftmR/RFYabKhYWwO6LDsQMMJkcgzKWqryQhtkNpMArpi69OupVi0W
	63veshLuzJ6e7lCuTWl5PUo8N7hWcTNyvqF8z8D1mMeDaLeOLuCtPl7Hm7UrbNI7YraEfjeHtOV
	PwGN6PbOin/OcerkXCL3KrlYc0aVJKpRlkfonoJZ04/nLce/69WTq8Yhrc7AmkPKj2br502Lx2q
	XQh/pVMp89Fw32L8X0F118wCyj1S20UCWqMB/sW343qGlaMCY32f51NEu2w+Bn/sF6Uv0ozF5Nv
	oNQ==
X-Received: by 2002:a05:6000:25ca:b0:481:3db1:a62f with SMTP id
 ffacd0b85a97d-482e270a5fbmr6535891f8f.17.1787745832819; Wed, 26 Aug 2026
 05:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822124531.644834-1-sammiee5311@gmail.com> <IA1PR11MB6098D3A31961238BCC060D83F4AE2@IA1PR11MB6098.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6098D3A31961238BCC060D83F4AE2@IA1PR11MB6098.namprd11.prod.outlook.com>
From: HyeongJun An <sammiee5311@gmail.com>
Date: Wed, 26 Aug 2026 21:03:39 +0900
X-Gm-Features: AcwNN1VYn1rMJH0uBE8WqY0o2i5MTuBv0noINf9T0z1pd6bFWRTrogWnyxecfaI
Message-ID: <CAJciObF_qN2G0RNpqO0N+DURop0Ja053QY1krfneCT0bmmv51A@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input buffer
 for the DMA
To: "Xu, Even" <even.xu@intel.com>
Cc: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 26, 2026 at 10:10 AM Xu, Even <even.xu@intel.com> wrote:
> so it's not a problem, that's why you never reproduce the issue.

Thanks for the explanation, that clears up the SWDMA side.

I had read the RxDMA2 side as a separate case, and it looks like I have
that wrong too.  input_buf is max(max_input_len, SZ_4K) at
pci-quicki2c.c:607 while THC_RXDMA2 is sized ALIGN(max_input_len,
SZ_4K), and LNL leaves qcdev->ddata NULL so the max frame size feature
is never enabled.  I had assumed that gap was reachable, but you would
know whether it can be.

Either way, please drop the patch.  Thanks for taking a look at it.
