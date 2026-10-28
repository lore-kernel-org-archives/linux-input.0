Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184508;
	b=Tr7hC6a6uB4wvrHzDdtOkzFTalSIxVLw84oBeOBgfP08t4y0TxIXooOJz+3dKez9hy63
	 UTc2f56kEn1nXV9/KIZpee6CfYS6jByxUoFN81iZFy/LnCtHfDA3sILq1qa44PyQnuLaA
	 dfX7JveICd31hTHIPpTszbP7YR2U9o8UitNs9M3mGxbS8hzdgwgDW4CZpc9cP/5TFYoJD
	 wUUWej1qDZUQ2EBjlQgOWzZuOP9KZzDBnlINzvTNKjHbcXE2NjCf/kEgEod+OJnQ9/Y7D
	 INQbGmVHmRLqfIq+pPaxpj4A0WK3RI2Q0VsGdjNuoT3/jN/ushqJj6eXw4PvJP1vCYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184508;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yWizwnsGbwsuOkjEDRHWMpES7V4gBVsTHQnzHXzFRAs=;
	b=Ehl5KovneF39tY5BVBYynCN13F0Q7QekE+gLXjS30BYWVQlA8lIS0+Irz0BVRsvB70om
	 S0LnklwermagaZzCnXAE8g/l+YnIJSamUkRXvR85Xi8nLRrsYMcIvlEeMi3O6u3blpZ3v
	 AUkaXnIJo+LsNVT6gyCYlm1bedYmbYpOl9mJte7uZxgIGTKuQtSrbCAenOUFu4mv1xooR
	 ngh3ZlvsnyOAsuinRuXdkfG1scByNZAQmirOB94MKj00YtoIeL6z4tGYEQ7Lidv9MvtdK
	 m4WfypiQBHTJyLi9qb+m4zQj5ccdvB1CTMQZ+PEa4Q5ETJKwNJ7DoAtVIrjB/nsB2/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3ZmjM3V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EE606A31A;
	Wed, 28 Oct 2026 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3ZmjM3V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417F21F01828;
	Wed, 28 Oct 2026 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793184507;
	bh=yWizwnsGbwsuOkjEDRHWMpES7V4gBVsTHQnzHXzFRAs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Z3ZmjM3VY1gUIrj8iDAep4/LntWSHRLbHmZHt1MTTVxkSBJcRYisYqiYgKhVYzEKn
	 nGcVvLJikJleemBsO7a8o2TQyY9q/kbWHsUs9F1XLSHUDqnaQiv5mpt2LqZlQJAwEe
	 JYEhv9BgK1nWyvQbKkVZwIEOhmTJtxuhwWqAheSlts0unEyRl2QOBOhVE9PzPoswjJ
	 U6GQcSohtkoqH0B5mhOEpaPchzFxms3haeSa8zW+ougsKZE5uL4WStNF321NzFczBl
	 BPpAI4MpALXYAh/Y+6ol8Wohmw9pTyVIlKdqm/Pvci23IRErvBTf8B/1bDiSUkK7y7
	 6l8wUAyS3XPuw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Zhengping Jiang <jiangzp@google.com>
Cc: Sean O'Brien <seobrien@chromium.org>, 
 Shashikirana H K <shashikiranah@chromium.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261015064223.1939367-1-jiangzp@google.com>
References: <20261015064223.1939367-1-jiangzp@google.com>
Subject: Re: [PATCH v4] HID: vivaldi: avoid redundant feature report reads
 per usage
Message-Id: <179318450157.1921288.15901444886154893550.b4-ty@b4>
Date: Wed, 28 Oct 2026 11:48:21 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793184505; l=412;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=wW3xJUX8XtcJ1Xaw0FroTZBIl1esD2+LjiG/2rKQrDY=;
 b=60dWcalUYKDQZVAWNfWk8MDxlFj0LljX3/aiOZjACohuTdJA/NVEDNkppjkcK9Q9kp1vXNJ2f
 np2RwpBshmmCgM0/weL/nU6FGgCoVt0wCoVSpfIQKJU+0jF5wbiU9I+
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

On Thu, 15 Oct 2026 06:42:23 +0000, Zhengping Jiang wrote:
> HID: vivaldi: avoid redundant feature report reads per usage

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.4/upstream-fixes), thanks!

[1/1] HID: vivaldi: avoid redundant feature report reads per usage
      https://git.kernel.org/hid/hid/c/720806515cb6

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

