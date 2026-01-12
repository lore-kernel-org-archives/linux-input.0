Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BA366573;
	Mon, 12 Jan 2026 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236420; cv=none; b=GltfXZOvz3ESSOL0QK5/YjsUPeUsYW6RArSC9pw52NKnwSMvoBk0Cbje64qDlq5AbOefpLnbk8PC7+ZnLiUxtHzWXCVL7HuEaUG7uv9H/K7BECWFHU6Zr8xO2EEgavj4r2Cgv5bju8/F3+0nz7N1uOhR89rwL5AlgyIL4OiMKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236420; c=relaxed/simple;
	bh=UzLlH82doLrL/ckLvBkN0f4CqOSac2h6xxL4B621P4A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZwpHL9/HZcW5Z/NToliZlf0PZgKRXE1vt3a6TIb/lScz205LZrS30du8T4/Ihk54CJolI1dgX3KZ0o13uGAsGK8OooABKazHYZ5PkQh/EiehjmzNhABXCjfGepCVBte36UMD8e0QXoLyUHZTLmZWxKVYAerAXqriMBqSqlj5wQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GExjHOJ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GExjHOJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA5FC116D0;
	Mon, 12 Jan 2026 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768236419;
	bh=UzLlH82doLrL/ckLvBkN0f4CqOSac2h6xxL4B621P4A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=GExjHOJ3QMPtgHHnbFFIhwFnpwZm4g9xOGdpGVXKaLOzG5TCOcCKAdYUdsyM5RsNo
	 VeQTCfQ9PT8PlmEZjZxqUrTr31rQe631T5sijKvljdgQZBGWdaZRlJdwyEbf9uVBhk
	 dJD4x6VncKrNm/hCUtGHouOb2m/q+kCbMHmbJEvSyFYhho9x2Rkpgr4pSXxrGC4Wnh
	 DvIIXD3OY9JBzTZv64RUE/ohetfJJjqsdj2Wpakj3gsO2I58hWfd4boPgVoBmOZEPo
	 Uf7i8Mp2HdKN0BRNRM6L1sgxxJwB/lm2x0Lc5qdOO70x7hl2lssWoYcmR8LOGcf6tR
	 i+hLZaAE7TMCQ==
Date: Mon, 12 Jan 2026 17:46:57 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: add support for bluetooth Rock Band 4 PS4
 guitars
In-Reply-To: <20260111210051.51743-2-rosalie@mailbox.org>
Message-ID: <14n95332-nqs7-oo3s-pr38-qr7p41sns50r@xreary.bet>
References: <20260111210051.51743-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 11 Jan 2026, Rosalie Wanders wrote:

> This commit adds support for the PDP Jaguar and MadCatz Stratocaster.

Queued in hid.git#for-6.20/sony, thanks.

-- 
Jiri Kosina
SUSE Labs

