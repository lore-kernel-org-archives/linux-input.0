Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433933FE2F;
	Thu, 23 Apr 2026 04:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776919818; cv=none; b=aBHwPWTwm/0zMwuwnBSS/67AnZmOf/Wh9myVpiix1WXp0xhYdUxb6VF0a4qeDZrDhEN1m8kVV1/oSvceF4s9Oi1D4gvtaD7CLkGNCaKTZzhxiOZVdnQaAUPlDIr9LFYJ1sd2WJrnpJtamsfTVwk5icKJFJMUDTlSDqFqnmCkAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776919818; c=relaxed/simple;
	bh=6r+D5E1lQ4qTV8wmRzMZrCF3i/bUraA7GSXSYijUsbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrdhXAnrV6xDN+hfJ3BxBsKySVAzkWyCe0R2QkTGo42uDUshtpdTMkBmVhDnesxQyKid/6hDVxEZ6XKiYchASi5zFEZxEoUtm0biFvEXSvKg/egnlr7FjRrFviRhuDALBtHs5cCYfy6fKsjOBvvbwissQ0iGvRUk6GHt0jAeRyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h/b1rbeQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h/b1rbeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41638C2BCB4;
	Thu, 23 Apr 2026 04:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776919817;
	bh=6r+D5E1lQ4qTV8wmRzMZrCF3i/bUraA7GSXSYijUsbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/b1rbeQmddcSuyvmQbhA7tY59tMGf/ptECvG7dTZrQ4p9YTDVhE++mqhynpFmtqC
	 G88faRQVC2WNG3cJKtHcgxc5VCbFAveOzGObMNkMq1kHzF9jo2a+9o5PcmmibOtFJR
	 HGnoVTQ7yB1+kkO/r/c4yApFhEO3JkrZqFMlglwg=
Date: Thu, 23 Apr 2026 06:50:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH 2/2] Input: synaptics-rmi4 - use u32 for reg_size to
 avoid sign extension into item->reg_size
Message-ID: <2026042351-smokeless-unflawed-2709@gregkh>
References: <2026042044-amuser-tantrum-73af@gregkh>
 <2026042046-clad-aspect-e8f9@gregkh>
 <ael3yDbI3_1oarHN@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ael3yDbI3_1oarHN@google.com>

On Wed, Apr 22, 2026 at 06:59:31PM -0700, Dmitry Torokhov wrote:
> On Mon, Apr 20, 2026 at 08:59:46PM +0200, Greg Kroah-Hartman wrote:
> > rmi_read_register_desc() builds the 4-byte register size from device
> > bytes:
> > 
> > 	reg_size = struct_buf[offset] |
> > 		   (struct_buf[offset + 1] << 8) |
> > 		   (struct_buf[offset + 2] << 16) |
> > 		   (struct_buf[offset + 3] << 24);
> > 
> > struct_buf is u8 *, so each byte is promoted to int before the shift.  A
> > device that supplies a top byte with bit 7 set (e.g. 00 00 00 00 00 00
> > 80 in struct_buf to reach the 4-byte path with offset+3 = 0x80) makes
> > (0x80 << 24) overflow into the int sign bit, and the OR result is
> > negative.  reg_size is then assigned to item->reg_size, which is
> > unsigned long, so the negative int sign-extends to a value near
> > ULONG_MAX.
> > 
> > After this, bad things happen when numbers start wrapping and buffers
> > are allocatged based on those numbers, and then accessed based on those
> > buffers assuming to be a sane size (bigger or smaller).
> > 
> > Fix this all up by just properly making reg_size be a u32.
> 
> Shouldn't it be replaced with get_unaligned_le32() instead?

Sure, be glad to do that instead, this was just a "simpler" solution :)

I'll respin that after -rc1 is out.

thanks,

greg k-h
