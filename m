Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861A3AB28E;
	Fri,  4 Sep 2026 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490652; cv=none; b=ONkIOmLnqtN5MIXHpNJKCwB2MAgZuNSXgnwOEdi6pjIKmgJeg85iUmIMe6ojmrJgCD/w4CCXWOKfOpnvRIW+mOdJ50LwUcckAdEUtjF0As1kL+o/Qh5JQ8WsNfm6jVD2ViypU/FbalA1kBIPwdnwY1lLlZLv7eaxaBkzlke0pLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490652; c=relaxed/simple;
	bh=GemFk7qd7jKf36VUjTw88H+RTl2AUJYtDiHlNxzn8vE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn3a7Y/raG3jI3Ojr2axPC+d6AMefM4wcvwF/2nMVsT6tUwtgLsQWfOCZu1n26S5M4DLRxb/oM1VJlHFf0ezmL6Ee0dJpGX8qrTXylR/roC7DamAqzZ6yxViOmpPJhohEZlf9nEb9Z+I6ESGpu7n5oOwKPC/wywvnEBWx1PkdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBek6etm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBek6etm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FBB1F000E9;
	Fri,  4 Sep 2026 02:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490650;
	bh=/OON/wKQui0ZRYf4x/MB2IOYmtvsSN6+9H+z12uAFCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jBek6etmBZvZVphHhuWa3J8bvivsrOYR3ZDEardAzJ9jYrLn1qmh+ONIZyBedHVaA
	 KIn4q3frC+35IVmE2iVj7pWDTQEfECa4VGHSelO7WH9nh7r3Nu5YWUrWcvR5S7Bx3X
	 M0jN2o8wsnkkc6/XLoakySaqEfHGJMZQafUUgCCIK8biakYsQAtF0f+Ympb/qyvnq7
	 ZtsdQbm331gL5AS1a3BES4rDBydqqXlSW57XE25fBKR1d7qxCfJo59zwbhrC+030KL
	 13PZuVOJJWGcL2CC4WgOAVmeFYV37/gPrkfD1C2lSaA3gESKqFYRkCIysjQW0rWy6z
	 tuPdxWUQ5ycmQ==
Date: Fri, 4 Sep 2026 03:57:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eliav Farber <farbere@amazon.com>
Cc: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
 <guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
 <lenb@kernel.org>, <laurent.pinchart@ideasonboard.com>,
 <linusw@kernel.org>, <brgl@kernel.org>, <orsonzhai@gmail.com>,
 <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <dmitry.torokhov@gmail.com>, <hansg@kernel.org>,
 <ilpo.jarvinen@linux.intel.com>, <W_Armin@gmx.de>, <ukleinek@kernel.org>,
 <fabio.m.de.francesco@linux.intel.com>, <kaihengf@nvidia.com>,
 <ankita@nvidia.com>, <leitao@debian.org>, <pedro.pbg@usp.br>,
 <paulmck@kernel.org>, <frederic@kernel.org>, <kees@kernel.org>,
 <saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <acpica-devel@lists.linux.dev>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 04/13] iio: position: iqs624: use
 devm_blocking_notifier_chain_register()
Message-ID: <20260904035720.6046b03c@jic23-huawei>
In-Reply-To: <20260816060648.4030-5-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
	<20260816060648.4030-5-farbere@amazon.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 06:06:03 +0000
Eliav Farber <farbere@amazon.com> wrote:

> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> iqs624_pos_notifier_unregister() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Applied to the testing branch of iio.git

Thanks,

Jonathan
