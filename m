Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C543F86F1;
	Thu, 28 May 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984122; cv=none; b=GRX4GEt6+Ea2nxW6cHfkN0UhKGuwpXiktkV2UPhT8bKVR0xvqwN+j0mdifIqafajUKjhwJYstBFAcgoPX0wrCDdaNmibmUJJyfpr3GE2voccxPoWZzltR4Nvg+XuwsxwLQCaePfHHQOZNGnb5xhrKJzf1J3aHBXmWYZDXen53dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984122; c=relaxed/simple;
	bh=RpTNknV0WyXlYNw9QzPJsG2w5Bd7rKHN/jqTwW7jElA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TJxgMChdJ8deIkpveUZQD8qowrTfAnyNw9gwMN+cOUqn4VAMUn13E0hXmL5FMfKT8IGPDLjfWT8EVc5mNu2ROYg5JFvbSFTmqknTo1V+2BRxTsvrAb4xKtdv8ioGd9iwF6fw5fGmNFfGxsuu+KglUBGEAEqpc+YCgR9/agtCuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX/E6jcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX/E6jcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A231F000E9;
	Thu, 28 May 2026 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779984121;
	bh=wJXClxkoFYPoH4gVOZhth167QR/u1ia1jdmUwer1ano=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SX/E6jcKDKzLY8ex2T/MdQXMe/GMsd2ccWT9o0ZwrAJ2aErapuBom6+VJzZS9HWhi
	 sdwaJROghEZYDvIkLcgpTx1jH8LyDkCazfl7dkncnxc25sgfowqv/8Xe6SJEB8qE91
	 yQu44QQhUv8zb+Yw7ozeuP+5jAFl2TAqdZ6SqcdPOHNlKnYcc8r3OJjWHAEfZQNUYQ
	 SAS8+38jnO8Kft8VsVI1jAYMJ6rHn3bZA9Fh/oVPhWHzh6O6FyR9xME6blAuv01jba
	 U7J3rIafCBeKwo/F0YmHlzL5lUhQJDK37QpHCFBQC+fBE92B2omz3wmmcqA9C1TJ0c
	 SIdF+MxtcRZsA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Ping Cheng <ping.cheng@wacom.com>, 
 Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20260527160528.847928-1-lee@kernel.org>
References: <20260527160528.847928-1-lee@kernel.org>
Subject: Re: [RESEND 1/1] HID: wacom: Fix OOB write in
 wacom_hid_set_device_mode()
Message-Id: <177998411943.2101279.12631387121558262229.b4-ty@b4>
Date: Thu, 28 May 2026 18:01:59 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 27 May 2026 17:05:26 +0100, Lee Jones wrote:
> wacom_hid_set_device_mode() currently assumes that the HID_DG_INPUTMODE
> usage is always located in the first field (field[0]) of the feature report.
> However, a device can specify HID_DG_INPUTMODE in a different field.
> 
> If HID_DG_INPUTMODE is in a field other than the first one and the first
> field has a report_count smaller than the usage_index of HID_DG_INPUTMODE,
> this leads to an out-of-bounds write to r->field[0]->value.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.1/upstream-fixes), thanks!

[1/1] HID: wacom: Fix OOB write in wacom_hid_set_device_mode()
      https://git.kernel.org/hid/hid/c/c0a8899e02dd

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

