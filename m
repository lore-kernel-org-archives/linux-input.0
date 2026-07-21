Received: from m65s28.vlinux.de (m65s28.vlinux.de [83.151.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B532B11C
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.151.22.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644770; cv=none; b=eD+uuu3mHtypy9gOSrI6h/qatV40KfAKC4rKeWZwo5VvEKteXoicSw8QDKmVSfUQklaNa3WpIYpY2YE1H7nD1yAhg3Sd95ce+YkCmmH5L7gv3Mbad1EYAGsVO9tBXOHVF+nqQWFo3iwe3CZKDb3xTIdx/RuSTdzjIACKunL6ucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644770; c=relaxed/simple;
	bh=iN6ie97Kk4S18SFQA9txiSObUVRPZwZxP0BVwNZ1ZlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApPdKwxLQv3mhYJBgVw4YC964sFGxqwtVVPx5Z4yVqj74DIPoT9RpF6UPHt0JF4qRGhPel8yg3JFNoAmkqgtvHp7O94t/X7TOsQs3VH4XOY6V7j1rhqoihjn89D/Ci7B1oXGQBuYFU+QYM7DAlqQoFB9ZMEUiNIwqeiEVFRBx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaoticmind.net; spf=pass smtp.mailfrom=chaoticmind.net; dkim=pass (2048-bit key) header.d=chaoticmind.net header.i=@chaoticmind.net header.b=XzH87pWE; arc=none smtp.client-ip=83.151.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaoticmind.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaoticmind.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaoticmind.net header.i=@chaoticmind.net header.b="XzH87pWE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chaoticmind.net; s=default; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/LF9PxrFlr4L/M1VW2+SXmoXVWkN/00PKuYCk7ztFE8=; b=XzH87pWEmKZarwxG/0y81wW9Sd
	GV9m3ntUNHxsN3gLRafMp+1kz7L9Wi9X6LIaU9K7oyD1T/NWX05/kUncu77/5W0kD4H5fQpLw8mdl
	pmWzW8LJsJx22AQPuxRaXBIVFsya737rSdaK/Oo6REjB51RAvTd/jnsd+IWnDb7KPvnYp409Bww3J
	J9j5vnOs7jmBcXqhJ3+iD7uFy09lV2eR/DWv5GIyEdliAF+BbVlhMv8lDjLF6aD3I/413MRJ8IMqO
	DdXtEuORpY3e6CjygA5csAgrcOf8vK7m4yM729IsYbtw5zwzB7pVowuPrRuyt2MCslqEJZHu+3d47
	Le7Ap2CQ==;
Received: from pa49-196-176-77.pa.vic.optusnet.com.au ([49.196.176.77] helo=zephyr.localnet)
	by m65s28.vlinux.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <hcb@chaoticmind.net>)
	id 1wmBSa-0003GU-69; Tue, 21 Jul 2026 16:28:40 +0200
From: Helge Bahmann <hcb@chaoticmind.net>
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
 Basavaraj Natikar <bnatikar@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 0/2] asus vivobook tablet mode
Date: Tue, 21 Jul 2026 16:28:30 +0200
Message-ID: <5234335.GXAFRqVoOG@zephyr>
In-Reply-To: <ecadaac8-e222-420a-ac5b-4d529fb3317e@amd.com>
References:
 <6879487.lOV4Wx5bFT@lothlorien> <2632507.ElGaqSPkdT@lothlorien>
 <ecadaac8-e222-420a-ac5b-4d529fb3317e@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Basavaraj,

Here the two patches implementing the split hid/input
driver for the tablet mode support. I mulled over what 
exactly to use as report descriptor in the hid driver, and
there is no clean and easy solution -- I hope this is what
you had in mind? I could not figure a way how to do
a stand-alone input driver without doing any hid indirection,
as I simply could not find a way to bind to the physical
dev twice.

Please let me know in comments to the patches how you
would like to proceed.

Thanks!
Helge


