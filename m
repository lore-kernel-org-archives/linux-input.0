Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF8381E85;
	Fri, 11 Sep 2026 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133557; cv=none; b=lGqFbXz+SgsFYvVfArPkIJ5w0X9l+a365fl9QRaw7KGizLdndBSJ8V3Vcr1TwMlsFIoybVJOSTTIGcr94lyT8WJJAQH99azgc8Ywon5MsdJ09+eRbf6LPo4BzmEbz34xyn+GUnUCzl1w1eZZGRx8ygaGqcxEZ8Ou1LwfYo9nAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133557; c=relaxed/simple;
	bh=LFzh7LWOzSlpj7r2dxLA2mkmiyjKSJygs60oZ2yUeGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pi32qE9rnPO/nKRPmP+GsWceW+auHBvfrf7NYRIo8kzBlnsfdkiSVXsfmJ/FSN/Ulpk04fRR0fVd8i1KvSIuvrWfuzQWKvPxrYkkNb32hxbjbUEnPxGs2KXd0vDcecOulrGKwmkwmfj0EGqgaqpe+qPYZLhDAyTUsvlVIPymyCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP9aC55C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP9aC55C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736A21F000FF;
	Fri, 11 Sep 2026 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789133554;
	bh=uirpkPnM2HG9bZd+R/1x89vey7kgMMJP9N/VMKiq/Q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XP9aC55ClmeuvOvoJ0Br5qPo30fBjCxSWtMadP0wWFz8VHBMMxF2xZahMcqdoAjLN
	 pPgdsq6e4Nqm7nmv8kra7FcfQB1LBp5cFfgshPx7ZvUqp3rJDg1M2i+S6LLS6PuBv+
	 P4w9Ps6F5AWkfPnNCyVr8DxlZGBNkg9S5Pv226DhIrn1nIzI+MQLxkh7rMyELF5gwF
	 Q60Y48eW8AGEywyN2M0EnaSSpj5K2MKKaIf0yYKzXG4KakNVNEILVecYd0UH0RY4aU
	 QmOuHwqJGdgOyVjo/tYWUNG7aDOT73NrboOznUwkYlwP8i04/C7yKHEOyzCK14YCyS
	 oH8JTCflNCzwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] Input: synaptics-rmi4: Support drm_panel_follower
Reply-To: sashiko-reviews@lists.linux.dev
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260911-topic-rmi4_panel_follower-v1-2-c1b2cf1cdb62@oss.qualcomm.com>
References: <20260911-topic-rmi4_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com>
 <20260911-topic-rmi4_panel_follower-v1-2-c1b2cf1cdb62@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 13:32:33 +0000
Message-Id: <20260911133234.736A21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent I2C accesses can wedge the hardware during panel power-=
on because `page_mutex` is not held during the startup delay.
--

commit 31e9aa4b11936c658845014c2ef2567c8d7947f3
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Input: synaptics-rmi4: Support drm_panel_follower

Many RMI4 implementations are present on in-cell panels with very tight pow=
er
sequencing requirements, normally handled by the DRM panel driver in Linux.
This commit adds support for drm_panel_follower to handle that dependency.

> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index e11d0acb9b96d..84877030aefe9 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
[ ... ]
> @@ -187,17 +191,99 @@ static void rmi_i2c_regulator_bulk_disable(void *da=
ta)
[ ... ]
> +static int rmi_i2c_panel_prepared(struct drm_panel_follower *follower)
> +{
> +	struct rmi_i2c_xport *rmi_i2c =3D container_of(follower,
> +						    struct rmi_i2c_xport,
> +						    panel_follower);
> +	int error;
> +
> +	error =3D regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
> +				      rmi_i2c->supplies);
> +	if (error)
> +		return error;
> +	rmi_i2c->powered =3D true;
> +
> +	msleep(rmi_i2c->startup_delay);
> +
> +	/* The page-select register is reset when the sensor loses power. */
> +	mutex_lock(&rmi_i2c->page_mutex);

[Severity: High]
Can concurrent I2C accesses wedge the hardware during panel power-on because
page_mutex is not held during this startup delay?

The drm_panel_follower subsystem calls rmi_i2c_panel_prepared()
asynchronously when the display panel turns on. Since userspace is not
frozen during this event, a process reading a world-readable RMI sysfs
attribute (such as update_status, which calls
rmi_f34v7_check_command_status() then rmi_read_block()) or interacting
with /dev/rmi0 can invoke rmi_i2c_read_block().

Because rmi_i2c->powered is set to true before the msleep(), and page_mutex
is not held during the delay, a concurrent rmi_i2c_read_block() can acquire
page_mutex and issue an i2c_transfer() to the sensor while it is still in
the middle of its hardware boot sequence.

Does this early I2C access violate the strict timing requirements and leave
the touchscreen completely unresponsive until a reboot or driver reload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-topic-rmi4=
_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com?part=3D2
