Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877773F6C32;
	Wed, 10 Jun 2026 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122093; cv=none; b=P7LuYm0Db4CWm4U8Ng9Yg+ntINCrr09vd1yCEQ/KLxegW1GkGAZUmeBpAmwN5H9LARpcYbu+a+k5dAMJJJv7Ir9cAbXVh4JHypcwOFwjsEQ707L2z+n9oza1zO0Hj2jETv9XOyj01ZoH6cbiK2pyH/zC2y6gk7HAUOwFgDDzDsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122093; c=relaxed/simple;
	bh=udZHjDovNGQz3J0jqm6nxndgGlTA+vzoEBSpAgrzbec=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eebaAu5f8Clkolr/q7hL+S+CRbXB4yQrXw68fYIkNYjMaoN9VWtPESCe6U8BOaGd/LHPrTTkjhCX0PKip6b7F3UXYIC7eP3G66N7wu9rjlh0KYQh7EYpsMvcqO5XEOxG8IfxXVO3K3dXIHy6AJzcE7/oaziFBYd0dZewIl4rh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHgfI99s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHgfI99s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B82F1F00898;
	Wed, 10 Jun 2026 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781122085;
	bh=v1c9430jxqNxY8kHz0d/M4AlTxUJS8etpWW1n1kR9nY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=gHgfI99sBRYR160quPklf6oYZca8xeWyOhHFWYQ8kE5AlXg9jQ8rYbQmMn/0cP3or
	 ytA258hdnIlgTfsGm4DtIXL1L/7N7AP2wVsu0DMFjVlNWfidF/3rOCXOvOuFtuSDLW
	 RlSIspb662l6iBlnzGJvDaOjToIfr2Eik1EkPJKhZWFWEkB0Aw5ruQ369DyOcWqL4Y
	 JmgPhxHJ07iSA5aivq5B1hHzNco3KYVF1U1KtI3YHcp8Qd8xBn89INoCvJJaXWKj6c
	 FikyKkE2BXud8zYu8cL6sfRtPUZqqau/uvZ0HmX9bQ5aqKIBNkzM9xfECCPVSqpe/N
	 aMn0l73oEuWzg==
Date: Wed, 10 Jun 2026 22:08:02 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: d3z <d3z.the.dev@gmail.com>
cc: even.xu@intel.com, bentiss@kernel.org, xinpeng.sun@intel.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    sakari.ailus@linux.intel.com, abhishektamboli9@gmail.com
Subject: Re: [PATCH v2] HID: intel-thc-hid: intel-quickspi: reset touch IC
 on system resume
In-Reply-To: <20260601211828.112626-1-d3z.the.dev@gmail.com>
Message-ID: <92pon69p-8p64-2rr2-2553-rrr732s1996q@xreary.bet>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com> <20260601211828.112626-1-d3z.the.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Jun 2026, d3z wrote:

> From: Danny D. <d3z.the.dev@gmail.com>
> 
> On the Surface Pro 10 (Meteor Lake) the touchscreen stops working after a
> suspend/resume cycle and only recovers after a reboot. The driver logs
> "GET_DEVICE_INFO: recv failed: -11" on resume.
> 
> This platform suspends through s2idle: /sys/power/mem_sleep exposes
> "[s2idle]" as the only state, there is no "deep"/S3 entry at all. The
> touch IC nonetheless loses power across that s2idle suspend, the same
> way it does across hibernation. quickspi_resume() only re-selects the
> THC port, restores interrupts and DMA and sends a HIDSPI_ON command,
> assuming the touch IC kept its power and state. When it has actually
> lost power the HIDSPI_ON command is never acknowledged and the
> descriptor read fails, leaving the touchscreen dead until the module is
> reloaded.
> 
> quickspi_restore() already handles this for hibernation by
> reconfiguring the THC SPI/LTR settings and running reset_tic() to
> re-enumerate the device. Make quickspi_resume() do the same when the
> device is not a wake source. A wake-enabled device keeps its power and
> state across suspend, so it stays on the light restore path: resetting
> it would discard a pending wake touch event and break wake-on-touch.
> 
> The non-wake path mirrors the existing quickspi_restore() sequence,
> including enabling interrupts before reset_tic(), so it introduces no
> new ordering relative to code already in the driver.
> 
> This change has been validated on a Surface Pro 10 running the
> linux-surface kernel across multiple s2idle suspend/resume cycles; it
> has not been tested on a mainline build.
> 
> Closes: https://github.com/linux-surface/linux-surface/issues/1799
> Signed-off-by: Danny D. <d3z.the.dev@gmail.com>
> ---
> v1 -> v2:
>  - Only run the full reset when the device is not a wake source
>    (device_may_wakeup()), so wake-on-touch is no longer disturbed.
>  - Reword the changelog around s2idle: the SP10 has no "deep"/S3 state, the
>    touch IC loses power across s2idle.
> 
>  .../hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 60 +++++++++++++++++--
>  1 file changed, 56 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

