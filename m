Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA136CDE5;
	Mon,  9 Mar 2026 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043454; cv=none; b=jhqPD+tWIgnpn/lP5rPRzaqLQeZvpazC1sYBgZEpkBD3/Zhd39mkcPNyAAkOqsz1bRpyUlXJOtsNt9NG3Ymx5gPKxyKauJXd9yzdEGRK9eSkaSOy8EoGJg7K0YYv4uOl5cJVrohljwzcoTWFRIKX8HcCXyd2aN0zJCfXTEYmkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043454; c=relaxed/simple;
	bh=X0tGs7O6QiGQrhYYpAs9gFpBAMdmWTPYXOMZQs/6F64=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tkYTelF6P5cSAelWJSccNf7Xt76MG0nsbtXCqLIs89dq/1PCIph6KbeE2FDPFUBPc3V5TXSzXRwCRW4ajhch6BMCX3fYCsmhp08+68ECdYqAvX3ufRm0HU+czG3T36PI1rz7gfWN/Gl+eRe6Pfl/w3co0MO7Po0jzNKwW+0N3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwdPXbQp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwdPXbQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773043453; x=1804579453;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=X0tGs7O6QiGQrhYYpAs9gFpBAMdmWTPYXOMZQs/6F64=;
  b=cwdPXbQpe+6gq5ESofzLDrMFQCjRVY8dtaKJj4wmMRB/4a9HK/BJxRz2
   rO590wh8AsU3WNY3D6+KRk5CNNdg7/uTO/z0PAx4ZQ1Kq6ueD/VvPjfno
   bPOTrMPN6NzRmzS17ICCOFAF7QATvSunuUT8OwoUypq2ETUszrNBw0Ubu
   lGcAZceogq5bBVynyxcXW8+5aDWfB+RU2R5jZ/m0DSUpUfhumm2SpuOzH
   ZgrrGG8+g9apIEYvIheOP7W/epKx0ko2bOd3cculiWhEHr14bgnf+m5vN
   Gm6mOkwV31TaL0hXt4PTYNSsBlfuOjExF/XepFHoO1JIIVU7PJhoUxTNP
   Q==;
X-CSE-ConnectionGUID: Q9e1zHmsRzinjPk2w2AW8A==
X-CSE-MsgGUID: xmo4nqPxQEehP06ZFT9ubw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74105487"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74105487"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 01:04:02 -0700
X-CSE-ConnectionGUID: +L2ubFWOR3yT7PUUUDn4+A==
X-CSE-MsgGUID: wfr1KBATQeagsjDEmfx/tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224138855"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 01:03:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Mar 2026 10:03:53 +0200 (EET)
To: Vishnu Sankar <vishnuocv@gmail.com>
cc: Mark Pearson <mpearson-lenovo@squebb.ca>, dmitry.torokhov@gmail.com, 
    hmh@hmh.eng.br, Hans de Goede <hansg@kernel.org>, corbet@lwn.net, 
    derekjohn.clark@gmail.com, linux-input@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, 
    linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    vsankar@lenovo.com
Subject: Re: [PATCH v7 3/3] Documentation: thinkpad-acpi - Document
 doubletap_enable attribute
In-Reply-To: <20260209063355.491189-4-vishnuocv@gmail.com>
Message-ID: <991f8a08-7c5d-5611-7904-6c5d336a74a3@linux.intel.com>
References: <20260209063355.491189-1-vishnuocv@gmail.com> <20260209063355.491189-4-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 9 Feb 2026, Vishnu Sankar wrote:

> Document the doubletap_enable sysfs attribute for ThinkPad ACPI driver.
> 
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> ---

> +        * 1 - doubletap events are processed (default)
> +	* 0 - doubletap events are filtered out (ignored)

There's something odd in space vs tab here.

-- 
 i.

