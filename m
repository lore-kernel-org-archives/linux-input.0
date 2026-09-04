Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC233503BFD
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540203; cv=none; b=gzGdPiT866EtPfuIdUbtxDrQytnJRboJMUePEdXBWiwqdwE+WKVI4+hkii2YP3LWyXx625NpL3wGTmxoOlt5kKAMdQixiQjTI0KlyXTcwYXq3TZHUwb7BwmyarnrWfzSEqzdGW55id+bAfDCMUoyX3NEFlxbycSDRQdCGz86yVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540203; c=relaxed/simple;
	bh=UN1Q4YCX3zMEWvO4brPnAAVL50gmJA+eXdjg04YqO1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JdziodBsAhMiVDjluH2KcF3gKwuMHMFbYuoRu3zUK3vPKFdEw1drSpzYsR7gwO4rdVoTyCxF+mZsM1/6TX3dtyNl5ay8/JnMwWgOTSTZFejGvIfiK03eE3vav2U1FQokr5mXnXZ5UBcERp0pRtIZVR6aFXLkUzAFX08lH9IT0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnyrBWDh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnyrBWDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25431F00A3D;
	Fri,  4 Sep 2026 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788540201;
	bh=OwwLqvS00fEgzKjvg7n0OMK8+R8T4bBZ6o/RhpmOzbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnyrBWDhcQRI9XoMZm6W6yxxPDYVVJtP/4zXuzeIUPXdHPfNJ0ENklaSIq+9ttaED
	 Txyzb/YeAq2SCdT1Od1X86vKs1wGtBeLzGlr9xiKbgwwkvb8wpeh1OedIcSyDuDh6W
	 8qtVWtGvgXBxm+63aOu4FtLlvmzuydRPvynNhdaLi+yzi2wiudWd0jTCkbfAdlWQzs
	 wk9v+jKN0jQgeZTD0xKq6138doOfLWAVm+71bTNuYYQMOvxZTAcqO9zcaVeE5ZoIG5
	 wqz6UioX+M3kMjfdrZ5XxD6hW3GM5tjmNffSM5EHSqcmg44B2uySWrnwVGT3gRIBVE
	 8Wqej0L7ycoiQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 2/2] ALSA: usb-audio: bind the Topping M62's
 vendor controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904162236.3212370-3-mikhail.v.gavrilov@gmail.com>
References: <20260904153051.1785280-1-mikhail.v.gavrilov@gmail.com>
 <20260904162236.3212370-1-mikhail.v.gavrilov@gmail.com>
 <20260904162236.3212370-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:43:20 +0000
Message-Id: <20260904164320.D25431F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] A race condition exists between devres cleanup and the component=
 framework during device unbind, which allows the WARN_ON(!tm) in topping_m=
aster_bind() to be trivially triggered.
--

commit fc33d2a046de2359ba0a5826832474e168d41b39
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: bind the Topping M62's vendor controls

This commit adds a component master for the Topping M62 sound card,
binding the ALSA card to the HID vendor controls using the component
framework. The master's context lives in devres on the audio control
interface to manage its lifetime.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..722f98f97d0bc
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> +static struct topping_master *topping_get_master(struct device *dev)
> +{
> +	return devres_find(dev, topping_master_release, NULL, NULL);
> +}
[ ... ]
> +static int topping_master_bind(struct device *dev)
> +{
> +	struct topping_master *tm =3D topping_get_master(dev);
> +
> +	if (WARN_ON(!tm))
> +		return -EINVAL;

[Severity: Medium]
Is it possible for this WARN_ON to trigger during a race condition with
device unbind?

If Thread A initiates USB unbind for the Audio Control interface,
devm_release_action() unlinks the devres node from the devres_head
before calling topping_master_teardown().

Thread B could then concurrently probe the HID interface and call
component_add(), acquiring component_mutex before Thread A does. Thread B
would attempt to bind the still-registered aggregate device and call
topping_master_bind().

When topping_get_master() searches the devres list via devres_find(), would
it return NULL because Thread A already unlinked the node, causing this
WARN_ON to trigger?

Since this WARN_ON is reachable via USB hotplug overlapping with deferred
probe, could it unexpectedly crash systems where panic_on_warn is enabled?

> +
> +	return component_bind_all(dev, tm->card);
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904162236.3212=
370-1-mikhail.v.gavrilov@gmail.com?part=3D2
