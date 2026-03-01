Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5C26ED59
	for <linux-input@vger.kernel.org>; Sun,  1 Mar 2026 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772332010; cv=none; b=d37P3AgcNb1TsL1mTlTdH9xLhOWGjtLNbsKU7Yo+71aV23q/touCIu/ob1Gkr81hrNpoukITH7kfq4hug6//AniL3uimxiBtEC85GAuk3Jf3yTEXdHfLOLMgF7E25NVXksh+WxOEAKuvNHaZs6/CLA9Hoh63czUxAOqnXq4Uznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772332010; c=relaxed/simple;
	bh=nqwUqgxwJJ/yN+GalM6cyfx43HJVOxHb5q+Fv5inTEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiSZG5RVYg4TqYo8/BAtsqvysS3COW3g2gLFzNeVEJciuC/0NTUAwx3wcISYO8nnVD/+C50k3SNOLiOayfxLN9y+W0tJOhbcL97eT9I0pTgkMsmPUnbl4FkqGXlFQQPwq98oD/3zIw3A+XWgryFC5GmF5HjoeIFgDknFPqE6LrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCBk4D3S; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCBk4D3S"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdecd00ebdso4224554eec.0
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 18:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772332008; x=1772936808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JS8GHSNEpRdWIh926KehVaPDhrhy21AYTD/lvFwjhHA=;
        b=hCBk4D3SyUVXrlsgSHyrxdZj0jl2y1D0WKPWjt+qm0N7VBXy5ktufjfeCseLmbK5Gc
         64aw2/rDqbqDONaKmY/U2JP3dt4DYtIfzDWUct+jUj4uc143qBfk7aZRxVcdB2CHMkJI
         Hz5l1QfD4cvXUSZmo+NPSRHEqwZtVlMeIslMznLoPWlVyCsjFbYto+sIKJweB+sHEqJq
         9R9wvM1EGUh43+OCIAOm1mrqYLy2e+MegY+lTpRA2YBOXBBDsEx7sLZ8IrPxTizwS8oi
         kVbyMY1SCATCyauZJkfogXRLVvs/BXPmIwPv4vwp3XvIlQRGrB7CbqzWJWh0RaL/aHJ5
         ZmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772332008; x=1772936808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JS8GHSNEpRdWIh926KehVaPDhrhy21AYTD/lvFwjhHA=;
        b=QyVJUag21+UyacjUOoSE2kr/LhhlQvRa2HpQ/cOlltwdhukjpoW4qwVuUQcMovxr2r
         7GBOdMIv/S5XqhBIlr4UR43BfC52yNGm13l+BmDJFOjImbKlxXmtcFIpiwQ5cSkEeU/f
         ipII1lwya36hRJyJZ7PArRqKH1ilj2kDCWZIB75bJWZCsxqRdSqkDxjb4mfsL6/7I0T7
         HCg/uynK3mUluCiA925KhSGB+zMX4yp9zdATOHtdO7wXPzuugQDCOm46kJO5uzRWziTe
         iiDQQvZnM+CnH2J+iultzHUz3sbzj3h3lqwfGd9F99x7tKkSx1JVjYz+FtZauDxionVW
         ylHQ==
X-Gm-Message-State: AOJu0YxdzloCj7dcBEfa6b2vO2BWwsJl+d4H7J3iihASz0LosM8NyZda
	2mVm81dUwCcBZmmmUxgpdiEdplSnKBAtdFuXZePXjDGOvwxTxfvJgomN
X-Gm-Gg: ATEYQzzQM3u2L4LektZ2DIiqlFJcDYsJ1zaetLfQX901P3SrAj78qJvSZFDT0BsVs2F
	22gSHDpwPThnAFDTs0ri/zamFenM8oskrppG9WMx84xQcHyeCAJrCKSxHL8D5gvsEIR9q6Jr8mM
	LqwkwG4mCJ3rjz7YRNqh/GvQVAGuCYIvrNXpP5OYDDYeZRSHsDCSFE05BF3kvhvjYum7hykBoHa
	AM+Px0SPiC9AL0WVoyOVFXE65iGjdByzwczj9iY8yXMCvfY4No5SEDq+hj0X4RF5KOsldL/TBQL
	3U+pv5mm06gqoC0tXpFlP6c29uSQC7XVhBk+UESbUlOqmv2bbGrHX4undAMQkOLaGsNdiLlYImi
	n8pemiNvD6suWM1E91Sr8GERkbN9Jw6O2GGTtRBpdfAj2nSjE7bLPbWShLsySjm5EenatccP+k4
	ILldeBF03UNNpnXyrXlF6LGq/ceffTgGH1X7wvwpLpyaDjnBS+nGqw4nJXWaFvOzcW
X-Received: by 2002:a05:7300:2325:b0:2b8:66f3:2502 with SMTP id 5a478bee46e88-2bde1c0e786mr3671982eec.1.1772332007745;
        Sat, 28 Feb 2026 18:26:47 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:cf71:43a0:f3f6:e5be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f48c77sm7521132eec.26.2026.02.28.18.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 18:26:47 -0800 (PST)
Date: Sat, 28 Feb 2026 18:26:31 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ariel Silver <arielsilver77@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH] Input: atkbd - validate scancode in firmware
 keymap entries
Message-ID: <aaOjvcvit1uo4HtU@google.com>
References: <CACKMdfnPQoBnEhP0oCe1gXCYzJYyWBJsgHCHiMOn37XYYLAkVg@mail.gmail.com>
 <aZkYbKNxGohck2sq@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZkYbKNxGohck2sq@google.com>

On Fri, Feb 20, 2026 at 06:33:55PM -0800, Dmitry Torokhov wrote:
> Hi Ariel,
> 
> On Fri, Feb 20, 2026 at 10:44:28AM +0200, Ariel Silver wrote:
> > The SCANCODE() macro extracts a 16-bit value (0..65535) from firmware
> > device property data, but atkbd_get_keymap_from_fwnode() uses it
> > directly to index atkbd->keycode[], which only has ATKBD_KEYMAP_SIZE
> > (512) elements. A firmware-supplied scancode >= 512 causes a heap
> > out-of-bounds write that can corrupt adjacent struct atkbd fields and
> > neighboring slab objects.
> > 
> > Add a bounds check that rejects the entire firmware keymap if any entry
> > contains an out-of-range scancode, consistent with the validation
> > performed by matrix_keypad_parse_keymap() in drivers/input/matrix-keymap.c
> > for the same "linux,keymap" property format. When rejected, the driver
> > falls back to the default keycode table.
> > 
> > Fixes: 9d17ad2369dc ("Input: atkbd - receive and use physcode->keycode
> > mapping from FW")
> > Reported-by: Ariel Silver <arielsilver77@gmail.com>
> > Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> Was it observed on real hardware or this is theoretical? I do not think
> this needs to go to stable, but otherwise I will apply it.

Queued for the next release, thank you.

-- 
Dmitry
