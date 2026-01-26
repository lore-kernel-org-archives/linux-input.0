Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8292279355;
	Mon, 26 Jan 2026 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437840; cv=none; b=elN2rX4aC2k7nrjqajG4Y8ykGpYnCOybIiJaRozwHVJ2J3SvfYetsOUDYo+qQfs9qhvzKzw72HcILPmUWeNat9zmtHIHuNfOopK9/YE8XFVv0SGsVqkxwjHa5rfSJ9jChOyKozpF66aJynhcP/DFhdfNOkM2EY/foUL1TxNZ3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437840; c=relaxed/simple;
	bh=LuqNNRiiHfLE7d5JF1NVNI/inGMQMTeL1hDDkio1Ces=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QrcJps1M/mVqCmGXmi51syVWBjxSkT5dc8KsBMsUU2tNok6fUpAy2lMC5m7c/wdswEGlKKKtNtRHRQ5jftAda2usGSv8ZLGtf+zbiWLC1IdETRiZ2wQpJCpZNsWTAMHAnl7D1B/jG9op1wU44xq28fiHRa9mwgs8J97L+QoZZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMDX0oXS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMDX0oXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769437839; x=1800973839;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=LuqNNRiiHfLE7d5JF1NVNI/inGMQMTeL1hDDkio1Ces=;
  b=ZMDX0oXSOxuJYtKOHAAwJhmuVGlY4ADgWLWKE0fNGUidp7h8j+1POarF
   dsX25ZV/jRD6yRSq4ZPJ4Iy9RncoWz3SGW+6F5e+AFr+dvbOl3D6uidKl
   VFiA7uPhVN1JAHeak4i7KpguqJBcpMagiMFogwJq1UTZ39Mke2MkBEGTy
   VGzaSgShd3VN88G59q27+Rs93gOcC7nNbQ1KQFXkd5x3mH7n61/4BOQ1g
   xOrIonh2UNpwn7R8eOaUMw0HPfvPGexyz2NX0fGsWrglKMavAi2E3bKf+
   9d2bOa82dJ2IoBMVhavH0zILP077aY3A58glBQB0RaRp/Aih7/ooWn+Wg
   w==;
X-CSE-ConnectionGUID: gtmTfVvHTU6mvA9gAUaD/g==
X-CSE-MsgGUID: TzZcnymrRfug0lAr31Xv6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="74457886"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="74457886"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:30:39 -0800
X-CSE-ConnectionGUID: 3vn4jibRR8iMdIgIRf3SlA==
X-CSE-MsgGUID: Bmy20F0oTkSkSThfbPotMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="207748690"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.150])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:30:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, 
 Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>, 
 Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20260122075044.5070-1-lkml@antheas.dev>
References: <20260122075044.5070-1-lkml@antheas.dev>
Subject: Re: [PATCH v12 00/11] HID: asus: Fix ASUS ROG Laptop's Keyboard
 backlight handling
Message-Id: <176943783022.10029.7795048356126813573.b4-ty@linux.intel.com>
Date: Mon, 26 Jan 2026 16:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 22 Jan 2026 08:50:33 +0100, Antheas Kapenekakis wrote:

> This is a two part series which does the following:
>   - Clean-up init sequence
>   - Unify backlight handling to happen under asus-wmi so that all Aura
>     devices have synced brightness controls and the backlight button works
>     properly when it is on a USB laptop keyboard instead of one w/ WMI.
> 
> For more context, see cover letter of V1. Since V5, I removed some patches
> to make this easier to merge.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[01/11] HID: asus: simplify RGB init sequence
        commit: 0cd98ed97f1cab77822f0afea2bd4dabadd12a8b
[02/11] HID: asus: initialize additional endpoints only for certain devices
        commit: 3415a1beb3d876769e476cae2085bedb6b94da35
[03/11] HID: asus: use same report_id in response
        commit: 629771528f76df2e6d8b1d5b9297a0c95b317676
[04/11] HID: asus: fortify keyboard handshake
        commit: a96ec7a12e41a3f37784f3f69396facc659ec2d4
[05/11] HID: asus: move vendor initialization to probe
        commit: 8baca948f6aad8866b4722f527d01bb4d4e22b6f
[06/11] HID: asus: early return for ROG devices
        commit: ee1de467511811c71075e5750785d3c95cf45c5f
[07/11] platform/x86: asus-wmi: Add support for multiple kbd led handlers
        commit: efdcbec427f15e6514388c27cf5599604c95b788
[08/11] HID: asus: listen to the asus-wmi brightness device instead of creating one
        commit: ba374d424cdd3050d2e1864e7b18393cf3a4d06f
[09/11] platform/x86: asus-wmi: remove unused keyboard backlight quirk
        commit: d384a3994712ddaec10ae37549c6f0b1a10e7b98
[10/11] platform/x86: asus-wmi: add keyboard brightness event handler
        commit: f9a21738c6993c6720b8b82a7ead644a74497487
[11/11] HID: asus: add support for the asus-wmi brightness handler
        commit: 4884d4795a5ce8077bbb5b97e4c2fd51e312087f

--
 i.

