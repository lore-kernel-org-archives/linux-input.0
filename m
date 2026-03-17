Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7D3E1239;
	Tue, 17 Mar 2026 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756205; cv=none; b=WO5PIWNurLOqh5teq7vYeQiyo5u1VapE3sPjGkDG4/+Tk4yo7EqiXR7Yij66qEMAnn82Z6Ac2o17QNU9XxeG5pxuBvfTsEkTDANpTLX2jLxIPPtoRj784mTuCvVq5ohcUDIT3JXvzBXcZkzYoSonCBPAOMhjC3MJpm4Lab1q9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756205; c=relaxed/simple;
	bh=24z8TcWkRCoE/96+WzIo63cjOd7dGKkb9P6RPo3VEsM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nPgMdvypP1EBWlRB0yKBop8Uf8LfvzMsRG/AKkZsTuksPOk3P7cVYQOLobcy5liktKNdprdhUpZlhu+VYJgh3+dRvY4kN4Wg95hfCMOO8voi2NSLxOB8A8kKWDgxqrz26yxWbMeQLbcTUxuD1j+Mj+HMyIawSjDqkosuFI02x9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTNlaOrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTNlaOrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCB0C2BCAF;
	Tue, 17 Mar 2026 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773756204;
	bh=24z8TcWkRCoE/96+WzIo63cjOd7dGKkb9P6RPo3VEsM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fTNlaOrRy39ni/i0+AOOFkMBsUNQngAIfs3orvARfFwkmb/TMUBIztNeXLeUzUvf/
	 Fx3JI3vEiNeh9+2rlwDGaDWZshx0wXFAJ8GQkH/4oTeZ8VJ6DaiMqljcU2Obz8uQpB
	 1h+cIjGwzW8SzSxl+6J9WAmk5srZcL/pXGNjPv/ilUYtLupr8bGi6STlDSL8zbMin4
	 /aFmGQIA8/JwF7UZil7GZQEv/QYX3EqCL5Azl9m4l+mfz06Di1h9+A9kVB4At90pMR
	 ViM9C3kD9Y9BFSjfN8jDNi8n9Y2r2uEda4ZTbUKFaiwA8dGfACyQCHawRJ4qPpT2nc
	 pF0iF9OAV8UrA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
In-Reply-To: <20260227163031.1166560-2-lee@kernel.org>
References: <20260227163031.1166560-1-lee@kernel.org>
 <20260227163031.1166560-2-lee@kernel.org>
Subject: Re: (subset) [PATCH 2/2] HID: multitouch: Check to ensure report
 responses match the request
Message-Id: <177375618313.86913.13560090503728581709.b4-ty@kernel.org>
Date: Tue, 17 Mar 2026 15:03:03 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 27 Feb 2026 16:30:25 +0000, Lee Jones wrote:
> It is possible for a malicious (or clumsy) device to respond to a
> specific report's feature request using a completely different report
> ID.  This can cause confusion in the HID core resulting in nasty
> side-effects such as OOB writes.
> 
> Add a check to ensure that the report ID in the response, matches the
> one that was requested.  If it doesn't, omit reporting the raw event and
> return early.
> 
> [...]

Applied, thanks!

[2/2] HID: multitouch: Check to ensure report responses match the request
      commit: e716edafedad4952fe3a4a273d2e039a84e8681a

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

