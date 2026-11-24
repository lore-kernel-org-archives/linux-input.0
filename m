Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544551;
	b=Z03/XJPfzWvDSn9g6xGxrAo4/RnoYGucOyZOtzfxlxaox6iTt6EHcF8y168x4RNkixSd
	 O7zSk8xb+QP+pBsf82UEMY4oz+X8019xVIamgHAsGnX86angb0YtBuAI8NGpeJdY3EpCo
	 n26XzqY2pX7n/Y7yRAvnZOpc6PCxtzUzeaxKgeVeXkBvVIzjTJrqMli7Qc4N9tAxgsA1n
	 RClw7+1EDHBfot5Qxt/QGggxqfPuU8rw8b3TihPkHxAf7HjMen/ry+UaJbsU/vPGrLPJL
	 EeF32LrDxa1mGcK8tNO+yp2w0QUuUoF0CjONBfb5mGCt/ukr7X7NUIrGTqN4aPFXblw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lp2V1CD3UzTfS8SfEqnuM0AkFNXDFtv8aXVUJV8xgrM=;
	b=dskK6yGi3tmhLKe90rkvo1OWYYIm/u7O6owjL9Be7POe+CnwGZP8VW9h7xWv1ZBSvHOS
	 gTNeugljbmelVs0jpwfibNqTN1C2KUed/IrQqMzUxQmGBrIrftpfgnKJfML9YRgTZeEls
	 A7q8gW5vP+XkbZRCuwzTB+muXa6deks0Z7ESKHLeUNU9b25kNb3Dyk/eoalHrssMLIpfe
	 lG0wdFPXh8807NlJK2qpKJJ3j30GJtDzJ5PqL7LQeKE0zH/yF1ZIT+P/BRWK6dQcK5AuH
	 epCb9FWAgTnHUIW3uE90rTfdCI9MnHm3U8pqY7weMHE7XCiknnWrX/rhmbuE2QoPcBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DNLYG8o/";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FE606A33C
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 18:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 413FE606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DNLYG8o/
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b563e32936so1114268c88.1
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 10:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795544550; x=1796149350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lp2V1CD3UzTfS8SfEqnuM0AkFNXDFtv8aXVUJV8xgrM=;
        b=DNLYG8o/Q8J5WqPu8p+NIGocgHhg9M/LFdO8BOGqgl1n/72wXjyZnjaLhhCU8ExAz1
         KeYhD+Twn0WgTQj27WqyG9OIX4vixtNxcf2dJcr+OzSbSWdq9LQothnAIqyoE562KWN/
         8S5gHRbSkcCXHq4OVuddS4r1yu3OLRBNcALHpu1u8VehpsDAJkQaaC+Bvf4rnqg5yIVj
         Mo5+pWPeEgpg0khVaV/Jp+97+MenSYsgHYRZjkV2akYETyq4EQTynIl+zAe/F5vzGX0T
         8chHQs7BFv8I5KdJ2JWzpBjR9M42ghq5QrkOxWwikZwEOZ6Kj4k7asjiyd6eyvuX4vnj
         LGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795544550; x=1796149350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lp2V1CD3UzTfS8SfEqnuM0AkFNXDFtv8aXVUJV8xgrM=;
        b=iuWorRTPhf7bywNB6BPdobs7UOnaqay4szrskUV8/FB+pNZZnu9kRTaDViDwPKwuVB
         H90Ct6H4VOSxityNwcuc512BulSDCHRNoYvF0ElD82sybPpZmpAoP8piyYBFEAH5Ssbe
         J3NRwGk4YNqkjZ58jnN4fR3iJ0CD6miBUaVu0xgY9tFkX3lBdKgEM1n1oK0xhhNrt0N5
         Gq861JZnKRN26qxZdvHozfd/ZxuPivpVAvWx1qj3vWxzQd4LpvBAYItRr1iWZV0YJWi2
         vdWRquXsm0yV/VU2tQ4xc/zbIrg7kgzO7x618yHT1H/SX3s/habkRYZ0lXYjX21IsQz0
         T1Jw==
X-Forwarded-Encrypted: i=1; AL+hErEfiN+S07lT3HiuGj5D6nCJxpgXW3YkOCz84tJwQgkaAMyeYXFmpnlmX2kdUh1vZ8AvCEKy/SP40gwc+w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ixmojH3ssHgXUc4eNAy35tUfzah68BmSgSDh/RsuKanqiyfON
	ZHJeFIjgNPakgE0SYjqKvwe0oNpdLyIJ239puBxMYlOEHh+3lVTehs/e
X-Gm-Gg: AZFdTZci02/0yFR9EtPizt0gsu+x+/I+wU2mhuqfHF2jlSKwg4cK2wNK6ikqBYfvvY4
	udrtXtmkk/px2FWqf+RcvagwkNnMNhR+2Acibr5Z0bP/vwIKhrGGwA8uIv7bMi2M0xSXKpAMr1h
	aWiJFcymF49sPcvvldtfBD6nSpt3YD/YFc++9MJewxUqTA1ZeBsEQlFUCISKhvXJRy2DjWz6UOs
	6m8YzcmfZZxvwrVOi+2jezXqdcZgHOynYfZ75b+kZL43vJzMLIV6mvlSw0Bl6gJmpwmvUZMOjGF
	8PZruerG/DSmEgFRBbbCpGuo81z5HnfVGlXNx6E7jLeGjOqd8USvhywNAAs2+J350ZCwpGl9jIN
	Uuxt/hO2OzyI2b4MtuC9261rXZ1Oa1W7Y7PY1W6uVZA5THEqVXzknD98TQZOtlAjkGe32qUSBd7
	NOC/lUFVwQRivsBPWCwGvtiTL2Y5/sEQpVnNE8vu3fxsle4l26OE8ulaFzXmFoGM908z2pKQuAH
	chvoT626BDeN1JELLXl3Rc/lExgvsEum4JzZfEsy5gJ2VazcSAWg/KN3SI5EHkugJJaqThvU1KS
	PIZzenWO88XRiVcNxLseWzReEYRaEg7anWFCAeO7jBKc4SArsB6C21EL8ryJsICjQ3NXVZUq7mY
	6YwEgBvxfbBNRHK22ag==
X-Received: by 2002:a05:7022:3a83:b0:184:992:c9ec with SMTP id a92af1059eb24-1b55693aaabmr20326331c88.38.1795544549929;
        Tue, 24 Nov 2026 10:22:29 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ee3b:b892:771b:3bc7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm40472836c88.6.2026.11.24.10.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:22:27 -0800 (PST)
Date: Tue, 24 Nov 2026 10:22:24 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Hans de Goede <hansg@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] Input: goodix - sync the irq controller while
 starting firmware
Message-ID: <awXV3Y080rMLw_VO@google.com>
References: <20261124085058.128173-1-l.scorcia@gmail.com>
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
Content-Disposition: inline
In-Reply-To: <20261124085058.128173-1-l.scorcia@gmail.com>

On Tue, Nov 24, 2026 at 09:46:22AM +0100, Luca Leonardo Scorcia wrote:
> On the Lenovo Tab E7 (TB-7104F), which has a Goodix GT-912 touch screen,
> the touch screen fails to come online after loading firmware, printing
> the error "Error reading 1 bytes from 0x8041: -6".
> 
> Comparing the upstream code with the Android stock sources, the existing
> call to goodix_int_sync should be moved between the upload of the firmware
> and the watchdog restart. With this change the touchscreen is correctly
> detected and working.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Applied, thank you.

-- 
Dmitry
