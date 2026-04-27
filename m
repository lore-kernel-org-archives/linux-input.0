Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1D39B4BE;
	Mon, 27 Apr 2026 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288585; cv=none; b=R5DdCHgqkVZQNzZ9jU7wFMDD8n/veQ2yGM4qqiO+TGnNmEMGtV8Ak6VUBMZCQwBmlOucqFulqVwZDhVIn3q0aICLbW4vQXZ3pXvBiKMa+PDOelVZ8WW4gKqTUzgiLGzpbcDwU18+YXGRf9k/sHAr6Dn3/GXpLoZa/gSTmXuKNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288585; c=relaxed/simple;
	bh=9T8FEDtKFmUhZxwB8rgvIA3wS0jmwsgVlArGvq/MQNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFKg9ReJM+b+NS7aTmWGQXtIl2+B01dq6JlagQwIQ0LEdMzyWC9slF+V2ovkNSr7q49R06q5pYWxa1a6Bx8AeUQlJeoj+kSFddrqbndz9x8sr22DMKyEQNqdtXr47EHQd8KiWWvqhScK3QmesHvtTdgL2CbY80j2DHeJxwvTzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wxEm6TZ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wxEm6TZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813CEC2BCB4;
	Mon, 27 Apr 2026 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777288585;
	bh=9T8FEDtKFmUhZxwB8rgvIA3wS0jmwsgVlArGvq/MQNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wxEm6TZ53bBJH+ocT/w/yaPcHaTjhL86G+G+Ig8RA1WEKReowKob8aW8g3O904RJn
	 lfP9wU8pIeqFYctzZaaN37+YcXfiwa47Qke9UCuMuAOicCuS39W3fFeRx0OQZSfi2u
	 SIN/9HR/FrDoK0SpIqcnPRjCCZ9rfIuX8HUvIVII=
Date: Mon, 27 Apr 2026 05:15:50 -0600
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH] Input: xpad - reject short Xbox One packets before
 len-relative share-button index
Message-ID: <2026042729-phobia-deftly-0176@gregkh>
References: <2026042014-freestyle-deluxe-48e4@gregkh>
 <ae7kWV1Km1qoEeq3@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7kWV1Km1qoEeq3@google.com>

On Sun, Apr 26, 2026 at 09:22:21PM -0700, Dmitry Torokhov wrote:
> Hi Greg,
> 
> On Mon, Apr 20, 2026 at 05:53:15PM +0200, Greg Kroah-Hartman wrote:
> > xpadone_process_packet() receives len directly from urb->actual_length
> > and uses it to index the share-button byte at data[len - 18] or
> > data[len - 26].  Since both len and data[0] are under the device's
> > control, a broken controller can send a GIP_CMD_INPUT packet with
> > actual_length < 18 (e.g. 5 bytes) and reach this code path, causing
> > accesses beyond the actual array.
> > 
> > Since len is u32, 5 - 26 wraps to 0xFFFFFFEB, and data[0xFFFFFFEB] can
> > dereference about 4 GiB past the 64-byte usb_alloc_coherent() idata
> > buffer.  On a KASAN system this is an immediate splat otherwise the read
> > will either fault on an unmapped page (DoS) or pull a bit from arbitrary
> > kernel memory and report it as KEY_RECORD.
> > 
> > Fix this all up by properly bounds checking the value provided by the
> > device.
> > 
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Fixes: 4ef46367073b ("Input: xpad - fix Share button on Xbox One controllers")
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_t1000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/input/joystick/xpad.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> > index d6fc3d6006bb..7d99fe0ecf91 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -1110,10 +1110,13 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
> >  		input_report_key(dev, BTN_START,  data[4] & BIT(2));
> >  		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
> >  		if (xpad->mapping & MAP_SHARE_BUTTON) {
> > -			if (xpad->mapping & MAP_SHARE_OFFSET)
> > -				input_report_key(dev, KEY_RECORD, data[len - 26] & BIT(0));
> > -			else
> > -				input_report_key(dev, KEY_RECORD, data[len - 18] & BIT(0));
> > +			if (xpad->mapping & MAP_SHARE_OFFSET) {
> > +				if (len >= 26)
> > +					input_report_key(dev, KEY_RECORD, data[len - 26] & BIT(0));
> > +			} else {
> > +				if (len >= 18)
> > +					input_report_key(dev, KEY_RECORD, data[len - 18] & BIT(0));
> > +			}
> 
> Thank you for the report, but this is quite ugly. I committed an
> alternative version of the fix.

Not a problem at all, thanks for doing this, all I want is to see the
issue fixed :)

thanks,

greg k-h
