Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0B389452
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095463; cv=none; b=fyV1LyqXfyZZU7gEUSeAnunLNImZFibRnJH9tN08jUUciW2Ja78YLmNGjyNnnmPlUzK4PlKD+0J1Yv3EDmxXDxVSLTkYW4TfAW+GhnVBI0beoUyxk6teG5frxVj4zIMnKDkLYFBml2RIk9CZ/iFm/mzel1fZUJ/qInyI5OO3LZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095463; c=relaxed/simple;
	bh=/vPQIEV4/SgDSzC8EDs9ehJeVmZQPBn5YAqt9QP3nEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZTfQJ/AEQKDDkNk1d++J8KcuVogpy83rwz+cK3n3W+ERXyy75JIhPS9ADcYq7+JBUHIfQBrnrJOo5uOZYM5lTQae4weSXWaGb7Q8Vo0vL56NXZZCIZyz/lfriBthEdhG80HSw8YITYBJZPM6fRWAnShzqtLO6imE9XHBc4FjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-632a055fa9fso631389137.1
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 02:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095461; x=1779700261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRYZ3sLzBtPinz1jCgMS2nJKx1VYP4BGEJ88Tc5uCp8=;
        b=ecQ1TiGHyYo4pCwrSdKCvgs4aYxOi7mbbSjO7rYz/TIYcniiQQsCPxrZcRFDdmp0x8
         0sx/8GOTFC62FHM2SGP4VZGxp2FOS+ndNjO3HCMvmSnZ16sGWOxB3yu8XR6HCpmYkKOx
         DChbCwSQVfYKdWFzLUSC5YqJ+OQshRJ+PUjx5zr6IcZEsCx7vYhTJvANTfJArleu+Rlr
         ndrz4uXgSuuLD2xrMZFAQyUs1zUYMiDefwfKDuE7mESTqYXze0DCKHryg0a12kNCE+zr
         4PIVAeYLZBYoct+AnGTNSYiGp4OTw0mPFRY447xoM6LvhTZMj6PufmxT1wrX7/3NRS3h
         A0IA==
X-Forwarded-Encrypted: i=1; AFNElJ8LOvCiilmlt4Iwbb2dBfo3mMPr43iSS/ryxitEz3mUpKxFIhvHYm1OUN9NUfPF+uKXVyE53iOZcI/eMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZliRp3dl2AupqV4GE0m5R3FjThEaZLakqQrLR4LBDfKqSht/+
	LkiJRlB7NpRvcqWKgjrWC6fhhcXgqjtOtXiG4rwSFtB6ocstyjVnTv8en35yRCku
X-Gm-Gg: Acq92OEzAR+6F5bDHIuMELrGbf95ktPMDJqdTIBu6GcFV4fjPj79HOafxb8yd6wPh7g
	YxpjX/iPSJ1LDXm9NOX4lWX618CuSYIdOwUy9GrQgpUvs2KRMjXH5bqRyuw7n3m3OH+blMmouZw
	0SyvhB8vNPb87MYGppSir0+7ZqgBmPPL9u0ZBootWbftQBty50Lc7a0Pg9jZylqSSqUbR5FQxvS
	5eSKqoWwpY+hURic1RAamPZl+9T1xLygq44DkFQPQfmuFrbnMg8YZkPh2kgd1XswEFnBAUsYtXk
	baJ6ztzzG/6WbpPUm8QqhH4c2w0KhU8EZftxEO8Z5rMyvXQ5fRefxv+75LIHti98jukO3w9FqAW
	/8E69WRbX7gUB2GmUstf6StSOArkuzCnrl7ubQT9G7RlXn/37hPIxAqfLIctqM1nrQM0z/LM6rX
	uN7eM5pO6JfKC2E57hY37DXg2MVTztvJeWyckVepg2j8LYzV4TgeSfMnfOHxio
X-Received: by 2002:a05:6102:2ad4:b0:607:4fde:1921 with SMTP id ada2fe7eead31-63a3f8989e3mr5604845137.24.1779095460891;
        Mon, 18 May 2026 02:11:00 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-63ccf18bd92sm4403359137.3.2026.05.18.02.11.00
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:11:00 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-95cc1a5fe9cso301237241.2
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 02:11:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Ury6PVJNBm9WSQGFvDscVJpEiv6b75esDGLaqL6zR3wl4N49ooizH4mkd2hzNUMs8+o18OBnEn4vhDg==@vger.kernel.org
X-Received: by 2002:a05:6102:2ad4:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-63a3f8989e3mr5604834137.24.1779095460227; Mon, 18 May 2026
 02:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517-hid-core-fix-size_t-specifier-v1-1-bfdd959ec383@kernel.org>
In-Reply-To: <20260517-hid-core-fix-size_t-specifier-v1-1-bfdd959ec383@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 11:10:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVzWL0WZe6u-uY2U+uCNUKB1aNTYM3kaYkX=OJBCY9G0w@mail.gmail.com>
X-Gm-Features: AVHnY4Id0khCZ3ZQ3Xy8VTkUfy4-pbQWwRD5BgHydP7l9eIjiP4DncTGcfkDLiI
Message-ID: <CAMuHMdVzWL0WZe6u-uY2U+uCNUKB1aNTYM3kaYkX=OJBCY9G0w@mail.gmail.com>
Subject: Re: [PATCH] HID: core: Fix size_t specifier in hid_report_raw_event()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Nathan,

On Sun, 17 May 2026 at 06:51, Nathan Chancellor <nathan@kernel.org> wrote:
> When building for 32-bit platforms, for which 'size_t' is
> 'unsigned int', there are warnings around using the incorrect format
> specifier to print bsize in hid_report_raw_event():
>
>   drivers/hid/hid-core.c:2054:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
>    2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
>         |                                                                                         ~~~
>         |                                                                                         %zu
>    2054 |                                      report->id, csize, bsize);
>         |                                                         ^~~~~
>   drivers/hid/hid-core.c:2076:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
>    2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
>         |                                                                                          ~~~
>         |                                                                                          %zu
>    2076 |                                      report->id, rsize, bsize);
>         |                                                         ^~~~~
>
> Use the proper 'size_t' format specifier, '%zu', to clear up the
> warnings.
>
> Cc: stable@vger.kernel.org
> Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/20260516020430.110135-1-ojeda@kernel.org/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks, this fixes the warnings on 32-bit for me.

> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2050,7 +2050,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>                 return 0;
>
>         if (unlikely(bsize < csize)) {
> -               hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
> +               hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %zu)\n",
>                                      report->id, csize, bsize);

Both report->id and csize are unsigned, so should use %u.

>                 return -EINVAL;
>         }
> @@ -2072,7 +2072,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>                 rsize = max_buffer_size;
>
>         if (bsize < rsize) {
> -               hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
> +               hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %zu)\n",
>                                      report->id, rsize, bsize);

Same here.

>                 return -EINVAL;
>         }

And more incorrect %d outside the context!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
