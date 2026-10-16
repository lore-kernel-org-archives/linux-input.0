Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6F3B38AF
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138953; cv=none; b=RFBVMiPWWAgfqcUMoV5UgG2a0LRWtKZzeWiH8E0VE4DmQBYRjBskhyf8qUkNtlbXzf8PsYLYreTRz2vVsdJ4Ko4w44ELANG37XdxFND2Wl15FiBdZKSVRD/0EZ5NC+dRlhOLV+hjTFdgskSPO80X3iRmXtdV8QwBxMely3BqPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138953; c=relaxed/simple;
	bh=77lIV9+XZf1uAANaHdu24siZBMXAI7EB4PyK+RbmRcM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LvVZW3gzxPP8q2Kupqp8wByXIZQP/qazhdDj5D9zKOEda5ZW3C7D5/IUvJQcwm7FbW8lSaLApoF3WKQ5qLHu9k43KZyRO4cCPrieRM+00ty3c2XWsLlUcfla2+e53P68Ehi3jcafNKXa8z3eN1uOiavsFTg/+6hubqd8StmAERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjEEx6gt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjEEx6gt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0EB1F000C4;
	Fri, 16 Oct 2026 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792138951;
	bh=7DdbddfjePR4rYix5Zec9+KbxTW5+hL/VXniVxMhckQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=CjEEx6gtUEh3TIsgfQMT/l3+XBnNNMy5/GoaVd8Y0eOPJBcg1Uw0reJHfkD7YVM7S
	 JqXf2kqZNtlM9oPBK8S/Rxw8Uv3nzaUyYaYUZIlutL8nHqKNxP+SnqqcLqU72QrZJB
	 bpFrNpw9N8R8/geQfdQjMUKe3mMfCWzI+9v0XHiOBFyPswfWxcVqhRYQIqaSXH2CpK
	 JWKSV0HWmkGcZI2p3+hr7GwrsuoXE1A/CN+zXVX/8GP5bRMAxXbwE8X58ZOxXr/Jf6
	 V7OTeQWs5zRKX2nCkASw60N/+K4+UoerP5UzPsN9QQnMvd073dGz8+POnLL75gWWsQ
	 ++yP5ytHo/YUA==
Date: Fri, 16 Oct 2026 10:22:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Vicki Pfau <vi@endrift.com>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    Silvan Jegen <s.jegen@gmail.com>
Subject: Re: [PATCH v16 0/4] HID: nintendo: Add preliminary Switch 2 controller
 driver
In-Reply-To: <20261006061619.2005967-1-vi@endrift.com>
Message-ID: <r5p492pr-437n-r57q-3np5-77q5o2q45659@xreary.bet>
References: <20261006061619.2005967-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 Oct 2026, Vicki Pfau wrote:

> This adds a new driver for the Switch 2 controllers. The Switch 2 uses an
> unusual split-interface design such that input and rumble occur on the main
> HID interface, but all other communication occurs over a "configuration"
> interface. This is the case on both USB and Bluetooth, so this new driver
> uses a split-driver design with the HID interface being the "main" driver
> and the configuration interface is a secondary driver that looks up to the
> HID interface, sharing resources on a common struct.
> 
> Due to using a non-standard pairing interface as well as Bluetooth
> communications being extremely limited in the kernel, a custom interface
> between userspace and the kernel will need to be designed, along with
> bringup in BlueZ. That is beyond the scope of this initial patch, which
> only contains the generic HID and USB configuration interface drivers.
> 
> This initial work supports general input for the Joy-Con 2, Pro Controller
> 2, and GameCube NSO controllers. IMU, rumble and battery support is not yet
> present.
> 
> This should fix the last thing sashiko has been reporting that isn't
> complete and utter nonsense. Unless anything seriously bad comes through
> the next round, or a maintainer tells me I need to fix it, I'm just done.
> 
> Vicki Pfau (4):
>   HID: nintendo: Add preliminary Switch 2 controller driver
>   HID: nintendo: Add rumble support for Switch 2 controllers
>   HID: nintendo: Add unified report format support
>   HID: nintendo: Patch NYXI Hyperion 3 descriptor

Applied to hid.git#for-7.4/nintendo, thanks.

-- 
Jiri Kosina
SUSE Labs

