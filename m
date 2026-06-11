Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02F2EEE76;
	Thu, 11 Jun 2026 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195792; cv=none; b=DBaMLYk3M8riEH4P1kMs3MDaATqeaSIj7OtwXqVB5vDhBaPxF5qG+tiktwfzQa1IgqRxNgOdppCDWBNNznK3b2r7FlDiDlcJEBmAE9Wei2QCwfNDAD+/NSGClN0Q4SBk3Ugkg4AZbUmYUcZ3fk43bol5JyqzN+1py3dOk9vGsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195792; c=relaxed/simple;
	bh=z+TmawM80eM7L6U56jNJTWzbgtGoBiOdxUnEKz7y8R4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKIk22gJcfPSinoZrWY+4qx84uTiKl2BKZbK11mSdnY5jzN98b1Lt25/VBSfaEmdNBRn434vBm/5Zb3eIavisgpU5DpKJtlprUfkSBxTx37f0D/pIRc3mz9Wu249JRp+/54qcHsY6+kD9aZhs1KuzEzC4xwmHfZggpW3u4nokBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW1dn9p2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW1dn9p2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201BD1F00899;
	Thu, 11 Jun 2026 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195791;
	bh=+e/LpIKVA10deAUH78jEeyr5+/LtMTnm5dGbVrDweww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XW1dn9p2A0eY6I5C3+0PoCWhaErVxMHiimW7oMJKr3Jkqr6P4L8Wny2HkfZVp5EDg
	 S6uaUIGRWEWt9dYh2Xw2B9y3RYR1pEwP/5NpoYSKZ4Ob1NvSsiN+saKD51r2taKQpw
	 qLL8VphNvtOPUjk+zXoTH4zJbTv3xK3Q3IDdy0zYzKa8eEgvNkoh7YVX9aV+S2XBkc
	 5A0/FqSJgOvFzZObHoMACW6yZZenrEu24mcoO2ElTg508Xvgk7HZWvvxbsE7YeBS2G
	 /AnvhiPVdme3i5vbOyEyMfVDUb3/D6iDqtTW6bO8oTtnqwLFILynMFrTsLFjs130gb
	 GLc0wCOxRFeqQ==
Date: Thu, 11 Jun 2026 17:36:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Zhang Lixu <lixu.zhang@intel.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
 <bentiss@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: sensor-hub: Add
 sensor_hub_input_attr_read_values() for multi-byte reads
Message-ID: <20260611173621.2f981f22@jic23-huawei>
In-Reply-To: <nqr90q40-s472-o23n-nqn5-2s31qs75s2op@xreary.bet>
References: <20260610082911.157232-1-lixu.zhang@intel.com>
	<20260610082911.157232-2-lixu.zhang@intel.com>
	<nqr90q40-s472-o23n-nqn5-2s31qs75s2op@xreary.bet>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 18:41:27 +0200 (CEST)
Jiri Kosina <jikos@kernel.org> wrote:

> On Wed, 10 Jun 2026, Zhang Lixu wrote:
> 
> > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> > sensor_hub_input_attr_get_raw_value() is limited to returning a single
> > 32-bit value, which is insufficient for sensors that report data larger
> > than 32 bits, such as a quaternion with four s16 elements.
> > 
> > Add sensor_hub_input_attr_read_values() that accepts a caller-provided
> > buffer and accumulates incoming data until the buffer is full. The two
> > paths are distinguished in sensor_hub_raw_event() by pending.max_raw_size
> > being non-zero, preserving backward compatibility.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Co-developed-by: Zhang Lixu <lixu.zhang@intel.com>
> > Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>  
> 
> Acked-by: Jiri Kosina <jkosina@suse.com>
> 
> Jonathan, will you take the whole lot through your tree?
> 
I can do that, but as a fix after rc1 now (and only once I have
a suitable Fixes tag).

Thanks,

Jonathan

> Thanks,
> 

