Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794031408;
	b=V9a8jCXR/WBUBw6g6FB938wHpFLY8U5TfayLxz1vh8Tx600ntQc5Nq4/PLZEurFjji10
	 OfIveb3fCEeH18A/qmeblW11/vk2juHqGu6LL/JQ8VQzNTZm8ayyYOF4Mqb8F3Yxwwd+i
	 aRb2HfmVB0QvEdpHswdr2X3N3RV+FPRnvChLo2oAG1BjlfC/sd6iEruy38GfZMbuwyTOZ
	 dHBJwA84DkOOPLcRl1F71z8UMPyFSpkrpoGHjPi4uiP2tJpJMBHJf+uiRjs7/faBP7YNd
	 e0kGfvOssHI3rzSm0fJxuSzcmr/AMU9fe5KdzkeE9nNhOti82TQzJ/05KXTVEKVsA5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794031408;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WiA5qT8eRjnxgtA4uHSNnQnqdcnJzRqNedb1td25pz4=;
	b=OBsWvxImSo6SNAOTrqar+1aOsPzj5/S0s/nzdYgJGAzORUl7A9gQKuYI9VCTi8bCa/SX
	 +EWjfXcKshcS12D9A1fQ5dQZeNMRUuMxk4pYAiREp7SiAFHgXUBwO38g+03VbgdbYsHEr
	 ZO6VBKMhln2qD7buCtipQOxfc9iIBYX0gCEombnYgvhXmI5zfXpeh8hIFXtMS+dv3Xo01
	 l1HtPjQ5EV09FW8vfxIjKkdRnPx4/bW3sHxkL4YjTFyO3tNiLz8lBzDWeBtclH3aylu2U
	 +xWAHVQ9mRm0YiPGN4IoA9HzJCUp36HKQrEmJC7/w9Uj87lMEEluzw4j1IlAgO0TXgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzBJIncc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC1606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 06:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzBJIncc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF681F0089F;
	Sat,  7 Nov 2026 06:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794031408;
	bh=WiA5qT8eRjnxgtA4uHSNnQnqdcnJzRqNedb1td25pz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XzBJInccecaDSdLUT56Z/2V9aV23LaW7NJioLLBHXAIqH5W8K062juVYWv/gRwm7T
	 snTst4ZNzmwAuHTIOF/+4YysqEl8v+IEvXmDrjPKf3GR+nG3mj+aTLoMgJKwzbgRyy
	 pFP7IMEzWt5/DhCcKMcTd5q2ag9e8pjXAVVQCEqrJRQ6RDa+A5cDc5SaS4i8eQKwQE
	 V8rmw52Bc+4ctPrVfJt1qwlmb/Dr6YIXD+0ZT1jJ2CiOXnWA0vURTcShnoN2VvPPAD
	 /EVrc4sw5D/TEQo9cZMyekOj41iGrogZwJ1Fv2IhncikUfGyNnFuj0aHhKsryZvIP/
	 M78jUlxiES8gA==
Message-ID: <sashiko-outbox-202644@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] rust: serio: add serio bus abstractions and port
 Gravis Stinger driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vecheslav Filatov" <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261107053953.471972-3-harepro29@gmail.com>
References: <20261107053953.471972-1-harepro29@gmail.com>
 <20261107053953.471972-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 06:03:27 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] rust: serio: non-existent bindings::irqreturn::IRQ_* in
  interrupt_callback()
- [Low] Input: stinger_rust: built-in modalias uses stinger_rust instead
  of stinger
- [Low] rust: serio: borrow_mut() lifetime spans across
  serio_continue_rx()
--

commit 8182b04fefab6df9f076e7e3b941b950b2bc4c52
Author: Vecheslav Filatov <harepro29@gmail.com>

rust: serio: add serio bus abstractions and port Gravis Stinger driver

This commit adds Rust abstractions for the serio bus subsystem and ports
the Gravis Stinger serial gamepad driver to Rust.

> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Mak=
efile
> index 9976f596a9208..2ba3391af7c9f 100644
> --- a/drivers/input/joystick/Makefile
> +++ b/drivers/input/joystick/Makefile
> @@ -33,6 +33,9 @@ obj-$(CONFIG_JOYSTICK_SENSEHAT)	+=3D sensehat-joystick.o
>  obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+=3D sidewinder.o
>  obj-$(CONFIG_JOYSTICK_SPACEBALL)	+=3D spaceball.o
>  obj-$(CONFIG_JOYSTICK_SPACEORB)		+=3D spaceorb.o
> +ifdef CONFIG_JOYSTICK_STINGER_RUST
> +stinger-objs				:=3D stinger_rust.o
> +endif
>  obj-$(CONFIG_JOYSTICK_STINGER)		+=3D stinger.o

[Severity: Low]
Does building stinger_rust.o into composite stinger.o emit
stinger_rust.alias instead of stinger.alias into modules.builtin.modinfo
when CONFIG_JOYSTICK_STINGER=3Dy?

rustc derives the crate name and module_path!() from the source filename
stinger_rust.rs, which serio_device_table!() embeds after __kmod_ in the
__mod_device_table__ symbol, whereas module! declares the module name as
"stinger".

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..fa5fd93182938
> --- /dev/null
> +++ b/rust/kernel/serio.rs

[ ... ]

> +        // 5. Attach published resources under `serio_pause_rx` to elimi=
nate races with interrupts.
> +        // SAFETY: `serio_pause_rx` holds `serio->lock`, preventing conc=
urrent interrupt execution.
> +        unsafe {
> +            bindings::serio_pause_rx(serio);
> +            let mut borrowed =3D <T::Data as ForeignOwnable>::borrow_mut=
(raw_data);
> +            T::attach(&mut borrowed, published);
> +            bindings::serio_continue_rx(serio);
> +        }

[Severity: Low]
Does borrowed remain in scope across bindings::serio_continue_rx(serio)?

Because ForeignOwnable::BorrowedMut may have drop glue, borrowed is not
dropped until the end of the unsafe block after serio->lock is released.
An interrupt arriving right after serio_continue_rx() can run
interrupt_callback() and call ForeignOwnable::borrow_mut(raw) while
connect_callback()'s BorrowedMut is still alive, violating
ForeignOwnable::borrow_mut()'s non-overlapping lifetime requirement.
Explicitly dropping borrowed before serio_continue_rx(serio) avoids this.

> +
> +        0
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Must only be invoked by the serio subsystem during an interrupt =
on a connected port.
> +    /// `serio` must be a valid pointer.
> +    unsafe extern "C" fn interrupt_callback(
> +        serio: *mut bindings::serio,
> +        data: c_uchar,
> +        flags: c_uint,
> +    ) -> bindings::irqreturn_t {
> +        // SAFETY: `serio` is valid.
> +        let raw =3D unsafe { bindings::serio_get_drvdata(serio) };
> +        if raw.is_null() {
> +            return bindings::irqreturn::IRQ_NONE;
> +        }
> +
> +        // SAFETY: `raw` was created via `into_foreign()` in `connect_ca=
llback`.
> +        let mut borrowed =3D unsafe { <T::Data as ForeignOwnable>::borro=
w_mut(raw) };
> +        match T::interrupt(&mut borrowed, data, flags) {
> +            IrqReturn::None =3D> bindings::irqreturn::IRQ_NONE,
> +            IrqReturn::Handled =3D> bindings::irqreturn::IRQ_HANDLED,
> +        }
> +    }

[Severity: High]
Does this fail to compile when CONFIG_SERIO=3Dy?  bindgen generates
bindings::irqreturn as a u32 type alias with top-level constants
bindings::irqreturn_IRQ_NONE and bindings::irqreturn_IRQ_HANDLED, so
bindings::irqreturn::IRQ_NONE and bindings::irqreturn::IRQ_HANDLED do not
exist:

rust/kernel/irq/request.rs:IrqReturn {
    #[repr(u32)]
    pub enum IrqReturn {
        /// The interrupt was not from this device or was not handled.
        None =3D bindings::irqreturn_IRQ_NONE,

        /// The interrupt was handled by this device.
        Handled =3D bindings::irqreturn_IRQ_HANDLED,
    }
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107053953.4719=
72-1-harepro29@gmail.com?part=3D2
