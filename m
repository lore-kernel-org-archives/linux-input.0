Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFF2D97BB;
	Fri, 23 Jan 2026 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769172820; cv=none; b=iYUTBYr7gkMz28ynvAKFp8glDUbpIEGhcsCEMcZt9eneO0taVMZKCJwurA5S8uhY6a87OUmLIM3iD1m6fuwqUi+j5s1LfkQ8sCvD96c8ja0dCKD3shoPIY9tkayO/ND83nAkyCKKWO8O9Xl+PU8K14C9k3dOzaUPG1RZmX3uZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769172820; c=relaxed/simple;
	bh=ZW4nmxn7/YavDf8ZVnbWBnDjtvGPt79p0bSQpTSUXS0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QQu5hcC5smXEO2j2bTHpDfKzYKHvop9hQD4b3EsomJsA2I8jvjuVEmDaSIKddhhwxw6v3Z76uTw6n/n+Rn7eBsNJVaonCuDCYuLC+mNiUyEyZiMHbfIirzqSxeURKZoP8k8ouhukYwAFdJLgLX7Te3RmGPUwGp0EIp3Xf8aK3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbzlDL6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbzlDL6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EE3C19421;
	Fri, 23 Jan 2026 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769172820;
	bh=ZW4nmxn7/YavDf8ZVnbWBnDjtvGPt79p0bSQpTSUXS0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ZbzlDL6zngjrus8XswzMyfcH/mIeiM3qtM6HpGqWPD6Ct+5/5ksVoTAMWVIw0dr0t
	 I8w81J0Omj1YVyvt1yTb5Jn1Ym/KdPhLpUkLEvyiLGDK04oT9YC36r8oovNeLRSVeY
	 GonZnD8isb50eRzA5JzAJg6tazvitxHtM9c3BMjBTrwUfAuUXfLlQTlkcDDj2aqOe9
	 UDxgaANgybziRXxgFjVu+DnxLGt9tkChb3wHGj/VaJXi2sAzG6Ds1icZBO/Pk9d9k0
	 x5vfeCz6R7FBFNVgbZfoj7k/SiTLGHBxk14KExDV1S5NbtCNB4mAHHMFlvdzTEhYpP
	 sgWJJzG2w4dBA==
Date: Fri, 23 Jan 2026 13:53:37 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: David Phillips <david@profile.sh>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: elecom: Add support for ELECOM HUGE Plus
 M-HT1MRBK
In-Reply-To: <20260123-hid-elecom-huge-plus-fix-v1-1-4bed5e52fb3d@profile.sh>
Message-ID: <3603q858-6s6o-68r4-2722-pp1qp94389p1@xreary.bet>
References: <20260123-hid-elecom-huge-plus-fix-v1-1-4bed5e52fb3d@profile.sh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Jan 2026, David Phillips via B4 Relay wrote:

> From: David Phillips <david@profile.sh>
> 
> New model in the ELECOM HUGE trackball line that has 8 buttons but the
> report descriptor specifies only 5. The HUGE Plus supports connecting via
> Bluetooth, 2.4GHz wireless USB dongle, and directly via a USB-C cable.
> Each connection type reports a different device id, 01AA for cable,
> 01AB for USB dongle, and 01AC for Bluetooth.
> 
> This patch adds these device IDs and applies the fixups similar to the
> other ELECOM devices to get all 8 buttons working for all 3 connection
> types.
> 
> For reference, the usbhid-dump output:
> 001:013:001:DESCRIPTOR         1769085639.598405
>  05 01 09 02 A1 01 85 01 09 01 A1 00 05 09 19 01
>  29 05 15 00 25 01 75 01 95 05 81 02 75 03 95 01
>  81 01 05 01 09 30 09 31 16 01 80 26 FF 7F 75 10
>  95 02 81 06 09 38 15 81 25 7F 75 08 95 01 81 06
>  05 0C 0A 38 02 15 81 25 7F 75 08 95 01 81 06 C0
>  C0 05 0C 09 01 A1 01 85 02 15 01 26 8C 02 19 01
>  2A 8C 02 75 10 95 01 81 00 C0 05 01 09 80 A1 01
>  85 03 09 82 09 81 09 83 15 00 25 01 19 01 29 03
>  75 01 95 03 81 02 95 05 81 01 C0 06 01 FF 09 00
>  A1 01 85 08 09 00 15 00 26 FF 00 75 08 95 07 81
>  02 C0 06 02 FF 09 02 A1 01 85 06 09 02 15 00 26
>  FF 00 75 08 95 07 B1 02 C0
> 
> Signed-off-by: David Phillips <david@profile.sh>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

