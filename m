Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114773905E7;
	Tue, 12 May 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599804; cv=none; b=P1Wxf38qmoHkTlfPlG7F8KUEZ2jNtaY1G4DOkfwNvO0LvTNWTFwS5kDE3g0lFNlOsC7AyXs485tpShnhEFXN/SW5Uyf6m5HpeIa/8ro2CLfX4+9+7eTP6hGayM7/1DUK0Dy7lWDTcMuIFK1YNLIs+IoarDGGXrNSsl97nJ7T0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599804; c=relaxed/simple;
	bh=uo+QRBH9al1GE4xPuYymyuvD5ZQZ9Cyw7WRYQqtouH8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lP40n0pB/i2pSDkXkt6YwzuXhNG3byM8RL/a582KQhcs12VLnMqZu0XpqE+R2H1uUL7RRlHMpQo0wyfpAjgSz725nl+zCY/Z8y2aClnd5yEjRQKAclrZbKa98vFQVeuqhweKxBynQmE+ZrNk1OZ99alut9ZmBL6awvz4t3+8uBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4NVowMI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4NVowMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549E6C2BCB0;
	Tue, 12 May 2026 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599803;
	bh=uo+QRBH9al1GE4xPuYymyuvD5ZQZ9Cyw7WRYQqtouH8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=k4NVowMIz56adJ49hdhWEpZYP6EBeL+jjm0iuCG6FpYDmFw8HCIBIxkF8PzFlvc6w
	 g89Hu3DDlCjzaVCpTD/aEp3gKRI/gNqwhRGX1x1l2NF0aBNVKGkSN3PU+X19poo6b7
	 Q3HTK9YvBr4Dwp++Kh84O6VjmXMw5AhGMLsalo2PdSX59J/46L9NkB6UCoisc4+ThO
	 azQrhUBP4FZ8l8DCyOZXfJM2lngRnAI1nkZw2kwUNvnzW8ocaUd3spYW47X5WMDImi
	 9vOw2EcCuBjOdf02lBQQ/AZmXagvznhU7k9BzcXlO6gZgU9xO/s0l3W7NvwRWns5Xc
	 o57Iq6BkrNrZA==
Date: Tue, 12 May 2026 17:30:01 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aaron Webster <awebster@gmail.com>
cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: playstation: Add DualSense Edge extra button
 support
In-Reply-To: <20260407044008.40222-1-awebster@gmail.com>
Message-ID: <n72ss355-o0rr-1p03-69p6-038r7sn23n45@xreary.bet>
References: <20260407044008.40222-1-awebster@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 6 Apr 2026, Aaron Webster wrote:

> The DualSense Edge controller (product ID 0x0df2) has four additional
> buttons compared to the standard DualSense: two front function buttons
> (Fn1 and Fn2) and two rear paddles (left and right). These are reported
> in bits 4-7 of buttons[2] in the input report.
> 
> Map them to BTN_TRIGGER_HAPPY1 through BTN_TRIGGER_HAPPY4 so that
> userspace applications can use these extra inputs. An is_edge flag
> gates the extra button handling based on the product ID.
> 
> Signed-off-by: Aaron Webster <awebster@gmail.com>
> ---
> Tested with a DualSense Edge controller (Hardware: 1000208, Firmware:
> 1000087 type 3, Fw version: 20 131082 6, Sw series: 68, Update version:
> 0213, build date Jul 4 2025) on Debian 13 (trixie) with kernel
> 6.12.74+deb13+1-amd64 (x86_64) via Bluetooth.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

