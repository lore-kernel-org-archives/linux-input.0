Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B830C16E;
	Thu,  6 Aug 2026 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059150; cv=none; b=roMgSBxz3qW8MidVBN5QEtLZl9fWvtajJR4yFI+6s/k6CP01kxqypGD3hiV23QqV7NC1o5lutpDcqo5/xQhxqCBJaDQb+Q3als9ieA83vwRvFWi5YjOOO99ZgKNwg7pIOckSkbOKXu7mdU+XWq4xGbjVwry+MA860KuI2f6zQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059150; c=relaxed/simple;
	bh=SjjqwDbA2OUpr1c5Btx7awJ++SJxb1hdaQGEGBcUdrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhoT346NV4i7sj9m1jkosPkNRnvSTW0OFWKqXt+7I6UpagwWhNt3TcigDPYsMDcvL1v/ZgHUggDL/mDoMHMpJ0rmm1O+aMyNWRrt4fYZsNlg8NVG2ypQPHwMgpNKHm9w3nVJPgd+GNTCunN7bfx/oXmeSiX6X+5Emzx/Bqi8KDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuIJvndM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuIJvndM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0713A1F000E9;
	Thu,  6 Aug 2026 23:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786059148;
	bh=mYVYfDEEfl9keszVXmDdgRY7w/vLy5C9cApYnwvZoEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YuIJvndMiWSTa6tu8TJ6XfTiAFlRBtLqM+shOtAB/qGxPpH5C1RBz6wHs+Yc0g+Uj
	 55apNqiLqF8KdT4ECvpwsY7FuuWxOdZa1rcPCDj8Zj99vfHXFqzWj3zrf5lv3Kmt5H
	 2Tg9ixUDtQVp2Sn9UgkVPKYfxbZJfPB9iy2NcTvmxlCZRglfY6UXYwncECYFDban/s
	 qB8xv+JPhPGx2uIh4V3Nil4/HRf8njOIpvMv+B/ryjfFAI0u/3cV66tBT2Yt0q3WMN
	 Y1CakHknVqktHuUFo1nCImMO4Gj0litCCUdm7DzG8Y6XTmCYBBrdYtUJ2iyam/QNan
	 D/gnE4/KXUDQg==
Date: Fri, 7 Aug 2026 00:32:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] HID: sensor: custom: Fix fields lifetime issues
Message-ID: <20260807003224.3eceff06@jic23-huawei>
In-Reply-To: <20260712005906.4f196ff9@jic23-huawei>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com>
	<20260712005906.4f196ff9@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 00:59:06 +0100
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> On Tue,  7 Jul 2026 15:15:43 +0800
> Haoxiang Li <haoxiang_li2024@163.com> wrote:
> 
> > Hi,
> > 
> > This series fixes lifetime issues around sensor_inst->fields and the
> > sysfs attributes that can access it.
> > 
> > The first patch creates the field attributes before exposing enable_sensor
> > and removes enable_sensor before freeing the field attributes. This keeps
> > enable_sensor from accessing power_state and report_state pointers after
> > the fields array has been freed.
> > 
> > The second patch fixes the original field sysfs group leak on probe
> > failure by unwinding any field groups that were created before a later
> > sysfs_create_group() failure.  
> Series applied to the fixes-togreg branch of iio.git
> 
Sorry - I wasn't paying attention to what I was picking up.
These should go via Jiri's tree.
Dropping them from the iio-fixes tree.

Jonathan

> Thanks,
> 
> Jonathan
> 
> > 
> > Changes in v3:
> >  - Move the enable_sensor registration reorder from patch 2 to patch 1.
> >  - Add a comment explaining why enable_sensor is removed before fields.
> >  - Add Reported-by and Link tags for the Sashiko review.
> >  - Keep patch 2 focused on the field sysfs group cleanup. Tanks, Jonathan!
> > 
> > Changes in v2:
> >  - Split the fix into two patches.
> >  - Unwind already-created field sysfs groups on failure. Thanks, Jiri!
> > 
> > Haoxiang Li (2):
> >   HID: sensor: custom: Fix use-after-free in enable_sensor
> >   HID: sensor: custom: Fix field sysfs group cleanup on failure
> > 
> >  drivers/hid/hid-sensor-custom.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> > 
> > base-commit: ef0c9f75a19532d7675384708fc8621e10850104  
> 
> 

