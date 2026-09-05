Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772838238A
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621760; cv=none; b=jmCt1oGeAYOz9nW8/MgmOWNzneW/gr89PGoogJhkh1PG9HXc7qeikBCXgd5CeN97fRkYfELt8xOx7KQ6yM5wtWrB2dYrOcsdFPWxik76gxda+ORG5+qm7Y9owT4N71Vw/pQIpoO00IWmt2c1BhC6AVPAxEC7pYBTxE0WqsKOHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621760; c=relaxed/simple;
	bh=stE75XH+VoyliaLEVzRsIQuDTfaIfORb7fDDrzhIzIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtZWt0VwMKvGPEACs6ZlQMzvOnFQvbzrAElBSMPvUk3oTzRchDb8/+wloyYj+TIoVD89RzTi2ezTkx8tvr7mUCtXBlw45qQZtzaWuEzkPNdSC6dEv0V2WOVEISU836SWiV0ArULLlX6Ij8psbfoFjE2te1Al3T2bw/g5KmCD73I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8VBuZdB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8VBuZdB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso18035405e9.0
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621756; x=1789226556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xiwfJ3u464HVWwKQuOirA1XlcYzmmwiUzq3bDqr5FyA=;
        b=R8VBuZdByeAmOt2hgeiAFGbVlzYgkzSSgERPwbBPl7cKgG7HsAyE6M7wK8FxgaTYDA
         jnP+A+T1Q6ZI+Bo4qeibVLWDiR06l1YcNMjWu2BYr7VrQfI5ucQnodCaZfkn8hspCTgd
         xCMer0DSJqBa8O0qupacAgvtYunxyUJjL4rIi+wrpTWGYeK5dp6zqe60eXADpuTwfQ/t
         /87fOBp5cbjOPlen9dN8IxYE4/A6hx0uqYR6wiE6AVuPHlFBEhiJiB4zNbKn6T2B0bcH
         NNdHWzuUKhMn33Nyu7ZyUhAZJTBLlPivctwY6668dsBNKyxoD5AohDNaYLPCggO15xHC
         3ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621756; x=1789226556;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xiwfJ3u464HVWwKQuOirA1XlcYzmmwiUzq3bDqr5FyA=;
        b=FyrExNfxZVqGDds7oeQhbW2frXP7biuW2WXkCZG9F8UBlY3TXXd8UnhoizOqjObh0O
         IoRfy1cbaZrqfEsN0rAAFIe4dOeuG5qxSoWB4OCQmYZ42XsWuCpxER6yak+xaGWmytmF
         g/LtYAUzVjmNlPTYI+m4lgJX3HvPGZvn8Nk4Bu4psk4GSV0fXe3Z4gN7LP+9QYWSeicV
         JL16tmtYm+uTJSZMPRAZf+tlHmt99QirKpjIWGy8WFjNyBYSdyGLSy/Ni2r7LhU/0Ne5
         +3s/0emwsvFSVJ3Lb4vsvq8dhtlgk9Nejdx73XlYTb6j7F1c0VlQgoJ/DIb2UiniY1DF
         eKZw==
X-Forwarded-Encrypted: i=1; AKwUvBzyfU20RTpI4kZQhNicQ2gaXixuW6m4F0kDIb3TppwqO/Dy/EIa2NtdFEUyC7XRRCNOUwgAuiRAtT3uRw==@vger.kernel.org
X-Gm-Message-State: AFuF++l7GUXsJo2SP8hRtNcXTVyB2ic6o1UZ6ZSFsboz/yBiuiw73WJc
	TN2I1oBX9mzldGH0X8xLvgB/b/VjL6G3CgGveLBvyc5JfSFdcMqaPA2b
X-Gm-Gg: AYBFou0KcJtffgFmleLJgEsJN7LHFtCYrc/42D6IYtugbx5eo13zZfBR5N0keGjVxqn
	KXHPeCOGHk4WWZHRXkRm0nOrktHR0gjCD3/qEV4bqiASRO6b01wdcmVJjaR+SyGLtsH4XepBcK+
	KqfiIOWTWKi2EiWjCQuRl06ru0ILcOoaDvZf5xHwXt5DdW8579Wav9mS2B5M3eagBl0uVBqD+cP
	KOKa6op1s7xQI8vpxGIDGLH2mnHLnj41IhZLaeJPCL4pN3z9YPC6KgjtefGKuIjUWwAAdFN9f/n
	wH6S9BCBsTy+dz4sfzSzOTMnNHuA3o3mVOEomYQmQ5XQOdQbyx7zCsLPQpvSd9U5I01cTZw6ujx
	vUJDK3P+ErksgP5ndBLAyF/NDZx7yY7DClhNy7yf96bAO9iliee2FowZ6tnnFQLnsbU4fTaHLi0
	n3WABzoxKavsS6kIBPccnP8E6//aw5RgAB8Px73vsSf8MkMN3Tg8w9SbNyuvN5yzigzx991d8nz
	SQ0cX501gj6rbTJcD6GuXcbm28kd8DY3sbg0a2g38w7dq7ePjSHl/UtYpRxRndPVaRkcC8INhPi
	Z57L2JVo/287q529rz4kIOuCsNgySPcNTKyv25psh+ELNCDmxuIpYQiC25C5H7q2
X-Received: by 2002:a05:600c:6303:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49cf82cbab5mr112017265e9.6.1788621756075;
        Sat, 05 Sep 2026 08:22:36 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5952560sm246185335e9.3.2026.09.05.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:22:35 -0700 (PDT)
Date: Sat, 5 Sep 2026 17:22:33 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Mike Travis <mike.travis@hpe.com>, 
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, 
	Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org, 
	Dominik Brodowski <linux@dominikbrodowski.net>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Michael Schmitz <schmitzmic@gmail.com>, 
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 3/9] docs: kernel-parameters: Drop the edac_report=
 entry
Message-ID: <apwzmSr6b0WEkW86@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <20260905094649.41996-4-kmehltretter@gmail.com>
 <20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>

On Sat, Sep 05, 2026 at 08:13:45AM +0100, Borislav Petkov wrote:
> On Sat, Sep 05, 2026 at 11:46:43AM +0200, Karl Mehltretter wrote:
> > edac_report= went away with commit fee27d7d9788 ("EDAC: Delete
> > edac_stub.c"); nothing parses it any more.
> 
> Nope, it was:
> 
> 7fc0b9b995f2 ("EDAC: Drop the EDAC report status checks")
> 

Good catch! I will send a v3.

Thanks,
Karl
