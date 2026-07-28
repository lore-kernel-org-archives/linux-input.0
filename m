Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E3A24CEEA;
	Tue, 28 Jul 2026 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247922; cv=none; b=nw8l+9HCDYStI6VcoH4W+u1Xlp0QCztq8T+ZDlFDiYsmAqGx7RhSKkKJ1TqBj+XUEdr8Xa8fmagxpq8f+tvzvZ4xfPvmCRPbNYq+no3vOTm8olSWv5owIFuy/EpkDT5tGl+mMsS1fdjLIFSOKTe8J8uZKowSmbKX2nEfKZfwHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247922; c=relaxed/simple;
	bh=9JTtJGnPs1i1cBgqMngX2qGzTa1KfzAb8Mdg1rc8JPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=TsnrmPf1BGgJi1AI0u9b32HZPK1eOK6eAdOPL1ombu9SpjOZRpn7jTgfgssUWGqeKFN2Zs/hh90/ypxfG8xKSQSkTFqys2KEI+r37UprIi0FnM/bF0TEzA5JeZ7Otl34cV+/32a38vW/35unQjluw17iKz1a0vv/y1l9ZkXlyzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kh8/lsXf; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kh8/lsXf"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 54B58845C9;
	Tue, 28 Jul 2026 16:11:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJhK4RUntSKN; Tue, 28 Jul 2026 16:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785247917; bh=9JTtJGnPs1i1cBgqMngX2qGzTa1KfzAb8Mdg1rc8JPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To;
	b=kh8/lsXfD9xQsVcNHFJvzn0Nob9LliMDvDkz8iPgxvY+RwMt4uMReCdahZ9skam/T
	 ClT3rDRoVNMdGHGu//tiIG484UvALGLQB2kTYVXPfmLtKEwDXDzgAU9gOYqYr31gnM
	 qFQti4mHiIHc2xXRcmLAMUK4pQyB/sNRAW2VctRVJppSLVB+lVVZ77i+6VyLCOr9f/
	 Lk99043NuSiSt5b0GbKQWQiSraRx13cFu4N1z33d6q8wdy38EOFRZ7smWe0ZSN1JOM
	 1ZQ0BypvarRYo1Av24VsGY15edB0xk92iCZ+KH4zrGZe7mITLkIsQz14BL60j2fmDH
	 cbk88/f6aNngw==
From: Marco Scardovi <scardracs@disroot.org>
To: ilpo.jarvinen@linux.intel.com
Cc: bentiss@kernel.org, corentin.chary@gmail.com, denis.benato@linux.dev,
 hansg@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, luke@ljones.dev, marcus@grenangen.se,
 platform-driver-x86@vger.kernel.org
Subject:
 Re: [PATCH v3 1/3] HID: asus: export asus_hid_fnlock_set() for direct fn-lock
 control
Date: Tue, 28 Jul 2026 16:11:43 +0200
Message-ID: <PFmgQnA-R8Gt_PZ7vUSlKw@disroot.org>
In-Reply-To: <ad587675-cef3-f5b5-eb39-0f76dea8d617@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Ilpo,

the 2nd one is not Marcus' fault: during merge with the tag for-next it has
been picked up twice and Marcus filled both, thinking it was ok.

Correct commit [1]
Duplication [2]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/hid/hid-asus.c?h=next-20260727&id=f631011e36b87b173b71c7592b558ad05d791228
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/hid/hid-asus.c?h=next-20260727&id=4f349f4e3101c7b4c94fa2c0e530eb5374f46916


