Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C63D47B5
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918710; cv=none; b=WgttY1/BL9cNt0C27jyUcdXDx45XkbopHREz9oV/CFfmmPzofQxSpBkydMg4rJAsMbYHUozI9Ygprg9kD6GlxBTZrAONM3WCu7jyZ/Cq9VAsYJZ9FxIDx3yCZjzouGmrgYeB2ktWZQ3OCyjX2suVqHbZ8XUsmuI64b2XWPPBBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918710; c=relaxed/simple;
	bh=g7/k4uisB3yiRQCJKrGol/lrSc+9m+nkgTGpTG9dJqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZDs3sLprpp5wqZjLnupgkIoGeYijETUxY5o1PLxGiv6oY4gEbuvS0bWFjEbdNGjvJU23cc6iUCa3Xo3qpsN49lKpfJ4evK3VIZ6y53GzNWqG1vdadN3pWcyjE6Zv2ht2YW4rCooVt2jTi+MtrlQzittc5KaMeCh4oMLoACPNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsgpn7Yt; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsgpn7Yt"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-466beee35bdso888676fac.3
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 05:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787918689; x=1788523489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lWqQxoK7O394GAzySBcQeCr6jt4vv9YmvdIACmdtGGM=;
        b=Xsgpn7YtNYvW1F1t+i+s/PdkQ27wofqFDAPjvgqNsdY/+Jc/MUoI4D8X+zVj/3rR4u
         kjI2uNCqvK2HI1YYbTAwUyuEkJDXU5kX9cyyIHUpliA4ym8WAMdTi0qZll4c//piBoBd
         Cuq/4GoK/OA18D8D7E7eVgt7OHjXqwiTyL+QxGexhIZ51eSDCbrosszVNzol67MibKmy
         X6e81LpnDCdYZZb8MESf/Cm9i/GR2VEsI/Ty9Rmmm/Q9Db2ig+x2fouec7W7hdwUCZF7
         YUwPsyvWVZdusOF354K0S2wyhzUNgG3s3y2Si+1YMMT6WdSVE7B4xjRLOUH60cYJRNPl
         QPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787918689; x=1788523489;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWqQxoK7O394GAzySBcQeCr6jt4vv9YmvdIACmdtGGM=;
        b=MYCyColP+UXaAF/YMyclnv8zb7oZToURtTOD0lGvc6K9+DeYjxOXK0ko5bAJ0OJxAS
         qj+mM/FTb1M7Q5YQx6qjWYtQ9QS8GHzTFzeY6MOZLwOepymGa+HnJKO26VhJfE7fIrA8
         Q2VgbiezN0syfsB3jaPUV0Pz4mxHQkGFeHEIMXesZIAM6JYKxi2r9GJST+3aXekgvNxR
         JlTCEW/hdlZVmwDDsGleh3ZD9JZPwrHR7jQVEffUGhTzTdYKlVB9K84M64+T8We9bUiF
         aCMcMNwTjTOmDoGmCeJ5czxig1n2hSQgoavO1lmMeoPMC5fPZjlrhPCXXPD/sdwwMBJw
         yZ8w==
X-Forwarded-Encrypted: i=1; AHgh+Rps99ynU1d3+uTrGURYeaQlWVO2hTV8LrNBMoFTY0qvB3NXbpVvVsK7FBQSZj9EYky6h2guUvM/+YkM3w==@vger.kernel.org
X-Gm-Message-State: AFuF++lAJeJvJJZXaYLbARNvRrflpcFhB82M6um5Hd9EJRF7RrxCqsqh
	A70OgZYg56nRpt4hMmSYqAJrtW01ffRNhDlMEzL/HONHPyfvPu0xroqK
X-Gm-Gg: AR+sD11tMZfXkjneaSAnRnSYd2nyfJ8IoeXc/wBa1b6Ibr7evYa/+N+QCXDl4HCGGt2
	fe2gW2TBW2q1Rjq7BuTJFOABM7CxYNmsBU4VcgGZ2yooL5+T4x924FTMcda00VSvqNAezJU9nGC
	qPsU2IhijKx9GY2RvJE32Jk12OMV/V/JlJvuQxOqpPyC9AwprLOXBDu9Xag27rR5VB+edsVgT58
	akWqWpq7MukcGFXwT6ZOdoXAI5bBNhpBzAk0qE2GCPUjP1IpuxwH58nXRW4uL6bWS2rEKum9Flw
	mCT2abZp3gx5CUAjZBgyaTw1c7rR7OZ/OR/5I8xVF876m3VGcJnRFSSumDjaSMCMKPTNKwbjSXd
	Dq48jYQ38X/K8P/h7NqVm98/uc6I+6uPtEDMum04bq01PVWghnggay9tFOO4nrhlMm29WEfva4s
	VngYztb49bHuLvqhBgdvs3DoZN9j8OA1iwvs0A/4fOdCcbQjcg5hcLlgO0X1g6bndrGt37hkslb
	qyzUL/U5mqtKD6sB+CG3Hute2Hd+w==
X-Received: by 2002:a4a:e7c8:0:b0:6ac:8e23:3078 with SMTP id 006d021491bc7-6b1c6422a9bmr4115615eaf.5.1787918689511;
        Fri, 28 Aug 2026 05:04:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:590d:7e37:c87d:136d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f8095bcsm5559760eec.12.2026.08.28.05.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:04:48 -0700 (PDT)
Date: Fri, 28 Aug 2026 05:04:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexei Turtanov <9alexei9@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro
 16 2026
Message-ID: <apF5WFQU9LPM2lYL@google.com>
References: <20260828112239.18081-1-9alexei9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828112239.18081-1-9alexei9@gmail.com>

On Fri, Aug 28, 2026 at 02:22:39PM +0300, Alexei Turtanov wrote:
> The internal keyboard of the Xiaomi Redmi Book Pro 16 2026 (board TM2425)
> does not work: atkbd_probe() succeeds and every command is ACKed, but no
> scancodes ever arrive afterwards.
> 
> Testing on the hardware through serio_raw shows that ATKBD_CMD_RESET_DIS
> (0xF5) is the culprit. After 0xF5 the embedded controller keeps ACKing
> commands but stops delivering scancodes, and neither ATKBD_CMD_ENABLE
> (0xF4) nor ATKBD_CMD_RESET_BAT (0xFF) bring them back. Only re-enabling
> the keyboard interface at the controller level (i8042 command 0xAE, or
> rewriting the command byte as i8042_port_close() does) revives it.
> Running the init sequence without 0xF5 (0xED 0x00, 0xF3 0x00, 0xF4)
> keeps the keyboard working.
> 
> 'i8042.dumbkbd=1' also works around this, but then the driver never
> writes to the keyboard and the LEDs cannot be controlled. Use the
> existing atkbd_deactivate_fixup quirk instead, as done for the sibling
> TM2424 by commit 3a046db33bb9 ("Input: atkbd - skip deactivate for
> Xiaomi Book Pro 14's internal keyboard"). Tested on v7.2: keyboard,
> Caps Lock LED and s2idle suspend/resume all work.
> 
> DMI: XIAOMI REDMI Book Pro 16 2026/TM2425, BIOS RMAPT6B0P0909 05/22/2026
> 
> Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexei Turtanov <9alexei9@gmail.com>

Applied, thank you.

-- 
Dmitry
