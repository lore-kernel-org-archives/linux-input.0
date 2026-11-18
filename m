Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035432;
	b=O6BlNW83dOMczifYkwn/aHB/dyR1/2l5Ex1aTlCY7RsofQVqiGURRjNLgqJLvIr9Py0V
	 jhGh39ID+/UzIOO0Ffdn6pGEyZJcXE4sfknGGWtuABilkGuvffxS55sePp8/PxZX8xIx6
	 scze43NRs7kkz7Vfu617hme8OIi2XBCsDpXSX3OywzhaCxY1pQPOYQIcjFEPWEFjZuYCk
	 Fje4Ij8YNMk/74//MFq/Ytqic7DVHnHJm0hob2YTyHJJ4xcHUs6NciQ+BoS0U4dFvcO7j
	 p23PU6j0aae6dFtHnHs+/BTlmA1gtUH3Qo2+cmK2rS40CwcU2U4XAbx5OCgfA7iOGBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lwp8t8LUVYUpnfQ5EdPfzGcZvgUEwhtKxs66E4lRwbI=;
	b=UZVIEEZOaYOE+XYk9aewXikRGZgMwa6XpLRm+Kp5IAPripQT9k63nS87aZ0vKvXe9hPT
	 x/0PozCi1e/B92HUaDISisCinrxu9+1XweD8xrRwvsCjthSTSTJvuveAz/ZIZRuOQlWyG
	 Q3f4uAWrAEjAkhSBFlb1RiCRHlKbcbUDp1k6MW995yfFhsolSvjPeEA9y4hQPHnYNblNJ
	 YN63qWxFvfCRqhqKE51FPS6rOjrXBug+eq1ECuWX4PoeK81JbZ7VkTNIBxLP34U4y8286
	 LL94hhEfTr2weUkRHxhL7hB+Qyu3qZuhXlBr6HcG6IdiN1ZcTGOZe4o2I8FGRGq4J3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAr7mGAZ;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A1606A320
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 20:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 473A1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAr7mGAZ
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so16446175e9.2
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035430; x=1795640230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwp8t8LUVYUpnfQ5EdPfzGcZvgUEwhtKxs66E4lRwbI=;
        b=QAr7mGAZo6JypL+RtfhirUL+sLj2PvWccXTaR4kYbvYKNoTcxulTK66WgbD9Gu+iXh
         yN8EmlcgYBD1p7CIKeb/+4ZmOzu32KJwSfqBwL14sT6cEJaKmVkD4nyu3D5upZ4bqbUr
         wXYZyLvH86tk/a4zlwa5UeYyhMjqDPiHG3/dr4Xxn/rZElp3iHtKOqWs5l4xitQNL0k6
         ygFEBkDNZiUpSoEwhGw9DARA/iFJB25c7cYJQsvs5L1ZhhxvnaLRZ6K4Yw5e65ZZVC6n
         Vx6dXHSWp1/ZcQLPwqbM1NffNVZ6AJ9XhWqapmwjH/kXHCgid5QktCyWe+JU01s4PNF9
         j91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035430; x=1795640230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lwp8t8LUVYUpnfQ5EdPfzGcZvgUEwhtKxs66E4lRwbI=;
        b=nvXN03+DjTlagqX9l/GmJGDOkF6pgmf+FtwtTU/l769op6hmZSkToAijESviPzU68n
         MkizumGIFn6FE9Hog73jBqpUEUjakUtiNt/Bgy156PONT4gW1R8tAwK4tyOZyl1CEw/1
         eGfTDmq93BPygNsMpAtPJsNcVq+v6W6jl56Xuu1TGM86m3SGcNevDyyyIqJWX9pyaGbK
         b1S0xc/83ej6r778wtAZgVUdc7XlTVrBz9Lcc4xwASL4b6bL/0Y+oS9l1ETzc3qw9aIZ
         dT2D1CRpWX0tFCFahpobPi6Xr+HxQTHSw89I3rK4A0ngZNfqX3K5X9+DgS4WIbG4iaMI
         e9ig==
X-Forwarded-Encrypted: i=1; AL+hErGC04PgeDd3I7y8QV19d1I2sDPQwAo9cYxVh5a5X0/xOs2uJyWkdJ82Cn2d/34NIeY1IW90ChhFKWhC2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Vqvfqq0JGFEtdGRhEmarufgio9XJWtVNy+g31yGYETnlx3Hl2
	ZrLni57xEnU4KtUC8FSRahaInu4nk4lodjzZPZl6x2sGCA7wqUe65dza
X-Gm-Gg: AYBFou2H018M4FGpXkDJcir+tS5x/8wOeQPBewtPig4iQmr3Vf5xT9KklMP2SJF2gop
	DEG+j31/M9AKaHKi4YpB2IPphHQHu8n3G72o3eXlhAnPfBDem1LcycK/YUBtvCdwFPcmxy5gRnO
	uxozzg6OJXtXuuxkbFHgoH85f0j8kVAPxnA9SNqYyN84VrvRGq8ejQgxVaprZvtzk4kIk+wNg3Z
	XCMbF1JtbFKbuWoFLVxf5VJdUF7B5RJLLI1vZ1HW2zeoc7I+lzwidfRIdk6Gi3Qp5s1jWWKR1Le
	vjJKSPg/EVg8iMAv/hdOLnwuPyfVY4+yJJuT43/CKTQimVf/eqP8Pbz3VcqRGbPm6H4Fqpd4WP8
	yWUmLTUqQ+s9dPH+FBXNh3OFCh6hb26gFbQx85MwKMHifWlDIxdLOvdeuriBvuGx7US+i62+n1h
	AzugMZV2Ol5OzsI1fdb9lnnuo31zafSq3psIGQ6AmPfLa1QR2W8h6wUVJqCwp9RffEcQjyk/3el
	bWPm1yq5ZLIVmGGxBe0SnRfK2XOIlsEIoBITLZN3WcafWPfLeJu69VhtPKU/xI3KB63Avaw+6lp
	89NbDyzm5/arlW/+fm3SoBf8oWjU
X-Received: by 2002:a05:600c:1c03:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4bb7da1392emr80734155e9.9.1795035430450;
        Wed, 18 Nov 2026 12:57:10 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb7e577acfsm46582705e9.1.2026.11.18.12.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:57:10 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 02/16] HID: ft260: uart: fix serial driver
Date: Wed, 18 Nov 2026 22:56:59 +0200
Message-ID: <20261118205703.49167-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-219657@kernel.org>
References: <sashiko-outbox-219657@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 17, 2026 at 08:49:47PM +0000, sashiko-bot@kernel.org wrote:
> Can taking port->xmit_fifo_lock with plain spin_lock() deadlock against
> ft260_uart_write()?

Thanks, that is a real deadlock. kfifo_in_spinlocked() and
kfifo_out_spinlocked() take the lock with spin_lock_irqsave(), and the
other users of xmit_fifo_lock must do the same. In v5, patch 2 uses
spin_lock_irqsave() in all of them.

> Can ft260_uart_write_room() and ft260_uart_chars_in_buffer() race with
> kfifo_reset() and return a bogus count?

Right, kfifo_reset() writes in and out with two stores. A reader
without the lock can see one old and one new value. In v5 both
functions read the FIFO under xmit_fifo_lock, as uart_write_room() and
uart_chars_in_buffer() do in serial_core.

> Does removing ft260_uart_change_speed() from ft260_uart_port_activate()
> leave tty->termios out of sync with the hardware across an unplug and
> replug?

Yes, it's correct. v5 sets TTY_DRIVER_RESET_SAVED_TERMIOS in
tty_alloc_driver(), as you propose.

> Can publishing dev in ft260_uart_add_port() before
> tty_port_register_device_attr() allow a concurrent open to reach
> tty_init_dev() before driver->ports[dev->index] is updated?

It can. tty_kopen_exclusive() and tty_kopen_shared() find the driver
by dev_t and do not need the cdev. They can open the minor in that
window. I will take both of your proposals in v5: ft260_uart_install()
uses tty_port_install(), and ft260_uart_probe() makes the port visible
to ft260_uart_install() only after the chip is configured, just before
tty_port_register_device_attr().
