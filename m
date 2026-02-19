Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CB52D6E76;
	Thu, 19 Feb 2026 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525068; cv=none; b=ZW9O/XUrf8wszLorQGImQTVR0bTswmpYYfXsFPP9sojbPW1c6kqThShuiEu7O/+Qoj+CxeEFaQ+/R17kqf15qoz56lc8SMxP+gDAv761wWsKuTHMf3Z9hbZIG2N9edK2zcZY+IXvTUG68dqIX44l1LLCcEzpMoj8yJ4OmHzpYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525068; c=relaxed/simple;
	bh=Ci4EzCDG8y1u9LZNVTo5njwrWm7HthopmvewWhZ7srk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=om1XPUQUfT9KM0sFKcOG4JfQgzk1emy+NNz/caN/ZVMMsu/+UfP3h5qNzEaQRwzVAQneTO7GUCqtUCowEeQTs/EbPnT8aOU3trhj7/JL8S8pYQFyfXUoxaXFHlrhQ77oYKcZv2N0qXFGeLKBMcE7IPOTqUUQZ9frc3O9fi2Taws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1rsCRXC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1rsCRXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0AAC19423;
	Thu, 19 Feb 2026 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771525067;
	bh=Ci4EzCDG8y1u9LZNVTo5njwrWm7HthopmvewWhZ7srk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H1rsCRXCFurBvYk3Wzk2OiQ86d3EGo5lWDyDA6OgE7fGOuk3xJU6420IjK2YbrCTN
	 lcJZ/seYqy7Gelf2zUZxNPQlpIk5QAOyv7WKDas2YIIISXV7sqo65XO+K6h1ZdxSsK
	 WvzR4OjWaRwCKuYdYVySmF5yoitcZ3d99ha5KnM0QcoJb3yhHQZ1pPgVHs1FH3jBpQ
	 MAY5869M6cFQLe1pnMHHQtCjk4nAeZArmeEz1F8X8RnZZ9aMeHHg5rGC3fhT+VM0Oh
	 OvJtA/N41PCbs5sBJB9+kQR3gRyXO2q0hTsO1YzML7RrRnP29EFqYgN3y/2dIiwLEB
	 ZH2bx6Xl75lBQ==
From: Benjamin Tissoires <bentiss@kernel.org>
To: linux-input@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
 Bastien Nocera <hadess@hadess.net>, stable <stable@kernel.org>
In-Reply-To: <2026021953-entitle-panoramic-0927@gregkh>
References: <2026021953-entitle-panoramic-0927@gregkh>
Subject: Re: [PATCH] HID: Add HID_CLAIMED_INPUT guards in raw_event
 callbacks missing them
Message-Id: <177152506629.1014432.16774155783184308208.b4-ty@kernel.org>
Date: Thu, 19 Feb 2026 19:17:46 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 19 Feb 2026 15:33:54 +0100, Greg Kroah-Hartman wrote:
> In commit 2ff5baa9b527 ("HID: appleir: Fix potential NULL dereference at
> raw event handle"), we handle the fact that raw event callbacks
> can happen even for a HID device that has not been "claimed" causing a
> crash if a broken device were attempted to be connected to the system.
> 
> Fix up the remaining in-tree HID drivers that forgot to add this same
> check to resolve the same issue.
> 
> [...]

Applied to hid/hid.git (for-7.0/upstream-fixes), thanks!

[1/1] HID: Add HID_CLAIMED_INPUT guards in raw_event callbacks missing them
      https://git.kernel.org/hid/hid/c/ecfa6f34492c

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

