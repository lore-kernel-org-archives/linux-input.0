Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860593806C6;
	Mon, 27 Apr 2026 03:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261912; cv=none; b=etCUxsu/LlHsMLcqyRgzBHyG67eBQgPCdtcYWJzD2en13djfJhG39ndRRlx43/JM155XwcKW1L2zWHsBziGjn73YZcA1HziJbmb2SS8snzZmVp5qssygyE+fbQaXIaMqyj0ZAH4FR1q52YpF5jxwv6SWsTb8P5GdkrCsJCk3N84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261912; c=relaxed/simple;
	bh=pMS4KcMXbUb9IComLLZKM7M57S8rKPfcrkJwyXw4ILA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndOX+qyHufDzmVlx4DfOy2LKijiihUBUVSHcWDAYOz0gZzjz+1EuAPilhwMcWjjIDZuDtgiOiCH/LpPkpUEaBoT4Kfh6QXDok9X1bTMRdAgCy7nQ0vYyLos07H8XskXbmXFMbrlVpH7tvMsQ2+4T05USqdpxiZ6pGKjK2aGMUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JyuxBqOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyuxBqOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5792CC19425;
	Mon, 27 Apr 2026 03:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777261912;
	bh=pMS4KcMXbUb9IComLLZKM7M57S8rKPfcrkJwyXw4ILA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyuxBqOon929GD5kf1q/KaDrtIAEagMfL8h1PO+cAJJORMfKGe9LTxP9gcG6a4XdX
	 sGrrsOmzO8MvDiupl1T6jzYFuDMs+1ahVlFLD6njFwWRV/jHMnORq8uZfzKKI79uws
	 CL/MnPm4OKkjWaLJTNaovDmSjThhtJfgSPlFAb1U=
Date: Sun, 26 Apr 2026 23:18:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH] Input: ims-pcu - bound frame parser write index against
 read_buf size
Message-ID: <2026042620-blurry-primer-6dd5@gregkh>
References: <2026042030-mobilize-suspense-88f9@gregkh>
 <ael3agFzDEV0SgxT@google.com>
 <2026042322-swooned-bauble-40eb@gregkh>
 <aepUPTvakExa3OZS@google.com>
 <2026042414-demeanor-dimple-83b0@gregkh>
 <ae2ePyF_jDzVhgLf@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae2ePyF_jDzVhgLf@google.com>

On Sat, Apr 25, 2026 at 10:12:51PM -0700, Dmitry Torokhov wrote:
> On Fri, Apr 24, 2026 at 06:16:57AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Apr 23, 2026 at 10:24:08AM -0700, Dmitry Torokhov wrote:
> > > On Thu, Apr 23, 2026 at 06:52:23AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Apr 22, 2026 at 06:36:24PM -0700, Dmitry Torokhov wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > On Mon, Apr 20, 2026 at 09:05:31PM +0200, Greg Kroah-Hartman wrote:
> > > > > > ims_pcu_process_data() implements a STX/DLE/ETX byte-stuffing parser
> > > > > > that accumulates frame payload into pcu->read_buf[] using the running
> > > > > > index pcu->read_pos.  read_buf is IMS_PCU_BUF_SIZE (128) bytes and
> > > > > > read_pos is u8 but of course, we don't check the index before actually
> > > > > > writing the data :(
> > > > > > 
> > > > > > Fix this up by properly rejecting the frame at the first attempt to
> > > > > > write past read_buf and resync on the next STX, mirroring how the parser
> > > > > > handles short and bad-checksum frames on ETX.
> > > > > > 
> > > > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > > Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> > > > > > Cc: stable <stable@kernel.org>
> > > > > > Assisted-by: gkh_clanker_t1000
> > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > 
> > > > > I already have a patch for this, thanks.
> > > > 
> > > > Ah, missed that, sorry, I was working against Linus's tree.  I am
> > > > guessing you are referring to commit 875115b82c29 ("Input: ims-pcu - fix
> > > > heap-buffer-overflow in ims_pcu_process_data()")?  If so, why wasn't
> > > > that tagged for stable inclusion?
> > > 
> > > I do not believe it is worth it. The driver is for specialized hardware,
> > > so common distros will not be enabling it, and systems where it is used
> > > likely do not allow plugging weird stuff into them and probably do not
> > > use stable either.
> > 
> > Android allows a lot of odd things to be plugged into it :(
> 
> Well, that's on them. Do they enable drivers blindly?
> 
> > 
> > > I actually wonder if we need to carry the driver or if we should simply
> > > drop it. The only non-cleanup change to it was done in 2014.
> > 
> > I'll gladly send a patch to delete it if you want me to.
> 
> Sure, let's do it. It's easy to restore it if it is actually needed.

Ok, will work on that after -rc1 is out.

greg k-h
