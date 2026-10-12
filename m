Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6B486B8F;
	Mon, 12 Oct 2026 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807808; cv=none; b=h88au+FJEFSJiF07tQkuth3B90j3PYGQgnF+H6fXgM4szPbnWAZ9fzvW9em1sVCoQ4c4Pje4LoALrLQH6g/UgTbjBxzk6OBAsmjnkaCwpGhk6AwKD1vajqRCBpc1EFdvu82gYCKy/aABYxeL6IMe/bvi8FXeflLkKseer8m0J3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807808; c=relaxed/simple;
	bh=rUSKGERkwN/rcqFMbcLy0bAwRRE1y3lV5GQcwGM1ovc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jxn9OzxktmtcC/XbVNGDednzNApHOOapyLNFxpYZXMqYTzI+7myr2v61mticqn7ubo4YnfkXHOLLsDeTlgH+5m4pPH97N7ahf/JFOrxchUDI3nSsaFRDYTQKTRdMoF5mAA9OC7uTDLIWiBTDOvqsDOUr57qIHu2pQTsyeEY7er4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+tQfomI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+tQfomI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249441F0089C;
	Mon, 12 Oct 2026 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791807806;
	bh=1D1YjjFNaaP04QW7aEk7Aj9nUzXjOnd11+JwMptP2EE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j+tQfomI7H/YR7bB6Lgsc3fbI/fxZmfuOCkIM5fb+bFQin7LCBrMPbc9R0shKcGqA
	 gX12D4SGiX9PgcXeBxwWZ03pkB+x0HHABimoABhct/lV8HqBsWYSH/Rkoqsj5tNqlJ
	 hUxa5KfUB9ZhWHCqeEAFJu0kbQzcWjtd4gh9wjvxfw3/aG1KMnNI9buiTSQd/RIQwR
	 N8RJL6SXtd9dfX2ueAOE7HbtksppaHXEjX9rAUGwqCRmv9C8KjFm3OJtIU0ZY6Q4RS
	 PkzVIPHntiN7CWvaHXsEvAsPEbjPtzYtVARqRvEj5C4KEgcbamr77HOHuLe7joTFAX
	 Db2/GiR0Ch9Wg==
Message-ID: <sashiko-outbox-168090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] Input: add Nsiway NS2009 resistive touchscreen
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miotsuki Mizuno" <founder@crepuse.com>
Cc: robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20261012121705.53396-4-founder@crepuse.com>
References: <20261012121705.53396-1-founder@crepuse.com>
 <20261012121705.53396-4-founder@crepuse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 12:23:25 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] i2c: i2c_device_id array lacks named initializer
--

commit 1329443f9d0fcc43d7767e5dcaca297c790eca05
Author: Mizuno Miotsuki <founder@crepuse.com>

Input: add Nsiway NS2009 resistive touchscreen driver

This commit adds polling support for the Nsiway NS2009 I2C touchscreen
controller. It uses the input polling API, managed input allocation, and
applies coordinate transforms through common touchscreen helpers.

Link: https://lore.kernel.org/all/20170315155140.54518-4-icenowy@aosc.xyz/

> diff --git a/drivers/input/touchscreen/ns2009.c b/drivers/input/touchscre=
en/ns2009.c
> new file mode 100644
> index 0000000000000..d5c1f9f96bb6b
> --- /dev/null
> +++ b/drivers/input/touchscreen/ns2009.c

[ ... ]

> +static const struct i2c_device_id ns2009_id[] =3D {
> +	{ "ns2009" },
> +	{ }
> +};

[Severity: Low]
The I2C subsystem guidelines state that initialized arrays of type
struct i2c_device_id must use named initializers. Should the ns2009_id array
use a named initializer, such as { .name =3D "ns2009" }, instead of a
positional initializer?

> +MODULE_DEVICE_TABLE(i2c, ns2009_id);
> +
> +static const struct of_device_id ns2009_of_match[] =3D {
> +	{ .compatible =3D "nsiway,ns2009" },
> +	{ }
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012121705.5339=
6-1-founder@crepuse.com?part=3D3
