Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D721771C;
	Fri, 27 Feb 2026 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772197885; cv=none; b=CuDsbGBfOgR/iUcbDpGBdeSyY1TcoYQ6oNXqusLy2qpe7pJsKABZ6qh/C/+lDcnHyyAp7KJPPZTwbcepfPSp0WDvKCTeHDfSHTwvsR6h6J8ExQ1s19ycJ+E31cTKVmgmFR98LOb3hYRjOmZS4ZMvFnPxQDEtIH6WpakUL9cDrCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772197885; c=relaxed/simple;
	bh=UBEzje5jk1N1vQpwBeKK9IdLinVavzAd32zlw4sh4LU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m/XzYxw9iaQ34Sq+xqKAE8Il8tG9f3QpbZ1LtDucaq5GdxZIxgiuPo4FtC8LFta1w/DUCPgtd2kz1FkY6TqtL7bDECvW2BVCkmJPeYTLEblQaqcrQmnTZgK/rz0oAo+YWmb1CLuvmmjSrwYW29eEBI2uZwQrtIQ/FHeLzDjt2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz8eU7Zb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz8eU7Zb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75657C19423;
	Fri, 27 Feb 2026 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772197884;
	bh=UBEzje5jk1N1vQpwBeKK9IdLinVavzAd32zlw4sh4LU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Cz8eU7ZbyOcRkgx4wgbNb9tDxf2+wuk03E9eABJFoQL8cXyXhVix8IMn8Q/uyuSCI
	 QndnwixhCLx9BL/Hug0EvCq/tZY8s/CHlg5o5WKq/S0XGIav5x9fTQ2R3Fgr3M095z
	 KVfhAApib+QV+V0qhqvuox3udI3Satuw0DHBBJx71MpLJ/v/57HOsj/iKrcJ4i4Oog
	 80dPGjscbIhUpHvBgyAVpfCTp1ExHSW2gyu+ufS6aWVD0YRrISyZwarzC/4aHbmdxy
	 Onp4ngGJyvWA1G167OdvjM/7/FyHOgS4fngn+oF3BxHcmG90P4x7nNuWmKMb8WRTdF
	 8jQAGfvawjX4w==
Date: Fri, 27 Feb 2026 14:11:22 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>, 
    Denis Benato <benato.denis96@gmail.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/2] hid: asus: add xg mobile 2023 external hardware
 support
In-Reply-To: <20260216175539.12415-1-denis.benato@linux.dev>
Message-ID: <op014oq1-o7r1-p9o7-q251-o4qsprr81q69@xreary.bet>
References: <20260216175539.12415-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 16 Feb 2026, Denis Benato wrote:

> XG mobile stations have the 0x5a endpoint and has to be initialized:
> add them to hid-asus.

Applied to hid.git#for-7.0/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

