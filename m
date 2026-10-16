Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8447606F;
	Fri, 16 Oct 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143231; cv=none; b=L36WOb046U7U1pbmpf4x1jVRoJtaf0YsyhPfaDkdEzl/89nW5qC91jHNlOlI6oNAz6E4RNrTCCHIoRBIILD+WpDWCkN1jGV9zicS9ZLhQSYK/dF9Sc06lC+6BHpyrCkY9Ss4iC2QPqdjnfBgdwlY59Wk2eLnfRhLorwzscKQzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143231; c=relaxed/simple;
	bh=vW5pdbfu3RTV+/33+7WBeXOYTdwfqNv1w++OxTGZIys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I0XadlAPXYUDeo5kqcSHUqPT8VxGKE9TNKrTyX13hw33cMvNhK7Rz+F6iiQWbr4MpjKEqRqGnywVJ17brUQM9+RWadAZe6jjO6gv890SQ2KunPudVaHCYWXZdiDJuKl6PJTltC446a2yRzzAGzbpKYn4jhZ2zn0KobF7weYTP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4cohOuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4cohOuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0651F000C4;
	Fri, 16 Oct 2026 09:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143229;
	bh=IWNpua3QXkxEJ4s2AulgkHOQb0Gd93hC51mLjGa7Cz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=k4cohOuB9UVT6IaNhfQobGk71KNxYjfhnT28J7ejTYZcLn0Ggdt/dUbdwdjOOqRT3
	 bXao69SwFR3ud/AOFoqpi8wktMwtgbp0TIyA1F+W4xhoP7RQlObH9a6HeJPHApuWId
	 fL93Wr8g3M9iWaHkublZuaWFo5vnTvZReEP7OZQzscx//00e8WpY0kd1xqeCiu0jRb
	 tcjkjYJgsyJhSaNYilb4qA0RzBIjIiyluXod1v0+eNTOP2Oqc0X4gbRAASdS1VKbDA
	 t7Ez+1sbED7Zz1rcesTrKQKacm1YEECk9+s245mytuE0XaM8wv7OeTqprvNjttvZU7
	 7/VcM0rJExS/g==
Date: Fri, 16 Oct 2026 11:33:47 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Aditya Dash <mradityadash@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] HID: hid-lenovo-go: normalize calibration failure
 status
In-Reply-To: <71564420-F3C8-4963-82B4-D23A6815D688@gmail.com>
Message-ID: <no46sqq8-4614-s481-572s-928p7pn8826q@xreary.bet>
References: <836F1B09-60CA-4A82-8293-0F9CF506E593@gmail.com> <20260923211458.32755-1-mradityadash@gmail.com> <71564420-F3C8-4963-82B4-D23A6815D688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 23 Sep 2026, Derek J. Clark wrote:
> >According to my observations, data[1] seems to give the correct status
> >instead of data[0].
> >
> >device_type in cmd_rep seems to indicate the left or right controller, and
> >data[0] the calibration device (gyro, joystick, or trigger).
> >
> >To validate that, I ran the left gyro calibration on my Legion Go 1
> >and failed it on purpose.
> >
> >Here is the raw data alongside cmd_rep, its contents, and data array
> >
> >  raw        04 00 a0 02 03 01 02 01 00
> >
> >  cmd_rep    report_id   0x04
> >             id          0x00
> >             cmd         0xa0
> >             sub_cmd     0x02
> >             device_type 0x03 (left controller)
> >
> >  data[0]    0x01 (gyro)
> >  data[1]    0x02 (failure)
> >  data[2..3] 0x0001 (reason, little-endian)
> >
> >Reading data[0] as the status would report this failure as success.
> >
> >Therefore I lean towards keeping it as is.
> 
>  Okay, Sounds good.

Derek, would you mind Acking / Reviewing the series as a whole, please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

