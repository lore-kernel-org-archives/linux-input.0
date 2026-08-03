Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B5388397;
	Mon,  3 Aug 2026 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781549; cv=none; b=fBZ1O9WBHfdFe72uhWYBrc+NDu1Hi0g3TJlHixn1kTffjaMqIvwUIZ4onb9KF+/Tx6K1yPtc4gWTz0xg+6I530xYiUGf3pheGEjbasNn7lOV6wgROo/swCxlibU1Gd2r5SQhNl7BplfVl/KHkY9p3758Y9W478044P4O4pxLdag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781549; c=relaxed/simple;
	bh=uGk5cbcMyy4gOATPjBQ8gESnI/mspf+kPzaK2LBc9rY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t60zYaUNFHx0vDH4b9nDXjiVRWTf2iHQRhR5tygKzPlWbDO96hdv4SnUgPNdav+B/6pdoaaRLqu3KQqpH+7tNNUBnQtPdoZpujABje+hj87ZlrprhlJtVRmNr0rB7RncwLwCV3RK77HOIS57wg2w0RrlMgVvzWN0MpzeW+ZrW4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNCxeQst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNCxeQst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DBD1F000E9;
	Mon,  3 Aug 2026 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781548;
	bh=uJr8VhX6TVlvX9DEgK98jRMwoZAnZLB3SaHmNdDT6as=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=LNCxeQstaP+U6WdSEWQHqil2wdBcHLvw6SX5yQhNae2kfX92v1iP6GUrjKeMpPtDI
	 CaR5Vsh55qx39ZEidS23VYxEN9DrSc43edL3a3MN51iX0L273W8nIQGAfLlQ0hGnua
	 WJ+AkjBlmBHIHJOSzATviIuT2rbN6ZD/ps2UfPEqT3CdFJiL4lFLqH5MzR+uwJ/aRg
	 8L0m3OVzWM+tbowQr3EnpZMeuho6FmcH31+L5MTfgvDHyZsbYImbbaJzpM36LkAdd8
	 9XnDhovVROUuHX7ln4/03hvvTwLOvzQeciB29SFJ09Fb8qKtsa5HzdIn+kRSSzTEqS
	 gL9SQB7buevrA==
Date: Mon, 3 Aug 2026 20:25:45 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Bastien Nocera <hadess@hadess.net>
cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
    linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Remove duplicate ID for the G703
 Hero over USB
In-Reply-To: <21e8047a869d9d15eaae927fc0282bf0689b69f3.camel@hadess.net>
Message-ID: <s8p49rsp-1772-7rp9-4543-o5762rps432o@xreary.bet>
References: <20260721173710.500368-2-stuart.a.hayhurst@gmail.com> <21e8047a869d9d15eaae927fc0282bf0689b69f3.camel@hadess.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Jul 2026, Bastien Nocera wrote:

> > The ID appears to be given twice, remove the duplicate
> > 
> > Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> 
> Indeed, at line 4652:
>         { /* Logitech G703 Hero Gaming Mouse over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC090) },
>         { /* Logitech G900 Gaming Mouse over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081) },
>         { /* Logitech G903 Gaming Mouse over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
>         { /* Logitech G Pro Gaming Mouse over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
>         { /* MX Vertical over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08A) },
>         { /* Logitech G703 Hero Gaming Mouse over USB */
>           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC090) },
> 
> Benjamin, Jiri, is there not a way to detect duplicates like this?

I think the modern way to do this is to ask some LLM to find all of them 
:)

> In any case, looks good to me.
> 
> Reviewed-by: Bastien Nocera <hadess@hadess.net>

Thanks a lot, now queued.

-- 
Jiri Kosina
SUSE Labs

