Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274717BA6
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771187; cv=none; b=GkwfPwsT0I/4SVK+zybe+nZ/8A4O5UgtWl91ks9nhh+4M/YaZZcV8+j/CN6PBcq5mRDrSPpr7qy+PYSfFdb/6zvhuUtONyjRSJT1TwnsclbiNtrelpdIxYLEdf2FUihl9oVkdD2TrP1ysH3xe3FmX2/9M1PXCtLuBffvkkVEIGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771187; c=relaxed/simple;
	bh=UJTYCiIEHHapbK5ihydoCGf4EEp8acqEmhEL8leIBkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZJz1/DrLvoG7mT5MF2lnA1xYuUNpUYsQC5ItMkwp5GpFDbZgYaPQ+aPje6aZcG7SRNV8ZEm3kEWJcMBPAcdK9I6uRVUGy8iX8hrWGbTftcS8HQAJbT2dz7kVod+SOwqgm+UllGYlMTyAs1tR7izaHzcTvdJO6/bvpJLvWt35Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=JtLth6Gi; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="JtLth6Gi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1782771182;
	bh=D68vK+18Cry5zlz7WtRzUzSBrrRS6Z/uLx2fPSwPISU=;
	h=From:Subject:Date:Message-ID;
	b=JtLth6Gi6pivKy0cga4cjcyyvvFnZq5ETU/oO2/c30CQHBECLm3jBRnO7jC+exKE9
	 GQt3gkLO7gnhAukPct2xSZZJuXWQOGUVpIMaplh40HOkNzAlcfFpM7XF3yE7UrSRgX
	 EBQhQ+SfTBvXGH18JPEAEG9y6SyDQphwMSYuM7ag=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.31) with ESMTP
	id 6A42ED5500002615; Mon, 30 Jun 2026 06:10:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3370076816751
X-SMAIL-UIID: CCD146A9DF604767A44B02AA06DDB160-20260630-061032-1
From: Hillf Danton <hdanton@sina.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: hiddev: keep state alive through disconnect unlock
Date: Tue, 30 Jun 2026 06:10:18 +0800
Message-ID: <20260629221019.294-1-hdanton@sina.com>
In-Reply-To: <CAMuQ4bUuSP=J6Fv=TuzPL6Y34NC3v-rC-O8kGqh86gbUcF8H+g@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ feel free not to send top reply ]
On Mon, 29 Jun 2026 08:57:02 -0500 Yousef Alhouseen wrote:
> The missing interleaving is that mutex_unlock() clears the owner
> before taking wait_lock. A contender already spinning on existancelock
> can acquire it after that owner clear, reach the final-release path,
> and free hiddev before the disconnecting task reaches
> raw_spin_lock_irqsave(&lock->wait_lock, ...). It does not need to be
> woken by the disconnecting task.
> 
In __mutex_unlock_slowpath() the wait_lock is taken because of MUTEX_FLAG_WAITERS
after clearing the lock owner, so it is bug in the mutex backyard instead if
mutex is freed without pending waiters handled.
