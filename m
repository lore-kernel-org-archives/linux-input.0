Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A43B0584
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573375; cv=none; b=raTB55GIJycJ2CrtRp8pPVHjQNyGUD8iCRucgjtQegGbIz5MQRrzQ1ZC9pz7feK4fy4N9DiRboE/xNKL1QZllu0P2gTuOcE087trvW25OOqRhI8ttxkOro/rBK7jurrQUzDqp/FuTkBxVRKOFRqZvqcrm4HjXU0BUSOQ2rb24Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573375; c=relaxed/simple;
	bh=sLOAPCgamWe5dUzceRoWlkyLurqi25tTAPBLcoKdD0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTtX6ZVZz08dQnOfFhJZWHLX4LCrzUzuRd2oUaGFSXVZYStnil8iK0Zs20H3dRp6Vvpo7PT34qTR+SGDzNAWEr9vcEzBwGwxJ4C2mjuvKR4n3CdgfxEprCOjEAbVFRR28pZRHZCsQc1LRBHEcGF99W8NiHq03BZgas5Tej9ppnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJH2a/bz; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJH2a/bz"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33e6279a1d7so45127eec.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 12:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791573373; x=1792178173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0bY4AgXSvP8hqipveJnkvyGML0b46h1xg59dJBanoB8=;
        b=TJH2a/bzgHrxYXnqA9Ues5WjFn+ctabp5gbJ0OurVR1HTZ4htP0fSsFD7mDPBniel2
         xhjsLHZvM4DFPrA5J4CtkeXl0F526CO1b4BZU2ziC7ymzhqXR7Fc+Vb+76NliwWWwWSX
         bAU2GKBEISYCPWCEBo5qVTa1pZ1cS+66VZxgGVGo9Y7ljfTqkcFYK5gVc2uhwiPY+PoT
         x+PMSogRBjxjvaIbs11EF71Qo16RPXYaqR9/nTWBlAoxPcqkEsCY9CHeMO01b+1YvBOU
         kv/3w9lAPlskNOk9W5K+8IaVjoY8pZipb/lr9c/nLQsnlVPEXR2bTi4IrzgW45fWH13X
         QCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791573373; x=1792178173;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bY4AgXSvP8hqipveJnkvyGML0b46h1xg59dJBanoB8=;
        b=mNpICK+D8qJge8FC4cbqFbrzCyn/+UYTx1awSAJpinGC+MMi+JdGC+Fo/65fhEBfzb
         z3wxdmS7Ku3QyUGfbB8prs7l4Br4tvKTYgHtqvLiGCRKmxJ7jBmdwyTW4sM/iBWEOrik
         WK7ZHAUqDb9mc4irabeDubN444kFiV0X4ye32bZ+bNDm0AICOvx5iL1K7hvPBw/0i5Nq
         omMI4tSZQtUtwJxxz1l/EeTEXetAD5Vlh6fFpiPJiU+hysMQs9uNSvhbXlDAWSAgGpgs
         9XVQLBf3fMRS3afKyzNFQkazLuc9RAqCXrmvUp/sJtM9YccgGLyEtYby4zXdKuqsCFQd
         Bfbw==
X-Gm-Message-State: AFq9FYIougbUxkI3OntKR+TC5VK2eVS62NJr87MWtuSWUb1jF2RXun/d
	GtL1CKnDzxOSKfBzkY3T9i6A+vn30mUefMjiMabIitXt8ityXB+9G6psVz8C+1wY
X-Gm-Gg: AYBFou0K38QyLEDrr09BO8bd9lf5w42An0OzWc3s9pg6NzzL2w/Ydg8Mgys2wvoD918
	mZj/+9R2I+eA80o6DLXBSpOoQARFeFjUP3YvPAdq6Hhbve1o5bBVVhWTaGRIGsFkscUi3uHbCQo
	WzINs4Otr8oWNfQZpTRO7+xYE3/du59Nu5onVJWRWUEb3dnhZKqG3HR2FS8TuNwnHxNE/11Swlq
	6EmB7wgCmVZQnEzRNBy1LBCeRtwtOXxIBTDQsreqmRp9W9wqjmpfxlnK2j4x1woPthOULfpz+9v
	6v3Znni7liI/7lyrGWqnv+0g77DfgSrdpheoZD528shmamLsKqZE+HPLMtejthpTGKfGudD/Gow
	MHZrpZu3hSP/LXv47hsK6kapcw0OJEqDmITWXpHc3dW135OUIuRcvDIqZM5qXUzQ9uNPouiprFI
	zmX5T4WxdkwYZ2SUCLgs6BnCE7RbHWvN6Uw+WqnxAhCHW3oOiuRpIMV+ipnXyvZH/A72nJDdiRa
	8UEZt8utdxIuT3HXsV4RVhGtvWzytlDO1HuKABCDfcWTmOfzQ==
X-Received: by 2002:a05:7301:490e:b0:354:e37d:abb2 with SMTP id 5a478bee46e88-354e37daceemr2237247eec.36.1791573373344;
        Fri, 09 Oct 2026 12:16:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8725:99de:769c:1fe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm8116206eec.21.2026.10.09.12.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:16:12 -0700 (PDT)
Date: Fri, 9 Oct 2026 12:16:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: krisfur@proton.me
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - add support for Corsair Novablade Pro
Message-ID: <ask9bQQVgLhPSSRu@google.com>
References: <20261009-xpad-corsair-novablade-v1-1-e58746bef99f@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-xpad-corsair-novablade-v1-1-e58746bef99f@proton.me>

On Fri, Oct 09, 2026 at 03:47:10PM +0100, Krzysztof Furman via B4 Relay wrote:
> From: Krzysztof Furman <krisfur@proton.me>
> 
> Add device IDs for the Corsair Novablade Pro leverless fight controller
> in both wired (0x2b1f) and 2.4 GHz receiver (0x2b2b) modes, and add
> Corsair's vendor ID to the Xbox 360 vendor match list.
> 
> Outside of its PS4/PS5 modes the controller uses the Xbox 360 protocol
> (vendor-specific class, subclass 93, protocol 1) on interface 0, which
> xpad does not currently bind, so no gamepad device is created. The
> PS4/PS5 modes present a standard HID gamepad and already work with
> hid-generic.
> 
> Tested on 7.2.5 with the 2.4 GHz receiver and wired.
> 
> Assisted-by: Claude Opus 5.5
> Signed-off-by: Krzysztof Furman <krisfur@proton.me>

Applied, thank you.

-- 
Dmitry
