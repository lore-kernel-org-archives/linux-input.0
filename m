Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579631;
	b=3U8bs2gP8fg5+iUGnNk9JI0InF9X5eck68uMKxgbgOnWC7zNKYqWMB8uwVQ5CP70btR9
	 z6g4xrsJjNhg4MDNZ3fsI2w0yUVNDuswhTIiEtDz0HDumh/CJFG9xIfgq0qDyC6YgV6d/
	 FMGM7XoUuhIHApxhlsLKqCfOlHXu/Bc5d0f4TBdQ7r2A+P1CPI7APSCuowt7MgLMWfBG8
	 f0OJ21Djy+ACVfCpv0Uz+XopXWsUg7C3FMAFVCDxraw+LuwsyUExH+C3r848RczTo91h7
	 TGdulvkTGah4oaA4GbMo3fgq2idA2UNn9izpZsgbdC2t/d8WaV5HDHzduaNzwdzHsjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579631;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+iLK3dfiz/25MVVcB9U/Ow2cWcTI0SjLi1jvv+7sK2M=;
	b=hdG/Rp9gThEqPeRIfQLjoOzbLu4bNoK0Ui3zvUaVR5m0Z7sJ0GUzla7NqUMJdAicuyTy
	 wRgSEEkZ9zhVl2eW6d/rX2Zreegb/gE4uxPhjtfxsZB6Qb5mOLmd5rc5bk1VvjlYgRWP+
	 699WCfOixslQGJJZhKFblYNbzGPljrOOCycvcr31a9tC3alXSvrR9KH5Vb1DFOgRBxbTl
	 Xf03Z2XtvdHh92ySaO1knVpV7e5dy59M67PSy3MU4jhr6gHENgU4nVrxnH5yNi3uKB724
	 Sq4pibYz73KImduHaA/izgQvbBooSI8ZpANVNdXhZLpAvwte+zA9HRecvdRbTRdmWmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EoptoyeI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA1606A324;
	Mon,  2 Nov 2026 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EoptoyeI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ECC1F000C1;
	Mon,  2 Nov 2026 00:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793579631;
	bh=+iLK3dfiz/25MVVcB9U/Ow2cWcTI0SjLi1jvv+7sK2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EoptoyeIunkuHppXjEmY13yIbhsD04QkXCKcVdNR7EXNt4pqdfakTJuz/CFC5JDz0
	 Qa/p7WzNQO0yVjbzPOyH9/r0ilzHP5n9rOjA7H2RToiN5J8ngNEY85sNOCBUvFn9c3
	 fmUuzNVQHMarHBjGylREF95ih+RTjpIxOV6KS+drFtjxAZXwTu0twNitnMCUhSiawS
	 lwmbemhA34+2+dJQizeoIY6xH8WW7J22kuTFFt/OWORXf6RAvpG14WW7Q9SYFbck1l
	 omf4cjW77N26g7/+Welo9jfwyuIM0fj1iC2qc2lvlxYZpgFWzvFHEDBW+wZQEFqZqO
	 6zvzozzkb04Fw==
Date: Mon, 2 Nov 2026 00:33:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lixu Zhang
 <lixu.zhang@intel.com>, Joshua Crofts <joshua.crofts1@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: hid-sensors: fix shared callbacks in
 temperature and humidity
Message-ID: <20261102003344.7cf96f75@jic23-hlaptop>
In-Reply-To: <20261019023420.83976-1-ch@murgatroid.com>
References: <20261019023420.83976-1-ch@murgatroid.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 19:34:17 -0700
Christopher Hoover <ch@murgatroid.com> wrote:

> hid-sensor-temperature and hid-sensor-humidity share one static
> struct hid_sensor_hub_callbacks across instances and overwrite its pdev
> on every probe. With two temperature sensors, reports for one go to
> the other's pdev; once that device is removed,
> temperature_capture_sample() dereferences NULL. I hit this on 7.0
> with two uhid-created sensors.
> 
> Patches 2-3 make the callbacks per instance, as the other HID sensor
> drivers do. Patch 1 makes sensor_hub_remove_callback() take
> pdata->lock, as sensor_hub_raw_event() does, so a report racing an
> unbind cannot call through the freed callbacks.
I know Srinivas is just back from holiday, but though I'd just ping this
one as waiting on him taking another look!

Thanks,

Jonathan
