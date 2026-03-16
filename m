Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61113C457C;
	Mon, 16 Mar 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676839; cv=none; b=DBFCOdqA9NRsX+s0oEWzDIKTlQrCYx6E4uSj+xSEK3nZqWeVh7/a6KpR5SGjNjhQXr5pxsnHmJ6tMKoyAJ8UvpcuYC1dmD5aops1EZ43rgDWjgTFnA9uWH23+AUhuBEIgyNwt1ExuTMOPxXc8DqYFFAJt6dwNXozmib3jvy95rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676839; c=relaxed/simple;
	bh=0cFYEwaL+c1GkkskI7IrQNEV7PN3aSNebVRWm0fGl5A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Al6qLqEKzRzfKpr6lihfQuEgjI+mWHqA00ihTDQkaKfL8EbmgvslvHZCD6uK2zn9TBjH5U0QaNObm9BAv8k9GQxDlR/Eq2CUbGSBh6G8LSlv2mkSmjHhySRHGsStnwTo80+5Y28MsEG+LgAX5416uNjEZnT64WHJ9aoRuI4PldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BerJzI1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BerJzI1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1356C4AF09;
	Mon, 16 Mar 2026 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773676839;
	bh=0cFYEwaL+c1GkkskI7IrQNEV7PN3aSNebVRWm0fGl5A=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=BerJzI1AcsiT6/opHYqyS+1UBQo+HuMr7YHjNWXPaa2VbjFdpoCJXUZCqAN9pXmoL
	 HHvOswKS96Q7zsmnFTqFHYLoztUzmc4Q/Wsr/w6j+X5gNhsfOXOxtTvIt9syLMZ8w2
	 Ik7HUTn4QH/ALeXFSE2m2GtTytX8acLS5yW1sCfshvNKh+HYxztDxP5ABc5HO7pQvL
	 KclAPYkb7k3WEbmTYxZ1Jm/uDfMOQoXRqTmlTUb36RngI7z66gTvCloZp4BZFx5zy+
	 71gUy9XUdZ81RsDrFwti3jdJpEKuxBZLZiUqV4zko/FG+E819jkqeZKVXajAxA/SFe
	 oXabCxZbn7lgw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>
In-Reply-To: <20260227100939.961011-1-lee@kernel.org>
References: <20260227100939.961011-1-lee@kernel.org>
Subject: Re: (subset) [PATCH 1/1] HID: logitech-hidpp: Prevent
 use-after-free on force feedback initialisation failure
Message-Id: <177367679562.2580085.16653812041514704252.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 16:59:55 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 27 Feb 2026 10:09:38 +0000, Lee Jones wrote:
> Presently, if the force feedback initialisation fails when probing the
> Logitech G920 Driving Force Racing Wheel for Xbox One, an error number
> will be returned and propagated before the userspace infrastructure
> (sysfs and /dev/input) has been torn down.  If userspace ignores the
> errors and continues to use its references to these dangling entities, a
> UAF will promptly follow.
> 
> [...]

Applied, thanks!

[1/1] HID: logitech-hidpp: Prevent use-after-free on force feedback initialisation failure
      commit: f7a4c78bfeb320299c1b641500fe7761eadbd101

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

