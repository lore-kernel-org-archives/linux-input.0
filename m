Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC1611E;
	Thu, 23 Apr 2026 04:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776919947; cv=none; b=ZZdGjFd0znTjTRObMcgD1X7MVIPfX2mTJ64nqJYrzeayb/SVJFcZEIBBQ2W7t4VtnqidMLg7sdubTl/MY4y3ZHcpanttuSAkpGhRNoaSipiFzBAu2nBpg0ktrFqUOfHbtLAFEkX6S6xN1lktX/yy0jGKLgmaX1cq7Lc4Z26revQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776919947; c=relaxed/simple;
	bh=93fGNDWcICWnA6HRqSFHnwKb92WjD6khshKJOZFhWog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7frL2LivMVqZ9d9ygwLy3D7KrX9hp7/07F+5VtrWEg2NKeZYFW7bRF/LGA7gxgu0ubTVqTi30ajjm/PC/QzTIgJeMg0CIx20Ws5jXngf6FhKcgGIAewQ30fhbZe1vdNBAM6W81FXYFls8a3E0nZBi59yQ6HqVp4eI73z6RsQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxWnVknJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RxWnVknJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7D3C2BCB4;
	Thu, 23 Apr 2026 04:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776919946;
	bh=93fGNDWcICWnA6HRqSFHnwKb92WjD6khshKJOZFhWog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxWnVknJy8jHCRgvkuXwK64kOdoSIbM0cSFlymP2g4V9Lx4Zjc8pgLRyI/y19v2zo
	 3XkplvSjef8IBCAgXlBe4zuvlPXxGWMr+/pBNK64QzmhAAH+6h6NCuIOSOsbiufNfb
	 1ouhUrzX84b9sBHrG2XQ+AV/fNaHfEbU84WQDqsY=
Date: Thu, 23 Apr 2026 06:52:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH] Input: ims-pcu - bound frame parser write index against
 read_buf size
Message-ID: <2026042322-swooned-bauble-40eb@gregkh>
References: <2026042030-mobilize-suspense-88f9@gregkh>
 <ael3agFzDEV0SgxT@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ael3agFzDEV0SgxT@google.com>

On Wed, Apr 22, 2026 at 06:36:24PM -0700, Dmitry Torokhov wrote:
> Hi Greg,
> 
> On Mon, Apr 20, 2026 at 09:05:31PM +0200, Greg Kroah-Hartman wrote:
> > ims_pcu_process_data() implements a STX/DLE/ETX byte-stuffing parser
> > that accumulates frame payload into pcu->read_buf[] using the running
> > index pcu->read_pos.  read_buf is IMS_PCU_BUF_SIZE (128) bytes and
> > read_pos is u8 but of course, we don't check the index before actually
> > writing the data :(
> > 
> > Fix this up by properly rejecting the frame at the first attempt to
> > write past read_buf and resync on the next STX, mirroring how the parser
> > handles short and bad-checksum frames on ETX.
> > 
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_t1000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I already have a patch for this, thanks.

Ah, missed that, sorry, I was working against Linus's tree.  I am
guessing you are referring to commit 875115b82c29 ("Input: ims-pcu - fix
heap-buffer-overflow in ims_pcu_process_data()")?  If so, why wasn't
that tagged for stable inclusion?

thanks,

greg k-h
