Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7537080E
	for <linux-input@vger.kernel.org>; Sun,  1 Mar 2026 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368242; cv=none; b=tMq9qZG3A2gpTnbOwLF2rSsGNNmjP2Qa9VDNGaq58QdS28ULiCNlLInsa2wck/rmtL22Vkj6NHvnRcjTx1DBrBl0aTMDBfRz0CGyCbZvJXViWNs+fVcHxYoagotTFNBv15oNzO0rL0BKwLrpsDL/gWeFAIChGTzy4KA2appTnOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368242; c=relaxed/simple;
	bh=dorPxrpgTAI49f6C5uDoEqcH9IVW5Wra9eWVH1gsmkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WSz/z5gK5mDA8fHkjvvtEUIEm5q1918GVU/thXR5FAzmsrJCsKnhhN5z5HtTWYotqYlmznlpJRh9al4FgqY1qnRWsypLVcFj2/Hzgf+62x9Xu5DRAfXnKTJ5CWiLrQhNVbifHxsXhZ6l2rITfDIS+5MNXxJyLm68/Pk5Vrz8YDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUCyPEGS; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUCyPEGS"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48379489438so33906695e9.2
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 04:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772368240; x=1772973040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDN2WDDXTC16xIPp5jcjgZgs/IUeDfobJRK3g44Z0v0=;
        b=WUCyPEGSNmw+aWBCLAvpePz0KveCh+wXWW5ECNo5rH9X2e81UlHagG/Hl8uEL9IIyt
         Wh14fyA3I+IFlMBDsSfRMyQFU/GOrtai0Ix1WUqiY6A/FbPQz7IrFtTz5nmx2m0U3bqF
         l1LFbrkGP6DgGZH5tU3ltO6izOxN5z7umpEbFiHMD1MTHjHptl4OgEWpPKYP90PgWe4l
         6VprHR1JqQ3wv/ZseNPt13yySWMcT6przqdSRX1ExIfzfqDaC36NLCdXujVQ27vqbKHJ
         IRo6PVuAhQU81HObPGyuLWAhVLXKpc8rbERHB16/YNHFToWlJBauLh5nqTz0B1Q35VnP
         jVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772368240; x=1772973040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDN2WDDXTC16xIPp5jcjgZgs/IUeDfobJRK3g44Z0v0=;
        b=WQ3T9UP6YvPzYay6BV1K2WXc1xHvf3bAxunXL9TdwDoBFQeKXn3HvRzlA+TbdeM/ld
         DLR0FbIkuRWA6dKmhIZG5C21DVTwWk/zh+Q62JxDr48Tc3Gtm82RZzRHXb9OwqtXxrVe
         Znf2sbk0ZbrWUW8K76PX8yawukkdc9FCGBWOZA6cMm6+yiWUYDttkC7KCDNut9BeXM7D
         7ZUXHud/KrBqIbB+VbPgLoL2FIvEu+qUR/syg7OJGHMR8T4Kf40e7MwGfcWh9mjNIQ5l
         HaDhQ6wZJKppXXa+6FVO2/+GHuYcCjaEsFvGKBojOTy8o86lQLfoUkOct+W7zjLH5VXs
         vWeA==
X-Forwarded-Encrypted: i=1; AJvYcCWZuvrMxasTUSLn0QpgSSEugkTEQPRrFSahj5mwj8pXl2CoZn+B7S9hHhuV6l9YJquVmK/kMtSa+NUCuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw635DeqJO3dj7JDJMpa7blhqP86zu9FB96WAfiDufcrapR3Hpc
	7iH51PsvGrpe+Y1Nz+S52bpw0ekPQ+HOA0/ll2InrbRfHTRO7/gb8odX97EVoh+M0h+9zDt7Sqk
	KnWbyMuEluTOeIhZvJw==
X-Received: from wmbet9.prod.google.com ([2002:a05:600c:8189:b0:483:509d:729b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:81c9:b0:483:7783:5363 with SMTP id 5b1f17b1804b1-483c9bfa6bdmr133213125e9.26.1772368239617;
 Sun, 01 Mar 2026 04:30:39 -0800 (PST)
Date: Sun, 1 Mar 2026 12:30:38 +0000
In-Reply-To: <87o6l8kpud.fsf@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260222215611.79760-1-sergeantsagara@protonmail.com>
 <20260222215611.79760-2-sergeantsagara@protonmail.com> <DGPUMHQSACGL.1ITBM2W573WD1@garyguo.net>
 <87o6l8kpud.fsf@protonmail.com>
Message-ID: <aaQxblPj4W6W2dSR@google.com>
Subject: Re: [PATCH v6 1/2] rust: core abstractions for HID drivers
From: Alice Ryhl <aliceryhl@google.com>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Gary Guo <gary@garyguo.net>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	a.hindborg@kernel.org, alex.gaynor@gmail.com, benjamin.tissoires@redhat.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, db48x@db48x.net, jikos@kernel.org, ojeda@kernel.org, 
	peter.hutterer@who-t.net, tmgross@umich.edu
Content-Type: text/plain; charset="utf-8"

On Sun, Mar 01, 2026 at 06:48:20AM +0000, Rahul Rameshbabu wrote:
> On Fri, 27 Feb, 2026 15:27:59 +0000 "Gary Guo" <gary@garyguo.net> wrote:
> > On Sun Feb 22, 2026 at 9:56 PM GMT, Rahul Rameshbabu wrote:
> >> +/// The HID driver trait.
> >> +///
> >> +/// # Examples
> >> +///
> >> +/// ```
> >> +/// use kernel::{bindings, device, hid};
> >> +///
> >> +/// struct MyDriver;
> >> +///
> >> +/// kernel::hid_device_table!(
> >> +///     HID_TABLE,
> >> +///     MODULE_HID_TABLE,
> >> +///     <MyDriver as hid::Driver>::IdInfo,
> >> +///     [(
> >> +///         hid::DeviceId::new_usb(
> >> +///             hid::Group::Steam,
> >> +///             bindings::USB_VENDOR_ID_VALVE,
> >> +///             bindings::USB_DEVICE_ID_STEAM_DECK,
> >> +///         ),
> >> +///         (),
> >> +///     )]
> >> +/// );
> >> +///
> >> +/// #[vtable]
> >> +/// impl hid::Driver for MyDriver {
> >> +///     type IdInfo = ();
> >> +///     const ID_TABLE: hid::IdTable<Self::IdInfo> = &HID_TABLE;
> >> +///
> >> +///     /// This function is optional to implement.
> >> +///     fn report_fixup<'a, 'b: 'a>(_hdev: &hid::Device<device::Core>, rdesc: &'b mut [u8]) -> &'a [u8] {
> >> +///         // Perform some report descriptor fixup.
> >> +///         rdesc
> >> +///     }
> >> +/// }
> >> +/// ```
> >> +/// Drivers must implement this trait in order to get a HID driver registered.
> >> +/// Please refer to the `Adapter` documentation for an example.
> >> +#[vtable]
> >> +pub trait Driver: Send {
> >> +    /// The type holding information about each device id supported by the driver.
> >> +    // TODO: Use `associated_type_defaults` once stabilized:
> >> +    //
> >> +    // ```
> >> +    // type IdInfo: 'static = ();
> >> +    // ```
> >> +    type IdInfo: 'static;
> >> +
> >> +    /// The table of device ids supported by the driver.
> >> +    const ID_TABLE: IdTable<Self::IdInfo>;
> >> +
> >> +    /// Called before report descriptor parsing. Can be used to mutate the
> >> +    /// report descriptor before the core HID logic processes the descriptor.
> >> +    /// Useful for problematic report descriptors that prevent HID devices from
> >> +    /// functioning correctly.
> >> +    ///
> >> +    /// Optional to implement.
> >> +    fn report_fixup<'a, 'b: 'a>(_hdev: &Device<device::Core>, _rdesc: &'b mut [u8]) -> &'a [u8] {
> >
> > I think this can just use a single lifetime?
> >
> 
> I think the problem is when a driver decides to replace the _rdesc with
> a static lifetime report descriptor declared in the device driver. My
> example driver does not do this, but this is another common pattern in C
> HID drivers. This is why two separate lifetimes were required.

I'm not entirely sure what you mean, but adding a lifetime here does not
change what this function is allowed to do at all.

Alice
