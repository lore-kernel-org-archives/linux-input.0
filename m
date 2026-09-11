Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420FB40E8FA;
	Fri, 11 Sep 2026 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141234; cv=none; b=Cfx2lViA3DfIeiJU+r7W8nu+hkwa7zAGYtkWEzkFk5yFnqwMhJmgcqCn8al3yxWj4+haDsr6dGHHSuqZzS+8a9eDiqjojHIOQDVBd4v26+GCZR+B5HAwWcCOTN11lleXaPtgmM/Hkq+0bvoBFEahgx6piWxaR0AuRzYdZiQQiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141234; c=relaxed/simple;
	bh=6q0fEYtRDaQ3TnwgxKhvFA7rrQiEmKwTtJmYF+eXSsM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dptCwGejjIx9erspwCT1broLmUvARL2RAoMXGt7N/cAW74EQcXS1K/L8J5ApkQ7RwprWLm6IhjKYrF/wQYjCOInnvWZ9KiODu6xh2xr9wN5hfh0qr+aucJE31DVMFZuySHNSO947qfDXi7rbk6L5XK/A2XT38aJDonGN3739XYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q13Y7ssR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q13Y7ssR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F961F000FF;
	Fri, 11 Sep 2026 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789141230;
	bh=ERdZYnFM2kdgLye6/mB0A1/pjZiD8pgvKOmh4lYlS7Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Q13Y7ssRQqt7unMoxsyBWWuxBVsCK4Op6tOcd1tly8+GDbUK66BvLs13Ki33bjS4H
	 zewSKIOyahJ4uKy9zsFhTI2uCfBSNQg4oYGL2JZ67m+HJcvTinrM1pKJ0RoAZbAxJz
	 q52bHljDcrvzKT3DCqNldjDF6FG5Ak0AzPnidfhTzBMQ0Nz8OXnduojAvaFn5YZSsB
	 Q360Wn262Z2HDEWvHxaV01BOYrp5jsY3mPlYVB8OZbIZuF73fUjaG2VqOXs0tl+Uxj
	 htdjfSx1KGHOoN/uGojzP1asznVyViWOL0uaGsqcCDvQuIvX/nyNT1awdTUSxsT+nH
	 A1At64xlSgAOw==
Date: Fri, 11 Sep 2026 17:40:27 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: use designated initializers for
 acpi_device_id
In-Reply-To: <20260908-acpi-hid-v1-0-08df24c4b139@thegoodpenguin.co.uk>
Message-ID: <r79s6r8r-8732-8832-n310-r2293pp2rqq3@xreary.bet>
References: <20260908-acpi-hid-v1-0-08df24c4b139@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Sep 2026, Pawel Zalewski wrote:

> This series is converting lists that contain the acpi_device_id struct,
> which is defined in the include/linux/device-id/acpi.h to make use of named
> initializers (which they do not use currently). This work is part of the on
> going effort in the kernel associated with device-ids [1]
> 
> The plan is to convert acpi_device_id::driver_data to have an anonymous
> union, similarly to what was introduced for PCI and I2C device ID tables.
> The goal is to increase type-safety (most of the existing casts are gone),
> to improve readability and to make use intent a bit more clear:
> 
> ```
> union {
> 	kernel_ulong_t driver_data;
> 	const void *driver_data_ptr;
> }
> ```
> 
> But for that to work all lists containing the structs need to use named
> initializers first to avoid triggering -Wmissing-braces. I already have
> patches that implement this and touching a lot of kernel subsystmes that
> use the acpi_device_id struct and that list keeps on growing. Therefore,
> I have decided to split the series per every subsystem into:
> - pre-clean-ups that convert the lists to use named initializers
>   (which is this series)
> - actual implementations that make some of the modules use the new
>   driver_data_ptr member (does not apply here in the HID subsystem).
> 
> That way the task can be fragmented into manageable and independent chunks
> of work and makes this effort easier to review.
> 
> Tested builds on x86-64 and a64 in Yocto using 7.3-rc2.
> 
> [1] https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> 
> Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
> ---
> Pawel Zalewski (3):
>       HID: hid-google-hammer: use named initializers for acpi_device_id
>       HID: i2c-hid: use named initializers for acpi_device_id
>       HID: surface-hid: use named initializers for acpi_device_id

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

