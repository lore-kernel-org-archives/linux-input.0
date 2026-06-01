Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB63E5EF7;
	Mon,  1 Jun 2026 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337720; cv=none; b=BJVjfRshArYBKVnseBNv5KlFFqG2WjqYgHqGcKgXJYDDMhjJ8PPv+mHvvDlpv1iBV4O2nSNN3jzTGcg7cyy9UbGHUyp1cHa3f/zk0aZRDxkxO2a09BnOczMYwx4QltGTEnkXrC/t1rW1ZTG/yqi2ZxUXwVPTifJNew3H6lTu1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337720; c=relaxed/simple;
	bh=tmHBdL0l344ovrKQFzPH9CQ9wtVZHTB5vu6tuVy7DCQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IBZQ5KNX0JN/dQsUjaJ5uZah5CX9Ow2q8Oce6mS5rG+Y5q3tFSdZ2qgqh7oJDcfF8CVMnCieOjFSayDjUjbADtyFi5E8Sjbso849DglF7ZZqfVu4QIPLNuPVcvDvEiXEHmcjfgtx1aCj2JxvDRYkOWpIHy3yZO8PmL/jGPGKa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUp/N5no; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUp/N5no"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6F71F00893;
	Mon,  1 Jun 2026 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780337715;
	bh=PzMSD0vCgmCFFn+QfkI0mEwLYZNcvify1Hwo3O0rTtI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mUp/N5nooktR6826lX5HIzsx4449guYYvzbNmJsAD68Swz68sJJk4Ssb0jRBz9rR1
	 PFgi+O2ds9SVDJJcUHWHCcAHpexmNci+f4RoP2wIrBHDD9DXHzkHLakdcLrBNLJak3
	 wjwzxov20yMXA1RadAYiK7SJUsIWxA+qQJNINQZdea01m8eerYfURjZBtionLBxgwX
	 rpIzTsxgF+UK1w1b9xlbzVyt7SsUbqzdeqAL3aeadc4vDX3ULBfSDAC/Hnyfdm2Bb2
	 xbTQRh+SC1gGtV7YbFRvL/pWSaOv+71ejDdUhm9R/A6g+snfpoUYckNTsdBeTKMAvk
	 G8WkavQJoEL3A==
From: Benjamin Tissoires <bentiss@kernel.org>
To: David Rheinsberg <david@readahead.eu>, Jiri Kosina <jikos@kernel.org>, 
 Bogdan Petru <thonkdifferent@outlook.com>, 
 Joshua Jun <joshuajun@vivaldi.net>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260326-wiimod-table-v2-1-a11703ccdf41@posteo.net>
References: <20260326-wiimod-table-v2-1-a11703ccdf41@posteo.net>
Subject: Re: [PATCH v2] HID: wiimote: Fix table layout and whitespace
 errors
Message-Id: <178033771379.12524.4675493259159914902.b4-ty@b4>
Date: Mon, 01 Jun 2026 20:15:13 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2

On Thu, 26 Mar 2026 15:03:48 +0100, J. Neuschäfer wrote:
> Some tab characters snuck into the data layout table for turntable
> extensions, which resulted in the table only looking right at a tabstop
> of 4, which is uncommon in the kernel. Change them to the equivalent
> amount of spaces, which should look correct in any editor.
> 
> While at it, also fix the other whitespace errors (trailing spaces at
> end of line) introduced in the same commit.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.2/wiimote), thanks!

[1/1] HID: wiimote: Fix table layout and whitespace errors
      https://git.kernel.org/hid/hid/c/12b7731995ca

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

