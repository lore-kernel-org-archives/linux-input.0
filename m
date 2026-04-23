Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFF29BD88
	for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776909576; cv=none; b=S56q15vzxfOwjuSjJji4B4sKu2YG1Uup372bFMgzcD1LVc7jPVX+M6DrYvDDB+wc+STuuXWL6WVCbolmPOY5vhaZe0oDLDySCixXOMBj63VU8tSFYSo0ckPUR5hnTOnwwEAtstidjrbDI3suuZRXuV1J5B7tz8E3dwgrH4K+zBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776909576; c=relaxed/simple;
	bh=Lterwony2FtJvjP1BuB8aBl1R1VftyjEEpqcp+6Ekhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqD77hNQ64rlqiiAAr9MJ0E6nAJEFKKu6IobDtMd97cQ6YO6xuXcp3O74UgDpJZuj2GtWtY+1GP4JaaFMEqiE1i4B3+8/xZHiJSrJ6avM7Zddq+V2woV3pjsBjSnHI4wCtU/uzk/VCXwGcBZa8seY0JPZEwSQu9u1oqMbwfHWxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKkN10sb; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKkN10sb"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2d832f2f44cso5572990eec.0
        for <linux-input@vger.kernel.org>; Wed, 22 Apr 2026 18:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776909575; x=1777514375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDeKDbl3FkCpnF1llZ8KN55wot3WZsG6pj/Ef7jrG+g=;
        b=AKkN10sbZyYz8UJClUc6Iulml1n0Od2UXmKmGodrRa00BKkl6zdQmlQ2olNux2ArVy
         0ZG3Mto6IXXjiQp92vhIyKhffojUooSpxMe3p0A5688/ryr59Hz40bBqHPCkOBx1x9tt
         JDJTvOHbCcBcAllEa6HTksCUo+vUpQWZ5MSse/q7j0reQHrWjt/dE6TYlZWaql/jNXV3
         LwtfxLbhPcaFIlQH3+d27KJhnLdUefpIOaYTT0OHQlAIwQqjVLzaznbVjRsIVQRGtcST
         fnqLRtrv7SpaXJagNijAqLBmZtE31yzHFoMmlawHiji+5G85Taod0ywIN/c4GUdtEzJw
         vKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776909575; x=1777514375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDeKDbl3FkCpnF1llZ8KN55wot3WZsG6pj/Ef7jrG+g=;
        b=asd6cOC7qfzQingz1slxWPk3FD7Bm3t3+3WdpKiB54pOaSmpB2hKhk4Gc24WShg4HL
         vXwCcoHPEuhEgFLR0/yP9i3NKQPB17rjdY2BEAfo90pNA7XVih4PbqA+OBdVbYrNsQ0L
         K4kEc3g1L3wZMlJ3gd3WCPBmp7W28ruxiPPZxns0H6wcbG9JZ3ffm8737xB5RdhL20Ob
         ilMH3yq3NF89bSF1sdwcRnEB2GDe3r+V2sJdKERGAa+f7fSRzTTEgM8nFA8qOzvaVSKK
         D6tn3/K9v9iJgn1YXDO9PdzZppQKD8NAPjXKylA8aClJ2nQfinIaBSunn7VIJLh9duj4
         ELLg==
X-Gm-Message-State: AOJu0YwwQoyV2/K6lUymdD5SfJthnZDNdg9T2MYRb1KRgBQE089UngMb
	V79Shocpze2THNQkOwrRIeV9oeZbQJCmHHqnvuiP3hhUtmt7zZQPz6D9
X-Gm-Gg: AeBDiesIF8mO5NngVliCIcCPIbBbzTudNuQ80Dm3SFMkPpdAPZx0LU77g6aRyyLUz7G
	64GMcd8XsRmYbeMyrICnQdvz+0czWGqIRIzfZ/WANx+8mWd5IA8XEs662I/oUeI0EiV6DUZjScg
	LnXoAxjwboyh1dvHsewJi78DhSlRjcXQsyzUXDZ4l+1/0nuxUX2LqL3kV28F+kW96WeAkIBvWko
	OdP9VnBHMs6M+WSAI1njucKx2rmjz3/9gyhtgbl0+L4HNT03JutmJe1/aCkudcpFWC94nJ/YSE2
	Y1FKdqmioF58vJE7XKCdT7tb8sadjRtEcTXHbyYbq/ieVz4le84YDW4P7v8nIz4MySBOYjOFmNU
	dleToGTO5N/yqM9tSrumnVr4WswRqunDKCKrDbm0/k0Tt7szr0z69oGobG1hBYfdUBs4xyx5t9u
	jiHG/oxwuL3MzYKKLkxR0gsJ5rBcrZ7/lXHexG9/HoZz8B5bDXrIzyqlvRZ9RbfgCRReIds769A
	2c=
X-Received: by 2002:a05:7301:1f01:b0:2c7:5a7b:e8c0 with SMTP id 5a478bee46e88-2e4657714d1mr13182745eec.12.1776909574457;
        Wed, 22 Apr 2026 18:59:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2359:5fa4:9c29:41b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a80c7sm32163227eec.10.2026.04.22.18.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 18:59:33 -0700 (PDT)
Date: Wed, 22 Apr 2026 18:59:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable <stable@kernel.org>
Subject: Re: [PATCH 2/2] Input: synaptics-rmi4 - use u32 for reg_size to
 avoid sign extension into item->reg_size
Message-ID: <ael3yDbI3_1oarHN@google.com>
References: <2026042044-amuser-tantrum-73af@gregkh>
 <2026042046-clad-aspect-e8f9@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042046-clad-aspect-e8f9@gregkh>

On Mon, Apr 20, 2026 at 08:59:46PM +0200, Greg Kroah-Hartman wrote:
> rmi_read_register_desc() builds the 4-byte register size from device
> bytes:
> 
> 	reg_size = struct_buf[offset] |
> 		   (struct_buf[offset + 1] << 8) |
> 		   (struct_buf[offset + 2] << 16) |
> 		   (struct_buf[offset + 3] << 24);
> 
> struct_buf is u8 *, so each byte is promoted to int before the shift.  A
> device that supplies a top byte with bit 7 set (e.g. 00 00 00 00 00 00
> 80 in struct_buf to reach the 4-byte path with offset+3 = 0x80) makes
> (0x80 << 24) overflow into the int sign bit, and the OR result is
> negative.  reg_size is then assigned to item->reg_size, which is
> unsigned long, so the negative int sign-extends to a value near
> ULONG_MAX.
> 
> After this, bad things happen when numbers start wrapping and buffers
> are allocatged based on those numbers, and then accessed based on those
> buffers assuming to be a sane size (bigger or smaller).
> 
> Fix this all up by just properly making reg_size be a u32.

Shouldn't it be replaced with get_unaligned_le32() instead?

Thanks.

-- 
Dmitry
