Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9D2FD69D;
	Tue, 17 Mar 2026 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768261; cv=none; b=KX7WmUXjNaIs7aa5hknhpFuf+6RGcDjvfJvP3l4aepf52WrKZhBhROPFjEeS2rd6u+g+38dmYe5rY4FLY38oATk6oQUSlnBsK8hdboMljVprLoykGcnk2i+C2y9AeqSosalUN/Sehh/fmkDvrYAhsH/SE7grXU2YpCLeikqp0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768261; c=relaxed/simple;
	bh=jJAHZrGqwR/BsdkM4g1XMcAlOE6apgU4gouZqNdWL8M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QgqTOhr9vWDcOyEefQinpJHn+kg6bm7ZpPR7G2Jonx538vpBw8bLJSy6P6XmWmBDN8SMGYYU63zrQnBKViXjpKLCpfsWqxZwaYEwXFhlBx97e8SnrgjTiIginMMk/zfdGjvnhfKHChfT/la58/8zjSdOsUTdh2bHykvAciQpEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXwW+dAz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXwW+dAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E231DC4CEF7;
	Tue, 17 Mar 2026 17:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768261;
	bh=jJAHZrGqwR/BsdkM4g1XMcAlOE6apgU4gouZqNdWL8M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=SXwW+dAz+e86ZF8uMkEHwAQX0QzoyrzBM6w0d30GOB/NFwSHdjaf6kgk0IAnAOY8K
	 TZIhNtbyrFlht54Zpw38mSI4eZSWk9lkOUYjpi45wqYJ58ns4fjLHvfbA+jSNFwuoC
	 1Y+EDw+sLIEs4WEtBtjHlhlnv3EJp4CghoQdBoV0KpNx06MjcMDCGw03ZOPKRDp9EZ
	 cGeGJOwpk1c/a0JHksGYFKESFW8d8BMT9eiho012MxNLlxn2KTvuUlKNO0Isp2cAq+
	 XAhhmZkW1nckys9UBdxDyypn60CYmuM6w2umnRKifvEkauVDdIaHmw0CH3b4UYt9AQ
	 J+NyP/sQzVoBA==
Date: Tue, 17 Mar 2026 18:24:18 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Lee Jones <lee@kernel.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related
 user initiated OOB write
In-Reply-To: <20260317172052.GF554736@google.com>
Message-ID: <o5n60785-0900-7869-sn47-7977p8so17nq@xreary.bet>
References: <20260317162426.1533573-1-lee@kernel.org> <abmEJJ9vWz5fiZy6@beelink> <20260317172052.GF554736@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Mar 2026, Lee Jones wrote:

> > > diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> > > index 44b716697510..885b986c7a12 100644
> > > --- a/drivers/hid/hid-logitech-dj.c
> > > +++ b/drivers/hid/hid-logitech-dj.c
> > > @@ -1282,6 +1282,12 @@ static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
> > >  		return -ENODEV;
> > >  	}
> > >  
> > > +	if (report->maxfield < 1 || report->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
> > 
> > This is all static information. So this should be checked in the
> > .probe(), once the device has been parsed, not for every single call of
> > logi_dj_recv_send_report().
> 
> Doesn't report_count come from the device?

The point is -- maxfield and report_count can't change once parsed unless 
the report descriptor would be re-read and re-parsed (which doesn't happen 
in runtime, only during probe).

So checking during probe/parse time just once should be sufficient, 
instead of checking it upon every received report.

Thanks,

-- 
Jiri Kosina
SUSE Labs

