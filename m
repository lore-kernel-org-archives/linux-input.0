Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166893;
	b=WRJdh8ldVficLmvDkQN1lFE9bdSV72N7IuwYVNwuIiWWNIpY6xd4st2NRr1a6RtUFAUz
	 ZLSaRisqecTedIxNECkTXpeNmo2ZabW9PUaStLd5jGUMRdjaILJ3YgeGftjvnRu0xsCeB
	 WHIHQSKL10Dnhcw31R7o7ixTMp5AcOZZgOdKBuOflqHMN9c3YnPXEe8IRL5smeulwpSxG
	 yCD3vx5AUTqKzX0r2G0CpM1ZSOqa2asG0KfKcy7d16tJRNQ+rYnaO4T6hp29uS8tI5SAo
	 o+ns45EnwntJh+29PQVgYQsF8EOnOAhspA1qgALooktDFnjO7nIqRu6TUs3ogcnP9uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=iPIWf4CR+FySLK0WT2XKzaLbbIX8hP6nHSH1SwDADzw=;
	b=geNqWu7RV5/lBkjHpJ21L//t2dgR2dNsuuOkOhP4OxbdPSGnQEuYKMdWmckDRYJ0lHvJ
	 /WnrNIX3cR8gfC7ImTNN1BmptG0tT6saV37AI6bkFEobDcylpvcNaFDiLGO4tSvw43pn+
	 5hll9KZ35VJOStBBi7GlFo6M46KcaIqlTlXn87Xf/ikIIM/DklG5O9OF8UEenP/3S8uxy
	 LdGd9yp9Jv5RtwaHbfh30GNfQLAuYSwACcz+VoBzJEO0BQQrR7fTtwHfIbgrX2WrTbpNv
	 TRt6rECZtWj0hZvALV37TQp3hk0Oz1RWCvS2X+PTQsW8JyNqQiL+VI8DH4yfRVhjqIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0z69Qcf;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBC606A31A
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 05:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37FBC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0z69Qcf
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so1352310eec.1
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 22:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793166891; x=1793771691; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPIWf4CR+FySLK0WT2XKzaLbbIX8hP6nHSH1SwDADzw=;
        b=o0z69Qcfpdkp/p6Tn5NclGTKtl6MY/HW+BqKV80a4QaTrNGIg+jA8tKdXUH7KD1D8V
         xSReEm6u6evrxsh/6+S7Wn4Z6RPKeWj59oWsewcgLsAyFROJTovwFUETuLbg51IyiQIS
         zQBUF8/Wpb/kTL6ff+T+YB7v883/sjREJW32zIKl6C+fxc8Wr/PX5EA1gykfnyp9FP4S
         Vt2vCeOEIJCjkjKrarVaWzoJ7WKm8Wc7lxgaXwk2vGDTLIAkuPCODZHKaovK6/3WVkDY
         M73KDzIsQ/51UAvEu/nH3TnkTfOuu/SshBe/T584vy1hS40w48Xolvaa8/On56ahzmwk
         gCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166891; x=1793771691;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iPIWf4CR+FySLK0WT2XKzaLbbIX8hP6nHSH1SwDADzw=;
        b=sQlvgf+y1t/Bj7oURtiSdEJM9uzFy7YGzn1sX62WhCElocYhCgs8XI+i6DOg4jxrpn
         nsNmTjUy+oDj480BT6zufBwvbcirlWgtvR7NSxQI61RRmLPHtF9OHuCaVWdOEN47SbAW
         Pz7eWBh9GkKY2MPos6S0m0rwwcaDQjBRnSqIrrBHAtbdwPzyBe3/kv1KrUyS5ZaBm7Tk
         eVDysPKJGUSOCBXu13E6GVchCt3zzfE2LL1lAK9nZGOj12uCYri8xT6OSG/2bu9lMHm3
         H3UpOfRzog4D9A0p4PEQoJF2+C/x0qJZ1n7Wy+ki7v4n1NF6FrousjdHwJpaVVWP50ii
         tj7g==
X-Forwarded-Encrypted: i=1; AKwUvBy+/mKsP50rjxFX+vWvMJFyxlxZYhSBq9mx5Om6YrLopygVAOXXqlnozN/xWoKcyD7byeL9aZYyfLiALg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIc6gggPxAHGxg4di02EJhNDJStSCaRRzHGYJI0symS+/sewWAj
	Yz1yOY+2p+LMkLdFiKR8+X8uVuKM37rwjouPVqbsAYdgvO1a87EvGpHs
X-Gm-Gg: AYBFou3pW5NT6wUvvNFuKaH94flq1vBCZOpu+Gw+ysvAODcRdDElwddEHUXQZpdgk9h
	+gWRpK2R9LoffqQeO75lGlV1P+VgyKsdKiTId+JYGoA3hA3mqdUNg+vSx6JuwAd8zb+8y0jEe4d
	xiMHRVF39Idx0cHdPcYGHW46sRk/i2V0o0FioCnfTzp8BGOfsXZYqSYj8j3hZDWW2sxhFN19zhG
	wN+wLthmcAEIET89TVhwogLKN2hFHOkRq5Dxy6yVeiS1fFhP+PDZNly7gjiG+mRh4MGahQdtFUS
	yspXCKmXnNpAy51S1ku3SHCRgn5Gq3808SccnIIob0zK5VoShlhJlWYmMyhDpw8uObTup3pIYA4
	KvdAqyV3xrbmBQgtaqMU9uhKn6iZUjPfEGP02yYMIPtW+IE1Lry7zOFaH5cB1QRwf4TbKd1clUu
	cVG34sxr5AYbFE9Z8Eic6Xbz0d5+mwsHuRN4pre2JznbFdAwZUnfq6b9/ymjTxqAQTNUJWmm3eT
	KeJhIcmGQNZOzr2w353RWOaVljJR11v1npb8RzRsu8nrwmZIaYe6600bJ4Iygmr7o8eVtQ3bocA
	FfqjetlNGiV8IPMwi49cyfVseTEatxldO+NWtjUZIQ8Tc4G/QM1oBbUesqy/lJCMnoHD4Q==
X-Received: by 2002:a05:7300:fe87:b0:36a:1b62:da with SMTP id 5a478bee46e88-36a203ace60mr2130750eec.12.1793166891207;
        Tue, 27 Oct 2026 22:54:51 -0700 (PDT)
Received: from localhost ([2a00:79e0:2ebe:8:9958:9525:7799:82b5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm2765953eec.15.2026.10.27.22.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:54:50 -0700 (PDT)
Date: Tue, 27 Oct 2026 22:54:49 -0700
Message-ID: <03029b6324e9e95ad794ca57d187d52a@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: serport - defer write wakeups to a worker
In-Reply-To: <20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com>
References: <20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi James,

On Fri, Oct 23, 2026 at 10:23:44PM -0600, James Hilliard wrote:
> Defer the serio notification to a work item, as required for transmitting
> from a line discipline's write-wakeup path. Keep the SERPORT_ACTIVE check
> and callback under serport->lock to serialize with serio close. Cancel the
> work before freeing serport in line-discipline close, where the TTY layer
> has already excluded further line-discipline callbacks.
...
> @@ -66,6 +68,16 @@ static void serport_serio_close(struct serio *serio)
>  	clear_bit(SERPORT_ACTIVE, &serport->flags);
>  }
>  
> +static void serport_write_wakeup(struct work_struct *work)
> +{
> +	struct serport *serport = container_of(work, struct serport, write_wakeup);
> +
> +	guard(spinlock_irqsave)(&serport->lock);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		serio_drv_write_wakeup(serport->serio);
> +}
> +
>  /*
>   * serport_ldisc_open() is the routine that is called upon setting our line
>   * discipline on a tty. It prepares the serio struct.
> @@ -85,6 +97,7 @@ static int serport_ldisc_open(struct tty_struct *tty)
>  	serport->tty = tty;
>  	spin_lock_init(&serport->lock);
>  	init_waitqueue_head(&serport->wait);
> +	INIT_WORK(&serport->write_wakeup, serport_write_wakeup);
>  
>  	tty->disc_data = serport;
>  	tty->receive_room = 256;
> @@ -101,6 +114,7 @@ static void serport_ldisc_close(struct tty_struct *tty)
>  {
>  	struct serport *serport = tty->disc_data;
>  
> +	cancel_work_sync(&serport->write_wakeup);
>  	kfree(serport);
>  }
>  
> @@ -249,10 +263,8 @@ static void serport_ldisc_write_wakeup(struct tty_struct * tty)
>  {
>  	struct serport *serport = tty->disc_data;
>  
> -	guard(spinlock_irqsave)(&serport->lock);
> -
> -	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> -		serio_drv_write_wakeup(serport->serio);
> +	/* A serio driver may write to the TTY, so defer the callback. */
> +	schedule_work(&serport->write_wakeup);
>  }

Thank you for the patch. Deferring write_wakeup() in serport makes sense
(it also breaks a port->lock -> serport->lock -> input_dev->event_lock ->
port->lock lock ordering cycle with input event callbacks that call
serio_write()), however could we tighten the lifecycle and avoid scheduling
work when the bound serio driver does not implement write_wakeup()?

Right now serport_ldisc_open() sets TTY_DO_WRITE_WAKEUP unconditionally
(and never clears it), which means tty_wakeup() will invoke
serport_ldisc_write_wakeup() and schedule work on every TX wakeup even when
no serio driver is bound or the driver has no write_wakeup() callback
(every driver except iforce).

Instead, we can initialize serport->write_wakeup in serport_ldisc_open()
and immediately disable it with disable_work(), without setting
TTY_DO_WRITE_WAKEUP there. Then in serport_serio_open(), if
serio->drv->write_wakeup is set, call enable_work(&serport->write_wakeup)
and set TTY_DO_WRITE_WAKEUP on serport->tty->flags; and in
serport_serio_close(), if serio->drv->write_wakeup is set, clear
TTY_DO_WRITE_WAKEUP and call disable_work_sync(&serport->write_wakeup).

With serport_serio_close() draining the work before serio->drv or
serport->serio is torn down, serport_write_wakeup() will not even need to
acquire serport->lock or check SERPORT_ACTIVE before calling
serio_drv_write_wakeup(serport->serio).

Also, in serport_ldisc_hangup(), please clear TTY_DO_WRITE_WAKEUP and call
disable_work_sync(&serport->write_wakeup). tty_ldisc_hangup() explicitly
invokes ld->ops->write_wakeup() right before ld->ops->hangup(), while
TTY_DO_WRITE_WAKEUP and low-level driver TX wakeups remain active until
after tty_ldisc_hangup() finishes waiting for serport_ldisc_read() to
unregister the serio port. Disabling and draining the work in hangup
ensures we stop TX wakeups immediately on hangup and keep the work disabled
even if an asynchronous driver probe races with hangup.

Thanks.

-- 
Dmitry
