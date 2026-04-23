Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731542AA6
	for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965054; cv=none; b=DPG/g3Uz33HYuhMGUvMpoxEMJ+fymfIVL6rpy72YLNWT4J3cXJ6/59B1e9Ch35LxIyLm9DTUkQ3yMkPPONHg8xbENyXzs+78S77K86PTUrb9RsJSMjebn93qYV41ZKA1mijtNzaa/fwEDHf42jvGEwmwri0YQh25atqt3JfDdvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965054; c=relaxed/simple;
	bh=FO3LihRMtSAe5CC6vyzEK6/XGTlkw9lZsMKeZZvdXws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmXcBNN1xoGsVwt7gKgO1BPaTbUGFS8v/ydTSpRa7m5Wj/R3gtWwR2puMlbXIVWZNre1HP0Ct1cUYeyOKz0FS2I59U/K35BVIa+GrdRPN7igIabC1J/8rN7HQosTrhBqd8ppFSYOdsX6H3AjGKvrtK4mRHsPGigGZLjlNNE6p28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqfZU/56; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqfZU/56"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1279eced0b9so10317166c88.0
        for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776965052; x=1777569852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JgwqX5pfhmFEj4eQ0zNPlI36ziFgHDkO24T5ZYsAFjU=;
        b=IqfZU/56TDHx43u31H01GE76XK749EN3dpEZKMxGaNy4KJvIolsrDMJn0qSGkkMzo1
         uwrbYooELEyAIznoEeNsxD/Ue8taWhQqeoCXwI/y7gzMjWTtvCdAXuzIGIhMwBPC27jl
         AagzBlcTzCbHVJUkHoEc/7nud5U0xgeNzvq7kCOMajSwKukLZ1E9ymQ+fcbuvzr8c46p
         jdKB0HrCJbi78gdsCa2aqyW400A1SF/FQ/6uDoR8CVwjONMbHUl3nT+C7p2f3Zx1eLPs
         klFSBRhDUV69w5XHN5kXOhwHhqiM3EtFgBRtBfmyRyjsP4OljOG/3Q9z/2SxYrX+iXtt
         +wvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965052; x=1777569852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgwqX5pfhmFEj4eQ0zNPlI36ziFgHDkO24T5ZYsAFjU=;
        b=YYBuoPsffQzbX2TxdTq9tcSehFmCPRsf8DlNVVoCGJAuAJ9Ns7g95k3OP7y5dG/bEC
         NyTK7VJwzqHw3GSNJBsY1q+tMTI5g2YR2MXegf793Quv1SDHRDwiLmP1DAFNdtqJJf4D
         I4on99TXeomxX5TIej9z5PBSJmW2MPVcDCUFzKQCinPa/qNjayzMaw5tJmgds+6+lPvR
         X1aO0GK34HS3QF6Cq04xPAjmPTdQ99Dt2A9dv2Kgr/TYjLkSi2AdZbYk1utQV5kr9aFK
         CfllloR2FBFuruSyYZSaLBQtngQL3jHQv0csLpi1E4KVBVTBqjLE0M4zBCcJjHsEn/rH
         zRYg==
X-Gm-Message-State: AOJu0YzFnksxDGRaxppuXavSKRLRmwKv4I8JRdEkYijqaM3+gy5a3ag0
	SfXE//xyFYGb0Nnc/CQhax1l8bzRtAnNlwK69Ihf8Yv26EuqD7HykJf4
X-Gm-Gg: AeBDiesoYFwko/GzJLHYNhgk9g5QGgV364U04i+/lVQakutgNznlroZAlOvmAe0CYj4
	9EO3oB8rd6xjGOMQtKDn5ki8fHWMyBGZwT4fyVDYOUTQ7MUflm77VingZuyzYBzEXEZ0cBfg6Iv
	IX7FCvJumkkRAON6XsZjgEcA4EDTIx7W+uRfopR85nvGu/NiwVyay34tuoCguvKJKoomu3wP98/
	SyTzKn81Amjk27ZaMoVj4PSr9Kcl3V5p3N/LYTBYzeUpmNZLK+cUQnZi8BFJPi6abIMZ0RvZNBg
	TZcoTbeRb3VPYgzyN4+pMYBmi3h5wju9Yqgu7adI3KYQt9qCabTtP10cdsxzcYAcjTNkNjz3VXz
	eWTYt4KvLwmPjLFqF0jqHnHngyogy1HX4yIoJZrc8UGP+L+cDp/xPl0FzgEqAmfSaWS09vYfuAB
	fh1MuAwQNZUF6ywCcz4VZxBMut1FZGMNuBVwFKIGY81HdbR8nex4arD8M1sY7tJm2x6tbGF5Hn+
	Mlj9v9U88mUHg==
X-Received: by 2002:a05:7022:6b99:b0:128:d352:bf8a with SMTP id a92af1059eb24-12c73fcec58mr15148605c88.33.1776965051848;
        Thu, 23 Apr 2026 10:24:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2359:5fa4:9c29:41b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm21816482c88.1.2026.04.23.10.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:24:11 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:24:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable <stable@kernel.org>
Subject: Re: [PATCH] Input: ims-pcu - bound frame parser write index against
 read_buf size
Message-ID: <aepUPTvakExa3OZS@google.com>
References: <2026042030-mobilize-suspense-88f9@gregkh>
 <ael3agFzDEV0SgxT@google.com>
 <2026042322-swooned-bauble-40eb@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042322-swooned-bauble-40eb@gregkh>

On Thu, Apr 23, 2026 at 06:52:23AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 22, 2026 at 06:36:24PM -0700, Dmitry Torokhov wrote:
> > Hi Greg,
> > 
> > On Mon, Apr 20, 2026 at 09:05:31PM +0200, Greg Kroah-Hartman wrote:
> > > ims_pcu_process_data() implements a STX/DLE/ETX byte-stuffing parser
> > > that accumulates frame payload into pcu->read_buf[] using the running
> > > index pcu->read_pos.  read_buf is IMS_PCU_BUF_SIZE (128) bytes and
> > > read_pos is u8 but of course, we don't check the index before actually
> > > writing the data :(
> > > 
> > > Fix this up by properly rejecting the frame at the first attempt to
> > > write past read_buf and resync on the next STX, mirroring how the parser
> > > handles short and bad-checksum frames on ETX.
> > > 
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> > > Cc: stable <stable@kernel.org>
> > > Assisted-by: gkh_clanker_t1000
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > I already have a patch for this, thanks.
> 
> Ah, missed that, sorry, I was working against Linus's tree.  I am
> guessing you are referring to commit 875115b82c29 ("Input: ims-pcu - fix
> heap-buffer-overflow in ims_pcu_process_data()")?  If so, why wasn't
> that tagged for stable inclusion?

I do not believe it is worth it. The driver is for specialized hardware,
so common distros will not be enabling it, and systems where it is used
likely do not allow plugging weird stuff into them and probably do not
use stable either.

I actually wonder if we need to carry the driver or if we should simply
drop it. The only non-cleanup change to it was done in 2014.

Thanks.

-- 
Dmitry
