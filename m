Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDE36CE12;
	Thu,  9 Apr 2026 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748869; cv=none; b=d8fPGTZRo9fbD4QYYAovGpaEwcQQIeIOh8TGKJQbubnmlxZYuXWG7Ad3ODIR8dLQPMLDtOykEgPymCZPOhiFbh3DAID8xU1VBtq2KAldXn2X/S+Hn2edRKGnzGnujNz9eW7l7EHcwwImcktw3Dlg5JSVCiHqUJGdHRTJctIQhDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748869; c=relaxed/simple;
	bh=YWOXPWZtjdaJMBZYrTndW/v6KBg2VDVygwHjM0CKOt8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uSEZbl2oQCkuVyZfn9pBqIWqyqrSvQTcu2sMQwKpeMrAf+YGSXwwKnrgEq8P+0scTSeJ5RvjN1QFfwGEtMNtmQeHnXPnITx3rLI452n+kHqELBHJiLqcKOtG6Wz6/ysxlg62SI300zE1qcscytejaQYMJKb1hUud1U2Ej5j0Lbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfUTV0Xr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfUTV0Xr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BA8C4CEF7;
	Thu,  9 Apr 2026 15:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775748868;
	bh=YWOXPWZtjdaJMBZYrTndW/v6KBg2VDVygwHjM0CKOt8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NfUTV0Xrq7ilrP9WtzhgCgiSMeVfWTtWpMqI+I5D1coGcF3BS/PxdmFMqbL9+IcH6
	 P6ReAksuzjYBquOXbtuw5bjoxHpLuhlQsSz9DctnHPLOT5Xx06pGsBS1FIvcQGjY37
	 9ywu3ZbA4zqdRwlS0zwm0eQDKDTuimjAVTU3bZvbLXrqDXSc8J3WuTf6g+MhxFE5vq
	 KxmeVwd8XSNgf/0ffRma2vwpARDiDzWadX7dHACeU2KuDnYFJkOX4GJOv5V5g4JcHA
	 qS9R2jsOMYBBOvmRyvmW/06Q+4R3ghKu4dYROk1tT/OVTeVlcY3VXSSzaCN6sqo2Ja
	 Iy1M+ZH5nO82A==
Date: Thu, 9 Apr 2026 17:34:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: update module description
In-Reply-To: <20260402155915.17745-2-rosalie@mailbox.org>
Message-ID: <537osp43-s681-9p01-s760-0s6p01q8r172@xreary.bet>
References: <20260402155915.17745-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 2 Apr 2026, Rosalie Wanders wrote:

> This commit updates the hid-sony module description to make it correct
> with the recent hid-sony changes alongside making it more consistent.
> 
> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

