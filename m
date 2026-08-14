Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC431327D;
	Fri, 14 Aug 2026 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715881; cv=none; b=LcOwSyFdWJLHLlN1WsSI7Gx+nPRKij0DH54Xb7LuiToRzLY/Cda6fpohC4cEfs+OO8EK0dL7ggC3L0fnq8SSlSvQJ9Hnp62PHGKGct/U/m3FcAZvmzqvxC+E0L3uSfd4TTUy51EFykiA/ipYAp8zIHTgFNTx4cxCUvvZ8QFmgsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715881; c=relaxed/simple;
	bh=JdjW0CtJ/K9qSVeoF6CFrACgaPKqAQB8mkPYPP5tTHg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Us3QF1FPuKUpvrGHDSltwy95O4KlOk+ehuqOEOrX8uDs54H9dOdjBqPaaScV+8c2Ti6DB4oCuqQsSb9ZdU36CGiIOx7IaVEcf09DnnGEFE3XE7yJha9j0bhRKkTslq9dwo1MWXCwLFmm0oAY2GM9Jj7ptnXV9udglvlNH+MRWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHnMCZ3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHnMCZ3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8E91F000E9;
	Fri, 14 Aug 2026 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715880;
	bh=WLaxlG5gwQGLf/9/6lRfQscDo/MAP8DCMXMA7p5Ifxo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=NHnMCZ3scVQy/EtOwz8q8/xHrvYGCzTzrpUu2btyM6BjI31SVEwJS48ifFGZyKAcc
	 No8CKVZtk4TnFmIg7nklbIuLCtf5cHiIyJX9PDgWxCjyDSUM6QhqwK5TAgev2z8eqA
	 tvySP2AHQX4/H1axXvS+hZ/JF9zAijXIEWBikUccBnnXLWRssjr+eI9Jn+NXVpXwmu
	 wi4oTTGC4Rw577J8DUxmqYVwgkfY3Am+ZutLexHeUMNQjPlsY28taBFF6fc3OpMLFA
	 pM0jS/3c96N+ENn5hyHXE5ttuEMALmLiapZJI9ZU0K//lIAdBf3/2oE3pM4Q3Ct93O
	 tR/i0hPLSkylw==
Date: Fri, 14 Aug 2026 15:57:57 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
cc: Haoxiang Li <haoxiang_li2024@163.com>, srinivas.pandruvada@linux.intel.com, 
    bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] HID: sensor: custom: Fix fields lifetime issues
In-Reply-To: <20260807003224.3eceff06@jic23-huawei>
Message-ID: <97qr118p-02s5-185n-r974-46275s0109n8@xreary.bet>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com> <20260712005906.4f196ff9@jic23-huawei> <20260807003224.3eceff06@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Aug 2026, Jonathan Cameron wrote:

> > > This series fixes lifetime issues around sensor_inst->fields and the
> > > sysfs attributes that can access it.
> > > 
> > > The first patch creates the field attributes before exposing enable_sensor
> > > and removes enable_sensor before freeing the field attributes. This keeps
> > > enable_sensor from accessing power_state and report_state pointers after
> > > the fields array has been freed.
> > > 
> > > The second patch fixes the original field sysfs group leak on probe
> > > failure by unwinding any field groups that were created before a later
> > > sysfs_create_group() failure.  
> > Series applied to the fixes-togreg branch of iio.git
> > 
> Sorry - I wasn't paying attention to what I was picking up.
> These should go via Jiri's tree.
> Dropping them from the iio-fixes tree.

No worries, I've just picked them up.

Thanks,

-- 
Jiri Kosina
SUSE Labs

