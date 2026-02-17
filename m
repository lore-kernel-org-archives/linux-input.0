Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D40378800
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357349; cv=none; b=Baiy6whjof5greAtkDZoHw7be+Y5Z2St4rHG26TF+quggwm0XzJoeb6nObfVZN8TFTDDoXyZWpB7fOkqYYurkAI68OBQ6HW9/Ezq0YwkTdcS3B191JteCpBnhd9sWU2kiBIvx0UXuWrlHzLERiuUNkwvmdbY6NjRQQQ1/cTDkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357349; c=relaxed/simple;
	bh=oEd0j4HTHXjey6zdICz4VGHhfh1yZYcwmYPbk8qS6ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBPDNTs2W7gDCVc6x+lNtnO+aQ37wFIbtAbUWA1BIQASWcqo6b/hjZJ2RDSyCvbxRNjU1GoDx4gVLN7gVE7V/yB3sJmxVP+Q+E0LIYke6DqC+KunkCdjw9HsvRJeyQXNs7ozhMRB0P3Z9iG2ByDSGIS0JNSFsuBSYSBQpYVaCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXfV8o+3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXfV8o+3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4837907f535so32767875e9.3
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 11:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771357346; x=1771962146; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gPY3U4D8kcI/KJam2ubk4HEothPT8T9Sna2aKUxaL8g=;
        b=gXfV8o+38o+nh9nCo/1Jhm91+rynNSZaRv2SR1OJfb87PM8ncANt4pEXONDuvGWX9M
         DWAIog9ZfPF0Mr57PdZwOTpyKSde6m1G1Jn6qLzXq2k/xwZrkHss7CY0FJinuLPnFMP9
         kjxQ/gf0fBoiJydhow3z7zY2042xQQvtFZj+vTf+sQJV80g15Tkm55ycZYBqRjUoKU1i
         eggWdxDpKwz0Tnr2yHjO+NYbrIgBS6rp17s7k2+CfRgpMbOUln3uql6o5olu0/X35QJG
         js/ucoMZ3v3rQf3OrTcCqsoVcatnc4bhUFdNNLntneeTtFkrbDCsQsYwPW0x8PCRzLCZ
         CX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357346; x=1771962146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPY3U4D8kcI/KJam2ubk4HEothPT8T9Sna2aKUxaL8g=;
        b=KxriKskiN5P+yqXSGYmzdlvI5vEe6oNdLMgYyveEU7c+G42tNPMf8SEDzZK/WLc4sX
         Hru6tYjUD0T7Z9Fmcbd1e2slBlzoYtVEenuLzBPQN1qV0klK5gvxB1AjnmPMzXKlGC+y
         h4FS4chNEjcShovBEhCGi3baGrie+ICzHOcmBL8wkDcbGBCE7Je6y/B019/G3S01EMVn
         77fwjGV/9r5+z51aouxglxJ8o9/Gk8GCWRsZhaLScdAJoBNGA2SibBo7FsNLKXb/TECk
         kUvvsSMwxrJ4R+BynJD37Y3abi38NB0QQL3Wr39dlUa2EsxbYaJUTfqr/7ggldXtzkIq
         iaAw==
X-Forwarded-Encrypted: i=1; AJvYcCX1B74XE2G9EnHBoJrpES7pMRDt4MgQovpQKPDlm7/OEQ7r1UM0R0hDWzC8IGgudqbmMBkByMnJcahGtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6sX+U5/CA1sWih/JwL8/f4r2dN1WSYvP4fZUnUYOPgwCRaWyp
	gqVqQiOaGd/xjXyI+S+WVhamqlrnrjnWVFHJeFCaHOe3ai0T4oZgihzNo1bvYMu4mg==
X-Gm-Gg: AZuq6aL4pLwjv0Wn9daU+XnzHbhEOucEPNHRcOU2tVx0FhVHj6utTtwz534VTpps0jb
	hghB6W5a8M+dGDvz0Gcdi6XvdBCsCeAOout19t7JmL9kuu55/4eIuLAlklvB0ciqK+FoQQ3skAE
	BzJNe+yCPzWYHaV2bQGeYom/xWCI/En1bPNxXxKSNm3sSd6s9nq/SYB1RdHB0apblsTOMHoaPCb
	qDTF5ybmwvMPQB4wR5Znjl09gE9opWj8kEwZ5ccjDdwzdY0n3quGnueWWvHWE4Mg0vImNrGWY+G
	drTcTucb1/ytYIrMpdse7k37CpYzpuOoh1aIOSN2Au9mfO7h5XO5mQ1DEeZQ/A0VPTgm9C91xzY
	mu2MusUqfpMS+uXfLDinMIWILZdzphLrN7tT5WYXEuNfIKBXlA8AeIyIWjKNIrW/7zycNVeehrB
	BO+SqjC0b93fviINXKhY5ng3HxiM6SUmlA70gTn+Fp59xRuoFF5u/rHw==
X-Received: by 2002:a05:600c:1c08:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-48379b991c6mr198726345e9.14.1771357345552;
        Tue, 17 Feb 2026 11:42:25 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:8d29:f905:4a47:1dbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfafcdsm822528585e9.9.2026.02.17.11.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 11:42:24 -0800 (PST)
Date: Tue, 17 Feb 2026 20:42:20 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: apple: avoid memory leak in apple_report_fixup()
Message-ID: <aZTEnPEHcWEkoTJR@google.com>
References: <20260217160125.1097578-1-gnoack@google.com>
 <20260217160125.1097578-2-gnoack@google.com>
 <aZSxeusondD26uN3@plouf>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZSxeusondD26uN3@plouf>

Hello Benjamin!

On Tue, Feb 17, 2026 at 07:22:20PM +0100, Benjamin Tissoires wrote:
> On Feb 17 2026, Günther Noack wrote:
> > The apple_report_fixup() function was allocating a new buffer with
> > kmemdup() but never freeing it. Since the caller of report_fixup() already
> > provides a writable buffer and allows returning a pointer within that
> > buffer, we can just modify the descriptor in-place and return the adjusted
> > pointer.
> > 
> > Assisted-by: Gemini-CLI:Google Gemini 3
> > Signed-off-by: Günther Noack <gnoack@google.com>
> > ---
> >  drivers/hid/hid-apple.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> > index 233e367cce1d..894adc23367b 100644
> > --- a/drivers/hid/hid-apple.c
> > +++ b/drivers/hid/hid-apple.c
> > @@ -686,9 +686,7 @@ static const __u8 *apple_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> >  		hid_info(hdev,
> >  			 "fixing up Magic Keyboard battery report descriptor\n");
> >  		*rsize = *rsize - 1;
> > -		rdesc = kmemdup(rdesc + 1, *rsize, GFP_KERNEL);
> > -		if (!rdesc)
> > -			return NULL;
> > +		rdesc = rdesc + 1;
> 
> I might be wrong, but later we call free(dev->rdesc) on device removal.
> AFAICT, incrementing the pointer is undefined behavior.
> 
> What we should do instead is probably a krealloc instead of a kmemdup.
> 
> Same for all 3 patches.

Thanks for the review.

Let me try to address your three responses in one reply.

I am happy to accept it if I am wrong about this, but I don't
understand your reasoning.  (This should go without saying, but maybe
is worth reiterating, I would not have sent this if I had not
convinced myself independently of LLM-assisted reasoning.)

Let me explain my reasoning based on the place where .report_fixup()
is called from, which is hid_open_report() in hid-core.c:


	start = device->bpf_rdesc;                         /* (1) */
	if (WARN_ON(!start))
		return -ENODEV;
	size = device->bpf_rsize;

	if (device->driver->report_fixup) {
		/*
		 * device->driver->report_fixup() needs to work
		 * on a copy of our report descriptor so it can
		 * change it.
		 */
		__u8 *buf = kmemdup(start, size, GFP_KERNEL);   /* (2) */

		if (buf == NULL)
			return -ENOMEM;

		start = device->driver->report_fixup(device, buf, &size);  /* (3) */

		/*
		 * The second kmemdup is required in case report_fixup() returns
		 * a static read-only memory, but we have no idea if that memory
		 * needs to be cleaned up or not at the end.
		 */
		start = kmemdup(start, size, GFP_KERNEL);  /* (4) */
		kfree(buf);                                /* (5) */
		if (start == NULL)
			return -ENOMEM;
	}

	device->rdesc = start;
	device->rsize = size;


This function uses a slightly elaborate scheme to call .report_fixup:

(1) start is assigned to the original device->bpf_rdesc
(2) buf is assigned to a copy of the 'start' buffer (deallocated in (5)).
 .  It is done because buf is meant to be mutated by .report_fixup()
 .  (3) start = ...->report_fixup(..., buf, ...)
 .  (4) start = kmemdup(start, ...)
(5) deallocate buf

Importantly:

(a) The buffer buf passed to report_fixup() is a copy of the report
    descriptor whose lifetime spans only from (2) to (5).
(b) The result of .report_fixup(), start, is immediately discarded in
    (4) and reassigned to the start variable again.

From (b), we can see that the result of .report_fixup() does *not* get
deallocated by the caller, and thus, when the driver wants to return a
newly allocated array, is must also hold a reference to it so that it
can deallocate it later.

From (a), we can see that the report_fixup hook is free to manipulate
the contents of the buffer that it receives, but if we were to
*reallocate* it within report_fixup, as you are suggesting above, it
could become a double free:

* During realloc, the allocator would potentially have to move the
  buffer to a place where there is enough space, freeing up the old
  place and allocating a new place. [1]
* In (5), we would then pass the original (now deallocated) buf
  pointer to kfree, leading to a double free.

If I were to describe the current interface of the hook
.report_fixup(dev, rdesc, rsize), it would be:

* report_fixup may modify rdesc[0] to rdesc[rsize-1]
* report_fixup may *not* deallocate rdesc
  (ownership of rdesc stays with the caller)
  * specifically, it may also not reallocate rdesc
    (because that may imply a deallocation)
* report_fixup returns a pointer to a buffer for which it can
  guarantee that it lives long enough for the kmemdup in (4), but
  which will *not* be deallocated by the caller (see (b) above).  The
  three techniques I have found for that are:
  * returning a subsection of the rdesc that it received
  * returning a pointer into a statically allocated array
    (e.g. motion_fixup() and ps3remote_fixup() in hid-sony.c)
  * allocating it with a devm_*() function.  My understanding was
    that this ties it to the lifetime of the device.  (e.g. the
    QUIRK_G752_KEYBOARD case in hid-asus.c)

Honestly, I still think that this reasoning holds, but I am happy to
be convinced otherwise.  Please let me know what you think.

—Günther
