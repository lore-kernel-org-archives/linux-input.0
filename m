Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF493033DA
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766017; cv=none; b=RjzmbyuDEKRLCwSzyguFN3lCL1soB0QN7Dl//JYpHSscRqm139Wfo5O+yiP1ChNYmEs3KvHovi6oPKANjfAhwSAe2pZNeDcpGTxeFB7iF4T+WTbOFGZb6kA+7ozI8QUSJBM1r1Ae0+6cpQlEV0ijzhTCYuScHzFbIGhumTo4yOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766017; c=relaxed/simple;
	bh=y3sgEa6gV1VOeQBRpRIICRrhtDUP7KzUX4KuD+uuuis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZFeT5x2958QJd/GrO9OeJaRHhWqkBMNQG2jy8Kgit+47IQQYHc+VmQElunCOuTSwpXigSqsGS1LwpnY8XDGZW0zXOLXhcU4807ySMvqPRIZUiVtrKwyJxfxdkamUEDpSA3LzNN+3/0/wEo2pZA1BlZmt7FJb4S/O3Ze4B4lGbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLVem4f8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLVem4f8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782766016; x=1814302016;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=y3sgEa6gV1VOeQBRpRIICRrhtDUP7KzUX4KuD+uuuis=;
  b=iLVem4f8NVz9RXWzguW3XJbLuA7YbnBK2JjqgqdZfyNsQollw7FHVMdy
   O4Q8bVzztXX+jgNHGBGa8lf7B9bGpO6fkfTdKBcxJ50tLQQytl8ku7QbK
   ahXZ5vvcPMW4vtubabcsfHY/zaIgBabeWun6rbdrgWD8k6lvfCC/eAvLw
   cy0rlb8W8Sy2q2FE7WYMbhhbG7c6lqBuY+/Flm/87ynDiXrTxsOE4U155
   mz89A+PTZaHJoSmnF0ulbLYEF6jR2iH3KCXrbMokPgg3Yzj1vkwIZo2EJ
   2nq8+EuYyndyhuP3BiXlXLDFwK+WdylamDAbEoRaoW4NUNYml3dyAxK80
   w==;
X-CSE-ConnectionGUID: R0daFF0ETiOzfGsg6qLpUg==
X-CSE-MsgGUID: kgt7W3RFS5qpB+rorBsW+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="100900611"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="100900611"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 13:46:55 -0700
X-CSE-ConnectionGUID: 3So1L+jOROaE6fBCNZaZXQ==
X-CSE-MsgGUID: yFrC79BTStClspjxV+Aq9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="255999383"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 13:46:56 -0700
Message-ID: <99d9674e64a94bff5750d8ec608cbf3c98675fe4.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from
 firmware
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Wahid7852 <wahidzk0091@gmail.com>, linux-input@vger.kernel.org
Cc: jikos@kernel.org, Lixu Zhang <lixu.zhang@intel.com>
Date: Mon, 29 Jun 2026 13:46:55 -0700
In-Reply-To: <20260629180419.383303-1-wahidzk0091@gmail.com>
References: <20260627224753.35075-1-wahidzk0091@gmail.com>
	 <20260629180419.383303-1-wahidzk0091@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-29 at 23:34 +0530, Wahid7852 wrote:
> From: Wahid Khan <wahidzk0091@gmail.com>
>=20
> Thanks. Correct sign-off should be: Signed-off-by: Wahid Khan
> <wahidzk0091@gmail.com>.
> Should i send a follow up as v2 for this?
Wait for Lixu's feedback, then send v2.

Thanks,
Srinivas

