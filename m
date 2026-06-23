Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5932860B
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 03:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186849; cv=none; b=c3dSDEy+0otV2xxXWeOCwZOW3NkXomUuy+LLHE38rPdD8Z+C/T+XPXWiw7uT6ZZDwGTKkCAL5p6P3+zGhTeTizaB4xTX+f5JOEa1yvTB/6OZCKeepQ9+4MSIjHOXMU0wilgSbdBtL99o4ldsgUsP7++dDO+IZ3BUUjA+h9vyUmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186849; c=relaxed/simple;
	bh=AtobID1XN2SBdN6N7K+JDLiP7Lz92I4F6L3HYo1ow0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIfFkYOuI7ux+iVstMOw7q/uhzIRG0aFvREDunHhbsBPovB4Tth5FA7GdpL8kiXRRYNgIaQlSJjlBhUVMS7NQMUgLTZnuFkp7zpJQM+t2DTEPKWu8mk4Zu6Cy9jE3JYCb24dvgYIIWmwNES9+xYf7D+L4PB6+lwnXXQS4oR2zpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=go1Pp/sA; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go1Pp/sA"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13986d61b4eso4045698c88.0
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 20:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782186839; x=1782791639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0nIWqLfpotqRiv/1wHZwPTTITbqTrkCA4q6I67J/OHE=;
        b=go1Pp/sAZ/JJmK9N18C69ilBQdIUqjwQ+0VuPnz2PGWW2aw66nwHFuX8rU+a0Pn206
         ASaswRJj0WrtFEWIbr9O1dXAlEDhXpoyCfyvTZ9d9xe/QYiE3gP+VZ2HKO2mt8HePL4Z
         E9pssk0rhSVFPh1dNZfc+nkrmX1qUWpxSvOSu2Y9jB2eolOqep6N4Q5qKe0axDXEs5vu
         /3BPpivsp+kgfjHaeUyMdgzBdip3yBllsupBIPhHKf9UR3Uo8UzOZPcui222b5NJbDhG
         /O+2BecbPij2rYXa6Up+7GvtE1IGIspdiNFYGfcvIqf5y+YO6ePGe123n+ZKsQpA7qPs
         /Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782186839; x=1782791639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nIWqLfpotqRiv/1wHZwPTTITbqTrkCA4q6I67J/OHE=;
        b=hUQRCZiTXMj5CFrPEjsAZJMsICIUKtdaavD9xUSL6seQwrgbtjDyGxCTDALrF0QUoP
         357XrCMsc/+r3CJSKOaqtx6lYZeDxkaD22f+b0gx1PfQES5aFTqKx6oTvssbpNw2vJFg
         WUCsjCxwvaQr8WdphuYgAkYLC/ZgcJ2K5vfC/ZlWkO9RoNdT92SabCA4IoasJ5O6DYex
         N4dHreLy4jLonapGtXEn7gFYRkeXqhNu0xp3aDeHV5SoU6jMFt10OoeGWO+DEgvdXA+B
         CUSc0e36yLswt7s4udsl1PpyHY9xYgSBstqs0KdIVqxF7/BWmhy6Vt7DjyfH1C/xdeyR
         QpIw==
X-Gm-Message-State: AOJu0Yz/f3QiTtMwgdakpJJea6kg1RCzYMCbNUtM85KDpENdgqrFGZUd
	DKJqjzaA2pLI34MPzbPmzET2LGYHw09O3guCEUrTZPdxJf0vrHYhQVfeEo7fMA==
X-Gm-Gg: AfdE7clEjXPbYNVfpXBQ4nTffnvdSvH6olacWqkfUaTnzRTzYnTLLRjwAYt9QI92zZO
	nmOu3VLXvEVRQSIDmN//x5oFqZwMkcHt6aOfyOGBMP2oqIroPfHR01w5GROCMfxzBq/ZcJ9ndOd
	vMmidUsbdboYjC3hO/94juVVW31Pgwz2iuFOjxDXr8pLbSiixXSVtkkgCYCCi/X6XF2qRqxsN0q
	O3mfXzHWXD8eATM0J3CAy//nPjgOUdKpvRyhTEsaNMWhURZUD4xOk9MEVf0fclcFCwtGx+ntQ8m
	RFRRvi3siEkkYALE0GsTjNEATUAUmyQ/4JkAWQmzsfcv6earr/7a11Ncli3rinyeUbv8gv9p4YO
	+Ymuf70mBcm8Zr+veqxoUqfIprS5KLXFuGjh8kqZuvrHKF0NLmxY9eM9hN3DxK25s0FEFoT1YYn
	oK3w5UmGs5uFgzQqP0qOFMCS7d4OIwT+26qIRPkU+jAzS6ZZXAtQhhOIhOh7K7hmQS
X-Received: by 2002:a05:7022:7a4:b0:136:5e4c:7aba with SMTP id a92af1059eb24-139ad6ac8ccmr9959250c88.16.1782186839459;
        Mon, 22 Jun 2026 20:53:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7d8d:3bdf:d563:1911])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add5bd68sm11767253c88.11.2026.06.22.20.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 20:53:58 -0700 (PDT)
Date: Mon, 22 Jun 2026 20:53:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: hexlabsecurity@proton.me
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: iforce - bound the device-reported force-feedback
 effect index
Message-ID: <ajoDJ82Csta196ja@google.com>
References: <20260613-b4-disp-4828d263-v1-1-02320e1a89dd@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613-b4-disp-4828d263-v1-1-02320e1a89dd@proton.me>

On Sat, Jun 13, 2026 at 09:58:55PM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> iforce_process_packet() handles a status report (packet id 0x02) by
> taking a force-feedback effect index straight from the device wire and
> using it to address the per-effect state array:
> 
> 	i = data[1] & 0x7f;
> 	if (data[1] & 0x80) {
> 		if (!test_and_set_bit(FF_CORE_IS_PLAYED,
> 				      iforce->core_effects[i].flags))
> 			...
> 	} else if (test_and_clear_bit(FF_CORE_IS_PLAYED,
> 				      iforce->core_effects[i].flags)) {
> 		...
> 	}
> 
> The index is masked only with 0x7f, so it ranges 0..127, but
> core_effects[] holds only IFORCE_EFFECTS_MAX (32) entries.  For an index
> of 32..127 the test_and_set_bit()/test_and_clear_bit() is an
> out-of-bounds single-bit read-modify-write past the array.  core_effects[]
> is the second-to-last member of struct iforce, so the write lands in the
> trailing members and beyond the embedding kzalloc()'d iforce_serio /
> iforce_usb object.
> 
> data[1] is unvalidated device payload on both transports (the USB
> interrupt endpoint and serio), and the status path is not gated on force
> feedback being present, so a malicious or counterfeit device can set or
> clear a bit at an attacker-chosen offset past the object.
> 
> Reject an out-of-range index instead of indexing with it.  Bound against
> the array dimension IFORCE_EFFECTS_MAX rather than dev->ff->max_effects so
> the check guarantees memory safety regardless of how many effects the
> device registered.  A legitimate "effect started/stopped" status always
> carries an index below IFORCE_EFFECTS_MAX, so well-formed devices are
> unaffected; the neighbouring mark_core_as_ready() loop is already bounded
> and is left untouched.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Thank you, applied (but I dropped the temporary 'flags').

-- 
Dmitry
