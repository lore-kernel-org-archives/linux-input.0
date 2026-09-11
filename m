Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351321CA02;
	Fri, 11 Sep 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139075; cv=none; b=SFUnoSlvAdYs70DhZYGURH68uMI7rz5v6XPyid3SkqJWsEslPyYDpg+jWYQYuePqsiVgDHoCj+u9miS/RcPfxe5UtoAquBOjYVVDSJPw9AdFfG0Jud4Bm9fVOvWFk6WQFfaExNDPPQrfvVRmmuxnpXD4dxU9aBL9rm/AKNMSzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139075; c=relaxed/simple;
	bh=6TPDwydXLX3ctw8DB2fq8hIOIpyZvEWEQKhPlFJC72M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G5mMKCyL/0IaRdu3EvogK12aFlPM0Hxou5Zbc5Z4kL8mnZWSewcm9ev82UTVZYCDRlhcz71VsrauL8H4ny7eNrQSDTMuJg+akFGa1cwXzmZhCHyO3dX6vFJP8TjR7lH4xAsXfdhDHFStfYeccLoYMetyrkHQTTlrbAEF5r2ZxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSGFJ8aa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSGFJ8aa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6BA1F000FF;
	Fri, 11 Sep 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139073;
	bh=K55J/2l57dkiAkmFZiE1t6cdnggbKHGVqGgrNHeXvWY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=gSGFJ8aaj1l5ODhOq36vt7LREJ6KXqvl64hyk1hfHthFwq7MpMlBLXog1WdiZ8c9m
	 jpXVVb4APaKW3/tZ2ncEM9j2oEoPM0B3ic03tvQZr7nIsNkKyQDJdGWLUowmASSzVB
	 hpohb1N+VekYq/O/vYaIIncPy8/R47lWzPMQh7+pNM35Od5gvdbVZVeH4XSjeyFTpN
	 ENL2n6upsm5RAtu5Mjp6kQ7qDP1mrIFq+ErgDrvPY+mrmBNilLvseBZTblRtB1kA2Q
	 CJCR83r3/dRC/CgZF5/dGp7WY7ZiLdCKH08NBENtmA7zbRUUQOuDXTXkvK0x19Mwv5
	 0rba27dSyGLRw==
Date: Fri, 11 Sep 2026 17:04:31 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-usb@vger.kernel.org, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hiddev: set report-init policy before device
 registration
In-Reply-To: <20260630211845.50511-1-alhouseenyousef@gmail.com>
Message-ID: <53ono0oq-6s62-850s-rpop-1n529q6p63or@xreary.bet>
References: <20260630211845.50511-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Jun 2026, Yousef Alhouseen wrote:

> usb_register_dev() publishes the hiddev character device before
> hiddev_connect() initializes the report policy. A process that opens the
> new node immediately can issue a usage ioctl while initialized is still
> false and trigger usbhid_init_reports(), bypassing
> HID_QUIRK_NO_INIT_REPORTS.
> 
> Set initialized before registering the character device so every opener
> observes the quirk-selected policy.
> 
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Same as before -- sorry for the delay, thanks for the fix, applied.

-- 
Jiri Kosina
SUSE Labs

