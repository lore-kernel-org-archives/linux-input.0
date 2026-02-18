Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF012FE56A;
	Wed, 18 Feb 2026 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441497; cv=none; b=GU2TmpS51twupGtQWYlgoKiAIPbKSUJMqivBu06D0gsMKMbFB/dXaIQH7xwVyf5dkvJHr6+EO4rJa6fSDS9dA5BH/BR/E7+wNB08givcxQb4ZggD+vmGrAn8lF9u09ba5wv/pq+eRDeL3FtYjt5odhU4kCaB5g2K0yRGxopixIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441497; c=relaxed/simple;
	bh=3+BxxppG+7eCIu0fcfAL4ecK0E855Brzx1YH3Z9EPSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ+nv+GvfolqZWB03+CPeVSnsssN6Qs+VLMFyvn4whTLtt4oYQZAWbrxt9y/IewWp3P+9FENig6fTakUJ+am9uAlMKT7XbVW9T6KW/y2EdaM41ScCTakiNmggHgjlWLL5TDrrNubvOu4uxAzp68onnuPeUgWHhAvykO9tEh6jjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVw7NM3W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVw7NM3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BE8C116D0;
	Wed, 18 Feb 2026 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771441496;
	bh=3+BxxppG+7eCIu0fcfAL4ecK0E855Brzx1YH3Z9EPSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVw7NM3Wtv9QaEeGyHJ1D5MX4kYVeEo44cSDd7PwuWOL3bxeM9e7Es+PouCrV32nn
	 IoijrgbJ+LRkN/nZPRnzrjl/DC4FDIJPhDHHrdXwV3FF64eW7bCnjC3gDNICQbnDcn
	 eZz5LmWujMF6O/BW/TQH41ipr6VbbMZqf8E4AjsPKzhnr0bNdHnf0FKU5G8S1ld5BG
	 kmXwLN4yXG/9SQ+aBUXXakBnp2C0DbKWrkuQ785nFPTbseWlW6KHxXATZVe0gOvCoX
	 sjfJT35Sq9kxZpjV0dzpOkKEtAQbLYItGewZSUiZ3mh+KGhDCouBQUt63dVPnhu4q0
	 QWSkJAu5sgXow==
Date: Wed, 18 Feb 2026 20:04:52 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: apple: avoid memory leak in apple_report_fixup()
Message-ID: <aZYMcsHlWL5pDHdR@plouf>
References: <20260217160125.1097578-1-gnoack@google.com>
 <20260217160125.1097578-2-gnoack@google.com>
 <aZSxeusondD26uN3@plouf>
 <aZTEnPEHcWEkoTJR@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZTEnPEHcWEkoTJR@google.com>

On Feb 17 2026, Günther Noack wrote:
> Hello Benjamin!
> 
> On Tue, Feb 17, 2026 at 07:22:20PM +0100, Benjamin Tissoires wrote:
> > On Feb 17 2026, Günther Noack wrote:
> > > The apple_report_fixup() function was allocating a new buffer with
> > > kmemdup() but never freeing it. Since the caller of report_fixup() already
> > > provides a writable buffer and allows returning a pointer within that
> > > buffer, we can just modify the descriptor in-place and return the adjusted
> > > pointer.
> > > 
> > > Assisted-by: Gemini-CLI:Google Gemini 3
> > > Signed-off-by: Günther Noack <gnoack@google.com>
> > > ---
> > >  drivers/hid/hid-apple.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> > > index 233e367cce1d..894adc23367b 100644
> > > --- a/drivers/hid/hid-apple.c
> > > +++ b/drivers/hid/hid-apple.c
> > > @@ -686,9 +686,7 @@ static const __u8 *apple_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> > >  		hid_info(hdev,
> > >  			 "fixing up Magic Keyboard battery report descriptor\n");
> > >  		*rsize = *rsize - 1;
> > > -		rdesc = kmemdup(rdesc + 1, *rsize, GFP_KERNEL);
> > > -		if (!rdesc)
> > > -			return NULL;
> > > +		rdesc = rdesc + 1;
> > 
> > I might be wrong, but later we call free(dev->rdesc) on device removal.
> > AFAICT, incrementing the pointer is undefined behavior.
> > 
> > What we should do instead is probably a krealloc instead of a kmemdup.
> > 
> > Same for all 3 patches.
> 
> Thanks for the review.
> 
> Let me try to address your three responses in one reply.
> 
> I am happy to accept it if I am wrong about this, but I don't
> understand your reasoning.  (This should go without saying, but maybe
> is worth reiterating, I would not have sent this if I had not
> convinced myself independently of LLM-assisted reasoning.)
> 
> Let me explain my reasoning based on the place where .report_fixup()
> is called from, which is hid_open_report() in hid-core.c:
> 
> 
> 	start = device->bpf_rdesc;                         /* (1) */
> 	if (WARN_ON(!start))
> 		return -ENODEV;
> 	size = device->bpf_rsize;
> 
> 	if (device->driver->report_fixup) {
> 		/*
> 		 * device->driver->report_fixup() needs to work
> 		 * on a copy of our report descriptor so it can
> 		 * change it.
> 		 */
> 		__u8 *buf = kmemdup(start, size, GFP_KERNEL);   /* (2) */
> 
> 		if (buf == NULL)
> 			return -ENOMEM;
> 
> 		start = device->driver->report_fixup(device, buf, &size);  /* (3) */
> 
> 		/*
> 		 * The second kmemdup is required in case report_fixup() returns
> 		 * a static read-only memory, but we have no idea if that memory
> 		 * needs to be cleaned up or not at the end.
> 		 */
> 		start = kmemdup(start, size, GFP_KERNEL);  /* (4) */
> 		kfree(buf);                                /* (5) */
> 		if (start == NULL)
> 			return -ENOMEM;
> 	}
> 
> 	device->rdesc = start;
> 	device->rsize = size;
> 
> 
> This function uses a slightly elaborate scheme to call .report_fixup:
> 
> (1) start is assigned to the original device->bpf_rdesc
> (2) buf is assigned to a copy of the 'start' buffer (deallocated in (5)).
>  .  It is done because buf is meant to be mutated by .report_fixup()
>  .  (3) start = ...->report_fixup(..., buf, ...)
>  .  (4) start = kmemdup(start, ...)
> (5) deallocate buf

Ouch. Yeah, sorry. I wrote that code and it seemed I completely paged
it out. Your code is actually correct (all three) but it would be nice
to have a longer commit message explaining this above.

The main point of this alloc before calling fixup is because some
drivers are using a static array as the new report descriptor. So we can
not free it later on. Working on a known copy allows to handle the kfree
correctly.

So yes, sorry, returning rdesc+1 in 1/3 and 2/3 is correct, and using a
devm_kzalloc is too in 3/3.

Cheers,
Benjamin

> 
> Importantly:
> 
> (a) The buffer buf passed to report_fixup() is a copy of the report
>     descriptor whose lifetime spans only from (2) to (5).
> (b) The result of .report_fixup(), start, is immediately discarded in
>     (4) and reassigned to the start variable again.
> 
> From (b), we can see that the result of .report_fixup() does *not* get
> deallocated by the caller, and thus, when the driver wants to return a
> newly allocated array, is must also hold a reference to it so that it
> can deallocate it later.
> 
> From (a), we can see that the report_fixup hook is free to manipulate
> the contents of the buffer that it receives, but if we were to
> *reallocate* it within report_fixup, as you are suggesting above, it
> could become a double free:
> 
> * During realloc, the allocator would potentially have to move the
>   buffer to a place where there is enough space, freeing up the old
>   place and allocating a new place. [1]
> * In (5), we would then pass the original (now deallocated) buf
>   pointer to kfree, leading to a double free.
> 
> If I were to describe the current interface of the hook
> .report_fixup(dev, rdesc, rsize), it would be:
> 
> * report_fixup may modify rdesc[0] to rdesc[rsize-1]
> * report_fixup may *not* deallocate rdesc
>   (ownership of rdesc stays with the caller)
>   * specifically, it may also not reallocate rdesc
>     (because that may imply a deallocation)
> * report_fixup returns a pointer to a buffer for which it can
>   guarantee that it lives long enough for the kmemdup in (4), but
>   which will *not* be deallocated by the caller (see (b) above).  The
>   three techniques I have found for that are:
>   * returning a subsection of the rdesc that it received
>   * returning a pointer into a statically allocated array
>     (e.g. motion_fixup() and ps3remote_fixup() in hid-sony.c)
>   * allocating it with a devm_*() function.  My understanding was
>     that this ties it to the lifetime of the device.  (e.g. the
>     QUIRK_G752_KEYBOARD case in hid-asus.c)
> 
> Honestly, I still think that this reasoning holds, but I am happy to
> be convinced otherwise.  Please let me know what you think.
> 
> —Günther
