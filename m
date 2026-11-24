Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484263;
	b=NhU2IHbPrxx8SAE2xLcxFVDGCUHxUjQonP7ROy+pilkRbCTbxAHs/qBSV1dxCIF7vp+y
	 JaFTwlyEXyUjYTPumz2l/eNNOMOxIhnKs7Dj97w+EvUe2brwUYxYIUu4euKFmDhY4RMf6
	 E8u6w0Kr/+lhKiqKQTRixTrbXuMLzwwGC0VUy0gcwlRb3rNb3FjpdciU+/6WqNyh7gkme
	 XTIqo3UYkEDijvnUNkKMBTfjRBUtBj5Jvi+BrBJpjJZNHJApfFNESZaP+aZbT0JJ+LATI
	 SfpOo4aGzIWgW5isLIug6VavpaQt+Dh2Devatk14xnW+JPjzYEm4I9uJqUT05RkoR2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vbV0FpLnVDem8kc+KhRgKSxbkxjFXS6P0ZcqGLrdAOI=;
	b=iB8kICcP4tgbC4T1KaJT4sX8BJT8SMJ6F3KBOSY4OVi41yc16XNzBQQSBR/a/hN/fPWk
	 4TLFoBiOvHaiTNO3YcYp+/j7JOk06uEg7srHrKF5egQWw1JlnhQT0GIyCb/yu1Wfeig0o
	 KzRZNASotkbyT6D7kRU2Gu3PPJJXedHd9+hg87CqBpb2jlLWCYUSaFj7b/7BVfIf3XRfB
	 i2ISlcoD6k9gFbp6s3G7ImnAgr9Y5bdCHWLhVA6KqQk3eDF/RbI+YHzBJWebU63N1RxQ0
	 IZj+rhxE0eER+BOSCcmAxyCzivBVrqIEW16BdArnJjQZJMRpSc9yLG2MjdBQ/GRj8+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BB3rjcwz;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB8606A321
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 01:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BCB8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BB3rjcwz
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-386ab9ab619so3594091eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 17:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795484262; x=1796089062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vbV0FpLnVDem8kc+KhRgKSxbkxjFXS6P0ZcqGLrdAOI=;
        b=BB3rjcwzTeTydd05Z2ugRZe0xbkIrxB5fxHGYHaNOscwnu4/blfaOFF4/U5y+T+1RL
         yNPSMJOXSDJczxf1E3OGkBKWiNUQtQP6yli1a9Vghue3+jrKEHNIZdZAxbfKjYZUE8Dd
         pJxC8qAE5s9b0PZoEAGJixc9d2fL5CtdBOGIJ92trVfDPYNG4nrzafSnnjgQBolJk85l
         0DFrg4cvqsApIJC0tPf371hQ9a/cFmYasrR43oPG5GCKgTvNyNkNxWZi5f+f5EelojH4
         /84jbpjwWPQhUH4RENmFDBBuvI9PsjFX4KqdyV+mbWsOS8JOjRIKkb1YQQ63Wq68SvIr
         CkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795484262; x=1796089062;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbV0FpLnVDem8kc+KhRgKSxbkxjFXS6P0ZcqGLrdAOI=;
        b=bveFenfkH/+CpGgHrEYEOqTb4ozy/tJF+Db0W/pU6LqSnrJ9geGHlAUBtqY4iIrEaC
         8q/4lnS0MiEZDoSGzweoXsmOijyT3AN7j1Q8S0TCwtntucNTIJvnU0jD9f6AdSgWUQ+B
         HI2fb6VEz0vOlrtepGaUBz8TbKi5aw+gYBiTFso7rm2Apn9oj3TrJ2yNAd0jgc8va3NM
         +hFD3W4KqQ2c7I2WGTr2ojjhia8nkwEQ1VFi5QMpDyt/ovFEutOuUGbYs2Ki9qArWEhO
         xJnsvLzeguGlBf+c+lLlyR+hLRN9pGZxJZ9mVK4s+zv5+0wJd4Vv/w33fCq0ToK4i9GE
         yKbQ==
X-Gm-Message-State: APuU4Z+sDlGB9i9ROgspGVMkMUbDG50q6qpO07miRppEF/tNDzCXFqut
	FkR+DccqAsUAk2WLyhVrufOioWBpxmQWqcnf3zeDZ1EoQdQNXUme/ggXqc5l9Xt/
X-Gm-Gg: AZFdTZdShkZPEc4n6JBr+zNeeJJwZsE9rmagsZQ+GAeio1NzWCdFdyWBW41hLrP0qZh
	Zxk8ijWI2qizatmA1/GGOwI2seU+oksC69JSmY3pITQrWPM4rqmBAPtC9KmWV8OmEnvy+1ZyZ3O
	zJaXUkdTBCAf9Xmu1vk/w0YsisP/zXCLC12aQ4FvlEJikX2f0QWiCQW9+7/6mC0JjqNo6wNW6Xv
	K7G7u7tHaOoQICA2D+JNpteAUJNS+enJ/o9NgIfUoRUTBPrkxe5QV4PHkyr+Jef/tZs46LJ83tq
	za7YfMVEYJ07eYlfl8GJ6iAeeFEGMEn6PzpgQUPyMb4oiTi3FgUTpAT3fBV8/YqfyyUGnPehpFC
	LqKv7Jy9sfXjWwjop/tzbdSlpgyCvm+EpK8jT1OjLLvpkpVACt3VMv6NJux5eiJQy3MTAluSdlE
	lDqbLOt7EkyiGJ6eqLS0pgbVh6a6dZCicK2RwupxWxMEu+j0bkJOJvmOjYycCcSNCeMv7Gi+VGy
	5+SD1Owz9J9EBQG0UmRIl23oG/AwHkBNJ7v0vR7P24jBN7GlXLzTCEEk3aTnkELcZM5ObGxZ7hT
	X85meBN6ZcOcL0XbJppzDAI122C0E1QSRgqC6j7rP0Shih4dOiRSlrZARKxNJnXifyHX4XQ=
X-Received: by 2002:a05:7301:46a3:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-3856f65ada3mr14784970eec.8.1795484262241;
        Mon, 23 Nov 2026 17:37:42 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm11760696eec.27.2026.11.23.17.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:37:41 -0800 (PST)
Date: Mon, 23 Nov 2026 17:37:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Igor Sousa <contato@igorsousa.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3
 15IWC11 (83WA)
Message-ID: <awTqX8YvJ-4WsIsu@google.com>
References: <20261118013902.10467-1-contato@igorsousa.com>
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
In-Reply-To: <20261118013902.10467-1-contato@igorsousa.com>

On Tue, Nov 17, 2026 at 10:39:02PM -0300, Igor Sousa wrote:
> The Lenovo IdeaPad Slim 3 15IWC11 (DMI code 83WA) requires skipping
> keyboard deactivation in atkbd, similar to the existing "83RR" variant,
> otherwise the internal keyboard won't work unless the
> i8042.dumbkbd=1 option is passed.
> 
> Added a DMI quirk for the "83WA" variant using atkbd_deactivate_fixup.
> Tested on the hardware without i8042.dumbkbd=1.
> Fixes typing and keyboard LEDs even after suspend/resume.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Igor Sousa <contato@igorsousa.com>

Applied, thank you.

-- 
Dmitry
