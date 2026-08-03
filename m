Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2B2D8DCA
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720080; cv=none; b=LXORN6qZ378/C5MqydRgB4reh7a04dquinsfdWJWnv1fx2adaCaO++zE4OqED1FUyaTQ/EOBKKv6KtdHdyABbbiS3s78uIFkHPwWEbqrELdiawznO+cGRAz3pKd9/PV2aED7dz/loAA4Kr3ynPFK1TFdb4p8YF7PxKxFwlMDG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720080; c=relaxed/simple;
	bh=n1iRWpPrOSxNBHjUH3iEATnDjKXHvsXa3jkCQGw5dnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPanGx97tU6ZHhaC4Qujz3ybTnkyaWd4DNPfcHZXF32Xi465jaFvSgj7cr/SC7wqKlS2bhPaJVDiFwNn7OZJRCTUz45NORyfXv87wh0oJenrL82vxenuC0LYC45/FqbFF5KuBkI8Fwulfg2EgfhVBk8uxA16Qbx2f2wYOQ3wcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwtRccSv; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwtRccSv"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so1630198a12.0
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 18:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785720078; x=1786324878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EB+Sf7A5NBTxTQVwVMz+Qt7MnzNb9v/SfkfGEW20/OM=;
        b=cwtRccSvfdU+N3Oo93HWLZcLkFE7L3wgaMO5JV2OsUyOgudfBjNiX5eKYytM3dBw6a
         8cxm7OgsY9IRbCSVghfye4jpONOxp5eaWjxsQAZErduSwaRcOBjHkklE+gDUGBAjTJWh
         b88imC58AWlGWIrRNIuHaEQJJ+GOjHCHOVzVX9px2CQVIJ5flZVtVoVxBSeCSKGCllPd
         TUCjWY/6lmsx+jeFkYYvFMHYDxhHMB3VvSMdL1P1OPZtCdRZtFItHPfn2DUNZHtSjsBY
         OhDm07Mg81YEaOBZOdHhXZtxLfrlGPPfKlPfEMvmtpkVAfZew2ZGrWpkP5xvjx8E5Osc
         wz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785720078; x=1786324878;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EB+Sf7A5NBTxTQVwVMz+Qt7MnzNb9v/SfkfGEW20/OM=;
        b=QA4zWJGf0E5DFlKtuZRvRavQ56acFQHKNV4CbrjBSAtHBNns7RN670NnX8i/K4dgQC
         1vg7Ap2+w4BTf6uKhJnvrlGsNFEdNk+9lPwtXW4OiSI51TDSw9o9mOvmNjRqBNwUuPyJ
         nUAAm3Y3psUxK+PrPNzrmoWdJ6ocUHj7dYtOECSsacWZ2KFsPd5P8V8d9ygeTs4/NwdA
         sKBd35sBSOOvSePctJMabcyjS5wzp9DOR2KHZQTdTx7NpiUo7VApdqYYH1atZaCOZqze
         Onne9FHbh9eIKN2RbOpWzvV4VkZV/7/E50LqxeV5BPljpKYwaFodGk3pFxMfuYMy/hyG
         u0DQ==
X-Gm-Message-State: AOJu0YzK0GtH0R9Soy93kKNKXDukHo/718V5GYil0Fn1DoWRF28yupd/
	dTs8XpDtgl97XOMuQ2wreJXTFalqklgMJnqPTeBq6qPLK/p6MOC1uePj
X-Gm-Gg: AR+sD117WVr6+LxR77jZSgAEsl+7P+8+1ALdtGGEpXWJaoZv3ZXy2PtBs95sj9mOOxu
	0gWiySHpezPi0ip9hx0niZpL+8vwnGGw3F4JIst88W2uBvZ6eQZfVz6bUVwWq3DDCZuLkVvx2Du
	R+Q1b3SNeHamFd2ERWCae8HH/+P+J0vaTUeuzruvbAlCZTnovnFR7ma3mltMAZQgXDxEikXbI3e
	qNXR5u1vetQGIsY6ESKuv3QYgD/Bq8e0EJ5jcHB/oKJTxDe3bJdhC4OwOVnrH4vPwnaKe9CH10K
	IlSvtbJiAypJ8B7Wm22vGUGUShJ74uL88J/h+lCp+Ehbrt6RbpGXMWUhecFLpfEjV7ttol2nl9i
	kg4YH0DMB3w2FupBHukFW6GGlkm4nlXgtg1U2CACdPaG7Ycn9HF0oMsW8WH7RVCDYcROA8vUCTA
	Uw+jDm4c5ECSPJY05GFv6xWvpQoZxXlWWuaL6HL2aQ2U8alh+cQKv8LplQa4kRAjXXO48XvmB7H
	4uDej8B14jLyUElgxLKBVa27lXvug==
X-Received: by 2002:a05:6a21:3417:b0:3b3:ccd0:cf62 with SMTP id adf61e73a8af0-3c91a9ebf03mr10263879637.36.1785720078330;
        Sun, 02 Aug 2026 18:21:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e5b0sm29939315eec.1.2026.08.02.18.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 18:21:17 -0700 (PDT)
Date: Sun, 2 Aug 2026 18:21:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Richard Davies <richard@arachsys.com>
Cc: linux-input@vger.kernel.org, 
	Mathias Gottschlag <mgottschlag@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: focaltech - fix array out-of-bounds in
 focaltech_process_rel_packet
Message-ID: <am_s-KBWozJzlcWD@google.com>
References: <20260701190932.14960-1-richard@arachsys.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701190932.14960-1-richard@arachsys.com>

On Wed, Jul 01, 2026 at 08:09:32PM +0100, Richard Davies wrote:
> Make finger2 (and also finger1) unsigned, so that if the finger index in
> the packet is 0 then subtracting 1 creates an array index which overflows
> above the existing check for FOC_MAX_FINGERS, as the existing comment says
> it should, instead of writing to state->fingers[-1].
> 
> Fixes: 05be1d079ec0 ("Input: psmouse - support for the FocalTech PS/2 protocol extensions")
> Signed-off-by: Richard Davies <richard@arachsys.com>

Applied, thank you. Sorry for the delay.

-- 
Dmitry
