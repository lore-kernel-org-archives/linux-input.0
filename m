Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D581A6810;
	Fri, 24 Apr 2026 04:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777004219; cv=none; b=cdsSgDF1jM5DQwHTEyN04ox2pRBbhSIyhprxaZ/HCWNQzubeYrA8ty9FJh4bn0KXJRHd41BftFzQP34hZxptw4JDM/KssPidSFgqBwSktZ04Yq5Ge+G2f7PWGQAW9IZpcHTA45YI/IjR1EDIlPQPypcCvY6w/SvYd7w0Q9d0Gz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777004219; c=relaxed/simple;
	bh=mue8hBk1ZHW+QaZc+buxOLOMtUgLfqvsOywNeAJLrus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVxs5uBopVYwAcQ220+CAicJ7MBO0HQ4mJk90UNMueeLMtDE33LgnziAe88uTcS/9kdFdMcf+Ddn5/J8jc7ZAcGnomKsCvEna8dKEiN66FHhr9OQFbnRRZ8og0AuSgghieyu6hPv/956v4+BGjzPe2hgVtZtqztlU9cYASsrf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YX/QGtVv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YX/QGtVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D3CC19425;
	Fri, 24 Apr 2026 04:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777004219;
	bh=mue8hBk1ZHW+QaZc+buxOLOMtUgLfqvsOywNeAJLrus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YX/QGtVv4/UnfLzAUY2AB45sfdvyJtMmkANqMyS5gg3n6QmRaW3F5Va2zikgUExAh
	 C5YkvwijfHlxj+JnX1phzc+TlD2Cw209/Mh0VVqx48LwuNTr/0Q0jSnhJUta7yAmrZ
	 noJVilWUHAMLxSzaUpMynq3fJ5jvd/VvxcjkvDmw=
Date: Fri, 24 Apr 2026 06:16:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH] Input: ims-pcu - bound frame parser write index against
 read_buf size
Message-ID: <2026042414-demeanor-dimple-83b0@gregkh>
References: <2026042030-mobilize-suspense-88f9@gregkh>
 <ael3agFzDEV0SgxT@google.com>
 <2026042322-swooned-bauble-40eb@gregkh>
 <aepUPTvakExa3OZS@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aepUPTvakExa3OZS@google.com>

On Thu, Apr 23, 2026 at 10:24:08AM -0700, Dmitry Torokhov wrote:
> On Thu, Apr 23, 2026 at 06:52:23AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 22, 2026 at 06:36:24PM -0700, Dmitry Torokhov wrote:
> > > Hi Greg,
> > > 
> > > On Mon, Apr 20, 2026 at 09:05:31PM +0200, Greg Kroah-Hartman wrote:
> > > > ims_pcu_process_data() implements a STX/DLE/ETX byte-stuffing parser
> > > > that accumulates frame payload into pcu->read_buf[] using the running
> > > > index pcu->read_pos.  read_buf is IMS_PCU_BUF_SIZE (128) bytes and
> > > > read_pos is u8 but of course, we don't check the index before actually
> > > > writing the data :(
> > > > 
> > > > Fix this up by properly rejecting the frame at the first attempt to
> > > > write past read_buf and resync on the next STX, mirroring how the parser
> > > > handles short and bad-checksum frames on ETX.
> > > > 
> > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> > > > Cc: stable <stable@kernel.org>
> > > > Assisted-by: gkh_clanker_t1000
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > I already have a patch for this, thanks.
> > 
> > Ah, missed that, sorry, I was working against Linus's tree.  I am
> > guessing you are referring to commit 875115b82c29 ("Input: ims-pcu - fix
> > heap-buffer-overflow in ims_pcu_process_data()")?  If so, why wasn't
> > that tagged for stable inclusion?
> 
> I do not believe it is worth it. The driver is for specialized hardware,
> so common distros will not be enabling it, and systems where it is used
> likely do not allow plugging weird stuff into them and probably do not
> use stable either.

Android allows a lot of odd things to be plugged into it :(

> I actually wonder if we need to carry the driver or if we should simply
> drop it. The only non-cleanup change to it was done in 2014.

I'll gladly send a patch to delete it if you want me to.

thanks,

greg k-h
