Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10E3C2D
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785710728; cv=none; b=MDR+LXdw0FxbWHV4xq51STrJfjy/sgBPTNUWrXre1/H/0GKzHHULvjp0YDVnvECKFYYxZ4YRiFhSflyUpnneUG6fUQKYNN3piRKjFk23Omdl/mdBsTPyuP0/BCjwYnUUCzdt2ZEYEUfYcVZqm4NZSO7PWPd7cR2c+t3mrusnWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785710728; c=relaxed/simple;
	bh=kxlhhF2a11Y6I4WEXndwoZSZLtgkQ9ERaJnGW5Nxv2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbxHFsrZ1urh2V6YbiVAL5TfnFRaCadg3NA0OBsSBgOU3o7LBcH/iSAQhTNowrVAh74aDou/0opcTfbERP9It+rIWWKHAEw8ZL7qMsIxQYu0aHLVIMysM0SwPD4wGe8PwrP19ImNTPGSaWow9oEZtSTaC0XXbbaASgz2z4T3JqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsLVd/7Y; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsLVd/7Y"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9e7391839cso2432723a12.0
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 15:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785710727; x=1786315527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TG0GsILf6UTIfn5ea5o6UFhLwGhu0NROm11h9WKDNM0=;
        b=hsLVd/7Yp5vR5Jara2hmJLX/cUQDQ5v/+WaRKygSbumKl7gtKLvGAS1sIsjqx/f1Uh
         Z1pqbUfwKaHyoJ/FDLZEpmglN/oZcLdsWNRUwbbWo4uCi3bEYdeMv3d1xYDsydmLRhVj
         ITboKL/PBBO8oy3ul8Cf1f7dGBHDiUnVaOmXvFqzf5YosHAsbm+y5w3aSdIrn2WbtUfR
         OSss+RkiBU7qn5rzn7OihNw23FqsLh0sd+yT4V8BP+++McS00ox65DEPvM82qksYDIAa
         nOTfVQBqtqXzopAjxvmC2FvxbHz86MaPO/j7vDlYqrGv2ltHaqAHFyfXYB/vOwgqi4s/
         g3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785710727; x=1786315527;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TG0GsILf6UTIfn5ea5o6UFhLwGhu0NROm11h9WKDNM0=;
        b=D3fo7hKwgiROQny2an6+X933H32OLKkLWBNtJwciAK0AbV6w+dveE0jykOefzoTw3e
         7DHLwsyF+pN4IbAC3AJhKUkzq4lr0HcBYxxm9J9jHd2C4L71TJ5hkCWeVN0QsvEv8Tgw
         4xCzEFYo0nyL/jxfE9AQmN79pmhvhjPyUVbfJ6CXJXEyw3OMOXYQebE6OPs9rD1xyR1/
         N9Ui3Q1VsdF4TwaYcGz1dl0SllNm5KT4E1YXVwcggKB2+wSyFUZzVAv1in+MXyfT8myY
         ij7DhH41RlnVgG0JExjNyjK+q6/plmvWfwzPBZpn68tYEnz8XHheVzyEtkU2Pb6niygF
         IehA==
X-Gm-Message-State: AOJu0Yyo18DqK8S4WgtcqM/ymmDtpGzXwDvWteT/WWFYN0h2ebDiGfsu
	OBB/i5FpouBafyowm1D/VczWxSLPhrawDKGF7Aj90k0ZXRvRh8XPxsNieIru/w==
X-Gm-Gg: AR+sD12P5Yo3ssB+0oMIIq6ASusAVca/rCTBwdEjpnqy7UbwHjJAffKfMrGYoLBJdeI
	ZS2EbIwys7uAjk/ll3OiWU/6QBINtg23aJbiKyGG2X9ppkUsz40gMGF3aQ23IlaOkDIPnoY/64w
	Zq54Nt5mYqhiaT+4qbFmZMBxUVTkb1vsO9Y4zyIQp5vcVTgAl26TLROemPxqniV//mML/u9rXGo
	/GBP/vz5PZUmbpozXxc2VbBly1St+H2XkgwXsO0mApYEiL2lGPq+l4WoK4ujvujxoVeESXg/aS/
	xTOsWJgxWUNbV8BFUjI8HPBPLyp4yq9yLmhxoWYZm1du2dllaX7k1qVVfIRXwiM9nYJ3oQnUjDN
	VdlNMHQ2dDV4htR9T/9/2ATl644qOFSVWGwuILd0UqJWt/6UiGzxYoKLqvUZYqXFxXfR6c49CeU
	zQOTY/Y+qr989oASdC0/GgDv5WCsgBE/nv3yJTXg4tkjhd+RzUGXvgf/Fp/U/LL96rnlBuH5iu3
	1Xu1vQIsYqBDaPlURi8ki+gsCCFsvMFSMIDzeXV
X-Received: by 2002:a05:6a20:431f:b0:3b2:a809:ffe with SMTP id adf61e73a8af0-3c92a51aeb8mr6706503637.14.1785710726957;
        Sun, 02 Aug 2026 15:45:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddda5d9sm36941975eec.13.2026.08.02.15.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 15:45:26 -0700 (PDT)
Date: Sun, 2 Aug 2026 15:45:23 -0700
From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To: Donglin Lyu <DongLin_Lyu@outlook.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH v2] Input: atkbd - skip deactivate for HONOR ZQC-P
Message-ID: <am_IZaPyhE7HOgt1@google.com>
References: <20260801151115.52709-1-donglin_lyu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801151115.52709-1-donglin_lyu@outlook.com>

On Sat, Aug 01, 2026 at 03:11:30PM +0000, Donglin Lyu wrote:
> The internal keyboard on the HONOR ZQC-P (HONOR MagicBook Pro 14 2026) 
> does not work after boot.
> 
> Using the kernel command line 'i8042.dumbkbd=1' makes the keyboard 
> functional, but the CapsLock LED does not work. Adding the 
> 'atkbd_deactivate_fixup' quirk fixes the keyboard and CapsLock LED
> natively without requiring boot parameters.
> 
> DMI: HONOR ZQC-P/ZQC-P-PCB, BIOS 1.09 03/19/2026
> 
> Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
> Signed-off-by: Donglin Lyu <donglin_lyu@outlook.com>

Applied, thank you (but rearranged entries to keep HONOR entries
together).

-- 
Dmitry
