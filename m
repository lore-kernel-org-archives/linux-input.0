Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457528;
	b=RLqLDTIZ80+MGGSU1/0AN/yz+B7yqXXsMFo//od4mj6wZGv26RkxozdVboT6HnehLa74
	 rtHFc7GJ8OOTorKZgy176dXE7TgQLIeX4Mhw5ljZa3NMKxzjhUdwDRnbxUZijV7rnF521
	 Ag2V2LIw0qworYjt7/kWOoX84ZczK9R5DYMD2aFGTk9noCdGkLwp+5R84A/FRlLx1twP0
	 EEIis5UyswgN0Xpp/QHrxPZuQCh6bq8mj4TquriMY5zUyNwRgR45y+s9XOAfrxCQtF5ZK
	 barcMko0dZVq/5lCR/uZvLjYEE6GCGuJ7Avp3PqpEl7liIgKCaPgWTmiCYvVYBB72sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=jzqkJeZaTQXahw6ShZXqUnXj4qKS+ePavQpcZ/GtLFg=;
	b=WMxgoy85VP0TLAjkKVkRVkkpV1QB7cSTVsxOnKvMU7tEHcYHMcylwELGOhNRnG0MmQLx
	 XsKVDghzZxA0OCdpxtpeI46GRi59cuzzQN+NbOLUEH4Xv8b5R3hqjOThKlSIL09Vc2nFe
	 wfHWzJu3zxnKaG2urpgR4j44u3HkvZ2cm2wGVJFM3wy7It49T8p/S+/H4K32suqrdkfxU
	 ybWZUHlFSYJ0g3JaZQJnqqE+NyiK++XDezIU4hgEa0djuP1bE/g6D55J2gAyzVszoC7BA
	 MJFTzjMMAQOFwCBlwZdvJkRerKVT4OKETM8VJIc0ywOqSmtbmVZLoEjy+JQajDVEIYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u0ywaFlF;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71949606A31F
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 18:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71949606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u0ywaFlF
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-38644aedba1so5437055eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 10:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457527; x=1796062327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jzqkJeZaTQXahw6ShZXqUnXj4qKS+ePavQpcZ/GtLFg=;
        b=u0ywaFlFQGJU+pxzbL1a6SWXyRaCwXZzS5AbxqdZ8bjRjQdOVXELGmrG31NpNdT2DV
         YxIToPBydNJ6+VBAerf2ZQUbvV5aP4E1CppnauztHG5J/REu3mfghDTsDFAeeX2N/lxU
         6yz7wwa07D3H8c3doovT6i2/HLy3Oz/z1mcZZlsvcTBKhBoTDqPcur34aPP/1/esBkW2
         btuFQ/UveeLAZ4E1UKJBZX6KwNHn8mrS09w24sgdNnEaNnWW2Jhnshx90JwneM7NC1hX
         wYm3GYbrav8YUhEKwS1jgi5WMlTAjb7yzCUJgCBQAnyewMP7QGHkdSuWb1Iz+cD3sHrx
         sTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457527; x=1796062327;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzqkJeZaTQXahw6ShZXqUnXj4qKS+ePavQpcZ/GtLFg=;
        b=TOgdVjAh22HmtqbPl3C4eMk3c8GRnF2ts7eNu40r25vMBSVZrk6J6RPXEZ30nOagPi
         /R/hAbkHlTaRzcLL5f7XoMDBAPyrQHDm9HJC2WHPsLm558p8rzTnVCoBI4cASSxO1G15
         u6NKLrpn1Jb32n6Qc2ecg5DJmle2XAZzo7yf7EqSlp7HCsXlwdcMqjRrQykJLWA11EWX
         5buAkYQpw13+SAv5J/xsxPOgVe08HQglb6Nr+Re6CfM6Acl/oZiIVbqljzYjwajwvFQn
         BfnfylGns24TCs5bJAiY1YrZwH0Gpayo+SzIn4zpX9AyETeeeunlaA/ijV6dlmDamSDW
         K5RQ==
X-Gm-Message-State: APuU4Z/ywPnrcJHOgBThdBJIrU8Lf0s1hQZh7mHXZ7BpcbuL0KdmYgb4
	cOkE1rJcKPERN5jT4x9hvmjUv6r36L6ftNAorGYerVkKHHVT6roUfWTs
X-Gm-Gg: AZFdTZfs4zmf9R9RUANiDdG/wtuJPF7Q/Lyh/wzpHTTz7mooP3lDE8k0ezEcOYuU9KD
	OZOr5jSHpdzggWui0wQuBkZizwKvxOVuzqfMR0jBWjqu9TOa/Xuhnq/2Y2uKVjfww1/1N8XYvu4
	2hg22QApYIl14Eb7RtOeEz68gkkUcq7y+9V/mXtnac+1/UMSgfU1keI4A8qny3cgZw+5nWGNvZN
	oq+TqwHX/T1txPP1HLFo++3b9iugsrK4cn0s6rbPto8soo7GyiB+ScG9uyRpDKzLoeQuM5YPQnL
	gW16QRigVir2rWq2Wkb9yHXkGUOp3/O5tksn678NbGQGOvY8lxX7ZSgw+yBZbaxDLkfhvS4fC8u
	ZJVAWb00lYOk5/08RleW9dbmP0KVnaPP89cEVI42qn/NE9wq8eOLIK5u8YU5VRCOVD7OR3nGRZM
	g0Rem92jSJgUK5s+Tr0URP3lo2rPOa9gTfc3m9t6lcSU4RPyiZqs08yZGrYSaXaw/YJp1E8UGPp
	4bba7f/8H1lecFNW4NgHwp6w+/C9Pu0TuzVkaXEiy2fO75fqvYB1t/MD+3SPjJWxZLkVqii6pTM
	io8JRDNt01Kb32wU1k0fZX2H2BpIbv06a5E8H33JbAkEDGVW2+ZQQsRcMUpZAFD9UTXq5Z3QE91
	gLNoka7OU8sBU4+TG
X-Received: by 2002:a05:693c:83cf:10b0:386:b526:24d1 with SMTP id 5a478bee46e88-386b52638e1mr2787839eec.9.1795457527409;
        Mon, 23 Nov 2026 10:12:07 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm43434987eec.26.2026.11.23.10.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 10:12:06 -0800 (PST)
Date: Mon, 23 Nov 2026 10:12:03 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Michael Auer <mick@yoxcu.de>
Cc: linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: pm8941-pwrkey - report wakeup events
Message-ID: <awSB8AQVrGEAjFgr@google.com>
References: <20261123130336.1316006-1-mick@yoxcu.de>
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
In-Reply-To: <20261123130336.1316006-1-mick@yoxcu.de>

On Mon, Nov 23, 2026 at 02:03:36PM +0100, Michael Auer wrote:
> The power key (and resin, with "wakeup-source") is a wakeup source, but
> the driver never reports a wakeup event. Its wakeup_count in
> /sys/class/wakeup stays 0 even after it woke the system, so user space
> cannot tell a key press from other wakeups. PowerDevil, for example,
> uses the wakeup counts to decide whether to turn the display on after
> resume.
> 
> Report a wakeup event from the interrupt handler, as other power key
> drivers do.
> 
> Signed-off-by: Michael Auer <mick@yoxcu.de>

Applied, thank you.

-- 
Dmitry
