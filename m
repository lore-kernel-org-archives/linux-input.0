Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D64340A59;
	Mon,  9 Mar 2026 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081301; cv=none; b=jV3R9PcogNwHcmkwGusb51YAf1UNoC8zejb+8KM4BQhXIpRBxMihJ+sZwuWrFdNE4VUcxsH6h5jKOlTc9XKnejlPqq28HAJQuJBjywHkhk56FrloU74649Yah/jDzgW9ZFYiwysGnkWyCb8y/0JSy6ho1C6mr/cz9T9mx/HuZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081301; c=relaxed/simple;
	bh=FYwF7jAqiT3TyyAEwOq98XDuphRrLJJu1k6sit83bGo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kHF0XrQLbm6fov4KqgkjL5J+BP+wStUjmukeBWIxFdBQkVIP7fOIj0zblfPHHpJxk8Sa87/aTCWcCJuyLfoBObZIUWDPjtOjImqAIq5B5IzVethOuoth2YawrNEAb+F5s2aO2dJIbL/LH+YYoMcydDSEyZs0aCVkNA+I7AMD/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGEAbC4l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGEAbC4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC604C4CEF7;
	Mon,  9 Mar 2026 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773081301;
	bh=FYwF7jAqiT3TyyAEwOq98XDuphRrLJJu1k6sit83bGo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qGEAbC4lU/agzgA/w+0giNHA7Rv0pIAMqLHC8XVQ7V32k+LudfYhtbdGdAEVznMF6
	 i1mD0MJgRhhBjaAV7aJO4Io1fnYVeh6fXdDXgo4hVPgJeAtjG+pKpO8Bam5wsZHkLz
	 eq4xXWNV9d+thHFbYCWPq82kl3mWjJu331bwvWMl3smvxyboT+w3NJXjPSoECvUjWW
	 xgAEjC4ihgBKFMog8rHjwkMOR0V0wVTSlnOSspDimePAmz/ukyEWVWblA2QuprNEdB
	 iATXRmiQ1aJ5t1my76P8kU8lGPLsydbag8t92R0bEViEP5nYEuApS7sD5j9IviK5Ii
	 PsybccrowI1uw==
Date: Mon, 9 Mar 2026 19:34:58 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Beno=EEt_Sevens?= <bsevens@google.com>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: wacom: fix out-of-bounds read in
 wacom_intuos_bt_irq
In-Reply-To: <20260303135828.2374069-1-bsevens@google.com>
Message-ID: <258spqo5-n255-90n4-41n0-5493n5267or4@xreary.bet>
References: <20260303135828.2374069-1-bsevens@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Mar 2026, Beno=C3=AEt Sevens wrote:

> The wacom_intuos_bt_irq() function processes Bluetooth HID reports
> without sufficient bounds checking. A maliciously crafted short report
> can trigger an out-of-bounds read when copying data into the wacom
> structure.
>=20
> Specifically, report 0x03 requires at least 22 bytes to safely read
> the processed data and battery status, while report 0x04 (which
> falls through to 0x03) requires 32 bytes.
>=20
> Add explicit length checks for these report IDs and log a warning if
> a short report is received.
>=20
> Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>

Applied to hid.git#for-7.0/upstream-fixes, thanks.

--=20
Jiri Kosina
SUSE Labs

