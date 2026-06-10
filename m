Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564333344A;
	Wed, 10 Jun 2026 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109692; cv=none; b=kvwT9Q+ihgQyUKMKMcup3i5voeQBFK72tssBlcigy/e1RGCB25JC/c/0/kbbXVniIC8IkMSjDRg+v+01WFAiIoLXV4nwYcVaqgD81ECQuUp4kTiON+aUpThyjjvDzmMPu8f3Q0yKlz59gyAZ2onV7KeeCpXLes0o6SGvX2pLb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109692; c=relaxed/simple;
	bh=+21KKX8Q3ecdUPPp68pJ8jW7io6sie8rWuXNcKutUlk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yf73jJKSCX3o8EO8yrvwZLi3/dYRluFjYVf76S0N0tlEAbOjiiiPYQxnYBCXu/IICmVxjkSLbLtg4bNuRL7wxih1+xLEz5+4FsQoWyo48qoJtjplc1XUWqoT/alhs1rSQcMBZy4b1canmziSKB/ChmMOhFyMjQYEsmzEkXFUVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2OHrW1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2OHrW1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD8C1F00893;
	Wed, 10 Jun 2026 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781109691;
	bh=Td/xCCnMUXCa/D6DfB247abV1CMQlO1TdBc8f5zxngg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=M2OHrW1lVYmWB3Dbn0lVKhKIOFupIoylkUBoY8hgyXXolxd0reALc3cZqO9MyQEqW
	 ouX1hfD6RIj/rS+bxdEfCy+AumIs0lZEQBDLaz30rbuuQPXE56/MVVIUw2jntbGtoU
	 FRqA7kNEMGzlCLNOMq/kCxErFoy4FixCFdXX86/7u3EmwySM57tOFMNsq7SImpJ40G
	 IzKFHRuhkBLfiZL2KHpAk1VKMCoayqSe3t3nzchJOoll2pP7iViwFw88jmiglIDaHW
	 g+8wGJvxR/okL9uR0sI+RXLDmALKDlCWkN0waq3yvQgGyGTYQzG54/S74uW6XDpx7M
	 xKEXrE/XYda2Q==
Date: Wed, 10 Jun 2026 18:41:27 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Zhang Lixu <lixu.zhang@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    David Lechner <dlechner@baylibre.com>, 
    =?ISO-8859-15?Q?Nuno_S=E1?= <nuno.sa@analog.com>, 
    Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, 
    linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: sensor-hub: Add sensor_hub_input_attr_read_values()
 for multi-byte reads
In-Reply-To: <20260610082911.157232-2-lixu.zhang@intel.com>
Message-ID: <nqr90q40-s472-o23n-nqn5-2s31qs75s2op@xreary.bet>
References: <20260610082911.157232-1-lixu.zhang@intel.com> <20260610082911.157232-2-lixu.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jun 2026, Zhang Lixu wrote:

> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> sensor_hub_input_attr_get_raw_value() is limited to returning a single
> 32-bit value, which is insufficient for sensors that report data larger
> than 32 bits, such as a quaternion with four s16 elements.
> 
> Add sensor_hub_input_attr_read_values() that accepts a caller-provided
> buffer and accumulates incoming data until the buffer is full. The two
> paths are distinguished in sensor_hub_raw_event() by pending.max_raw_size
> being non-zero, preserving backward compatibility.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Co-developed-by: Zhang Lixu <lixu.zhang@intel.com>
> Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>

Acked-by: Jiri Kosina <jkosina@suse.com>

Jonathan, will you take the whole lot through your tree?

Thanks,

-- 
Jiri Kosina
SUSE Labs

