Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653A192D8A
	for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777180377; cv=none; b=WsDIQZ8Mt2Bb6TxaUzTnvI1zqxN70LCe0Vj/3412sDUTiyZwDoec357A0hzItrlyRhlkFHrNJiN7vQFb4ycL6+F6kDhRh9COXV35S5fanDGxfRfdO+tsoX6DFw0XbnArXoQB+l0DM70CnKS4YFORfNFCrFIuSZcWWViSoyGdu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777180377; c=relaxed/simple;
	bh=xXdyKTyEPTZJednWsZsTNyCnuqtfS/3akGJIlvKa2+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuaMjtRQb4JSEVObA87MopGYBFXmsw2EUI7F0XhTGGF3haKdXIhtOE+8bUL9qCf3e+k+fWqdiwLK96V20R4D16i0uwkNK43jzxlQzYtZNpV4K4xn/87mC9TaKUTDKMEbK52mSqof1ew3+F7J1L9b3fc6fxyM+8WZzWUVG0SJ6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPTEODj4; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPTEODj4"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c8f9846c8so9003197c88.0
        for <linux-input@vger.kernel.org>; Sat, 25 Apr 2026 22:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777180375; x=1777785175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98rDKFjiqIk7JzA95AP0WmmQtnrklmD9O8WJG5uKSAg=;
        b=sPTEODj4bEts3R/BUKIt+Ot+mB7Q8zRN88lRvHah3eTo9rxW24LH6T2i7cdRKJNRJ8
         Jq57C7LjAICWNywC4UF5jf640dc7M6ljQHPCb62Ennkd6Yf/nNi+9RCPoW5OzNqCc03o
         Lvx15Y6jQaludIcVl8Ae79K5qe47/D0l+JAw8Qc/NKA2OaELP8b9QRTlHW8EWjKCQdol
         fJ+VY7/ObLkGVsCUfXeTf435hnvKL6jKe0mpznF+IDw23FHz+vd9wHMOKBXcje7iT6XN
         ogdVCCm+TDL6C13ENd9KfAgLaQbu9SyC2zfCiHXGBCcbs2BEt2UP5wdUyGGT1557YA+j
         ARoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777180375; x=1777785175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98rDKFjiqIk7JzA95AP0WmmQtnrklmD9O8WJG5uKSAg=;
        b=eBeYrNPP7tF1O1HN7KUqSIOFcOlsIgmYgHt0djiItuvXUX+OYG/iMTyHdAJ23sCqTk
         qOrrAcXmFwgbmZxSEL+Vnk8jPIqxU0jF+4ggDJcf3ZrPjNhLkJZ56u9ZI0bArDAqhDU6
         VNuDNNWwfrLd1vuZswMZfP/6vp9usH8DOtics8WPV1C9vGk9qni30q08ywNFVWzVQ+FW
         /TFSPumSJgqF6hkfpZiJDiEbfsoOWLVg6ig46+f9GFN4zufyCiU8knRQFufmp34nGXVq
         lA+xf5spYnp8lxiwJ6k1Q4oiSMwqMYCep7eUjhLo4/H1+fzQ1VKtHEVMHmVCKG24HHZo
         PdQw==
X-Gm-Message-State: AOJu0Yzz0HjdN1fmKckXW0rOekSAC88wjsrYDBQA7acCbqEAzQJ5RS9L
	ebqDGiI6IN3W5xSnClotwN8GJ9gEjkea7QfEZHLs7FgjM1Jenp7ZVWuq
X-Gm-Gg: AeBDieuVy7BK0sU4cPYS8fecISlyU3tmEoPRR9uNi/Q8lFEMjr+QAAIoXwWJRQK/PiD
	YAjAfPGPS6rSet/kIZzCmG7ORH8blpkFcJcIrh8qbyftt+BC6NId+IUZxqmhQc466mJWlgwdnbV
	64ybMDW8qPTray/X0I/2TBvHjXrsm1w8j5bgnzBFcgViFuqCDFGHXTyzmgK+yP7kU/yyGgcShqz
	3QdhJftNgIvNz/yXGZdXo3eMtqtpbd534j8HWEvE6jKCTRufB64j01svhi/SWTSk0PjorQH55VT
	4MvHcxgjqBW3kJ+6H7vQgqz2sT2y/RWMkGg/hx/nS4BpXAjM5IHNmRNaQ9rLR4rJqYHlM4vGfD2
	IgNxMDrIGbchj2NtO57UKccf7PlQxrGcASa/1fi5RGXyFnH/hAwyR1lDSYUsnQr3mr21U6S9c/W
	wlN5dNA49zDAa+Iqxf6SsrBLdWL5+/qe55/0FwJudWMDIBLxrnMt4IfhlhOcvHJIXbRKNuku9ZW
	HM=
X-Received: by 2002:a05:7022:f92:b0:12d:ce69:1109 with SMTP id a92af1059eb24-12dce69119emr1791764c88.4.1777180374858;
        Sat, 25 Apr 2026 22:12:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f359:aa0c:530d:9dfd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dbe78e12fsm18353826c88.15.2026.04.25.22.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 22:12:54 -0700 (PDT)
Date: Sat, 25 Apr 2026 22:12:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable <stable@kernel.org>
Subject: Re: [PATCH] Input: ims-pcu - bound frame parser write index against
 read_buf size
Message-ID: <ae2ePyF_jDzVhgLf@google.com>
References: <2026042030-mobilize-suspense-88f9@gregkh>
 <ael3agFzDEV0SgxT@google.com>
 <2026042322-swooned-bauble-40eb@gregkh>
 <aepUPTvakExa3OZS@google.com>
 <2026042414-demeanor-dimple-83b0@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042414-demeanor-dimple-83b0@gregkh>

On Fri, Apr 24, 2026 at 06:16:57AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 23, 2026 at 10:24:08AM -0700, Dmitry Torokhov wrote:
> > On Thu, Apr 23, 2026 at 06:52:23AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Apr 22, 2026 at 06:36:24PM -0700, Dmitry Torokhov wrote:
> > > > Hi Greg,
> > > > 
> > > > On Mon, Apr 20, 2026 at 09:05:31PM +0200, Greg Kroah-Hartman wrote:
> > > > > ims_pcu_process_data() implements a STX/DLE/ETX byte-stuffing parser
> > > > > that accumulates frame payload into pcu->read_buf[] using the running
> > > > > index pcu->read_pos.  read_buf is IMS_PCU_BUF_SIZE (128) bytes and
> > > > > read_pos is u8 but of course, we don't check the index before actually
> > > > > writing the data :(
> > > > > 
> > > > > Fix this up by properly rejecting the frame at the first attempt to
> > > > > write past read_buf and resync on the next STX, mirroring how the parser
> > > > > handles short and bad-checksum frames on ETX.
> > > > > 
> > > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> > > > > Cc: stable <stable@kernel.org>
> > > > > Assisted-by: gkh_clanker_t1000
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > 
> > > > I already have a patch for this, thanks.
> > > 
> > > Ah, missed that, sorry, I was working against Linus's tree.  I am
> > > guessing you are referring to commit 875115b82c29 ("Input: ims-pcu - fix
> > > heap-buffer-overflow in ims_pcu_process_data()")?  If so, why wasn't
> > > that tagged for stable inclusion?
> > 
> > I do not believe it is worth it. The driver is for specialized hardware,
> > so common distros will not be enabling it, and systems where it is used
> > likely do not allow plugging weird stuff into them and probably do not
> > use stable either.
> 
> Android allows a lot of odd things to be plugged into it :(

Well, that's on them. Do they enable drivers blindly?

> 
> > I actually wonder if we need to carry the driver or if we should simply
> > drop it. The only non-cleanup change to it was done in 2014.
> 
> I'll gladly send a patch to delete it if you want me to.

Sure, let's do it. It's easy to restore it if it is actually needed.

Thanks.

-- 
Dmitry
